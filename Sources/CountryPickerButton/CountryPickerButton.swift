//
//  CountryPickerButton.swift
//  
//
//  Created by Cem Yilmaz on 17.02.21.
//

import SwiftUI
//import Cou

@available(iOS 14.0, *)
public struct CountryPickerButton: View {
    
    @Binding public var selectedCountry: String
    @State private var showCountryPickerSheet: Bool = false
    
    var body: some View {
        
        Button(
        
            action: { self.showCountryPickerSheet = true },
            
            label: {
                Image(systemName: "control")
            }
            
        ).buttonStyle(PlainButtonStyle())
        .foregroundColor(Color.blue)
        
        .sheet(isPresented: self.$showCountryPickerSheet) {
            
            Button("Demo set") {
                self.selectedCountry = "Deutschland"
            }
            
        }
        
    }
    
}



@available(iOS 14.0, *)
struct TestVeiw: View {
    
    @State private var selectedCountry: String = ""
    
    var body: some View {
        
        HStack {
            
            CountryPickerButton(selectedCountry: self.$selectedCountry)
            
            TextField("", text: self.$selectedCountry)
            
        }.padding()
        
    }
    
}



@available(iOS 14.0, *)
struct CountryPickerButton_Previews: PreviewProvider {
    
    static var previews: some View {
        
        TestVeiw()
        
    }
    
}
