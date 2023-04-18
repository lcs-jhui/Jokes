//
//  JokeView.swift
//  Jokes
//
//  Created by Justin Hui on 14/4/2023.
//

import Blackbird
import SwiftUI

struct JokeView: View {
    
    //MARK: Stored Properties
    
    //Access the connection to the database (needed to add a new record)
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    //0.0 is invisible, 1.0 is visible
    @State var punchLineOpacity = 0.0
    
    //The current joke to display
    @State var currentJoke: Joke?
    
    //MARK: Computed Properties
    var body: some View {
        NavigationView{
            
            VStack{
                
                Spacer()
                
                
                if let currentJoke = currentJoke {
                    
                    //Show the joke, if it can be unwrapped (if currentJoke is not nil)
                    Text(currentJoke.setup)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 1.0)){
                            punchLineOpacity = 1.0
                        }
                    }, label: {
                        Image(systemName: "arrow.down.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .tint(.black)
                        
                    })
                    
                    Text(currentJoke.punchline)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .opacity(punchLineOpacity)
                    
                } else {
                    //Show a spinning wheel indicator until the joke is loaded
                    ProgressView()
                }
                
                Spacer()
                
                Button(action: {
                                    // Reset the interface
                                    punchLineOpacity = 0.0

                                    Task {
                                        // Get another joke
                                        withAnimation {
                                            currentJoke = nil
                                        }
                                        currentJoke = await NetworkService.fetch()
                                    }
                                }, label: {
                                    Text("Fetch another one")
                                })
                                .disabled(punchLineOpacity == 0.0 ? true : false)
                                .buttonStyle(.borderedProminent)
                
                Button(action: {
                    
                    Task{
                        //Write to the database
                        if let currentJoke = currentJoke {
                            try await db!.transaction { core in
                                try core.query("INSERT INTO Joke (id, type, setup, punchline) VALUES (?,?,?,?)",
                                               currentJoke.id,
                                               currentJoke.type,
                                               currentJoke.setup,
                                               currentJoke.punchline)
                            }
                        }
                    }
                }, label: {
                    Text("Save for later")
                })
                .buttonStyle(.borderedProminent)
                
            }
            .navigationTitle("Random Jokes")
            .padding()
        }
        //Create an asynchronus task to be performed as this view appears
        .task {
            currentJoke = await NetworkService.fetch()
        }
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
        //Make the database avaiable to this view in Xcode previews
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
