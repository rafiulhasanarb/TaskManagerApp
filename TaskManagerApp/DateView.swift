//
//  DateView.swift
//  TaskManagerApp
//
//  Created by Rafiul Hasan on 11/21/24.
//

import SwiftUI

struct DateView: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var coreDate: Date = Date()
    @State var quickNote: String = ""
    @State var editing: Bool = false
    @Binding var edit: Bool
    @State var save: Bool = false
    @AppStorage("note") var note: String?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(coreDate.formatted(.dateTime.hour(.defaultDigits(amPM: .omitted)).minute()))
                Text(coreDate.formatted(.dateTime.week()))
            }
            .font(.system(size: 50, weight: .medium, design: .default))
            
            Rectangle()
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.gray.opacity(0.5))
                .overlay(alignment: .top) {
                    Rectangle()
                        .frame(height: 20)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.yellow)
                }
                .cornerRadius(10)
                .overlay(alignment: .center) {
                    if editing {
                        TextField("New Note", text: $quickNote)
                            .foregroundStyle(.white)
                            .frame(height: 30)
                            .background(Color.gray.opacity(0.2).cornerRadius(5))
                            .offset(y: 5)
                    } else {
                        Text(note ?? "")
                            .bold()
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    if edit {
                        Button {
                            if !quickNote.isEmpty {
                                note = quickNote
                                quickNote = ""
                            }
                            editing.toggle()
                            save.toggle()
                        } label: {
                            Image(systemName: "pencil")
                                .bold()
                                .foregroundStyle(.blue)
                        }
                        .padding(6)
                    }
                    
                    if save {
                        Button {
                            if !quickNote.isEmpty {
                                note = quickNote
                                quickNote = ""
                            }
                            editing.toggle()
                            save.toggle()
                        } label: {
                            Image(systemName: "checkmark")
                                .bold()
                                .foregroundStyle(.blue)
                        }
                        .padding(6)
                    }
                }
            
        }
        .onReceive(timer) { value in
            coreDate = value
        }
    }
}

#Preview {
    DateView(edit: .constant(false))
}
