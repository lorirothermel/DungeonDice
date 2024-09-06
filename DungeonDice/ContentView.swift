//
//  ContentView.swift
//  DungeonDice
//
//  Created by Lori Rothermel on 9/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var resultMessage = ""
    
    
    enum Dice: Int, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }  // func roll
    }  // enum Dice
    
    
    var body: some View {
        
        Text("Dungeon Dice")
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.red)
          
        Text(resultMessage)
            .font(.largeTitle)
            .fontWeight(.medium)
            .frame(height: 150)
            .multilineTextAlignment(.center)
        
        Spacer()
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 102))], content: {
            ForEach(Dice.allCases, id: \.self) { die in
                Button("\(die.rawValue)-sided") {
                    resultMessage = "You rolled a \(die.roll()) on a \(die.rawValue)-sided dice."
                }  // Button
            }  // ForEach
        })  // LazyVGrid
        .buttonStyle(.borderedProminent)
        .tint(.red)
        
        
        
        
    }  // some View
}  // ContentView

#Preview {
    ContentView()
}
