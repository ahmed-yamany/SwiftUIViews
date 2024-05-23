//
//  StepperStyle.swift
//
//
//  Created by Ahmed Yamany on 23/05/2024.
//

import SwiftUI

public struct StepperConfigurations {
    let value: Int
    let minValue: Int
    let maxValue: Int
    let onPlus: () -> Void
    let onMinus: () -> Void
}

public protocol StepperStyle: DynamicProperty {
    associatedtype Body: View
    typealias Configurations = StepperConfigurations

    @ViewBuilder
    func makeBody(configurations: Configurations) -> Body
}

public struct StepperKey: EnvironmentKey {
    public static var defaultValue: any StepperStyle = NormalStepperStyle()
}

public extension EnvironmentValues {
    var stepperStyle: any StepperStyle {
        get { self[StepperKey.self] }
        set { self[StepperKey.self] = newValue }
    }
}

public extension View {
    func stepperStyle(_ style: any StepperStyle) -> some View {
        environment(\.stepperStyle, style)
    }
}

public struct NormalStepperStyle: StepperStyle {
    
    @ViewBuilder
    public func makeBody(configurations: Configurations) -> some View {
        HStack {
            Button {
                configurations.onMinus()
            } label: {
                Image(systemName: "minus")
            }
            
            Text("\(configurations.value)")
            
            Button {
                configurations.onPlus()
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
