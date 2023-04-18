//
//  FavouritesView.swift
//  Jokes
//
//  Created by Justin Hui on 18/4/2023.
//

import Blackbird
import SwiftUI

struct FavouritesView: View {
    
    //MARK: Stored Properties
    
    //Access the connection to the database (needed to add a delete record)
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    //The list of favourite jokes
    @BlackbirdLiveModels({ db in
        try await Joke.read(from: db)
    }) var favouriteJokes
    
    //MARK: Computed Properties
    var body: some View {
        
        NavigationView{
            
            List {
                
                ForEach (favouriteJokes.results) { currentJoke in
                    
                    VStack(alignment: .leading) {
                        Text(currentJoke.setup)
                            .bold()
                        Text(currentJoke.punchline)
                        
                    }
                }.onDelete(perform: removeRows)
            }
            .navigationTitle("Saved Jokes")
        }
    }
    
    //MARK: Functions
    func removeRows(at offsets: IndexSet) {
        
        Task{
            try await db!.transaction { core in
                
                //Get ID of item to be deleted
                var idList = ""
                for offset in offsets {
                    idList += "\(favouriteJokes.results[offset].id),"
                }
                
                //Remove final comma
                print(idList)
                idList.removeLast()
                print(idList)
                
                //Delete the row from the database
                try core.query("DELETE FROM Joke WHERE id IN (?)", idList)
            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
        //Make the database avaiable to this view in XCode previews
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
