//
//  HistoryModel.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 16.07.2024.
//

import Foundation
import RealmSwift

final class HistoryModel: Object, Identifiable {
    @Persisted dynamic var rover: String = ""
    @Persisted dynamic var camera: String? = nil
    @Persisted dynamic var date: Date = Date()
    @Persisted dynamic var id = 0
    override class func primaryKey() -> String? {
        return "id"
    }
}

