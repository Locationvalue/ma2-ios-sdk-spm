// swift-tools-version: 6.0
import PackageDescription

// MARK: - リリース情報
//
// SDK 本体の xcframework は、このリポジトリの GitHub Releases のアセットとして
// 「1 モジュール = 1 zip」で配布する。リポジトリ本体に xcframework をコミットしない
// （SwiftPM は依存解決時にリポジトリを全履歴 clone するため）。
//
// `sdkVersion` と各 binaryTarget の `checksum` は、SDK 側のリリースワークフローで自動更新される。

let sdkVersion = "0.0.2"

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
            checksum: "e3eb425045f93a81f217a7bd3d58e85084724697971dbec050f546649ed5a092"
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
            checksum: "c60357071f9f3da5a4bdc7ded7aff116d19da6668f604aaa157efecee9b5696f"
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
            checksum: "6da0cb3be43feca9577596ed346ab2d3d900b3523904fa32d49c57a9f7fec47e"
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
            checksum: "33851c23d1675735699e5398253269f3ce5e9ee5b39c068756b0b6c98b850880"
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
            checksum: "8bc38758efdf58815041f3d504cb780a30c1ed57aa026d570845e73f074e7e3a"
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
            checksum: "7ed5b1bef40ef9478f4b949e65256074bb494dea8de27183efaaf50bf8c6009e"
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
            checksum: "5c710bccc11a930b19b818f6759b406c3d49b5beb008182f4d4892ed41af0044"
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
            checksum: "e775894aa8f2be8427415a91172001ef5c521144f3caba61633fff531ac6dcf0"
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
            checksum: "754791e1c08c3976d392973d5f564eb421bba211db3fcf6b3ee86723186b679a"
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
            checksum: "f172b335c76cba2d0e1df244f9e26df9fa666dee8a95d0ff37d58437862068a6"
        ),

        // MARK: - Content
        // 依存: Core, Container, Config, Identify, Imaging, Analytics, Logging, UI
        .binaryTarget(
            name: "_NautilusContentSDK",
            url: xcframeworkURL("NautilusContentSDK"),
            checksum: "dd37fdae82f316bcc5abe76882237aae9d09e862e114969241767802d5bd1265"
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
            checksum: "7bda23a1daaa2cf982e21720df400f3fa3cc503615f3ae9333a8d622547890ed"
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
            checksum: "8fcdf75bacdb6cbf4241d597f2ca115d4c964490f3432b126fba5b8c524c00e0"
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
            checksum: "e2a9d1be2842da11d799a3c19c079bf0354b1fb4fcfd62218787b94a9b5a2a99"
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
            checksum: "bbce8f759b916739a363c9375111d2c1eebfe9db97515551d6a4ebfefc22c5f5"
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
            checksum: "1940130801e182293c02247bc8ff28894dfd0f4be37e0999c057b686acc8d535"
        ),

        // MARK: - InAppMessage
        // 依存: Core, Container, Config, Identify, Analytics, Imaging, Logging, UI
        .binaryTarget(
            name: "_NautilusInAppMessageSDK",
            url: xcframeworkURL("NautilusInAppMessageSDK"),
            checksum: "3a090589b3ad48f2d2e7a43514693bb7d366b71e658afb7a2329a26eee0bbe6b"
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
            checksum: "5ad9f52d4fa3223ae6436557287d56185c1c3a68c937a43c47a66614a87a317a"
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
            checksum: "b230eb038e5b06ca6f9e17bec18115149b1508e7b830266aa97c371f7afe3642"
        ),

        // MARK: - Lottery
        // 依存: Core, Container, Config, Identify, Logging, Imaging, Analytics
        .binaryTarget(
            name: "_NautilusLotterySDK",
            url: xcframeworkURL("NautilusLotterySDK"),
            checksum: "4cb6fb4d75f5b812b30b52f1cce61e0453f501a65c247a4587e7902c183be0ca"
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
            checksum: "4e9e2ac18fcabdbe07d8f966757b2f57115fdf2e4957e1283fb7ebf9a16d65b1"
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
            checksum: "2a3f6647e0c4373a86d78dc29f39630cfc09084c0d1e1cbf1aab1c8fc5cbe4bd"
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
            checksum: "454e77626863b4737489a05af791bce12c1b8fb0f7bc72facd5535e76c2fb44b"
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
            checksum: "eb29689ea46441a27b524723c39eb2ea9edb8cb7b81021ab9f387a055d784cc3"
        ),

        // MARK: - NotificationUI
        // 依存: Core, Container, Config, Identify, Analytics, Notification, Imaging, UI, Logging
        .binaryTarget(
            name: "_NautilusNotificationUISDK",
            url: xcframeworkURL("NautilusNotificationUISDK"),
            checksum: "f080efe9eb7a8abb176ccdb48e37eb04d53dc63b13240c0a981cbba000b4368a"
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
            checksum: "b615c61442fb068433223fa0b38aec1f0d4124c244f5afe1482203069e53a21b"
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
            checksum: "bcdb1fbda1feea0e943ecf960597b20949d2bee006111d8cde3da0e11994a913"
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
            checksum: "30eff6c40c48ff61328a3cf38ff59aa97b969d852fcbb257bb4c3e3761ca687a"
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
            checksum: "0374c7aa056ffceabeef611c90cfab1764fd4278faffc92161e5f91a5fc1211f"
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
            checksum: "0552595870443e45ae38aed2a14dac5b1ca7b77d26b16218466c6f43b90482d3"
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
            checksum: "9e6f1fb84c4e8a85067b70f1e64d1c7ed05375a4e6ebd7f51b595dec9e8763d1"
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
            checksum: "5f29155108527febb6921144009d2eb92c35b9eb3edda517e960446030c95ad6"
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
            checksum: "11e09d04bd1aca456fbe4e8a045a1599f21fd0b2996e040ab634788906009e46"
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
