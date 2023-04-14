//
//  JokeView.swift
//  Jokes
//
//  Created by Justin Hui on 14/4/2023.
//

import SwiftUI

struct JokeView: View {
    var body: some View {
        NavigationView{
            
            VStack{
                
                Text("You see, mountains aren't just funny.")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                }, label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .tint(.black)
                    
                })
                
            }
            .navigationTitle("Random Jokes")
        }
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}
