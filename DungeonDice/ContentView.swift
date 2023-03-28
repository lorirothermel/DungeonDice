//
//  ContentView.swift
//  DungeonDice
//
//  Created by Lori Rothermel on 3/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var resultMessage = ""
    @State private var buttonsLeftOver = 0   // # of buttons in a less-than full row.
        
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 0   // between buttons
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
        }
    }
    
    
    var body: some View {
        
        GeometryReader { geo in
            
            VStack {
                Text("Dungeon Dice")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.red)
            
                Spacer()
                
                Text(resultMessage)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .frame(height: 150)
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)]) {
                    ForEach(Dice.allCases.dropLast(buttonsLeftOver), id: \.self) { dice in
                                    Button("\(dice.rawValue)-sided") {
                                        resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice."
                                    }  // Button
                                    .frame(width: buttonWidth)
                                }  // ForEach
                                .buttonStyle(.borderedProminent)
                                .tint(.red)
                }  // LazyVGrid
                
                HStack {
                    ForEach(Dice.allCases.suffix(buttonsLeftOver), id: \.self) { dice in
                        Button("\(dice.rawValue)-sided") {
                            resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice."
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                }  // HStack
                
                
            }  // VStack
            .padding()
            .onChange(of: geo.size.width, perform: { newValue in
                arrangeGridItems(geo: geo)
            })
            .onAppear {
                arrangeGridItems(geo: geo)
            }  // onAppear
            
        }  // GeometryReader

    }  // some View
    
    
    func arrangeGridItems(geo: GeometryProxy) {
        var screenWidth = geo.size.width - horizontalPadding * 2   // Padding on both sides
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        // Calculate numberOfButtonsPerRow as an Int
        let numberOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        buttonsLeftOver = Dice.allCases.count % numberOfButtonsPerRow
        
    }
    
    
    
}  // ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
