//
//  ButtonLayoutView.swift
//  DungeonDice
//
//  Created by Lori Rothermel on 3/29/23.
//

import SwiftUI

struct ButtonLayout: View {
    
    @State private var buttonsLeftOver = 0   // # of buttons in a less-than full row.
    
    @Binding var resultMessage: String
    
    
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
    
    // A preference key struct which we'll use to pass values up from child to parent View.
    struct DeviceWidthPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
        
        typealias Value = CGFloat
        
        
    }
    
    
    
    var body: some View {
            VStack {
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
                    }  // ForEach
                }  // HStack
            }  // VStack
            .overlay {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: DeviceWidthPreferenceKey.self, value: geo.size.width)
                }  // GeometryReader
            }  // overlay
            .onPreferenceChange(DeviceWidthPreferenceKey.self) { deviceWidth in
                arrangeGridItems(deviceWidth: deviceWidth)
            }  // onPreferenceChange
    }  // buttonLayoutView End
    
    func arrangeGridItems(deviceWidth: CGFloat) {
        var screenWidth = deviceWidth - horizontalPadding * 2   // Padding on both sides
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        // Calculate numberOfButtonsPerRow as an Int
        let numberOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        buttonsLeftOver = Dice.allCases.count % numberOfButtonsPerRow
    }
}  // ButtonLayout End

struct ButtonLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLayout(resultMessage: .constant(""))
    }
}
