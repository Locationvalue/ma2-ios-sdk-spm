# ma2-ios-sdk-spm

ModuleApps 2.0（MA 2.0）の iOS 向けライブラリを配布するためのリポジトリです。

## ご利用にあたって

本 SDK のご利用には、株式会社DearOne との契約が必要です。本リポジトリが公開されていること、およびその内容を閲覧・取得できることは、本 SDK の使用を許諾するものではありません。契約者以外の方に対しては、サポート、保守、動作保証その他一切の対応を行っておりません。

> This repository is provided by DearOne, Inc. for use in ModuleApps 2.0 projects under a commercial agreement with us. Public visibility of this repository does not grant any license to use, copy, modify, or redistribute this SDK. No support, maintenance, or warranty is provided to parties without such an agreement.

本 README は日本語版を正文とし、英文は参考訳です。

## サードパーティ ライセンス

本 SDK は以下のオープンソースソフトウェアに依存しています。ライセンス条文および著作権表示は、各リポジトリに含まれています。

| パッケージ | 由来 OSS |
| --- | --- |
| [ZXingObjC-Binaries](https://github.com/Locationvalue/ZXingObjC-Binaries) | [ZXingObjC](https://github.com/zxingify/zxingify-objc) |
| [lottie-spm](https://github.com/airbnb/lottie-spm) | [lottie-ios](https://github.com/airbnb/lottie-ios) |

`ZXingObjC-Binaries` は、弊社が上流の ZXingObjC を XCFramework 化して配布している非公式のバイナリパッケージです。オリジナルからの変更点は同リポジトリの README に記載しています。

**本 SDK を組み込んだアプリを配布される場合、上記 OSS の著作権表示およびライセンス条文を、貴社アプリのライセンス表示画面等に掲載してください。**

## プライバシーマニフェスト

- 本 SDK の各 XCFramework には `PrivacyInfo.xcprivacy` を同梱しています。
- `ZXingObjC-Binaries` には同梱されていません。App Store 申請時に Required Reason API に関する警告（ITMS-91053）が出た場合は、通知に記載された API カテゴリをアプリ本体のプライバシーマニフェストで宣言してください。
- Lottie は Xcode が同梱マニフェストを自動検出するため、追加の作業は不要です。

## ライセンス

Copyright © DearOne, Inc. (formerly LocationValue Inc.) All rights reserved.

本リポジトリは弊社の旧商号「株式会社ロケーションバリュー（LocationValue Inc.）」に由来する `Locationvalue` organization 配下にありますが、同社は商号変更により現在の株式会社DearOne となった同一法人です。過去のリリースやバイナリ等に旧商号の表記が含まれる場合も、権利は株式会社DearOne に帰属します。

本 SDK は、株式会社DearOne と利用者との間で締結された ModuleApps 2.0 に関する個別契約（以下「本契約」といいます）に基づき提供される商用ソフトウェアです。本 SDK の利用条件は本契約の定めるところによります。本 README の記載と本契約の内容が異なる場合は、本契約が優先します。

本契約を締結していない第三者に対して、本 SDK の使用、複製、改変、翻案、再頒布、逆コンパイル、逆アセンブルその他のリバースエンジニアリングを許諾するものではありません。

本 SDK は現状有姿（AS IS）で提供され、明示または黙示を問わず、商品性、特定目的への適合性、権利非侵害を含むいかなる保証も行いません。保証および責任の範囲については本契約の定めによります。

なお、本項は本 SDK 自体に関する条件であり、本 SDK が依存するオープンソースソフトウェアについては、前掲「サードパーティ ライセンス」に記載の各ライセンス条件が適用されます。

## 商標

「ModuleApps」「DearOne」およびこれらに関連する名称・ロゴは、株式会社DearOne の商標です。本 SDK の利用許諾は、これらの商標の使用を許諾するものではありません。

Apple、App Store、Xcode、Swift は、米国およびその他の国における Apple Inc. の商標です。本 SDK は Apple Inc. によって提供、承認、または推奨されるものではありません。

## お問い合わせ

本 SDK に関するお問い合わせは、ご契約時にご案内している窓口までご連絡ください。
