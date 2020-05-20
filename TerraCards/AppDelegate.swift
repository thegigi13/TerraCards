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
                
        do {
            try cards.fillAllCardsList()
        } catch {
            print(error)
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
        
        //Todo Work
        task.expirationHandler = {
            //This Block call by System
            //Canle your all tak's & queues
        }
        
        //Get & Set New Data
//        let interator =  ListInterator()
//        let presenter =  ListPresenter()
//        presenter.interator = interator
//
//        presenter.setNewData()
        
        //
        do {
            print("BLABLABLA")
            try cards.fillAllCardsList()
            task.setTaskCompleted(success: true)

        } catch {
            print(error)
            task.setTaskCompleted(success: false)

        }
        
    }
}

