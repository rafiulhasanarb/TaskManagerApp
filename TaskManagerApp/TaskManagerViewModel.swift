//
//  TaskManagerViewModel.swift
//  TaskManagerApp
//
//  Created by Rafiul Hasan on 11/21/24.
//

import CoreData
import Foundation

class TaskManagerViewModel: ObservableObject {
    
    @Published var taskTitle: String = ""
    @Published var taskDescription: String = ""
    @Published var taskIcon: String = ""
    @Published var taskColor: String = ""
    @Published var taskDeadline: Date = Date()
    @Published var showDatePicker: Bool = false
    @Published var newTaskView: Bool = false
    
    
    func addNewTask(context: NSManagedObjectContext) -> Bool {
        let newTask = Task(context: context)
        newTask.title = taskTitle
        newTask.descriptiont = taskDescription
        newTask.color = taskColor
        newTask.icon = taskIcon
        newTask.deadline = taskDeadline
        
        do {
            try context.save()
            return true
        } catch {
            print("Error saving task: \(error)")
            return false
        }
    }
    
    func deleteTask(context: NSManagedObjectContext, task: Task) -> Bool {
        context.delete(task)
        do {
            try context.save()
            return true
        } catch {
            print("Error delete task: \(error)")
            return false
        }
    }
    
    func resetTask() {
        taskTitle = ""
        taskDescription = ""
        taskIcon = ""
        taskColor = ""
        taskDeadline = Date()
    }
}
