//
//  ContentView.swift
//  WeConvert
//
//  Created by Hai Long Danny Thi on 2020/04/28.
//  Copyright © 2020 Hai Long Danny Thi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private enum TemperatureUnit: Int, CaseIterable {
        case kelvin, fahrenheit, celcius
        var title:String {
            switch self {
            case .kelvin:
                return "Kelvin"
            case .fahrenheit:
                return "Fahrenheit"
            case .celcius:
                return "Celcius"
            }
        }
    }
    
    @State private var amount = ""
    @State private var convertFrom = 0
    @State private var convertTo = 0
    
    var converted: Double {
        guard let temperature = Double(amount) else { return 0 }
        let from = TemperatureUnit(rawValue: convertFrom) ?? TemperatureUnit.kelvin
        let to = TemperatureUnit(rawValue: convertTo) ?? TemperatureUnit.kelvin
        return convert(temperature: temperature, from: from, to: to)
    }
    
    var convertionTypes = ["Kelvin", "Fahrenheit", "Celcius"]
    
    var body: some View {
        
        Form {
            Section(header: Text("Enter amount to convert:")) {
                TextField("Temperature", text: $amount)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("... in...")) {
                Picker("", selection: $convertFrom) {
                    ForEach(0..<TemperatureUnit.allCases.count) {
                        Text("\(TemperatureUnit.allCases[$0].title)")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("... is...")) {
                Text("\(converted, specifier: "%.3f")")
            }
            
            Section(header: Text("... in...")) {
                Picker("", selection: $convertTo) {
                    ForEach(0..<TemperatureUnit.allCases.count) {
                        Text("\(TemperatureUnit.allCases[$0].title)")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
    }
    
    private func convert(temperature: Double, from: TemperatureUnit, to: TemperatureUnit) -> Double {
        switch from {
        case .kelvin:
            switch to {
            case .kelvin:
                return temperature
            case .fahrenheit:
                return (temperature - 273.15) * 9/5 + 32
            case .celcius:
                return temperature - 273.15
            }
            
        case .fahrenheit:
            switch to {
            case .kelvin:
                return (temperature - 32) * 5/9 + 273.15
            case .fahrenheit:
                return temperature
            case .celcius:
                return (temperature - 32) * 5/9
            }
            
            
        case .celcius:
            switch to {
            case .kelvin:
                return temperature + 273.15
            case .fahrenheit:
                return (temperature * 9/5) + 32
            case .celcius:
                return temperature
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
