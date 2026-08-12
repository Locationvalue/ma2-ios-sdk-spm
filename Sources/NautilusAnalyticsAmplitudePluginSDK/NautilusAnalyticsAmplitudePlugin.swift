//
//  NautilusAnalyticsAmplitudePlugin.swift
//  NautilusAnalyticsAmplitudePluginSDK
//
//  Created by udagawa on 2022/10/07.
//  Copyright © 2022 LocationValue Inc. All rights reserved.
//

import Foundation
import NautilusAnalyticsSDK

@objc
public final class NautilusAnalyticsAmplitudePlugin: NSObject, NautilusAnalyticsPlugin {

    private var apiKey: String
    private var amplitudeManager: AmplitudeManager
    private var enableSessionReplay: Bool

    public var name: String
    
    @objc
    public convenience init(name: String) {
        self.init(name: name, apiKey: "", enableSessionReplay: false)
    }
    
    @objc
    public init(name: String, apiKey: String, enableSessionReplay: Bool) {
        self.name = name
        self.apiKey = apiKey
        self.enableSessionReplay = enableSessionReplay
        self.amplitudeManager = AmplitudeManager()
        super.init()
    }
    
    public func setup(_ analytics: NautilusAnalytics) {
        amplitudeManager.initialize(apiKey: apiKey, enableSessionReplay: enableSessionReplay)
    }
    
    public func sendEvent(payload: NautilusAnalyticsEventPayload) -> NautilusAnalyticsEventPayload {
        amplitudeManager.logEvent(
            eventType: payload.eventName,
            eventProperties: payload.eventProperties
        )
        return payload
    }
    
    public func setUserProperty(propertyName: String, value: Any?) {
        amplitudeManager.addOperation(name: propertyName, value: value)
    }
    
    public func removeUserProperty(propertyName: String) {
        amplitudeManager.removeOperation(name: propertyName)
    }
    
    public func sendUserProperty() {
        amplitudeManager.sendUserProperty()
    }
    
    public func setUserID(_ userID: String) {
        amplitudeManager.setUserID(userID)
    }
    
    public func removeUserID() {
        amplitudeManager.setUserID(nil)
    }
}
