//
//  RealmManager.swift
//  MarsDiscovery
//
//  Created by   Liza Kotova on 16.07.2024.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared: RealmManager = {
        let instance = RealmManager()
        return instance
    }()
    
    private let realm: Realm
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Could not initialize Realm instance: \(error.localizedDescription)")
        }
    }
    
    var historyData: Results<HistoryModel> {
        return getData(ofType: HistoryModel.self)
    }
    
    func getData<T: Object>(ofType: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
    
    func add(historyModel: HistoryModel) {
        historyModel.id = (self.realm.objects(HistoryModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
        do {
            try realm.write {
                realm.add(historyModel, update: .error)
            }
        } catch {
            print("Could not save object!\n\(error.localizedDescription)")
        }
    }
    
    func delete(historyModel: HistoryModel) {
        do {
            try realm.write {
                realm.delete(historyModel)
            }
        } catch {
            print("Could not delete object!\n\(error.localizedDescription)")
        }
    }
}
