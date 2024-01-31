//
//  ContentView.swift
//  UnitConverter-SwiftUI
//
//  Created by Noor Walid on 26/01/2024.
//

import SwiftUI

protocol InnerConversionType {}

enum ConversionType: String, CaseIterable {
    case temperature = "Temperature"
    case length = "Length"
    case time = "Time"
    case volume = "Volume"
}

enum TemperatureTypes: String, CaseIterable, InnerConversionType {
    case celsius = "C"
    case fahr = "F"
    case kelvin = "K"
}

enum LengthTypes: String, CaseIterable, InnerConversionType {
    case meters = "M"
    case kilos = "K"
}

enum TimeTypes: String, CaseIterable, InnerConversionType {
    case minutes = "m"
    case hours = "h"
}

enum VolumeTypes: String, CaseIterable, InnerConversionType {
    case liters = "L"
    case gallons = "G"
}

struct ContentView: View {
    private let conversionType: [ConversionType] = ConversionType.allCases
    private var inputTypes: [InnerConversionType] = []
    private var outputTypes: [InnerConversionType] = []
    
    @State private var selectedConversionType: ConversionType = .temperature {
        didSet {
            switch selectedConversionType {
            case .length:
                inputType = LengthTypes.meters.rawValue
                outputType = LengthTypes.meters.rawValue
            case .temperature:
                inputType = TemperatureTypes.celsius.rawValue
                outputType = TemperatureTypes.celsius.rawValue
            case .time:
                inputType = TimeTypes.minutes.rawValue
                outputType = TimeTypes.minutes.rawValue
            case .volume:
                inputType = VolumeTypes.liters.rawValue
                outputType = VolumeTypes.liters.rawValue
            }
        }
    }
    @State private var inputType: String?
    @State private var outputType: String?
    @State private var inputValue = ""
    
    private var calculateValue: String {
        guard
            let inputType = inputType,
            let outputType = outputType
        else { return "" }
        
        var converter: Converter
        var input: InnerConversionType?
        var output: InnerConversionType?
        
        switch selectedConversionType {
        case .length:
            converter = MetricConverter()
            input = LengthTypes(rawValue: inputType)
            output = LengthTypes(rawValue: outputType)
        case .temperature:
            converter = TemperatureConverter()
            input = TemperatureTypes(rawValue: inputType)
            output = TemperatureTypes(rawValue: outputType)
        case .time:
            converter = TimeConverter()
            input = TimeTypes(rawValue: inputType)
            output = TimeTypes(rawValue: outputType)
        case .volume:
            converter = VolumeConverter()
            input = VolumeTypes(rawValue: inputType)
            output = VolumeTypes(rawValue: outputType)
        }
        
        guard
            let input = input,
            let output = output
        else { return "" }
        
        return "\(converter.convert(input: input, inputValue: Double(inputValue) ?? 0.0, output: output) ?? "")"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Choose what to convert", selection: $selectedConversionType) {
                        ForEach(conversionType, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section("Choose input type:") {
                    Picker("Choose input type:", selection: $inputType) {
                        switch selectedConversionType {
                        case .length:
                            ForEach(LengthTypes.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        case .temperature:
                            ForEach(TemperatureTypes.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                            
                        case .time:
                            ForEach(TimeTypes.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        case .volume:
                            ForEach(VolumeTypes.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Choose output type:") {
                    Picker("Choose output type:", selection: $outputType) {
                        switch selectedConversionType {
                        case .length:
                            ForEach(LengthTypes.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        case .temperature:
                            ForEach(TemperatureTypes.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                            
                        case .time:
                            ForEach(TimeTypes.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        case .volume:
                            ForEach(VolumeTypes.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                TextField("Value:", text: $inputValue)
                    .keyboardType(.decimalPad)
                
                Text("Output: \(calculateValue)")
            }
            .navigationTitle("Units Converter")
        }
    }
}

#Preview {
    ContentView()
}
