//
//  NewEventNotification.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/10/17.
//

import Foundation
import UserNotifications

class NewEventNotification {
    
    static func setupLocalNotifcation(with event: FutureEvent) {
        let content = UNMutableNotificationContent()
        var data = [String: Any]()
        data["name"] = event.name
        data["dateTime"] = event.dateTime
        data["isDone"] = event.isDone
        
        content.title = "IT'S ALMOST TIME!!!"
        content.subtitle = event.name
        content.userInfo = data
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: event.dateTime.timeIntervalSinceNow, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }

}
