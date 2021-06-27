//
//  ModifyViewController.swift
//  MOAssignment
//
//  Created by Rajat Babhulgaonkar on 26/06/21.
//

import UIKit

class ModifyViewController              : UIViewController {
    
    @IBOutlet weak var txtTitle         : UITextView!
    @IBOutlet weak var txtDescription   : UITextView!
    @IBOutlet weak var btnUpdate        : UIButton!
    @IBOutlet weak var btnDelete        : UIButton!
    @IBOutlet weak var btnAdd           : UIButton!
    var taskData                        : Task?
    var taskType                        : TaskType?
    private let manager                 = TaskManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        txtTitle.delegate                 = self
        txtDescription.delegate           = self
        if self.navigationController?.restorationIdentifier == "Add"{
            self.title                    = "Add Task"
            btnUpdate.isHidden            = true
            btnDelete.isHidden            = true
            btnAdd.isHidden               = false
            txtTitle.textColor            = .lightGray
            txtDescription.textColor      = .lightGray
            btnAdd.layer.cornerRadius     = 5
        }else{
            self.title                    = "Modify Task"
            txtTitle.text                 = taskData?.title
            txtDescription.text           = taskData?.description
            btnUpdate.layer.cornerRadius  = 5
            btnDelete.layer.cornerRadius  = 5
            btnUpdate.isHidden            = false
            btnDelete.isHidden            = false
            btnAdd.isHidden               = true
            txtTitle.textColor            = .black
            txtDescription.textColor      = .black
            txtTitle.becomeFirstResponder()
        }
        
    }
    
    @IBAction func updateAction(_ sender: UIButton) {
        guard let data = taskData else { return  }
        if data.title == self.txtTitle.text && data.description == self.txtDescription.text {
            displayErrorAlert(alertMessage: "Please update the data")
        }else{
            let task = Task(title: self.txtTitle.text, description: self.txtDescription.text, type: data.type, id: data.id)
            if(manager.updateTask(task: task))
            {
                displayAlert(alertMessage: "Record Updated Successfully")
            }else
            {
                displayErrorAlert(alertMessage: "Something went wrong, please try again later")
            }
        }
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        guard let task = taskData else { return  }
        if(manager.deleteTask(id: task.id))
        {
            displayAlert(alertMessage: "Record deleted Successfully")
        }
        else
        {
            displayErrorAlert(alertMessage: "Something went wrong, please try again later")
        }
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        if self.txtTitle.text.isEmpty{
            displayErrorAlert(alertMessage: "Please Add Task Title")
        }else{
            let task = Task(title: self.txtTitle.text, description: self.txtDescription.text, type: taskType?.rawValue, id: UUID())
            manager.createTask(task: task)
            displayAlert(alertMessage: "Record Added Successfully")
        }
    }
    
    
    // MARK: Private functions
    private func displayAlert(alertMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    private func displayErrorAlert(alertMessage:String)
    {
        let errorAlert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
    }
}

extension ModifyViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text      = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text      = textView.tag == 0 ? "Title" : "Description"
            textView.textColor = UIColor.lightGray
        }
    }
}
