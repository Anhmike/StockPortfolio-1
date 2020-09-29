//
//  DataStorage.swift
//  StockPortfolio
//
//  Created by Ivan Ruiz Monjo on 29/09/2020.
//

import Foundation
import CoreData
import Combine

struct CoreDataStorage: DataStorage {

    private let manager: PersistenceManager

    init(manager: PersistenceManager = PersistenceManager.shared) {
        self.manager = manager
    }

    func save(symbol: String) -> AnyPublisher<(), DataStorageError> {
        let entity = NSEntityDescription.insertNewObject(forEntityName: String(describing: StockCoreData.self), into: manager.context) as! StockCoreData
        entity.symbol = symbol
        do {
            try manager.context.save()
            return Just(()).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
        } catch {
            return Fail(outputType: Void.self,
                        failure: DataStorageError.unkown(reason: error.localizedDescription)).eraseToAnyPublisher()
        }
    }

    func get() -> AnyPublisher<[String], DataStorageError> {
        let request: NSFetchRequest<StockCoreData> = StockCoreData.fetchRequest()
        do {
            let stocks = try PersistenceManager.shared.context.fetch(request)
            let symbols = stocks.map { $0.symbol ?? "" }.filter { $0 != "" }
            return Just(symbols).setFailureType(to: DataStorageError.self).eraseToAnyPublisher()
        } catch {
            return Fail(outputType: [String].self, failure: DataStorageError.unkown(reason: error.localizedDescription)).eraseToAnyPublisher()
        }
    }

}