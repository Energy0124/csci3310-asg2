//
//  Critter.swift
//  CatTracker
//
//  Created by LING Leong on 23/3/2017.
//  Copyright © 2017 LING Leong. All rights reserved.
//

import UIKit
import os.log

class Critter: NSObject, NSCoding{
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var details: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls( for: .documentDirectory, in: .userDomainMask ).first
    static let ArchiveURL = DocumentsDirectory?.appendingPathComponent("critters", isDirectory: false)
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let details = "details"
    }
    
    //MARK: Initialization
    init?(name: String, photo: UIImage, details: String) {
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.details = details
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey:PropertyKey.name)
        aCoder.encode(photo, forKey:PropertyKey.photo)
        aCoder.encode(details, forKey: PropertyKey.details)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey:
            PropertyKey.name) as? String else {
                os_log("Unable to decode name", log: OSLog.default,
                                                    type: .debug)
                return nil }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let details = aDecoder.decodeObject(forKey: PropertyKey.details) as? String
        self.init(name: name, photo: photo!, details: details!) }
}
