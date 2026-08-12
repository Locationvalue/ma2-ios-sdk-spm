//
//  AmplitudeManager.swift
//  Nautilus-ios-sdk
//
//  Created by masuno on 2020/09/23.
//  Copyright © 2020 LocationValue Inc. All rights reserved.
//

import Foundation
internal import AmplitudeSwift
internal import AmplitudeSwiftSessionReplayPlugin
import NautilusLoggingSDK

/**
 * Amplitudeの管理クラス
 */
internal final class AmplitudeManager: NSObject {
    
    private var amplitudeInstance: Amplitude!
    private var isInitialized: Bool = false
    private var operations: [AmplitudeAnalyticsUserOperation] = []
    private var clientName: String?
    
    internal override init() {
        super.init()
    }
    
    internal init(clientName: String) {
        self.clientName = clientName
        super.init()
    }
    
    /**
     * Amplitudeの初期化を行う
     *
     * - parameters:
     *   - apiKey: Amplitudeの管理画面から払い出されたAPIキー
     */
    internal func initialize(apiKey: String, enableSessionReplay: Bool) {
        guard !isInitialized else {
            // 重複した初期化は許可しない
            Logger.info("Amplitude is already initialized.")
            return
        }
        guard !apiKey.isEmpty else {
            // 空文字列では初期化させない
            fatalError("Amplitude API key is empty. Please disable the Amplitude plugin or set a valid API key.")
        }
        
        let configuration: Configuration = if let clientName {
            Configuration(
                apiKey: apiKey,
                instanceName: clientName,
                autocapture: []
            )
        } else {
            Configuration(
                apiKey: apiKey,
                autocapture: []
            )
        }
        amplitudeInstance = Amplitude(configuration: configuration)

        if enableSessionReplay {
            let sessionReplay = AmplitudeSwiftSessionReplayPlugin()
            amplitudeInstance.add(plugin: sessionReplay)
        }

        self.isInitialized = true
    }
    
    /**
     * Amplitudeにイベントを送信する
     *
     * - parameters:
     *   - eventType:イベントの名称
     *   - eventProperties: イベントプロパティ
     */
    internal func logEvent(eventType: String, eventProperties: [String: Any?]? = nil) {
        guard isInitialized else {
            // 初期化されていない
            Logger.error("Failed to send log event to Amplitude, because Amplitude API key is not given.")
            return
        }
        if let eventProperties {
            let event = BaseEvent(
                eventType: eventType,
                eventProperties: eventProperties as [String : Any]
            )
            amplitudeInstance.track(event: event)
        } else {
            let event = BaseEvent(
                eventType: eventType
            )
            amplitudeInstance.track(event: event)
        }
    }
    
    /// Amplitude に User Propertyを送信する
    internal func sendUserProperty() {
        guard isInitialized else {
            // 初期化されていない
            Logger.error("Failed to send user properties to Amplitude, because Amplitude API key is not given.")
            return
        }
        // UserProperty送信
        let userProperty = Identify()
        operations.forEach {
            switch $0 {
            case .set(let prop, let value):
                guard let ampValue = value as? AmplitudeUserPropertyValue else {
                    Logger.warn("User property `\(prop)` is invalid value type: `\(type(of: value))`")
                    return
                }
                userProperty.set(property: prop, value: ampValue.amplitudeValue)
            case .unset(let prop):
                userProperty.unset(property: prop)
            }
        }
        amplitudeInstance.identify(identify: userProperty)
        operations.removeAll()
    }
    
    /// Amplitude にUserIDを送信する
    internal func setUserID(_ userID: String?) {
        guard isInitialized else {
            // 初期化されていない
            Logger.error("Failed to send user properties to Amplitude, because Amplitude API key is not given.")
            return
        }
        amplitudeInstance.setUserId(userId: userID)
    }
    
    /// operationsに値を追加
    internal func addOperation(name: String, value: Any?) {
        guard value != nil else {
            Logger.warn("User property `\(name)` is nil")
            return
        }
        guard value is AmplitudeUserPropertyValue else {
            Logger.warn("User property `\(name)` is invalid value type: `\(type(of: value))`")
            return
        }
        operations.append(.set(name, value!))
    }
    
    /// operationsにunsetな値を追加
    internal func removeOperation(name: String) {
        operations.append(.unset(name))
    }
}

internal protocol AmplitudeUserPropertyValue {
    var amplitudeValue: NSObject { get }
}

extension AmplitudeUserPropertyValue where Self: NSObject {
    var amplitudeValue: NSObject {
        self
    }
}

extension String: AmplitudeUserPropertyValue {
    var amplitudeValue: NSObject {
        NSString(string: self)
    }
}

extension NSString: AmplitudeUserPropertyValue { }
extension NSNumber: AmplitudeUserPropertyValue { }
extension NSArray: AmplitudeUserPropertyValue { }

extension Bool: AmplitudeUserPropertyValue {
    var amplitudeValue: NSObject {
        NSNumber(value: self)
    }
}
extension Int: AmplitudeUserPropertyValue {
    var amplitudeValue: NSObject {
        NSNumber(value: self)
    }
}
extension UInt: AmplitudeUserPropertyValue {
    var amplitudeValue: NSObject {
        NSNumber(value: self)
    }
}
extension Float: AmplitudeUserPropertyValue {
    var amplitudeValue: NSObject {
        NSNumber(value: self)
    }
}
extension Double: AmplitudeUserPropertyValue {
    var amplitudeValue: NSObject {
        NSNumber(value: self)
    }
}

extension Array: AmplitudeUserPropertyValue {
    var amplitudeValue: NSObject {
        NSArray(array: self.compactMap {
            $0 as? AmplitudeUserPropertyValue
        })
    }
}

extension Dictionary: AmplitudeUserPropertyValue {
    var amplitudeValue: NSObject {
        NSDictionary(dictionary: self.compactMapValues { element in
            element as? AmplitudeUserPropertyValue
        })
    }
}

/// UserPropertyに値をセットする
internal enum AmplitudeAnalyticsUserOperation {
    case set(String, Any)
    case unset(String)
}
