//
//  Joke.swift
//  Jokes
//
//  Created by Justin Hui on 14/4/2023.
//

import Blackbird
import Foundation
struct Joke: Identifiable, Codable, BlackbirdModel {
    @BlackbirdColumn var type: String
    @BlackbirdColumn var setup: String
    @BlackbirdColumn var punchline: String
    @BlackbirdColumn var id: Int
}

let exampleJoke = Joke(type: "general", setup: "How much does a hipster weigh", punchline: "An instagram", id: 146)
