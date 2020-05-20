//
//  Card.swift
//  TerraCards
//
//  Created by Joséphine Delobel on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import MapKit
import SwiftUI

final class Card: Decodable, Identifiable, Hashable, ObservableObject {
    let id = UUID()
    let name: String!
    
    var imageRectoURL: URL?
    var imageRectoOnlineDate: Date?
    
    var imageVersoURL: URL?
    var imageVersoOnlineDate: Date?
    
    let habitats: [HabitatType]!
    let season: String!
    let averageSize: String!
    let anecdote: String!
    var obtained: Bool
    let collection : CollectionType!
    let alert: AlertType!
    
    
    var latitude: Double
    var longitude: Double
    
    var coordinates: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 100, longitudinalMeters: 100)
    }
    
    @Published var imageRecto: Image?
    @Published var imageVerso: Image?
    
    // Pour rendre la Card Decodable du JSON
    enum CodingKeys: String, CodingKey {
        case id, name, imageRecto, imageVerso, habitats, season, averageSize, anecdote, collection, alert, latitude, longitude, obtained, imageRectoLastChange, imageVersoLastChange
    }
    struct imageJson: Codable {
        let url: String
    }
    
    // Pour pouvoir parcourir un tableau de Card avec ForEach
    static func == (lhs: Card, rhs: Card) -> Bool {
           return lhs.id == rhs.id
       }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    

    // Initialisation à vide (pour les preview)
    init() {
        self.name = "Chêne"
        self.imageRectoURL = URL(string: "https://master.salamandre.net/media/21902/chene-jardin-1800x1012.png")!
        self.imageVersoURL = self.imageRectoURL
        self.habitats = [.mountains]
        self.alert = .blackAlert
        self.collection = .amphibian
        self.obtained = false
        self.anecdote = "hahaha"
        self.averageSize = "telle taille"
        self.latitude = 48
        self.longitude = 2
        self.season = "hiver"
    }
    
    // Initialisation depuis un decoder JSON
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        habitats = try values.decode([HabitatType].self, forKey: CodingKeys.habitats)
        season = try values.decode(String.self, forKey: CodingKeys.season)
        averageSize = try values.decode(String.self, forKey: CodingKeys.averageSize)
        anecdote = try? values.decode(String.self, forKey: CodingKeys.anecdote)
        collection = try values.decode(CollectionType.self, forKey: CodingKeys.collection)
        alert = try values.decode(AlertType.self, forKey: CodingKeys.alert)
        if let longitude = try?  values.decode(Double.self, forKey: CodingKeys.longitude) {
            self.longitude = longitude
        } else {
            self.longitude = 48
        }
        if let latitude = try?  values.decode(Double.self, forKey: CodingKeys.latitude) {
            self.latitude = latitude
        } else {
            self.latitude = 2
        }
        if let obtained = try?  values.decode(Bool.self, forKey: CodingKeys.obtained) {
            self.obtained = obtained
        } else {
            self.obtained = false
        }
        
        if let imageRectoLastChange = try? values.decode(String.self, forKey: CodingKeys.imageRectoLastChange) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            self.imageRectoOnlineDate = formatter.date(from: imageRectoLastChange)

        } else {
            self.imageRectoOnlineDate = nil
        }
        
        if let imageVersoLastChange = try? values.decode(String.self, forKey: CodingKeys.imageVersoLastChange) {
            let formatter = DateFormatter()
            self.imageVersoOnlineDate = formatter.date(from: imageVersoLastChange)
        } else {
            self.imageVersoOnlineDate = nil
        }
        
        
        if let imageRectoArray = try? values.decode([imageJson].self, forKey: CodingKeys.imageRecto) {
            self.imageRectoURL = URL(string: imageRectoArray[0].url)!
            //self.imageRecto?.isFileURL

        }
        
        if let imageVersoArray = try? values.decode([imageJson].self, forKey: CodingKeys.imageVerso) {
            self.imageVersoURL = URL(string: imageVersoArray[0].url)!

        }
        
        imageRecto = nil
        imageVerso = nil
        
    }
    
    func fileModificationDate(suffix: String) -> Date? {
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = cachesURL.appendingPathComponent("\(self.name ?? "image_default")_\(suffix).png")
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: fileURL.path)
            return attr[FileAttributeKey.modificationDate] as? Date
        } catch {
            return nil
        }
    }
    
    func loadImageFromCache(suffix: String) -> Image? {
        var image: Image?
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = cachesURL.appendingPathComponent("\(self.name ?? "image_default")_\(suffix).png")
        let filePath = fileURL.path
        print("on cherche l'image dans le cache ici : \(filePath)")

        if FileManager.default.fileExists(atPath: filePath) {
            print("trouvée dans le cache")
            image = Image(uiImage: UIImage(contentsOfFile: filePath) ?? UIImage(systemName: "chene")!)
            return image
        }
        return image
        
        
    }
    
    func downloadImageFromURL(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: {data,response,error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    print("erreur lors du téléchargement :\(error!)")
                    completion(nil)
                    return
                    
            }
            DispatchQueue.main.async() {
                print("bien joué !")
                completion(image)
                
            }
        } ).resume()
        
    }
    
    func writeImageOnCache(image: UIImage, suffix: String) {
        print("on écrit l'image dans le cache")
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = cachesURL.appendingPathComponent("\(self.name ?? "image_default")_\(suffix).png")
        do {
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileURL, options: .atomic)
                print("bien inscrite dans le cache à l'adresse : \(fileURL.path)")
            }
        } catch {
            print("erreur inscription dans cache : \(error)")
        }
        
    }
    // Télécharger les images, depuis le HTTP ou depuis le Cache
    func loadingImages() {
        
        if imageRectoOnlineDate == nil ||
                imageRectoOnlineDate! < (fileModificationDate(suffix: "recto") ?? Date())  {
            print("cache cachou")
            imageRecto = loadImageFromCache(suffix: "recto")
        }
        if imageVersoOnlineDate == nil ||
            imageVersoOnlineDate! < (fileModificationDate(suffix: "verso") ?? Date()) {
            imageVerso = loadImageFromCache(suffix: "verso")
        }


        if imageRecto == nil && imageRectoURL != nil {
            print("on télécharge")
            downloadImageFromURL(url: imageRectoURL!, completion: { image in
                if let image = image {
                    self.imageRecto = Image(uiImage: image)
                    self.writeImageOnCache(image: image, suffix: "recto")
                }
            })
        }
        
        if imageVerso == nil && imageVersoURL != nil {
            downloadImageFromURL(url: imageVersoURL!, completion: { image in
                if let image = image {
                    self.imageVerso = Image(uiImage: image)
                    self.writeImageOnCache(image: image, suffix: "verso")
                }
            })
        }
    }
}

