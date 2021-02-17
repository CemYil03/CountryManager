//
//  SwiftUIView.swift
//
//
//  Created by Yilmaz, Cem on 16.02.21.
//

import SwiftUI
import CountryManager

@available(iOS 14.0, *)
public struct PhoneNumberPrefixPickerButton: View {
    
    @Binding private var selectedPhoneNumberPrefix: String
    @State private var showPhonePrefixPickerSheet: Bool = false
    
    public init(selectedPhoneNumberPrefix: Binding<String>) {
        self._selectedPhoneNumberPrefix = selectedPhoneNumberPrefix
    }
    
    public var body: some View {
        
        Button(self.selectedPhoneNumberPrefix) {
            
            self.showPhonePrefixPickerSheet = true
            
        }.sheet(isPresented: self.$showPhonePrefixPickerSheet) {
            
            CountrySearchList(selectedPhoneNumberPrefix: self.$selectedPhoneNumberPrefix)
            
        }
        
    }
    
    private struct CountrySearchList: View {
        
        @Environment(\.presentationMode) private var presentationMode
        @Binding public var selectedPhoneNumberPrefix: String
        
        @State private var searchText: String = ""
        
        public var body: some View {
            
            NavigationView {
                    
                List {
                
                    Section {
                        
                        TextField("Suchtext", text: self.$searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical)
                        
                    }
                    
                    if let recommendedRegionCode = CountryManager.getRecommendedRegionCode() {
                        
                        Section {
                            
                            CountryCell(selectedPhoneNumberPrefix: self.$selectedPhoneNumberPrefix, regionCode: recommendedRegionCode) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            
                        }
                        
                    }
                    
                    ForEach(CountryManager.getRegionCodesOfCountries(containing: self.searchText), id: \.self) { regionCode in
                        
                        CountryCell(selectedPhoneNumberPrefix: self.$selectedPhoneNumberPrefix, regionCode: regionCode) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    }
                    
                }.listStyle(GroupedListStyle())
                    
                .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
                .navigationBarTitle("Vorwahl auswählen")
                
            }.navigationViewStyle(StackNavigationViewStyle())
            
        }
        
        private struct CountryCell: View {
            
            @Binding public var selectedPhoneNumberPrefix: String
            public let regionCode: String
            public let completion: () -> Void
            
            public var body: some View {
                
                Button(
                    
                    action: {
                        
                        if let phoneNumberPrefix = CountryManager.getPhoneNumberPrefixForCountry(withRegionCode: self.regionCode) {
                            
                            self.selectedPhoneNumberPrefix = phoneNumberPrefix
                            self.completion()
                            
                        }
                        
                    },
                    
                    label: {
                        
                        HStack {
                            
                            if let countryName = CountryManager.getLocalizedCountryName(for: self.regionCode),
                               let countryFlagEmoji = CountryManager.getCountryFlagEmoji(for: self.regionCode),
                               let phoneNumberPrefix = CountryManager.getPhoneNumberPrefixForCountry(withRegionCode: self.regionCode)  {
                                
                                Text(countryFlagEmoji)
                                Text(phoneNumberPrefix).foregroundColor(Color.blue)
                                Text(countryName)
                                
                            }
                            
                        }
                        
                    }
                    
                ).buttonStyle(PlainButtonStyle())
                
            }
            
        }
        
    }
    
}



@available(iOS 14.0, *)
public struct TestView: View {
    
    @State private var selectedPhoneNumberPrefix: String = (Locale.current.regionCode != nil) ? CountryManager.getPhoneNumberPrefixForCountry(withRegionCode: Locale.current.regionCode!) ?? "+" : "+"
    
    public var body: some View {
        
        HStack {
            
            Text("Vorwahl auswählen")
            
            Spacer()
            
            PhoneNumberPrefixPickerButton(selectedPhoneNumberPrefix: self.$selectedPhoneNumberPrefix)
            
        }.padding()
        
    }
    
}



@available(iOS 14.0, *)
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        TestView()
        
    }
    
}
