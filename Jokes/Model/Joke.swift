//
//  Joke.swift
//  Jokes
//
//  Created by Justin Hui on 14/4/2023.
//

import Foundation
struct Joke: Identifiable, Codable {
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}

let exampleJoke = Joke(type: "general", setup: "How much does a hipster weigh", punchline: "An instagram", id: 146)
