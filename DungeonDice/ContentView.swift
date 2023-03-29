//
//  ContentView.swift
//  DungeonDice
//
//  Created by Lori Rothermel on 3/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var resultMessage = ""

    
    

    
    
    var body: some View {
        
   
            
            VStack {
                
                titleView
                                    
                Spacer()
                
                resultMessageView
                
                Spacer()
                
                ButtonLayout(resultMessage: $resultMessage)
           
                
            }  // VStack
            .padding()

            
        

    }  // some View
    
    

    
    
    
}  // ContentView


extension ContentView {
    private var titleView: some View {
        Text("Dungeon Dice")
            .font(.largeTitle)
            .lineLimit(1)
            .fontWeight(.black)
            .foregroundColor(.red)
    }
    
    private var resultMessageView: some View {
        Text(resultMessage)
            .font(.title)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .frame(height: 150)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

