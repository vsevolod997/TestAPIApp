//
//  MainViewController.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 16.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var lastKnowContentOfsset:CGFloat = 0.0
    var isClose: Bool = false

    var allPublication: [DataEntries] = []
    
    @IBOutlet weak var createButton: AddButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getSession()
    }
    
    private func getSession(){
        HttpService.sessionReqest { (data, error) in
            DispatchQueue.main.async {
                if error != nil{
                    self.showErrorAction(mess: "Неизвестная ошибка")
                }else {
                    if let dataP = data {
                        if dataP.status == 0{
                            guard let errorMess = dataP.error else { return }
                            self.showErrorAction(mess: errorMess)
                        }
                        if dataP.status == 1{
                            guard let session = data?.data?.session else {return}
                            SessionSingeltone.session.tokenStrings = session
                            SessionController.saveSesson(session: session)
                            guard let allSession = SessionController.getAllSession() else { return }
                            for session in allSession{
                                self.getEntries(session: session)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func getEntries(session: String ){
        HttpService.entriesResponse(session: session) { (data, error) in
            if error != nil{
                self.showErrorAction(mess: "Неизвестная ошибка")
            } else {
                if let dataP = data {
                    if dataP.status == 1{
                        DispatchQueue.main.async {
                            guard let sessionPublication = dataP.data else { return }
                            self.allPublication.append(contentsOf: sessionPublication[0])
                            self.tableView.reloadData()
                        }
                    }
                    if dataP.status == 0{
                        guard let errorMess = dataP.error else { return }
                        self.showErrorAction(mess: errorMess)
                    }
                }
            }
        }
    }
    
    private func showErrorAction(mess: String){
        let alertView = UIAlertController(title: "Ошибка", message: mess, preferredStyle: .actionSheet)
        let alertCancel = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        
        alertView.addAction(alertCancel)
        present(alertView, animated: true, completion: nil)
    }
    
    private func setup(){
        tableView.dataSource = self
        tableView.delegate = self
        
        title = "Все записи"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.blue]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .blue
    }

    @IBAction func createButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "add") as? CreateViewController else { return  }
        self.navigationController?.present(vc, animated: true, completion: nil)
        vc.complitionAddPost = { newPost in
            self.allPublication.append(newPost)
            self.tableView.reloadData()
        }
    }
    
}

//Mark - работа с таблицей
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPublication.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as? CustomTableViewCell{
            cell.dataEntries = allPublication[allPublication.count - indexPath.row - 1]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Detail", sender: allPublication[allPublication.count - indexPath.row - 1] )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            if let vc = segue.destination as? DetailViewController{
                guard let publication = sender as? DataEntries else { return }
                vc.elenentData = publication
            }
        }
    }
    
}

//Mark - работа с анимацией кнопки
extension MainViewController{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let contentOffset = scrollView.contentOffset.y
            if contentOffset > 0 && contentOffset > self.lastKnowContentOfsset && abs(self.lastKnowContentOfsset - contentOffset) > 25 {
                if !isClose{
                    createButton.closeButton()
                    isClose = true
                }
            } else {
                if isClose{
                    createButton.openButton()
                    isClose = false
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            self.lastKnowContentOfsset = scrollView.contentOffset.y
        }
    }
}
