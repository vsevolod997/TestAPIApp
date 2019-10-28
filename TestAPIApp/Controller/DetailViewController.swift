//
//  DetailViewController.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 16.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var allText: UITextView!
    
    @IBOutlet weak var dateUpdateLabel: UILabel!
    @IBOutlet weak var dateCreateLabel: UILabel!

    var elenentData: DataEntries!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        allText.layer.cornerRadius = 10
    }
    
    @IBAction func CloseButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    private func setupView(){
        if let data = elenentData{
            dateUpdateLabel.text = "Дата  публикации: " + data.dm
            if data.da != data.dm{
                dateCreateLabel.text = "Дата  последнего обновления: " + data.da
            }
            allText.text = data.body
        }
    }
    
}
