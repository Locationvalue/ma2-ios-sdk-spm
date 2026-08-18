# ma2-ios-sdk-spm

ModuleApps 2.0（MA 2.0）の iOS 向けライブラリを配布するためのリポジトリです。

SDK 本体は XCFramework（バイナリ）として [Releases](https://github.com/Locationvalue/ma2-ios-sdk-spm/releases) のアセットで配布しています。

## ⚠️ ModuleApps 導入プロジェクト向けのリポジトリです

**本リポジトリは、株式会社ディアワン（DearOne, inc.）が提供する ModuleApps 2.0 の導入プロジェクトでの利用を目的としています。**

ご利用には弊社との契約が必要です。契約者以外の方へのサポート・保守・動作保証は行っておりません。

> This repository is for use in ModuleApps 2.0 projects by DearOne, inc.
> We do not provide any support, maintenance, or guarantees for external users.

## サードパーティ依存

以下のパッケージに依存しています。バージョンは `Package.swift` の記載を参照してください。

| パッケージ | 利用しているライブラリ |
| --- | --- |
| [ZXingObjC-Binaries](https://github.com/Locationvalue/ZXingObjC-Binaries) | `NautilusCodeImageProvidersSDK` |
| [lottie-spm](https://github.com/airbnb/lottie-spm) | `NautilusLotteryUISDK` ほか |

## プライバシーマニフェスト

本 SDK の各 XCFramework には `PrivacyInfo.xcprivacy` を同梱しています。

ただし `ZXingObjC-Binaries` には同梱されていません。App Store 申請時に Required Reason API に関する警告が出た場合は、アプリ本体のプライバシーマニフェストで宣言してください。

## CocoaPods をご利用の場合

CocoaPods 版は [ma2-ios-sdk](https://github.com/Locationvalue/ma2-ios-sdk) および [ma2-ios-sdk-repo](https://github.com/Locationvalue/ma2-ios-sdk-repo) で配布しています。

## ライセンス

Copyright © DearOne, inc. All rights reserved.

本 SDK は商用ライセンスのもとで提供されます。
