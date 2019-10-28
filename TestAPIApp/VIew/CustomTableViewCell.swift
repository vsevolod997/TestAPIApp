//
//  CustomTableViewCell.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 21.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
   
    @IBOutlet weak var allTextLabel: UILabel!
    @IBOutlet weak var dataTextLabel: UILabel!
    @IBOutlet weak var updateTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var dataEntries: DataEntries?{
        didSet{
            guard let data = dataEntries else { return }
            if (dataEntries?.body.count)! > 200{
                let string = data.body
                let subString = string.prefix(200)
                allTextLabel.text = String(subString) + "..."
            }else{
                allTextLabel.text = dataEntries?.body
            }
            if data.da == data.dm{
                dataTextLabel.text = "Дата публикации: " + data.da
            }else{
                dataTextLabel.text = "Дата публикации: " + data.da
                updateTextLabel.text = "Дата редактирования: " + data.dm
            }
        }
    }
    

}
