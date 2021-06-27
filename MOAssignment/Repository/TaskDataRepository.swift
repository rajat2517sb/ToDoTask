//
//  TaskDataRepository.swift
//  MOAssignment
//
//  Created by Rajat Babhulgaonkar on 26/06/21.
//

import Foundation
import CoreData

protocol TaskRepository {
    func create(task: Task)
    func getAll() -> [Task]?
    func get(byIdentifier id: UUID) -> Task?
    func update(task: Task) -> Bool
    func delete(id: UUID) -> Bool
}

struct TaskDataRepository : TaskRepository
{
    func create(task: Task) {
        let toDoTask             = TodoTask(context: PersistentStorage.shared.context)
        toDoTask.taskTitle       = task.title
        toDoTask.taskDescription = task.description
        toDoTask.id              = task.id
        toDoTask.taskType        = task.type ?? 0
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Task]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: TodoTask.self)
        
        var tasks : [Task] = []
        
        result?.forEach({ (task) in
            tasks.append(task.convertToTask())
        })
        return tasks
    }
    
    func get(byIdentifier id: UUID) -> Task? {
        let result = getTask(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToTask()
    }
    
    func update(task: Task) -> Bool {
        let toDoTask              = getTask(byIdentifier: task.id)
        guard toDoTask != nil else {return false}
        toDoTask?.taskTitle       = task.title
        toDoTask?.taskDescription = task.description
        toDoTask?.id              = task.id
        toDoTask?.taskType        = task.type ?? 0
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(id: UUID) -> Bool {
        let toDoTask = getTask(byIdentifier: id)
        guard toDoTask != nil else {return false}
        
        PersistentStorage.shared.context.delete(toDoTask!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    
    private func getTask(byIdentifier id: UUID) -> TodoTask?
    {
        let fetchRequest = NSFetchRequest<TodoTask>(entityName: "TodoTask")
        let predicate    = NSPredicate(format: "id==%@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            guard result != nil else {return nil}
            
            return result
            
        } catch let error {
            debugPrint(error)
        }
        
        return nil
    }
    
    
}
