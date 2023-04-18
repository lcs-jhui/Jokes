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
    
    //The list of favourite jokes
    @BlackbirdLiveModels({ db in
        try await Joke.read(from: db)
    }) var favouriteJokes
    
    //MARK: Computed Properties
    var body: some View {
        
        NavigationView{
            
            List(favouriteJokes.results) { currentJoke in
                VStack(alignment: .leading) {
                    Text(currentJoke.setup)
                        .bold()
                    Text(currentJoke.punchline)
                }
            }.navigationTitle("Saved Jokes")
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
