//
//  TableViewDataSourse.swift
//  Camera
//
//  Created by 郑清江 on 2017/8/8.
//  Copyright © 2017年 zqj. All rights reserved.
//
import UIKit
import CoreData

protocol TableViewDataSourseDelegate {
    associatedtype Object
    associatedtype Cell: UITableViewCell
    func config(cell: Cell, for object: Object)
    var numberOfAdditionalRows: Int { get }
    
    func supplementaryObject(at indexPath: IndexPath) -> Object?
    func presentedIndexPath(for fetchedIndexPath: IndexPath) -> IndexPath
    func fetchedIndexPath(for presentedIndexPath: IndexPath) -> IndexPath?
    
}

extension TableViewDataSourseDelegate{
    
    var numberOfAdditionalRows: Int {
        return 0
    }
    
    func supplementaryObject(at indexPath: IndexPath) -> Object? {
        return nil
    }
    
    func presentedIndexPath(for fetchedIndexPath: IndexPath) -> IndexPath{
        
        return fetchedIndexPath
    }
    func fetchedIndexPath(for presentedIndexPath: IndexPath) -> IndexPath?{
        return presentedIndexPath
    }
    
    
}


class TableViewDataSourse<Result: NSFetchRequestResult, Delegate: TableViewDataSourseDelegate>: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    
    required init(tableView: UITableView,
                  cellIdentifire: String,
                  fetchResultController: NSFetchedResultsController<Result>,
                  delegate: Delegate) {
        
        self.delegate = delegate
        self.tableView = tableView
        self.cellIdent = cellIdentifire
        self.fetchResultController = fetchResultController
        super.init()
        fetchResultController.delegate = self
        try! fetchResultController.performFetch()
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    var selectedObject: Object? {
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return nil
        }
        return objectAtIndexPath(indexPath)
    }
    
    func objectAtIndexPath(_ indexPath: IndexPath) -> Object {
        
        guard let fetchResultIndexPath = delegate.fetchedIndexPath(for: indexPath) else {
            return delegate.supplementaryObject(at: indexPath)!
        }
        
        return (fetchResultController.object(at: fetchResultIndexPath) as! Object)
        
    }
    
    //MARK: - NSFetchResultControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { fatalError("indexPath can't be nil") }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else { fatalError("indexPath can't be nil") }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .move:
            guard let indexPath = indexPath else { fatalError("indexPath can't be nil") }
            guard let newIndexPath = newIndexPath else { fatalError("indexPath can't be nil") }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .update:
            guard let indexPath = indexPath else { fatalError("indexpath can't be nil") }
            let object = objectAtIndexPath(indexPath)
            guard let cell = tableView.cellForRow(at: indexPath) as? Cell else { break }
            delegate.config(cell: cell, for: object)
            
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    //MARK: - Private
    
    fileprivate let tableView: UITableView
    fileprivate let fetchResultController: NSFetchedResultsController<Result>
    fileprivate var delegate: Delegate
    fileprivate let cellIdent: String
    
    
    //MARK: - TableViewDataSourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = fetchResultController.sections?[section] else {
            return 0
        }
        
        return section.numberOfObjects + delegate.numberOfAdditionalRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = objectAtIndexPath(indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdent, for: indexPath) as? Cell else { fatalError("can't find cell") }
        delegate.config(cell: cell, for: object)
        return cell
    }
    
    
    

}
