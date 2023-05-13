//
//  CoreController.swift
//  ParkPalSwiftUI
//
//  Created by Mudit Arora on 4/21/23.
//

import Foundation
import CoreData
import SwiftUI

class CoreController: ObservableObject {
    @Published var parkingData: [ParkingData] = [ParkingData]()
    @Published var userData: [UserData] = [UserData]()
    let container = NSPersistentContainer(name: "ParkPalSwiftUI")
    
    init() {
        container.loadPersistentStores {description, error in
            if let error = error {
                print("Failed to initiate: \(error.localizedDescription)")
            }
        }
        updateData()
        updateInfo()
    }
    
    private func updateData() {
        let fetchRequest: NSFetchRequest<ParkingData> = ParkingData.fetchRequest()
        do {
            parkingData = try container.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch: \(error)")
            parkingData = []
        }
    }
    
    func saveData(name: String, address: String) {
        let info = ParkingData(context: container.viewContext)
        info.id = UUID()
        info.name = name
        info.address = address
        do {
            try container.viewContext.save()
            updateData()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    func deleteData(name: String) {
        let fetchRequest: NSFetchRequest<ParkingData> = ParkingData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            let datasToDelete = try container.viewContext.fetch(fetchRequest)
            if let dataToDelete = datasToDelete.first {
                container.viewContext.delete(dataToDelete)
                try container.viewContext.save()
                updateData()
            } else {
                print("Data not found")
            }
        } catch {
            print("Failed to delete: \(error)")
        }
    }
    
    private func updateInfo() {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        do {
            userData = try container.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch: \(error)")
            userData = []
        }
    }
    
    func saveInfo(username: String, password: String) {
        let info = UserData(context: container.viewContext)
        info.username = username
        info.pass = password
        
        do {
            try container.viewContext.save()
            updateData()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    func deleteInfo(name: String) {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            let infosToDelete = try container.viewContext.fetch(fetchRequest)
            if let infoToDelete = infosToDelete.first {
                container.viewContext.delete(infoToDelete)
                try container.viewContext.save()
                updateInfo()
            } else {
                print("Data not found")
            }
        } catch {
            print("Failed to delete: \(error)")
        }
    }
    
}
