//
//  AppDelegate.swift
//  Note app
//
//  Created by APPLE on 23.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CoreDataManager.shared.load {
            let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
            
            if launchedBefore {
                debugPrint("Test")
            } else {
                UserDefaults.standard.set(true, forKey: "launchedBefore")
                let main = MainViewController()
                let note = NoteApp(context: CoreDataManager.shared.viewContext)
                note.id = UUID()
                note.text = "Hi"
                main.notesArray.append(note)
                CoreDataManager.shared.save()
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

