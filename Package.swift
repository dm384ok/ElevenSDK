// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ElevenSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ElevenSDK",
            targets: ["ElevenSDK"]),
    ],

    dependencies: [
        
        .package(
            url: "https://github.com/AppsFlyerSDK/AppsFlyerFramework.git", exact: "6.14.3"),
               
        .package(
                   url: "https://github.com/facebook/facebook-ios-sdk.git", exact: "17.0.0"),
            
        .package(
                url: "https://github.com/OneSignal/OneSignal-iOS-SDK",   from: "5.2.0"),

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ElevenSDK",
            
            dependencies: [
                .target(name: "WonderPush"),
                .target(name: "PostHog"),
                
                .product(name: "OneSignalFramework", package: "OneSignal-iOS-SDK"),
                .product(name: "OneSignalInAppMessages", package: "OneSignal-iOS-SDK"),
                .product(name: "OneSignalLocation", package: "OneSignal-iOS-SDK"),
                .product(name: "OneSignalExtension", package: "OneSignal-iOS-SDK"),

                .product(name: "AppsFlyerLib", package: "AppsFlyerFramework"),
                .product(name: "FacebookCore", package: "facebook-ios-sdk"),
                .product(name: "FacebookAEM", package: "facebook-ios-sdk"),
            ]
        ),
        
        .binaryTarget(
            name: "WonderPush",
            path: "./WonderPush.xcframework"),
        .binaryTarget(
            name: "PostHog",
            path: "./PostHog.xcframework"),

    ],
    swiftLanguageVersions: [.v5]
)
