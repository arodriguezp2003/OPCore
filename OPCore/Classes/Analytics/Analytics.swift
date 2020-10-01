//
//  Analytics.swift
//  OPCore
//
//  Created by arodriguez on 01-10-20.
//

import Foundation

import FirebaseAnalytics
import FirebaseCrashlytics

/// Protocol OPAnalyticsProtocol
public protocol OPAnalyticsProtocol: class {
    /// Sets the user ID property. This feature must be used in accordance with Google's Privacy Policy
    /// - Parameter userID: The user ID to ascribe to the user of this app on this device, which must be non-empty and no more than 256 characters long. Setting userID to nil removes the user ID.
    func setUserID(_ userID: String)
    /// Logs an app event. The event can have up to 25 parameters. Events with the same name must have the same parameters. Up to 500 event names are supported. Using predefined events and/or parameters is recommended for optimal reporting.
    /// - Parameters:
    ///   - eventName: The name of the event. Should contain 1 to 40 alphanumeric characters or underscores. The name must start with an alphabetic character. Some event names are reserved. See FIREventNames.h for the list of reserved event names. The "firebase_", "google_", and "ga_" prefixes are reserved and should not be used. Note that event names are case-sensitive and that logging two events whose names differ only in case will result in two distinct events. To manually log screen view events, use the `screen_view` event name.
    ///   - parameters: The dictionary of event parameters. Passing nil indicates that the event has no parameters. Parameter names can be up to 40 characters long and must start with an alphabetic character and contain only alphanumeric characters and underscores. Only NSString and NSNumber (signed 64-bit integer and 64-bit floating-point number) parameter types are supported. NSString parameter values can be up to 100 characters long. The "firebase_", "google_", and "ga_" prefixes are reserved and should not be used for parameter names.
    func logEvent(eventName: String, parameters: [String: Any])
    /// Clears all analytics data for this instance from the device and resets the app instance ID. FIRAnalyticsConfiguration values will be reset to the default values.
    func resetAnalyticsData()
    
    /// Records a non-fatal event described by an NSError object. The events are grouped and displayed similarly to crashes. Keep in mind that this method can be expensive. The total number of NSErrors that can be recorded during your app's life-cycle is limited by a fixed-size circular buffer. If the buffer is overrun, the oldest data is dropped. Errors are relayed to Crashlytics on a subsequent launch of your application.
    /// - Parameters:
    ///   - code: code identified
    ///   - parameters: parametes errors
    func registerError(code: Int, parameters: [String: Any])
}

/// Sigleton class Analytics
public class OPAnalytics {
    /// static shared intance Singleton
    public static let shared = OPAnalytics()
}

extension OPAnalytics {
    /// Sets the user ID property. This feature must be used in accordance with Google's Privacy Policy
    /// - Parameter userID: The user ID to ascribe to the user of this app on this device, which must be non-empty and no more than 256 characters long. Setting userID to nil removes the user ID.
    public func setUserID(_ userID: String) {
        FirebaseAnalytics.Analytics.setUserID(userID)
    }
    /// Logs an app event. The event can have up to 25 parameters. Events with the same name must have the same parameters. Up to 500 event names are supported. Using predefined events and/or parameters is recommended for optimal reporting.
    /// - Parameters:
    ///   - eventName: The name of the event. Should contain 1 to 40 alphanumeric characters or underscores. The name must start with an alphabetic character. Some event names are reserved. See FIREventNames.h for the list of reserved event names. The "firebase_", "google_", and "ga_" prefixes are reserved and should not be used. Note that event names are case-sensitive and that logging two events whose names differ only in case will result in two distinct events. To manually log screen view events, use the `screen_view` event name.
    ///   - parameters: The dictionary of event parameters. Passing nil indicates that the event has no parameters. Parameter names can be up to 40 characters long and must start with an alphabetic character and contain only alphanumeric characters and underscores. Only NSString and NSNumber (signed 64-bit integer and 64-bit floating-point number) parameter types are supported. NSString parameter values can be up to 100 characters long. The "firebase_", "google_", and "ga_" prefixes are reserved and should not be used for parameter names.
    public func logEvent(eventName: String, parameters: [String : Any]) {
        FirebaseAnalytics.Analytics.logEvent(eventName, parameters: parameters)
    }
    /// Clears all analytics data for this instance from the device and resets the app instance ID. FIRAnalyticsConfiguration values will be reset to the default values.
    public func resetAnalyticsData() {
        FirebaseAnalytics.Analytics.resetAnalyticsData()
    }
    /// Records a non-fatal event described by an NSError object. The events are grouped and displayed similarly to crashes. Keep in mind that this method can be expensive. The total number of NSErrors that can be recorded during your app's life-cycle is limited by a fixed-size circular buffer. If the buffer is overrun, the oldest data is dropped. Errors are relayed to Crashlytics on a subsequent launch of your application.
    /// - Parameters:
    ///   - code: code identified
    ///   - parameters: parametes errors
    public func registerError(code: Int, parameters: [String: Any]) {
        
        let error = NSError.init(domain: "OPCORE", code: code, userInfo: parameters)
        FirebaseCrashlytics.Crashlytics.crashlytics().record(error: error)
    }
}

