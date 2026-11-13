// swift-tools-version: 6.0
import PackageDescription

// MARK: - リリース情報
//
// SDK 本体の xcframework は、このリポジトリの GitHub Releases のアセットとして
// 「1 モジュール = 1 zip」で配布する。リポジトリ本体に xcframework をコミットしない
// （SwiftPM は依存解決時にリポジトリを全履歴 clone するため）。
//
// `sdkVersion` と各 binaryTarget の `checksum` は、SDK 側のリリースワークフローで自動更新される。

let sdkVersion = "1.28.1"

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
            checksum: "d633a88beb95d124db493096b6d12d5c5556c4c1ac9dd3343ee242a9faee3aa3"
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
            checksum: "784e6e3de9e28febb1507c3d7bd65d29fbfa1e03418ee6f9333d10d1bdc37264"
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
            checksum: "34364bd4ac602cb4103c472789dbc4f91e29a37b494de39cdec1702a0a64c147"
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
            checksum: "dd29f53c8fba8a8fa3f6a1e79bf070982246e1703a5a760d6128ecdc997eff3c"
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
            checksum: "5927cdeb10c3a01387f7d1e33c1d197599afbf2f35e1ff685dcf721edb1b2df6"
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
            checksum: "abf8157934ad9ba1e2edbf1fed78f090bf9b2b3eff648f5ca827033e9e60939e"
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
            checksum: "50c5ea16d9233d7919b75d6b269f3767ba7f783e0c8e61ea5f6f6738e9d21b09"
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
            checksum: "6a6cb0cf9d33ecb60f7b301c4d2eea8417b058668416d121cf658d832c5c8cb9"
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
            checksum: "634d8c90599a24d8643cdd30d580db479750a4859fa91d491d8d4e601a55180e"
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
            checksum: "c8dd7597f2a4f87432809fb846c7c4615ba3b2ab5fc28d1ca4e1ab91d5c0bbc9"
        ),

        // MARK: - Content
        // 依存: Core, Container, Config, Identify, Imaging, Analytics, Logging, UI
        .binaryTarget(
            name: "_NautilusContentSDK",
            url: xcframeworkURL("NautilusContentSDK"),
            checksum: "040ccd54358c63185abacef562e61b687c395b19530ebe23d5e87a1a48415d01"
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
            checksum: "a8275871dafb9f5d3c8e78980d8db2687ddd03bb351cc5da01fe33cefd058b9b"
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
            checksum: "2fa18352385b1816a5777f16a9ee72e819ddada022cd4a1ec555de787e0abdca"
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
            checksum: "92b85cd10a3132cfd05e2139e9aa2ef260cb73e782eba121a4ebbd2f98de9e07"
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
            checksum: "94ebb9ec7b7b9247669c6934b7a78159dbed8c0f1548e25c7797aaa8386c7d87"
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
            checksum: "a55a8a281260f41a3eaf38dd58d0685abf0156889db72068576cce19dd9470ce"
        ),

        // MARK: - InAppMessage
        // 依存: Core, Container, Config, Identify, Analytics, Imaging, Logging, UI
        .binaryTarget(
            name: "_NautilusInAppMessageSDK",
            url: xcframeworkURL("NautilusInAppMessageSDK"),
            checksum: "ba9144f60fd72f0d13da92e58f2830e5e15f65d5b92a7e2105075ee38ae99cad"
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
            checksum: "27fc69117bceec03bd530402ad7f9ee2936c08bede9100df86c507b51cfc3ca9"
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
            checksum: "5dc42e1c6bd118309080abac8e9279ce09bf0f18b9cd3095a5452bb2edcc468b"
        ),

        // MARK: - Lottery
        // 依存: Core, Container, Config, Identify, Logging, Imaging, Analytics
        .binaryTarget(
            name: "_NautilusLotterySDK",
            url: xcframeworkURL("NautilusLotterySDK"),
            checksum: "f76cc878bad9ef32c0b2ad2528c0dad1b0bc98b9bf256d4d22adc20dd3cdf2e2"
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
            checksum: "1a025f773b8de1f9d52c5634b11fd4253b5a7cb66d626f694f5aff8b9ff1618e"
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
            checksum: "d1cd5b71cc7b759f181a7a82d10aceb3eb2d53b0553bf817e4eb45d7a7c5eba1"
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
            checksum: "4a5dac0600fcecc8de128c54c96c01f8bd17c680d358a79db16241f0fdd9275d"
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
            checksum: "1a31fdf2ffc5ad865fc6c4cc77fcdadab1ff8e4ec3ab6502056ba71cc7f11fe8"
        ),

        // MARK: - NotificationUI
        // 依存: Core, Container, Config, Identify, Analytics, Notification, Imaging, UI, Logging
        .binaryTarget(
            name: "_NautilusNotificationUISDK",
            url: xcframeworkURL("NautilusNotificationUISDK"),
            checksum: "ee8b6e3304dbe36d875e241a4a12cec48ca13791a16235a2c26ce4c262cad255"
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
            checksum: "3ee5570fc804e13a1e585db70dd68f6ea48e4916a9266c2f7573b143ad45e3a0"
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
            checksum: "df7c89c65573a1d4eabde07cb295dea978ad8388a1efe39c91247ba967da1877"
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
            checksum: "8ac4f6709f7a97bb018cedcf89616e038bd712dd22ac359f25d230840d78fa20"
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
            checksum: "465a2f8eb6f695afbf78de9c5565474f6aa0e62bf79aac4154f817a9c0a984d0"
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
            checksum: "bca93352b286fce5b561af35b40aca71a5ecc7952a26aac011b819b0f27376fb"
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
            checksum: "60e542a654d65cdef6f233e3b73d3b1060fa98e2a82493644cec7c5b3a06b2bc"
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
            checksum: "fa3d61b934f7403e6a2353f07d5b8779e7c8c602706ee523aafc0a3b3c5bb625"
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
            checksum: "7eff6c591f1851a4f1ae1a8f54efb6de77bf4307891df8fcd4c23a95aacb5451"
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
