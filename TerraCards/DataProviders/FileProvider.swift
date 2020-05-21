//
//  FileReaderWriter.swift
//  TerraCards
//
//  Created by foxy on 21/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


enum FileError: Error {
    case unknown
}

struct FileProvider {
    
    typealias Completion = (Result<URL, FileError>) -> Void

    static func fileModificationDate(fileURL: URL) -> Date? {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: fileURL.path)
            return attr[FileAttributeKey.modificationDate] as? Date
        } catch {
            return nil
        }
    }

    

    static func getCachedCardImageUrl(name: String?, suffix: String) -> URL {
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cachesURL.appendingPathComponent("\(name ?? "image_default")_\(suffix).png")
    }


    static func getImageFromCache(name: String?, suffix: String, completion: Completion? = nil) -> Image? {
        var image: Image?
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = cachesURL.appendingPathComponent("\(name ?? "image_default")_\(suffix).png")
        let filePath = fileURL.path

        if FileManager.default.fileExists(atPath: filePath) {
            print("trouvée dans le cache")
            image = Image(uiImage: UIImage(contentsOfFile: filePath) ?? UIImage(systemName: "chene")!)
            completion?(.success(fileURL))
            return image
        }
        
        completion?(.failure(.unknown))
        print("chemin invalide")
        return image
    }
    
    static func writeImageInCache(image: UIImage, name: String?, suffix: String?, completion: Completion? = nil) {
        print("on écrit l'image dans le cache")
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = cachesURL.appendingPathComponent("\(name ?? "image_default")_\(suffix ?? "").png")
        do {
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileURL, options: .atomic)
                print("bien inscrite dans le cache à l'adresse : \(fileURL.path)")
                completion?(.success(fileURL))
            }
        } catch {
            print("erreur inscription dans cache : \(error)")
            completion?(.failure(.unknown))
        }
        
    }

    static func clearImagesFromCacheFolder(completion: Completion?  = nil) {
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheFolderPath = cachesURL.path
        do {
            let filePaths = try FileManager.default.contentsOfDirectory(atPath: cacheFolderPath)
            for filePath in filePaths {
                let fileUrl = URL(fileURLWithPath: filePath)
                print(URL(fileURLWithPath: fileUrl.lastPathComponent).pathExtension)
                if URL(fileURLWithPath: fileUrl.lastPathComponent).pathExtension == "png" {
                    try FileManager.default.removeItem(atPath: cacheFolderPath + "/" + filePath)
                    completion?(.success(cachesURL))
                }
            }
        } catch {
            print("Could not clear cache folder: \(error)")
            completion?(.failure(.unknown))
        }
    }
    
}


