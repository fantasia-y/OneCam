//
//  CustomTextfield.swift
//  CoLiving
//
//  Created by Gordon on 07.04.23.
//

import SwiftUI

struct CustomTextFieldBase<Field: View>: View {
    let placeholder: String
    let text: Binding<String>
    let invalid: Bool
    let fieldBuilder: (String, Binding<String>) -> Field
    
    init(_ placeholder: String, text: Binding<String>, invalid: Bool = false, fieldBuilder: @escaping (String, Binding<String>) -> Field) {
        self.placeholder = placeholder
        self.text = text
        self.invalid = invalid
        self.fieldBuilder = fieldBuilder
    }
    
    var body: some View {
        fieldBuilder(placeholder, text)
            .padding(6)
            .background(Color("lightGray"))
            .cornerRadius(6)
            .overlay {
                if invalid {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke()
                        .fill(.red)
                }
            }
    }
}

struct CustomTextField: View {
    let placeholder: String
    let text: Binding<String>
    let invalid: Bool
    
    init(_ placeholder: String, text: Binding<String>, invalid: Bool = false) {
        self.placeholder = placeholder
        self.text = text
        self.invalid = invalid
    }
    
    var body: some View {
        CustomTextFieldBase(placeholder, text: text, invalid: invalid) { placeholder, text in
            TextField(placeholder, text: text)
        }
    }
}

struct CustomSecureField: View {
    let placeholder: String
    let text: Binding<String>
    let invalid: Bool
    
    init(_ placeholder: String, text: Binding<String>, invalid: Bool = false) {
        self.placeholder = placeholder
        self.text = text
        self.invalid = invalid
    }
    
    var body: some View {
        CustomTextFieldBase(placeholder, text: text, invalid: invalid) { placeholder, text in
            SecureField(placeholder, text: text)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldBase("Placeholder", text: .constant(""), invalid: false) { placeholder, text in
            TextField(placeholder, text: text)
        }
        .padding()
    }
}
