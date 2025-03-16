// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct FormField: View {
    @Binding private var value: String
    private var icon: String
    private var placeholder: String
    private var isSecure: Bool
    private var validateState: ValidateState
    
    public init(
        value: Binding<String>,
        icon: String,
        placeholder: String,
        isSecure: Bool = false,
        validateState: ValidateState
    ) {
        self._value = value
        self.icon = icon
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.validateState = validateState
    }
    
    public var body: some View {
        let shadowColor: Color = {
            switch validateState {
            case .empty:
                return .black.opacity(0.25)
            case .invalid:
                return .red
            case .valid:
                return .green
            }
        }()
        
        HStack {
            Image(systemName: icon)
                .foregroundColor(shadowColor)
                .padding(4)
            
            Group {
                if isSecure {
                    SecureField(placeholder, text: $value)
                } else {
                    TextField(placeholder, text: $value)
                }
            }
            .font(.system(size: 16, design: .monospaced))
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.leading)
            .disableAutocorrection(true)
            .autocapitalization(.none)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(shadowColor, lineWidth: 2)
                .shadow(radius: 1, x: 0, y: 2)
        )
    }
}
