//
//  TodoTask+CoreDataProperties.swift
//  MOAssignment
//
//  Created by Rajat Babhulgaonkar on 26/06/21.
//
//

import Foundation
import CoreData


extension TodoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTask> {
        return NSFetchRequest<TodoTask>(entityName: "TodoTask")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var taskDescription: String?
    @NSManaged public var taskTitle: String?
    @NSManaged public var taskType: Int16
    
    func convertToTask() -> Task{
        return Task(title: self.taskTitle, description: self.taskDescription, type: self.taskType, id: (self.id ?? UUID(uuidString: "123"))!)
    }

}

extension TodoTask : Identifiable {

}
