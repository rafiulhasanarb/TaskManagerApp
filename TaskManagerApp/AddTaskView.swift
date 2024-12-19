//
//  AddTaskView.swift
//  TaskManagerApp
//
//  Created by Rafiul Hasan on 11/24/24.
//

import SwiftUI

struct AddTaskView: View {
    
    @EnvironmentObject var taskManager: TaskManagerViewModel
    @Environment(\.self) var environment
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .pink, .cyan, .mint, .orange, .teal]
    let icons: [String] = ["circle.fill", "square.fill", "checkmark.circle.fill"]
    
    var body: some View {
        VStack {
            Text("New Task")
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button(action: {
                        environment.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .bold()
                            .foregroundStyle(.red)
                    }
                }
            
            VStack {
                BarColorView(taskManager: _taskManager, colors: colors, section: "Colors")
                IconView(taskManager: _taskManager, icons: icons, section: "Icons")
                Divider()
                HStack {
                    Text(taskManager.taskDeadline.formatted(date: .abbreviated, time: .omitted) + taskManager.taskDeadline.formatted(date: .omitted, time: .shortened))
                    Spacer()
                    Button(action: {
                        taskManager.showDatePicker.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    AddTaskView()
        .environmentObject(TaskManagerViewModel())
}

struct BarColorView: View {
    
    @EnvironmentObject var taskManager: TaskManagerViewModel
    let colors: [Color]
    let section: String
    
    var body: some View {
        
        Text(section)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 25, height: 25)
                        .background {
                            if taskManager.taskColor == color {
                                Circle()
                                    .strokeBorder(.gray)
                                    .padding(-3)
                            }
                        }
                        .onTapGesture {
                            taskManager.taskColor = color
                        }
                }
            }
            .padding()
        }
        
    }
}

struct IconView: View {
    
    @EnvironmentObject var taskManager: TaskManagerViewModel
    let icons: [String]
    let section: String
    
    var body: some View {
        Text(section)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(icons, id: \.self) { icon in
                    Circle()
                    Image(systemName: icon)
                        .resizable()
                        .clipShape(Rectangle())
                        .frame(width: 25, height: 25)
                        .background {
                            if taskManager.taskIcon == icon {
                                Circle()
                                    .strokeBorder(.gray)
                                    .padding(-3)
                            }
                        }
                        .onTapGesture {
                            taskManager.taskIcon = icon
                        }
                }
            }
            .padding()
        }
    }
}
