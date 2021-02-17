// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CountryManager",
    products: [
        .library(
            name: "CountryManager",
            targets: ["CountryManager"]
        ),
        .library(
            name: "PhoneNumberPrefixPickerButton",
            targets: ["PhoneNumberPrefixPickerButton"]
        )
    ],
    targets: [
        .target(name: "CountryManager"),
        .target(
            name: "PhoneNumberPrefixPickerButton",
            dependencies: ["CountryManager"]
        )
    ]
)
