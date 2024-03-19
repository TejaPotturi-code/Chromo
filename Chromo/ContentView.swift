//
//  ContentView.swift
//  Chromo
//
//  Created by Teja Potturi on 3/17/24.
//

import SwiftUI

struct ContentView: View {
    let color1 = Color.red
    let color2 = Color.white
    
    @State var colorsAdded : [Color] = []
    @State var mixedColor : Color = .white
    @State var colorselected : Color = .red
    
    
    var body: some View {
        
        ScrollView {
            Circle()
                .fill(mixedColor)
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 300, height: 300)
                .padding(.top)
            
            ColorPicker(selection: $colorselected, label: {
                Text("Select color ")
                    .font(.title3)
                    .foregroundStyle(Color.white)
                    .padding()
            })
            .background(content: {
                Color.accentColor
            })
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            
            HStack {
                Button {
                    mixColors(mixedColor, colorselected)
                    colorsAdded.append(mixedColor)
                } label: {
                    Text("Mix")
                        .padding(.horizontal)
                        .font(.title2)
                    
                }
                .buttonStyle(.borderedProminent)
                .frame(width: 200)
                
                if colorsAdded.count > 0 {
                    Button(action: {
                        if colorsAdded.count > 0 {
                            colorsAdded.removeLast()
                        }
                        mixedColor = colorsAdded.last ?? .white
                    }, label: {
                        Image(systemName: "arrow.uturn.backward")
                    })
                }
            }
            
            Text("Colors Added:")
                .font(.title2)
                .padding()
            ForEach(colorsAdded, id: \.self) { color in
                HStack {
                    Circle()
                        .fill(color)
                        .frame(width: 20,height: 20)
                    Text("\(color.description)")
                }
            }
            .padding(.top)
        }
        
    }
    
    func mixColors(_ color1: Color, _ color2: Color) {
        // Extract components of each color
        if color1 == .white {
            mixedColor = color2
            return
        }
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        
        UIColor(color1).getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        UIColor(color2).getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        // Mix the components
        let mixedRed = (r1 + r2) / 2
        let mixedGreen = (g1 + g2) / 2
        let mixedBlue = (b1 + b2) / 2
        
        mixedColor = Color(red: Double(mixedRed), green: Double(mixedGreen), blue: Double(mixedBlue))
    }

}

#Preview {
    ContentView()
}

