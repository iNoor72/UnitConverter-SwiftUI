//
//  Converter.swift
//  UnitConverter-SwiftUI
//
//  Created by Noor Walid on 26/01/2024.
//

import Foundation

protocol Converter {
    func convert(input: InnerConversionType, inputValue: Double, output: InnerConversionType) -> String?
}

struct TemperatureConverter: Converter {
    func convert(input: InnerConversionType, inputValue: Double, output: InnerConversionType) -> String? {
        guard
            let input = input as? TemperatureTypes,
            let output = output as? TemperatureTypes
        else { return nil }
        
        switch (input, output) {
        case (.kelvin, .celsius):
            return "\(inputValue - 273.15)"
        case (.celsius, .kelvin):
            return "\(inputValue + 273.15)"
        case (.fahr, .celsius):
            return "\((inputValue - 32) * 5/9)"
        case (.celsius, .fahr):
            return "\((inputValue * 9/5) + 32)"
        case (.kelvin, .fahr):
            return "\(((inputValue - 273.15) * 1.8) + 32)"
        case (.fahr, .kelvin):
            return "\(((inputValue - 32) * 5/9) + 273.15)"
        default:
            return nil
        }
    }
}

struct MetricConverter: Converter {
    func convert(input: InnerConversionType, inputValue: Double, output: InnerConversionType) -> String? {
        guard
            let input = input as? LengthTypes,
            let output = output as? LengthTypes
        else { return nil }
        
        switch (input, output) {
        case (.kilos, .meters):
            return "\(inputValue * 1000)"
        case (.meters, .kilos):
            return "\(inputValue / 1000)"
        default:
            return nil
        }
    }
}

struct TimeConverter: Converter {
    func convert(input: InnerConversionType, inputValue: Double, output: InnerConversionType) -> String? {
        guard
            let input = input as? TimeTypes,
            let output = output as? TimeTypes
        else { return nil }
        
        switch (input, output) {
        case (.minutes, .hours):
            return "\(inputValue / 60)"
        case (.hours, .minutes):
            return "\(inputValue * 60)"
        default:
            return nil
        }
    }
}

struct VolumeConverter: Converter {
    func convert(input: InnerConversionType, inputValue: Double, output: InnerConversionType) -> String? {
        guard
            let input = input as? VolumeTypes,
            let output = output as? VolumeTypes
        else { return nil }
        
        switch (input, output) {
        case (.liters, .gallons):
            return "\(inputValue * 0.264172)"
        case (.gallons, .liters):
            return "\(inputValue / 0.264172)"
        default:
            return nil
        }
    }
}
