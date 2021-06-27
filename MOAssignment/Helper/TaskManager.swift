//
//  TaskManager.swift
//  MOAssignment
//
//  Created by Rajat Babhulgaonkar on 26/06/21.
//

import Foundation

struct TaskManager
{
    private let _taskDataRepository = TaskDataRepository()

    func createTask(task: Task) {
        _taskDataRepository.create(task: task)
    }

    func fetchTask() -> [Task]? {
        return _taskDataRepository.getAll()
    }

    func fetchTask(byIdentifier id: UUID) -> Task?
    {
        return _taskDataRepository.get(byIdentifier: id)
    }

    func updateTask(task: Task) -> Bool {
        return _taskDataRepository.update(task: task)
    }

    func deleteTask(id: UUID) -> Bool {
        return _taskDataRepository.delete(id: id)
    }
}
