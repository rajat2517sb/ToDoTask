//
//  TaskViewModel.swift
//  MOAssignment
//
//  Created by Rajat Babhulgaonkar on 27/06/21.
//

import UIKit

class TaskViewModel: NSObject {
    
    private let manager               = TaskManager()
    private var todaysTask            : [Task]? = nil
    private var tomorrowsTask         : [Task]? = nil
    private var upcomingTask          : [Task]? = nil
    let sections                      = ["Today","Tomorrow","Upcoming"]
    var openModify                    : ((Task) -> ())?
    var openAdd                       : ((TaskType) -> ())?
    
    func setUpDataFromDB(){
        let allTasks   = manager.fetchTask()
        todaysTask     = allTasks?.filter({$0.type == TaskType.today.rawValue})
        tomorrowsTask  = allTasks?.filter({$0.type == TaskType.tomorrow.rawValue})
        upcomingTask   = allTasks?.filter({$0.type == TaskType.upcoming.rawValue})
    }
    
    func setNumberOfRowsSections(section :Int) -> Int {
        switch section {
        case 0:
            return todaysTask?.count ?? 0
        case 1:
            return tomorrowsTask?.count ?? 0
        case 2:
            return upcomingTask?.count ?? 0
        default:
            return 0
        }
    }
    
    func setNumberOfSections() -> Int {
        return sections.count
    }
    
    func configureCellDetails(indexpath:IndexPath,section:Int,cell:TaskTableViewCell) {
        var data:Task?
        switch indexpath.section {
        case 0:
            data = todaysTask?[indexpath.row]
        case 1:
            data = tomorrowsTask?[indexpath.row]
        case 2:
            data = upcomingTask?[indexpath.row]
        default:
            data = Task(title: "", description: "", type: 0, id: UUID(uuidString: "123")!)
        }
        if let data = data{
            cell.setData(data: data)
        }
    }
    
    func manageSelectionOfCell(indexpath:IndexPath,section:Int){
        
        var selectedData:Task?
        switch indexpath.section {
        case 0:
            selectedData = todaysTask?[indexpath.row]
        case 1:
            selectedData = tomorrowsTask?[indexpath.row]
        case 2:
            selectedData = upcomingTask?[indexpath.row]
        default:
            selectedData = Task(title: "", description: "", type: 0, id: UUID(uuidString: "123")!)
        }
        guard let data = selectedData else{
            return
        }
        if let modify = openModify{
            modify(data)
        }
    }
    
    func setHeaderForSection(headerView:SectionHeaderView,section: Int) {
        
        headerView.setData(data: sections[section],tag: section)
        headerView.addTask = { [unowned self] (section) in
            let type = TaskType.init(rawValue: Int16(section)) ?? .upcoming
            if let add = openAdd{
                add(type)
            }
        }
    }
}
