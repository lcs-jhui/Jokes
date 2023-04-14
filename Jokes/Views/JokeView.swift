//
//  JokeView.swift
//  Jokes
//
//  Created by Justin Hui on 14/4/2023.
//

import SwiftUI

struct JokeView: View {
    
    //MARK: Stored Properties
    
    //0.0 is invisible, 1.0 is visible
    @State var punchLineOpacity = 0.0
    
    //MARK: Computed Properties
    var body: some View {
        NavigationView{
            
            VStack{
                
                Text("You see, mountains aren't just funny.")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    punchLineOpacity = 1.0
                }, label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .tint(.black)
                    
                })
                
                Text("THey are hill areas.")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .opacity(punchLineOpacity)
                
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
