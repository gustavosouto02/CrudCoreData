//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Gustavo Souto Pereira on 27/06/25.
//

import SwiftUI

@main
struct MovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        }
    }
}
