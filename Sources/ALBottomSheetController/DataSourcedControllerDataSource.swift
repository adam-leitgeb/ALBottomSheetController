//
//  File.swift
//  
//
//  Created by Adam Leitgeb on 02.05.2021.
//

import DataSource
import Foundation
import UIKit

public protocol DataSourcedControllerDataSourceDelegate: AnyObject {
    func dismissSheet(then completion: ALBottomSheetContainerController.Completion?)
}

open class DataSourcedControllerDataSource: DataSource {
    
    // MARK: - Properties

    public weak var delegate: DataSourcedControllerDataSourceDelegate?
    
    // MARK: - DataSource
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellSelectable = sections[indexPath.section].cells[indexPath.row] as? CellModelSelectable else {
            return
        }
        
        if cellSelectable.deselectAutomatically {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        delegate?.dismissSheet {
            cellSelectable.selectionHandler?()
        }
    }
}
