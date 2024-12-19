//
//  HomeView.swift
//  TaskManagerApp
//
//  Created by Rafiul Hasan on 11/21/24.
//

import SwiftUI

struct HomeView: View {
    @State var editing: Bool = false
    @State var edit: Bool = false
    @State var isShiking: Bool = false
    @Environment(\.self) var environment
    @ObservedObject var taskManager: TaskManagerViewModel = .init()
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], animation: .easeInOut)
    var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    DateView(edit: $editing)
                    
                    ForEach(tasks) { item in
                        VStack {
                            TaskCard(title: item.title ?? "", description: item.description, dateDate: (item.deadline ?? Date()).formatted(date: .long, time: .omitted), dateTime: (item.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                                .overlay(alignment: .bottomTrailing) {
                                    if editing {
                                        Button(action: {
                                            edit.toggle()
                                            if taskManager.deleteTask(context: environment.managedObjectContext, task: item) {
                                                
                                            }
                                        }) {
                                            Image(systemName: "trash")
                                                .font(.title2)
                                                .foregroundStyle(.red)
                                                .offset(x: 10, y: isShiking ? -3 : 3)
                                        }
                                        .padding(5)
                                    } else {
                                        if taskManager.deleteTask(context: environment.managedObjectContext, task: item) {
                                            Button(action: {
                                                edit.toggle()
                                            }) {
                                                Image(systemName: "trash")
                                            }
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            .padding(10)
            .overlay {
                Button(action: {
                    taskManager.resetTask()
                    taskManager.newTaskView.toggle()
                }) {
                    Text("New Task")
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .background(Color.black, in: Capsule())
                }
            }
            .sheet(isPresented: $taskManager.newTaskView) {
                AddTaskView()
                    .environmentObject(taskManager)
            }
        }
        .navigationBarItems(leading: Button(action: {
            self.editing.toggle()
            withAnimation(Animation.default.speed(2).repeatForever(autoreverses: true).delay(0.2)) {
                self.isShiking.toggle()
            }
        }, label: {
            Image(systemName: "square.and.pencil.circle.fill")
                .font(.title2)
                .foregroundStyle(.yellow)
        }))
        
    }
}

#Preview {
    HomeView()
}
