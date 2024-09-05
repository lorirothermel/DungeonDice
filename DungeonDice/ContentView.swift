//
//  ContentView.swift
//  DungeonDice
//
//  Created by Lori Rothermel on 9/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var resultMessage = ""
    
    
    enum Dice: Int {
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
        VStack {
            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.red)
            
            Spacer()
            
            Text(resultMessage)
                .font(.largeTitle)
                .fontWeight(.medium)
                .frame(height: 150)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Group {
                HStack {
                    Button("\(Dice.four.rawValue)-sided") {
                        resultMessage = "You Rolled a \(Dice.four.roll()) on a \(Dice.four.rawValue)-sided Dice."
                    }  // Button
                    Spacer()
                    Button("\(Dice.six.rawValue)-sided") {
                        resultMessage = "You Rolled a \(Dice.six.roll()) on a \(Dice.six.rawValue)-sided Dice."
                    }  // Button
                    Spacer()
                    Button("\(Dice.eight.rawValue)-sided") {
                        resultMessage = "You Rolled a \(Dice.eight.roll()) on a \(Dice.eight.rawValue)-sided Dice."
                    }  // Button
                }  //HStack
                
                HStack {
                    Button("\(Dice.ten.rawValue)-sided") {
                        resultMessage = "You Rolled a \(Dice.ten.roll()) on a \(Dice.ten.rawValue)-sided Dice."
                    }  // Button
                    Spacer()
                    Button("\(Dice.twelve.rawValue)-sided") {
                        resultMessage = "You Rolled a \(Dice.twelve.roll()) on a \(Dice.twelve.rawValue)-sided Dice."
                    }  // Button
                    Spacer()
                    Button("\(Dice.twenty.rawValue)-sided") {
                        resultMessage = "You Rolled a \(Dice.twenty.roll()) on a \(Dice.twenty.rawValue)-sided Dice."
                    }  // Button
                }  //HStack
                
                Button("\(Dice.hundred.rawValue)-sided") {
                    resultMessage = "You Rolled a \(Dice.hundred.roll()) on a \(Dice.hundred.rawValue)-sided Dice."
                }  // Button
                
            }  // Group
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .padding(.leading)
            .padding(.trailing)
            
        }  // VStack
        .padding()
    }  // some View
}  // ContentView

#Preview {
    ContentView()
}
