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
        var trigger: UNTimeIntervalNotificationTrigger
        let data = formatFutureEvent(event: event)
        content.title = "IT'S TIME!!!"
        content.subtitle = event.name
        content.userInfo = data
        content.sound = UNNotificationSound.defaultRingtone
        let eventDate = dateFormatter(from: event.dateTime)
        let currentDate = dateFormatter(from: Date())

        if eventDate ==  currentDate {
            let intervals = event.dateTime.timeIntervalSinceNow
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: intervals, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            // add our notification request
            UNUserNotificationCenter.current().add(request)
        } else {
            if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: event.dateTime) {
                
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: yesterday.timeIntervalSinceNow, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // add our notification request
                UNUserNotificationCenter.current().add(request)
                
            }
        }
    }
    
    static func formatFutureEvent(event: FutureEvent) -> [String: Any] {
        var data = [String: Any]()
        data["name"] = event.name
        data["dateTime"] = event.dateTime
        data["isDone"] = event.isDone
        return data
    }
    
    static func dateFormatter(from eventDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: eventDate)
    }

}
