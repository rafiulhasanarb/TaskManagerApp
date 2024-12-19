//
//  TaskManagerAppApp.swift
//  TaskManagerApp
//
//  Created by Rafiul Hasan on 11/21/24.
//

import SwiftUI

@main
struct TaskManagerAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
