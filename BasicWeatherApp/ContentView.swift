//
//  ContentView.swift
//  BasicWeatherApp
//
//  Created by Armando Francisco on 10/19/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var tempNum: Double = 0.0
    @State private var tempUnit: String = "F"
    @FocusState private var tempNumIsFocused: Bool
    
    private let tempUnits: [String] = ["F","C","K"]
    
    private var changeTemp: (
        FtoC:String,
        FtoK:String,
        CtoF:String,
        CtoK:String,
        KtoC:String,
        KtoF:String
    ) {
        // Fahrenheit to celsius formula((fahrenheit - 32) * 5) / 9
        let FtoC: Double = ((tempNum - 32) * 5) / 9
        // Fahrenheit to celsius formula(((fahrenheit - 32) * 5) / 9) + 273.15
        let FtoK: Double = (((tempNum - 32) * 5) / 9) + 273.15
        
        // celsius to Fahrenheit formula((celsius * 9) / 5) + 32
        let CtoF: Double = ((tempNum * 9) / 5) + 32
        // celsius to Kelvin formula(celsius + 273.15)
        let CtoK: Double = tempNum + 273.15
        
        // kelvin to celsius
        let KtoC: Double = tempNum - 273.15
        // kelvin to fahrenheit formula(K - 273.15) * 1.8 + 32
        let KtoF: Double = (tempNum - 273.15) * 1.8 + 32
        
        return (
            FtoC:String(format: "%.2f", FtoC),
            FtoK:String(format: "%.2f", FtoK),
            CtoF:String(format: "%.2f", CtoF),
            CtoK:String(format: "%.2f", CtoK),
            KtoC:String(format: "%.2f", KtoC),
            KtoF:String(format: "%.2f", KtoF)
        )
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section("Temperature Value & Unit") {
                    
                    TextField("Temperature Value", value: $tempNum, format:.number)
                        .keyboardType(.decimalPad)
                        .focused($tempNumIsFocused)
                    
                    Picker("Temperature Unit", selection: $tempUnit) {
                        ForEach(tempUnits, id: \.self) {
                            Text("\($0)°")
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section {
                    if tempUnit == "F" {
                        Text("converted to \(changeTemp.FtoC) C°")
                        Text("converted to \(changeTemp.FtoK) K°")
                        
                    } else if tempUnit == "C" {
                        Text("converted to \(changeTemp.CtoF) F°")
                        Text("converted to \(changeTemp.CtoK) K°")
                    } else {
                        Text("converted to \(changeTemp.KtoC) C°")
                        Text("converted to \(changeTemp.KtoF) F°")
                    }
                }
            }
            .navigationTitle("Simple Temp Converter").navigationBarTitleDisplayMode(.inline)
            .fontDesign(.rounded)
            .toolbar {
                if tempNumIsFocused {
                    Button("Done") {
                        tempNumIsFocused = false
                    }
                }
            }
        }
        
    }
    

}
#Preview {
    ContentView()
}
