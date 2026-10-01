// swift-tools-version: 6.0
import PackageDescription

// MARK: - リリース情報
//
// SDK 本体の xcframework は、このリポジトリの GitHub Releases のアセットとして
// 「1 モジュール = 1 zip」で配布する。リポジトリ本体に xcframework をコミットしない
// （SwiftPM は依存解決時にリポジトリを全履歴 clone するため）。
//
// `sdkVersion` と各 binaryTarget の `checksum` は、SDK 側のリリースワークフローで自動更新される。

let sdkVersion = "0.0.1"

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
            checksum: "c92f2397f8fa14812ea2c6a8c9647f5af47917ce4ede0789194261e1ce0cd1f1"
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
            checksum: "907f63f27136f7e38abe134d67b1ddb4e62a3d7cd7f4f99e6e0b853edcc5bd1e"
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
            checksum: "dd17999cc6c420288874d53409accccce8c6ef6904bd13117c722763107ccf3f"
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
            checksum: "f583bac0fb5aca1cf2da7703e6ddfa4c6864acc051f760d8de92ba84b1417e02"
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
            checksum: "374b632e36d045cb4a70240dd6f8c0f2e99a22c6a1abc54bb7dce4c982d71a19"
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
            checksum: "367015a7e66d058a0bc7f1bf3e114bbec5c175a430779f2a5613734145e89f19"
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
            checksum: "c9a84fdfee9aaca0c2a96e3b871f81d21f673100dd234b80738b1af5c0f559f2"
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
            checksum: "d64848b98ccb6a2dadab3b6b32944c6dbd56c30d58b8a0ec7b0bf65a7db73573"
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
            checksum: "d3a09a3a97c02ba6b715cc523453a6b8f1daec595718d0c9733dfdf147cfca50"
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
            checksum: "2f1cd33dbe18eba10394f05af5fa49e5ea4755525db198250b22772158748b08"
        ),

        // MARK: - Content
        // 依存: Core, Container, Config, Identify, Imaging, Analytics, Logging, UI
        .binaryTarget(
            name: "_NautilusContentSDK",
            url: xcframeworkURL("NautilusContentSDK"),
            checksum: "267ae96876a3f324dd420d74fa7c17cac4169e352554ebbe8bbb706061e140ef"
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
            checksum: "f28deb6b4c670a57bb8912f03209ffeb72f85d74a382b193f75de92ff1eed0c0"
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
            checksum: "32e2059ff505205a3aad9e2001c08e3df41939b7189fbdf240b1b7dfc3849922"
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
            checksum: "4916d9e87f18235055657d5ef4a57488912a88e6dd54d12d8c771e7c80d359cb"
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
            checksum: "4febb92404e821c5521e2b2aa789db41f56b68d4f3283b66e9efa82f9cc10520"
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
            checksum: "e84bed651abcdeeb5bd046292eec3d3e430bd90bc0e0a973df5ca044948f8352"
        ),

        // MARK: - InAppMessage
        // 依存: Core, Container, Config, Identify, Analytics, Imaging, Logging, UI
        .binaryTarget(
            name: "_NautilusInAppMessageSDK",
            url: xcframeworkURL("NautilusInAppMessageSDK"),
            checksum: "44b5ea42d661ff3a20c20db8caf007400c774516005dce8a04d95485217432b1"
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
            checksum: "42480694c47c9b91ff71647b5cb4534035d27c28f5c80876c7dee247f80af355"
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
            checksum: "5aeb3e615b34bd946898d54c6406c87229bbd32e43bfab7e0a553ee810a25cf6"
        ),

        // MARK: - Lottery
        // 依存: Core, Container, Config, Identify, Logging, Imaging, Analytics
        .binaryTarget(
            name: "_NautilusLotterySDK",
            url: xcframeworkURL("NautilusLotterySDK"),
            checksum: "598e3cb1ec4a0331247a0c5fbe32b093c8edb23b7f1d751bdafefd9b944cba03"
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
            checksum: "907b03fe601dd3be932c545a64e7aa15a8e73cdf772a8f7aec998d5062a8b106"
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
            checksum: "0b78feefa2b2e349585a0ba5934f0681f4be1b1175a2194f364f06b538e11f7d"
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
            checksum: "3ed57842dae2e560411d5941890938617ce24199aeee9cfa86b8a58f9a1ed408"
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
            checksum: "cbf26b1f170388f880d3a112a1ea716b9150923ad626d7db0c9cb15264b03e02"
        ),

        // MARK: - NotificationUI
        // 依存: Core, Container, Config, Identify, Analytics, Notification, Imaging, UI, Logging
        .binaryTarget(
            name: "_NautilusNotificationUISDK",
            url: xcframeworkURL("NautilusNotificationUISDK"),
            checksum: "4baa070c571a5bae9724007e8a3bbee8e214d92639155857782a01a14c846ca3"
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
            checksum: "96340b57e3585ec6eeba25d5681c88ab58f27a431faa7558c1336a552c48a344"
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
            checksum: "6e92d863cd65eafcf09bbd9d01d749ffeff75f53d1dc8d7b286cdb716405eae6"
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
            checksum: "398d1ac5e87dcf8811194a0adb205521bcb3ea702461d8561649241b595a9d68"
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
            checksum: "3c5ba80aea0e66d5cdec3400ef91bf011880928e1611803fe4fe78b86b3a5a08"
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
            checksum: "2a280ed8ec671363070da748811afcc4f24f3a71094ad1ebdca7a1b38a93fef6"
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
            checksum: "b1aede4198e6de447b36ae2c358f8f173a3add01e062b805fa2df9339ac5cf61"
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
            checksum: "1571f70c4d1f5f66eafff7d80971a508a8ae55fab13e8b76faccabfc61bf4a79"
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
            checksum: "f1b5bc15215cccc7d170d4f4caa65fe43625ed0f7d8e770ac8413868f288fe14"
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
