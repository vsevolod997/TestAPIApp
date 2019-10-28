//
//  CreateViewController.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 16.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    

    @IBOutlet weak var textLabel: UITextView!
    
    var complitionAddPost: ((DataEntries)->())?
    
    var startHeigthTextLabel: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let recognizer = UILongPressGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handleLongPressGesture(_:)))
        view.addGestureRecognizer(recognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startHeigthTextLabel = self.textLabel.frame.size.height
    }
    // Mark: событие долгого нажатия
    @objc func handleLongPressGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        view.endEditing(true)
        UIView.animate(withDuration: 0.3) {
            self.textLabel.frame.size.height = self.startHeigthTextLabel
        }
    }
       
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true) {
            self.textLabel.text = ""
        }
    }
    //Mark:  обработка добавления записи, при удвчном добавлении получаем данные о записи
    @IBAction func createButton(_ sender: Any) {
        HttpService.addEntryResponse(text: textLabel.text) { (response, error) in
            if error != nil{
                self.showErrorAction(mess: "Неизвестная ошибка")
            }else{
                if let data = response{
                    if data.status == 1{
                        if let postData = data.data?.id{
                            HttpService.entriesResponse(session: SessionSingeltone.session.tokenStrings) { (data, error) in
                                if error != nil{
                                    self.showErrorAction(mess: "Неизвестная ошибка")
                                }else{
                                    guard let response = data else { return }
                                    if response.status == 1{
                                        DispatchQueue.main.async {
                                            guard let sessionPublication = response.data else { return }
                                            guard let dataEntries = sessionPublication[0].first(where: {$0.id == postData }) else { return }
                                            self.complitionAddPost?(dataEntries)
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                    }
                                    if response.status == 0{
                                        guard let errorMes = response.error else { return }
                                        self.showErrorAction(mess: errorMes)
                                    }
                                }
                            }
                        }
                    }else{
                        guard let error = data.error else { return }
                        self.showErrorAction(mess: error)
                    }
                }
            }
            
        }
    }
    
    private func showOkAction(){
        let alertView = UIAlertController(title: nil, message: "Сообщение успешно отправленно", preferredStyle: .alert)
        let alertCancel = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        
        alertView.addAction(alertCancel)
        present(alertView, animated: true, completion: dismissView)
    }
    
    private func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showErrorAction(mess: String){
           let alertView = UIAlertController(title: "Ошибка", message: mess, preferredStyle: .actionSheet)
           let alertCancel = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
           
           alertView.addAction(alertCancel)
           present(alertView, animated: true, completion: nil)
       }
    
}

extension CreateViewController: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
         self.textLabel.frame.size.height = self.textLabel.frame.size.height - 250
    }
}

