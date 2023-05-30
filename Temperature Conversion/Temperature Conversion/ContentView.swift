//
//  ContentView.swift
//  Temperature Conversion
//
//  Created by Juliana Nielson on 5/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var startingScale = "Fahrenheit"
    @State private var inputDegrees = ""
    @State private var convertingScale = "Celsius"
    @FocusState private var inputing: Bool
    
    let scaleOptions = ["Fahrenheit", "Celsius", "Kelvin"]
    
    var outputDegrees: Double? {
        guard inputDegrees != "" else { return nil }
        let currentTemp = Double(inputDegrees) ?? 0
        switch (startingScale, convertingScale) {
        case ("Fahrenheit", "Celsius"):
            return (currentTemp - 32) * 5 / 9
        case ("Fahrenheit", "Kelvin"):
            return (currentTemp - 32) * 5 / 9 + 273.15
        case ("Celsius","Fahrenheit"):
            return (currentTemp * 9) / 5 + 32
        case ("Celsius","Kelvin"):
            return currentTemp + 273.15
        case ("Kelvin","Fahrenheit"):
            return (currentTemp - 273.15) * 9 / 5 + 32
        case ("Kelvin","Celsius"):
            return currentTemp - 273.15
        case ("Fahrenheit", "Fahrenheit"), ("Celsius", "Celsius"), ("Kelvin", "Kelvin"):
            return currentTemp
        default:
            return 0
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Convert From:", selection: $startingScale) {
                        ForEach(scaleOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Picker("Convert To:", selection: $convertingScale) {
                        ForEach(scaleOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Temperature in degrees (\(startingScale))", text: $inputDegrees)
                        .keyboardType(.decimalPad)
                        .focused($inputing)
                }
                
                Section {
                    Text(outputDegrees ?? 0, format: .number)
                } header: {
                    Text("Converted Temperature")
                }
            }
            .navigationTitle("Temperature Conversion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputing = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
