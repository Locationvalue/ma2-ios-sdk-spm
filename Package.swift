// swift-tools-version: 6.0
import PackageDescription

// MARK: - リリース情報
//
// SDK 本体の xcframework は、このリポジトリの GitHub Releases のアセットとして
// 「1 モジュール = 1 zip」で配布する。リポジトリ本体に xcframework をコミットしない
// （SwiftPM は依存解決時にリポジトリを全履歴 clone するため）。
//
// `sdkVersion` と各 binaryTarget の `checksum` は、SDK 側のリリースワークフローで自動更新される。

let sdkVersion = "1.28.2"

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
            checksum: "45e341fed8236552246196fa5f793ecf2e421596f7137d471d048697ef20ab82"
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
            checksum: "08c958f8bd584fd34c44143931b4fb11c5cb5ff1c7a0e86e1c5f6436d3804ed6"
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
            checksum: "7b70a205cff7c1fa0a7965f1d3979de5f0b29684a26abf2fbe4ade73531e4822"
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
            checksum: "970baeb7e3ad108575b1f5cb088af6455398932c37cb7bf7a8747d0522aed62d"
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
            checksum: "be7c6b6003f28022d442d104cc98e300955f9a5c3a5be532682ad67380b6ab47"
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
            checksum: "9c6af7e864f3b1c0ae934d2b137dcd0fd543a70d75b59002f0eae0920dc998d7"
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
            checksum: "25dc9267ef0b4be2d369cf5ff515ac451bb929219f3a9aeddee182f07401bf73"
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
            checksum: "d85ad2c1f9d742e55a8207099b25670b3baf39fbb12cbd6d0505922bc02eff10"
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
            checksum: "b32306e8c35c83854e5c49849dc29870bd3dd45107e92a095755fdbc0be39296"
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
            checksum: "95331a9ce36ff1a0f783a59ab57a79172fccb741ec993943b58d81c8b2bc2ffd"
        ),

        // MARK: - Content
        // 依存: Core, Container, Config, Identify, Imaging, Analytics, Logging, UI
        .binaryTarget(
            name: "_NautilusContentSDK",
            url: xcframeworkURL("NautilusContentSDK"),
            checksum: "89eb1937bf5e5ceca009ad0952747e5f8f7e88e6c468f33dee6c534357fa2c58"
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
            checksum: "46d46c3da1c505cd5d1b3ae3ec2f80e5b9e1ec08f847c824be2fb9223b37231e"
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
            checksum: "d836f69221da7044cf2e2302b8d3d12cc213b831c6d6e0b1499826443b1fc47d"
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
            checksum: "5a855dc7d425a4575629eed23838c0130fbb2173a0b651b33a7d1652ba45ab47"
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
            checksum: "7d138edbb28f146a39fe0789eb3b15b7570e30c418f53327006bc7d325ec6046"
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
            checksum: "872cf52a258e48e6a1f802889fa0d268504af8429e83269328a9412aef0fc24e"
        ),

        // MARK: - InAppMessage
        // 依存: Core, Container, Config, Identify, Analytics, Imaging, Logging, UI
        .binaryTarget(
            name: "_NautilusInAppMessageSDK",
            url: xcframeworkURL("NautilusInAppMessageSDK"),
            checksum: "59da0eec7c2185122deb18dc80f68c2e3878cb30c0460c78f1a60ee88e5d88f9"
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
            checksum: "96bfb9d7a84bea0da2d7af7f2801be1543d69cec61305d80224cb15a2f001b7d"
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
            checksum: "8c4c567b7c066dc40437d56662566e9d68de96c70ef00056c3f46f6c2a72afd9"
        ),

        // MARK: - Lottery
        // 依存: Core, Container, Config, Identify, Logging, Imaging, Analytics
        .binaryTarget(
            name: "_NautilusLotterySDK",
            url: xcframeworkURL("NautilusLotterySDK"),
            checksum: "dc3f6d81037d0a38823c2472d4eb522ebdbdb9d38e8561e792c2dc05c427f719"
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
            checksum: "9df7591acc2ca1c71407eb6afef7ce0e2a62e9527fbbf07895ec58bf10bae2b8"
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
            checksum: "eeac15ea2dd20e4200c08508b758b4e1a860a0a71ca8291d55282d1aad605899"
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
            checksum: "12e729b830167a8ba2fdfc63e6d4c9ca133a8e6f61b2c81c85877ae5fa87a2f3"
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
            checksum: "502a39768df65db762da10f1936383dba08ab9552eb4d04a2f23bfa2b3b8a714"
        ),

        // MARK: - NotificationUI
        // 依存: Core, Container, Config, Identify, Analytics, Notification, Imaging, UI, Logging
        .binaryTarget(
            name: "_NautilusNotificationUISDK",
            url: xcframeworkURL("NautilusNotificationUISDK"),
            checksum: "467e61d41d94b962e8427c6f96c8f4a462f724f0df8f099691ed1d4cfb32e2aa"
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
            checksum: "5277ad4a4e991322ed93d0c341626c4b37ec31564c4fd50e59694c29710974cc"
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
            checksum: "1a041b79ed46b3138f644da0cfee7a8a0504025f49469aded9e27e26b5254266"
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
            checksum: "ba2aa06b643fafab1570ab05eaad42a4949095216f34db80bc43403e057aece9"
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
            checksum: "175990fbaa53e54e991ee1e3f82f771fd624b7d6caedc0133d973ef0bf81e0b9"
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
            checksum: "b4669ba4d7d96380f28684f06f062116ed5119c570952e28b4ba53caf67896d8"
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
            checksum: "7c6a986c5ac878d77eacf2c320ffe4378b4e67725f69e12c890027551ce22a17"
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
            checksum: "cd5b53ebf9b21d3b58d8678707438107451f973f53bba037312258e3f4f7420f"
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
            checksum: "d28ccd53f709ae9b1c40a884696e32ef6ecf5df7e1045ff68352b30e61a19030"
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
