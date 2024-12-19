//
//  TaskCard.swift
//  TaskManagerApp
//
//  Created by Rafiul Hasan on 11/22/24.
//

import SwiftUI

struct TaskCard: View {
    
    @Environment(\.self) var environment
    @EnvironmentObject var taskManager: TaskManagerViewModel
    var title: String = ""
    var description: String = ""
    var iconName: String = ""
    var colorName: String = ""
    var dateDate: String = ""
    var dateTime: String = ""
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 160)
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color("note"))
                .overlay(alignment: .leading) {
                    Rectangle()
                        .frame(width: 6, height: 130)
                        .foregroundStyle(.red.opacity(0.6))
                        .cornerRadius(5)
                }
                .overlay(alignment: .top) {
                    VStack {
                        HStack {
                            Text(title)
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: iconName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 35, height: 35)
                                .clipShape(Rectangle())
                                .foregroundColor(.red)
                            
                        }
                        .padding(.horizontal, 10)
                        
                        Text(description)
                            .minimumScaleFactor(0.9)
                            .multilineTextAlignment(.leading)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(height: 85)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                    }
                }
                .overlay(alignment: .bottomLeading) {
                    HStack {
                        Image(systemName: "calendar")
                        Text(dateDate)
                        
                        Image(systemName: "clock.arrow.circlepath")
                        Text(dateTime)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                }
                .cornerRadius(10)
        }
    }
}

#Preview {
    TaskCard()
        .environmentObject(TaskManagerViewModel())
}