// Enums

enum HabitatType: String, Codable {
    case sea, mountains, city, countryside, forest
    var name : String {
        get {
            switch self {
            case .sea : return "Mer"
            case .mountains : return "Montagne"
            case .city : return "Ville"
            case .countryside : return "Campagne"
            case .forest : return "Forêt"
                
            }
        }
    }
}
enum CollectionType: String, Codable {
    case tree, fish, mollusc, largeMammal, bird, insect, reptile, plant, amphibian, smallMammal, spider
    
    var name : String {
        get {
            switch self {
            case .tree : return "Arbres"
            case .fish : return "Poissons"
            case .mollusc : return "Mollusques"
            case .largeMammal : return "Grands Mammifères"
            case .bird : return "Oiseaux"
            case .insect : return "Insectes"
            case .reptile : return "Reptiles"
            case .plant : return "Plantes"
            case .amphibian : return "Amphibiens"
            case .smallMammal : return "Petits Mammifères"
            case .spider : return "Arachnides"
            }
        }
    }
}

enum AlertType: String, Codable {
    case greenAlert, yellowAlert, redAlert, blackAlert
    var name : String {
        get {
            switch self {
            case .greenAlert : return "Vert"
            case .yellowAlert : return "Jaune"
            case .redAlert : return "Rouge"
            case .blackAlert : return "Noir"
            }
        }
    }
}
