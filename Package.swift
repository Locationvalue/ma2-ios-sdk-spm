// swift-tools-version: 6.0
import PackageDescription

// MARK: - リリース情報
//
// SDK 本体の xcframework は、このリポジトリの GitHub Releases のアセットとして
// 「1 モジュール = 1 zip」で配布する。リポジトリ本体に xcframework をコミットしない
// （SwiftPM は依存解決時にリポジトリを全履歴 clone するため）。
//
// `sdkVersion` と各 binaryTarget の `checksum` は、SDK 側のリリースワークフローで自動更新される。

let sdkVersion = "1.28.3"

func xcframeworkURL(_ module: String) -> String {
    "https://github.com/Locationvalue/ma2-ios-sdk-spm/releases/download/\(sdkVersion)/\(module).xcframework.zip"
}

let package = Package(
    name: "ma2-ios-sdk-spm",
    platforms: [
        .iOS(.v16),
        // SDK 自体は iOS 専用だが、macOS 向けツール（LicensePlist 等）を同一パッケージ
        // グラフに含めるアプリ側の都合で、プラットフォーム宣言を残している。
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "NautilusHierarchicalMenuSDK", targets: ["_NautilusHierarchicalMenuSDKBridge"]),
        .library(name: "NautilusAnalyticsSDK", targets: ["_NautilusAnalyticsSDKBridge"]),
        .library(name: "NautilusBannerSDK", targets: ["_NautilusBannerSDKBridge"]),
        .library(name: "NautilusCampaignSDK", targets: ["_NautilusCampaignSDKBridge"]),
        .library(name: "NautilusCheckInSDK", targets: ["_NautilusCheckInSDKBridge"]),
        .library(name: "NautilusCodeImageProvidersSDK", targets: ["_NautilusCodeImageProvidersSDKBridge"]),
        .library(name: "NautilusCodeReaderSDK", targets: ["_NautilusCodeReaderSDKBridge"]),
        .library(name: "NautilusCollectionCardSDK", targets: ["_NautilusCollectionCardSDKBridge"]),
        .library(name: "NautilusConfigSDK", targets: ["_NautilusConfigSDKBridge"]),
        .library(name: "NautilusContainerSDK", targets: ["_NautilusContainerSDK"]),
        .library(name: "NautilusContentSDK", targets: ["_NautilusContentSDKBridge"]),
        .library(name: "NautilusCoreSDK", targets: ["_NautilusCoreSDKBridge"]),
        .library(name: "NautilusCouponSDK", targets: ["_NautilusCouponSDKBridge"]),
        .library(name: "NautilusGeoUtilSDK", targets: ["_NautilusGeoUtilSDKBridge"]),
        .library(name: "NautilusIdentifySDK", targets: ["_NautilusIdentifySDKBridge"]),
        .library(name: "NautilusImagingSDK", targets: ["_NautilusImagingSDK"]),
        .library(name: "NautilusInAppMessageSDK", targets: ["_NautilusInAppMessageSDKBridge"]),
        .library(name: "NautilusIntroSDK", targets: ["_NautilusIntroSDKBridge"]),
        .library(name: "NautilusLoggingSDK", targets: ["_NautilusLoggingSDK"]),
        .library(name: "NautilusLotterySDK", targets: ["_NautilusLotterySDKBridge"]),
        .library(name: "NautilusLotteryUISDK", targets: ["_NautilusLotteryUISDKBridge"]),
        .library(name: "NautilusMaintenanceSDK", targets: ["_NautilusMaintenanceSDKBridge"]),
        .library(name: "NautilusNotificationSDK", targets: ["_NautilusNotificationSDKBridge"]),
        .library(name: "NautilusNotificationServiceSDK", targets: ["_NautilusNotificationServiceSDK"]),
        .library(name: "NautilusNotificationUISDK", targets: ["_NautilusNotificationUISDKBridge"]),
        .library(name: "NautilusPointSDK", targets: ["_NautilusPointSDKBridge"]),
        .library(name: "NautilusServerTimeSDK", targets: ["_NautilusServerTimeSDKBridge"]),
        .library(name: "NautilusShopSDK", targets: ["_NautilusShopSDKBridge"]),
        .library(name: "NautilusStampRallyUISDK", targets: ["_NautilusStampRallyUISDKBridge"]),
        .library(name: "NautilusStampSDK", targets: ["_NautilusStampSDKBridge"]),
        .library(name: "NautilusStampUISDK", targets: ["_NautilusStampUISDKBridge"]),
        .library(name: "NautilusUISDK", targets: ["_NautilusUISDKBridge"]),
        .library(name: "NautilusUserInfoSDK", targets: ["_NautilusUserInfoSDKBridge"])
    ],
    dependencies: [
        // ZXingObjc
        .package(url: "https://github.com/Locationvalue/ZXingObjC-Binaries.git", .upToNextMinor(from: "1.1.0")),
        // Lottie
        .package(url: "https://github.com/airbnb/lottie-spm.git", .upToNextMinor(from: "4.6.0")),
    ],
    targets: [
        // binaryTarget は依存を宣言できないため、各モジュールの依存は Bridge target に書く。
        // 他の SDK は Bridge 経由で参照し（Bridge を持たないリーフは binaryTarget を直接参照）、
        // 推移的な依存は SwiftPM にたどらせる。各 Bridge には直接 import しているモジュールを書く。
        //
        // MARK: - HierarchicalMenu
        // 依存: Config, Container, Core, Identify, Logging
        .binaryTarget(
            name: "_NautilusHierarchicalMenuSDK",
            url: xcframeworkURL("NautilusHierarchicalMenuSDK"),
            checksum: "f395370ff7fd6953445b4d2c2387870feea70240c7472c9a6c3225ef983593b4"
        ),
        .target(
            name: "_NautilusHierarchicalMenuSDKBridge",
            dependencies: [
                "_NautilusHierarchicalMenuSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusIdentifySDKBridge",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - Analytics
        // 依存: Core, Container, Identify, Logging
        .binaryTarget(
            name: "_NautilusAnalyticsSDK",
            url: xcframeworkURL("NautilusAnalyticsSDK"),
            checksum: "4e820e88a772efcdb977022379b0dc2aa16f060590d93d09c91641132d3a2e54"
        ),
        .target(
            name: "_NautilusAnalyticsSDKBridge",
            dependencies: [
                "_NautilusAnalyticsSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusIdentifySDKBridge",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - Banner
        // 依存: Core, Config, Container, Identify, Imaging, Analytics, Logging, UI
        .binaryTarget(
            name: "_NautilusBannerSDK",
            url: xcframeworkURL("NautilusBannerSDK"),
            checksum: "43ceefab235781f00e14d9b6ac38f978742ed60e583b833f3abfcad4914e801f"
        ),
        .target(
            name: "_NautilusBannerSDKBridge",
            dependencies: [
                "_NautilusBannerSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusConfigSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusIdentifySDKBridge",
                "_NautilusImagingSDK",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusLoggingSDK",
                "_NautilusUISDKBridge",
            ]
        ),

        // MARK: - Campaign
        // 依存: Core, Container, Logging, Config, Identify
        .binaryTarget(
            name: "_NautilusCampaignSDK",
            url: xcframeworkURL("NautilusCampaignSDK"),
            checksum: "c2b5cb4afc9e4e8e9c8ec70e3425f49a77d291de32d01326a7a05d6e57fa1533"
        ),
        .target(
            name: "_NautilusCampaignSDKBridge",
            dependencies: [
                "_NautilusCampaignSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusLoggingSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
            ]
        ),

        // MARK: - CheckIn
        // 依存: Core, Container, Logging, Config, Identify
        .binaryTarget(
            name: "_NautilusCheckInSDK",
            url: xcframeworkURL("NautilusCheckInSDK"),
            checksum: "17d425f5b17d76999f583dd1bac7b24b6945c7bf56d38ce7bd39db45419fd483"
        ),
        .target(
            name: "_NautilusCheckInSDKBridge",
            dependencies: [
                "_NautilusCheckInSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusLoggingSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
            ]
        ),

        // MARK: - CodeImageProviders
        // 依存: Identify (+ ZXingObjC)
        .binaryTarget(
            name: "_NautilusCodeImageProvidersSDK",
            url: xcframeworkURL("NautilusCodeImageProvidersSDK"),
            checksum: "c8c99d7b8526142789802d680de9389b118128527d4db781bed3f4ecafc9d527"
        ),
        .target(
            name: "_NautilusCodeImageProvidersSDKBridge",
            dependencies: [
                "_NautilusCodeImageProvidersSDK",
                "_NautilusIdentifySDKBridge",
                .product(name: "ZXingObjC-Binaries", package: "ZXingObjC-Binaries")
            ]
        ),

        // MARK: - CodeReader
        // 依存: Core
        .binaryTarget(
            name: "_NautilusCodeReaderSDK",
            url: xcframeworkURL("NautilusCodeReaderSDK"),
            checksum: "3ff0058495e07c955059bd29385e4bfe41f2b08ebe4be7a41f5ca874b84c48da"
        ),
        .target(
            name: "_NautilusCodeReaderSDKBridge",
            dependencies: [
                "_NautilusCodeReaderSDK",
                "_NautilusCoreSDKBridge",
            ]
        ),

        // MARK: - CollectionCard
        // 依存: Core, Container, Logging, Config, Identify
        .binaryTarget(
            name: "_NautilusCollectionCardSDK",
            url: xcframeworkURL("NautilusCollectionCardSDK"),
            checksum: "f73b5370b058bc2e7928094f76b37a3255bddcda890e6fd1673808bc391d6e25"
        ),
        .target(
            name: "_NautilusCollectionCardSDKBridge",
            dependencies: [
                "_NautilusCollectionCardSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusLoggingSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
            ]
        ),

        // MARK: - Config
        // 依存: Core, Container, Logging
        .binaryTarget(
            name: "_NautilusConfigSDK",
            url: xcframeworkURL("NautilusConfigSDK"),
            checksum: "623566563e146451030e7ebb1865d860e5cc60b96f9933df86e68374401e479e"
        ),
        .target(
            name: "_NautilusConfigSDKBridge",
            dependencies: [
                "_NautilusConfigSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - Container (リーフ、依存なし)
        .binaryTarget(
            name: "_NautilusContainerSDK",
            url: xcframeworkURL("NautilusContainerSDK"),
            checksum: "593803b18ab4e8abe2ddd5539ffcfbfdd0beaa5589375e72b59987dfc7effb38"
        ),

        // MARK: - Content
        // 依存: Core, Container, Config, Identify, Imaging, Analytics, Logging, UI
        .binaryTarget(
            name: "_NautilusContentSDK",
            url: xcframeworkURL("NautilusContentSDK"),
            checksum: "baf38c1905108d34cdeb0dd0d4543553b43dcad4f753665c1d66894edad9dd55"
        ),
        .target(
            name: "_NautilusContentSDKBridge",
            dependencies: [
                "_NautilusContentSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
                "_NautilusImagingSDK",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusLoggingSDK",
                "_NautilusUISDKBridge",
            ]
        ),

        // MARK: - Core
        // 依存: Container, Logging
        .binaryTarget(
            name: "_NautilusCoreSDK",
            url: xcframeworkURL("NautilusCoreSDK"),
            checksum: "8b6b770d10217714d78953fdc675a58bf8644bafd5befb32fd09479aa86388b5"
        ),
        .target(
            name: "_NautilusCoreSDKBridge",
            dependencies: [
                "_NautilusCoreSDK",
                "_NautilusContainerSDK",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - Coupon
        // 依存: Core, Container, Config, Identify, Imaging, Analytics, Logging, UI, ServerTime
        .binaryTarget(
            name: "_NautilusCouponSDK",
            url: xcframeworkURL("NautilusCouponSDK"),
            checksum: "201f5dbe4b5c7f01bdf1943e7c5eb920d706b8f9c23de2f8a78c72b0c74ab5e7"
        ),
        .target(
            name: "_NautilusCouponSDKBridge",
            dependencies: [
                "_NautilusCouponSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
                "_NautilusImagingSDK",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusLoggingSDK",
                "_NautilusUISDKBridge",
                "_NautilusServerTimeSDKBridge",
            ]
        ),

        // MARK: - GeoUtil
        // 依存: Core, Container, Config, Identify, Logging
        .binaryTarget(
            name: "_NautilusGeoUtilSDK",
            url: xcframeworkURL("NautilusGeoUtilSDK"),
            checksum: "b0b91604811cf3e99e430fb804f1180b68ad786b55faad4f093c534a7a07093d"
        ),
        .target(
            name: "_NautilusGeoUtilSDKBridge",
            dependencies: [
                "_NautilusGeoUtilSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - Identify
        // 依存: Core, Container, Config, Logging
        .binaryTarget(
            name: "_NautilusIdentifySDK",
            url: xcframeworkURL("NautilusIdentifySDK"),
            checksum: "ba9565ceb62b84b7bb50e600fe10ed560584976a9bc67ddd028c02b52e93d7fb"
        ),
        .target(
            name: "_NautilusIdentifySDKBridge",
            dependencies: [
                "_NautilusIdentifySDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - Imaging (リーフ、依存なし)
        .binaryTarget(
            name: "_NautilusImagingSDK",
            url: xcframeworkURL("NautilusImagingSDK"),
            checksum: "f99efa3428ff21348f2a7460603e6774a8985fd2fbcfa9ae9b52bb9c1e7c0116"
        ),

        // MARK: - InAppMessage
        // 依存: Core, Container, Config, Identify, Analytics, Imaging, Logging, UI
        .binaryTarget(
            name: "_NautilusInAppMessageSDK",
            url: xcframeworkURL("NautilusInAppMessageSDK"),
            checksum: "ac00bf40d0211d7bb12002be16f65eb7fe648148fb8318b8c31d49b4c5deebed"
        ),
        .target(
            name: "_NautilusInAppMessageSDKBridge",
            dependencies: [
                "_NautilusInAppMessageSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusImagingSDK",
                "_NautilusLoggingSDK",
                "_NautilusUISDKBridge",
            ]
        ),

        // MARK: - Intro
        // 依存: Core, Config, Container, Identify, Analytics, Logging, UI
        .binaryTarget(
            name: "_NautilusIntroSDK",
            url: xcframeworkURL("NautilusIntroSDK"),
            checksum: "f75870c08140c7c9625fe9c7ecd9dbc0d8cd5445985a253575ef9e7820e0a890"
        ),
        .target(
            name: "_NautilusIntroSDKBridge",
            dependencies: [
                "_NautilusIntroSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusConfigSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusIdentifySDKBridge",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusLoggingSDK",
                "_NautilusUISDKBridge",
            ]
        ),

        // MARK: - Logging (リーフ、依存なし)
        .binaryTarget(
            name: "_NautilusLoggingSDK",
            url: xcframeworkURL("NautilusLoggingSDK"),
            checksum: "adc0b3434f5bff5f265744f73e7918d97c6bd46b14ff48bbc2b95ac1ab6bb5b4"
        ),

        // MARK: - Lottery
        // 依存: Core, Container, Config, Identify, Logging, Imaging, Analytics
        .binaryTarget(
            name: "_NautilusLotterySDK",
            url: xcframeworkURL("NautilusLotterySDK"),
            checksum: "3c1e5ed79d9a3f67ea74b2757db3e0b6fd7990a0264c1fa00d420f9f11395d87"
        ),
        .target(
            name: "_NautilusLotterySDKBridge",
            dependencies: [
                "_NautilusLotterySDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
                "_NautilusLoggingSDK",
                "_NautilusImagingSDK",
                "_NautilusAnalyticsSDKBridge",
            ]
        ),

        // MARK: - LotteryUI
        // 依存: Core, Container, Config, Identify, Logging, Imaging, Analytics, UI, Lottery, ServerTime (+ Lottie)
        .binaryTarget(
            name: "_NautilusLotteryUISDK",
            url: xcframeworkURL("NautilusLotteryUISDK"),
            checksum: "39a3728d07bb49b4ce6b098d72346bd766a029e249f1e2821f804781bbfeec04"
        ),
        .target(
            name: "_NautilusLotteryUISDKBridge",
            dependencies: [
                "_NautilusLotteryUISDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
                "_NautilusLoggingSDK",
                "_NautilusImagingSDK",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusUISDKBridge",
                "_NautilusLotterySDKBridge",
                "_NautilusServerTimeSDKBridge",
                .product(name: "Lottie", package: "lottie-spm")
            ]
        ),

        // MARK: - Maintenance
        // 依存: Core, Container, Logging, Config
        .binaryTarget(
            name: "_NautilusMaintenanceSDK",
            url: xcframeworkURL("NautilusMaintenanceSDK"),
            checksum: "fb2076331064f6fa5f9854b6ad79351cb3fbeeb29e8f5009cd373f1aa36f56b3"
        ),
        .target(
            name: "_NautilusMaintenanceSDKBridge",
            dependencies: [
                "_NautilusMaintenanceSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusLoggingSDK",
                "_NautilusConfigSDKBridge",
            ]
        ),

        // MARK: - Notification
        // 依存: Core, Container, Config, Identify, Logging
        .binaryTarget(
            name: "_NautilusNotificationSDK",
            url: xcframeworkURL("NautilusNotificationSDK"),
            checksum: "9181e4f2a7e8e22e4976d99ae15ecdb732f6bf61d06d3fa06ef03d3d6c8872f4"
        ),
        .target(
            name: "_NautilusNotificationSDKBridge",
            dependencies: [
                "_NautilusNotificationSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - NotificationService (リーフ、依存なし)
        .binaryTarget(
            name: "_NautilusNotificationServiceSDK",
            url: xcframeworkURL("NautilusNotificationServiceSDK"),
            checksum: "24e8752d3d3affbb4a6b6a00a829c2ae44ce1077b0dfc1b53ffc028c4e9aae57"
        ),

        // MARK: - NotificationUI
        // 依存: Core, Container, Config, Identify, Analytics, Notification, Imaging, UI, Logging
        .binaryTarget(
            name: "_NautilusNotificationUISDK",
            url: xcframeworkURL("NautilusNotificationUISDK"),
            checksum: "5b3aa605ecc4adf3ee561ba3c2b2c136ec50aea2eb12dc2a36f0e506669cfc5b"
        ),
        .target(
            name: "_NautilusNotificationUISDKBridge",
            dependencies: [
                "_NautilusNotificationUISDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusNotificationSDKBridge",
                "_NautilusImagingSDK",
                "_NautilusUISDKBridge",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - Point
        // 依存: Core, Container, Logging, Config, Identify
        .binaryTarget(
            name: "_NautilusPointSDK",
            url: xcframeworkURL("NautilusPointSDK"),
            checksum: "a7009e35d6b99d3c5cdb2da84801f478ef7c9d8ec38a8fdbfc30798f4a4b582f"
        ),
        .target(
            name: "_NautilusPointSDKBridge",
            dependencies: [
                "_NautilusPointSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusLoggingSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusIdentifySDKBridge",
            ]
        ),

        // MARK: - ServerTime
        // 依存: Core, Container, Config, Logging
        .binaryTarget(
            name: "_NautilusServerTimeSDK",
            url: xcframeworkURL("NautilusServerTimeSDK"),
            checksum: "4321fb039ac599b8816d59d91562390b11469c9f832e6b40ecaca704632550cc"
        ),
        .target(
            name: "_NautilusServerTimeSDKBridge",
            dependencies: [
                "_NautilusServerTimeSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - Shop
        // 依存: Core, Config, Container, Identify, Imaging, Analytics, Logging, UI, GeoUtil
        .binaryTarget(
            name: "_NautilusShopSDK",
            url: xcframeworkURL("NautilusShopSDK"),
            checksum: "02bbb916fe263e9d4ae3c9377c9045c50b27cc9da8be050f8fa0791ee1d610dd"
        ),
        .target(
            name: "_NautilusShopSDKBridge",
            dependencies: [
                "_NautilusShopSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusConfigSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusIdentifySDKBridge",
                "_NautilusImagingSDK",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusLoggingSDK",
                "_NautilusUISDKBridge",
                "_NautilusGeoUtilSDKBridge",
            ]
        ),

        // MARK: - StampRallyUI
        // 依存: Analytics, Config, Container, Core, Stamp, CodeReader, UI, ServerTime, Imaging, Logging
        .binaryTarget(
            name: "_NautilusStampRallyUISDK",
            url: xcframeworkURL("NautilusStampRallyUISDK"),
            checksum: "34666768f470600037113ab68873da32f6e4093d3111d3797eaa3242d07a57e7"
        ),
        .target(
            name: "_NautilusStampRallyUISDKBridge",
            dependencies: [
                "_NautilusStampRallyUISDK",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusConfigSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusStampSDKBridge",
                "_NautilusCodeReaderSDKBridge",
                "_NautilusUISDKBridge",
                "_NautilusServerTimeSDKBridge",
                "_NautilusImagingSDK",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - Stamp
        // 依存: Config, Container, Core, Identify, Logging
        .binaryTarget(
            name: "_NautilusStampSDK",
            url: xcframeworkURL("NautilusStampSDK"),
            checksum: "2f4f8a10ac398fb4a3fe560cf1da3dad9ac135cb095ff401ddb85adcd9d6fc6f"
        ),
        .target(
            name: "_NautilusStampSDKBridge",
            dependencies: [
                "_NautilusStampSDK",
                "_NautilusConfigSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusIdentifySDKBridge",
                "_NautilusLoggingSDK",
            ]
        ),

        // MARK: - StampUI
        // 依存: Analytics, Config, Container, Core, Stamp, CodeReader, UI, ServerTime, Imaging, Logging (+ Lottie)
        .binaryTarget(
            name: "_NautilusStampUISDK",
            url: xcframeworkURL("NautilusStampUISDK"),
            checksum: "bf026d7385392dc1d742b4f2bb245014061e7c00c396d15823d735cd037e1118"
        ),
        .target(
            name: "_NautilusStampUISDKBridge",
            dependencies: [
                "_NautilusStampUISDK",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusConfigSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusStampSDKBridge",
                "_NautilusCodeReaderSDKBridge",
                "_NautilusUISDKBridge",
                "_NautilusServerTimeSDKBridge",
                "_NautilusImagingSDK",
                "_NautilusLoggingSDK",
                .product(name: "Lottie", package: "lottie-spm")
            ]
        ),

        // MARK: - UI
        // 依存: Core, Config, Analytics, Logging, Container
        .binaryTarget(
            name: "_NautilusUISDK",
            url: xcframeworkURL("NautilusUISDK"),
            checksum: "817ff0e8453f0242d8558c13d98c6029087f5da657d5cea09ae9e56d625768d1"
        ),
        .target(
            name: "_NautilusUISDKBridge",
            dependencies: [
                "_NautilusUISDK",
                "_NautilusCoreSDKBridge",
                "_NautilusConfigSDKBridge",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusLoggingSDK",
                "_NautilusContainerSDK",
            ]
        ),

        // MARK: - UserInfo
        // 依存: Core, Config, Container, Identify, Analytics, Logging, GeoUtil
        .binaryTarget(
            name: "_NautilusUserInfoSDK",
            url: xcframeworkURL("NautilusUserInfoSDK"),
            checksum: "69dd921710ec2d534599ad074e5b996a11e98a59de1d4c909b92f73d105dc1c3"
        ),
        .target(
            name: "_NautilusUserInfoSDKBridge",
            dependencies: [
                "_NautilusUserInfoSDK",
                "_NautilusCoreSDKBridge",
                "_NautilusConfigSDKBridge",
                "_NautilusContainerSDK",
                "_NautilusIdentifySDKBridge",
                "_NautilusAnalyticsSDKBridge",
                "_NautilusLoggingSDK",
                "_NautilusGeoUtilSDKBridge",
            ]
        ),
    ]
)
