//
//  ContentView.swift
//  DungeonDice
//
//  Created by Lori Rothermel on 9/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var resultMessage = ""
    @State private var buttonsLeftOver = 0  // # buttons in a less-than-full row.
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 0   // Spacing between buttons
    let buttonWidth: CGFloat = 102
        
    
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
        
        GeometryReader { geo in
            
            VStack {
                
                titleView
                
                resultMessageView
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)], content: {
                    ForEach(Dice.allCases.dropLast(buttonsLeftOver), id: \.self) { die in
                        Button("\(die.rawValue)-sided") {
                            resultMessage = "You rolled a \(die.roll()) on a \(die.rawValue)-sided dice."
                        }  // Button
                        .frame(width: buttonWidth)
                    }  // ForEach
                })  // LazyVGrid
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
                HStack {
                    ForEach(Dice.allCases.suffix(buttonsLeftOver), id: \.self) { die in
                        Button("\(die.rawValue)-sided") {
                            resultMessage = "You rolled a \(die.roll()) on a \(die.rawValue)-sided dice."
                        }  // Button
                        .frame(width: buttonWidth)
                        
                    }  // ForEach
                }  // HStack
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
            }  // VStack
            .padding()
            .onChange(of: geo.size.width, { _, newValue in
                arrangeGridItems(deviceWidth: geo.size.width)
            })  // .onChange
            .onAppear {
                arrangeGridItems(deviceWidth: geo.size.width)
            }  // .onAppear

        }  // GeometryReader
        
    }  // some View
    
    func arrangeGridItems(deviceWidth: CGFloat) {
        
        var screenWidth = deviceWidth - (horizontalPadding*2)  // horizontalpadding on both sides.
        
        if Dice.allCases.count > 1 {
            screenWidth = screenWidth + spacing
        }  // if
        
        // Calculate numOfButtonsPerRow as an Int
        let numberOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        
        buttonsLeftOver = Dice.allCases.count % numberOfButtonsPerRow
        print("numberOfButtonsPerRow = \(numberOfButtonsPerRow)")
        print("buttonsLeftOver = \(buttonsLeftOver)")
        
        
        
    }
    
}  // ContentView



extension ContentView {
    
    private var titleView: some View {
        Text("Dungeon Dice")
            .font(Font.custom("Snell Roundhand", size: 60))
            .fontWeight(.black)
            .foregroundColor(.red)
            .minimumScaleFactor(0.5)
            .lineLimit(1)
    }
    
    private var resultMessageView: some View {
        Text(resultMessage)
            .font(.largeTitle)
            .fontWeight(.medium)
            .frame(height: 150)
            .multilineTextAlignment(.center)
    }
}







#Preview {
    ContentView()
}

