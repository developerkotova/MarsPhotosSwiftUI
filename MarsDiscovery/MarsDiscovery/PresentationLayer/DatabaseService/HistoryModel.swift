//
//  HistoryModel.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 16.07.2024.
//

import Foundation
import RealmSwift

final class HistoryModel: Object, Identifiable {
    @objc dynamic var rover: String = ""
    @objc dynamic var camera: String? = nil
    @objc dynamic var date: Date = Date()
    @objc dynamic var id = 0
    override class func primaryKey() -> String? {
        return "id"
    }
}

