//
//  JokesApp.swift
//  Jokes
//
//  Created by Justin Hui on 14/4/2023.
//

import SwiftUI

@main
struct JokesApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                JokeView()
                    .tabItem{
                        Label("Fresh", systemImage: "carrot")
                    }
                
                FavouritesView()
                    .tabItem{
                        Label("Favourites", systemImage: "face.smiling")
                    }
            }
        }
    }
}
