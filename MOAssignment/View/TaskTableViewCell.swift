//
//  TaskTableViewCell.swift
//  MOAssignment
//
//  Created by Rajat Babhulgaonkar on 26/06/21.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:Task){
        taskTitle.text       = data.title
        taskDescription.text = data.description
    }
}
