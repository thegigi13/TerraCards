//
//  AppDelegate.swift
//  TerraCards
//
//  Created by MacBookGP on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import UIKit
import SwiftUI

import BackgroundTasks
import Network

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    @ObservedObject var cards = CardsLists()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                

        
        cards.fetchAllCards {response in
            switch response {
            case .success:
                print("all cards fetched and loaded")
            case .failure:
                print("problem during downloading or decoding")
                // retry ??
            }
        }
        
        registerBackgroundTaks()

        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("connected")
                DispatchQueue.main.async {
                    self.cards.connection = true
                }
                
            } else {
                print("disconnected")
                DispatchQueue.main.async {
                    self.cards.connection = false
                }
            }
        }
        
        monitor.start(queue: DispatchQueue.global())
        
        // à enlever avant production
        UserSettings.nbLaunches = 0
        FileProvider.clearImagesFromCacheFolder(){response in
            print("ok")
        }
        //
        
        UserSettings.nbLaunches = UserSettings.nbLaunches + 1
        print("nombre de lancement de l'app : \(UserSettings.nbLaunches)")
        
        if UserSettings.nbLaunches == 1 {
            UserSettings.userCards = ["Mésange Bleue", "Chêne", "Dauphin"]
        }
        print("cartes déjà gagnées : \(UserSettings.userCards)")

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
    
    
    
    
    //MARK: Regiater BackGround Tasks
    private func registerBackgroundTaks() {
        print("on est là")
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.TerraCards.fetchBackground", using: nil) { task in
            //This task is cast with processing request (BGProcessingTask)
            self.handleNewCardsFetcherTask(task: task as! BGProcessingTask)
        }
    }


}

extension AppDelegate {
    
    func cancelAllPandingBGTask() {
        BGTaskScheduler.shared.cancelAllTaskRequests()
    }
    
    func scheduleNewCardsFetcher() {
        let request = BGProcessingTaskRequest(identifier: "com.TerraCards.fetchBackground")
        request.requiresNetworkConnectivity = false // Need to true if your task need to network process. Defaults to false.
        request.requiresExternalPower = false
        
        request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 5) // Featch Image Count after 1 minute.
        //Note :: EarliestBeginDate should not be set to too far into the future.
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule image featch: \(error)")
        }
    }
    
    
    func handleNewCardsFetcherTask(task: BGProcessingTask) {
        
        scheduleNewCardsFetcher() // Recall
        task.expirationHandler = {
            //This Block call by System
            //Canle your all tak's & queues
            self.cancelAllPandingBGTask()
        }

        cards.fetchAllCards {response in
            switch response {
            case .success:
                print("all cards fetched and loaded in background")
                task.setTaskCompleted(success: true)
            case .failure:
                print("problem during downloading or decoding in background")
                task.setTaskCompleted(success: false)
            }
        }
        
        

        
        
    }
}

