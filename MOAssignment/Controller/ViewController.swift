//
//  ViewController.swift
//  MOAssignment
//
//  Created by Rajat Babhulgaonkar on 26/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView      : UITableView!
    private let cellReuseIdentifier   = "TaskTableViewCell"
    private let headerReuseIdentifier = "TaskTableViewCell"
    
    var taskViewModel = TaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpData()
    }
    
    private func setUp(){
        self.title   = "Tasks"
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
    }
    
    private func setUpData(){
        taskViewModel.setUpDataFromDB()
        taskViewModel.openAdd = { [unowned self] type in
            self.openAddController(type: type)
        }
        taskViewModel.openModify = { [unowned self] data in
            self.openModifyController(data: data)
        }
        self.tableView.reloadData()
    }
    
    private func openModifyController(data : Task){
        let controller      = ModifyViewController()
        controller.taskData = data
        self.navigationController?.restorationIdentifier = "Modify"
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func openAddController(type : TaskType){
        
        let controller      = ModifyViewController()
        controller.taskType = type
        self.navigationController?.restorationIdentifier = "Add"
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return taskViewModel.setNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskViewModel.setNumberOfRowsSections(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! TaskTableViewCell
        taskViewModel.configureCellDetails(indexpath: indexPath, section: indexPath.section, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskViewModel.manageSelectionOfCell(indexpath: indexPath, section: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView     = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier) as! SectionHeaderView
        taskViewModel.setHeaderForSection(headerView: headerView, section: section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

