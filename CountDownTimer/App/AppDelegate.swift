//
//  AppDelegate.swift
//  CountDownTimer
//
//  Created by Ayemere  Odia  on 2022/09/25.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerForPushNotification()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let reminderEvent = FutureEvent(aps: userInfo) {
            // TODO: Add support for future event notification on T - 1 day
           displayDurationFor(event: reminderEvent)
        }
    }
}

extension AppDelegate {
    func registerForPushNotification() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
                print("Permission: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
              UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to Register for remote notification")
    }
    
    func displayDurationFor(event: FutureEvent) {
        let counter = CountDownTimer(event: event)
        let viewModel = CountDownViewModel(event: event, countDownTimer: counter)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let countDownViewController = storyBoard.instantiateViewController(withIdentifier: "CountDownViewController") as? CountDownViewController else { return }
        
        viewModel.delegate = countDownViewController
        countDownViewController.viewModel = viewModel
        countDownViewController.modalPresentationStyle = .formSheet
        (window?.rootViewController as? UINavigationController)?.present(countDownViewController, animated: true)
    }
}

