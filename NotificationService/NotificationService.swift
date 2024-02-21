//
//  NotificationService.swift
//  NotificationService
//
//  Created by Gordon on 21.02.24.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            if let userDefaults = UserDefaults(suiteName: "group.dev.gordonkirsch.OneCam") {
                let badgeCount = userDefaults.integer(forKey: "badgeCount")
                
                if badgeCount > 0 {
                    userDefaults.set(badgeCount + 1, forKey: "badgeCount")
                    bestAttemptContent.badge = badgeCount + 1 as NSNumber
                } else {
                    userDefaults.set(1, forKey: "badgeCount")
                    bestAttemptContent.badge = 1
                }
                
                contentHandler(bestAttemptContent)
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
