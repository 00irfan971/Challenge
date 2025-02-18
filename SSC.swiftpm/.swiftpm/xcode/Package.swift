//
//  Package.swift
//  
//
//  Created by Irfan on 17/02/25.
//

// Package.swift
import PackageDescription

let package = Package(
    name: "MySwiftPackage",
    platforms: [.iOS(.15)], // Set the minimum iOS version
    products: [
        .executable(name: "MyApp", targets: ["MyApp"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "MyApp",
            dependencies: []
        )
    ]
)

