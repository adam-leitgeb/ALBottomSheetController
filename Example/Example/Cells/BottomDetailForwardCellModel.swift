//
//  OrderListOrderCellModel.swift
//
//  Created by Adam Leitgeb on 09/09/2020.
//  Copyright © 2020 Adam Leitgeb. All rights reserved.
//

import DataSource
import UIKit

struct BottomDetailForwardCellModel: CellModelSelectable {

    // MARK: - Properties

    let title: String
    let subtitle: String
    let backgroundColor: UIColor
    let selectionHandler: (() -> Void)?

    // MARK: - Object Lifecycle
    
    init(title: String, subtitle: String, selectionHandler: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        backgroundColor = .white
        self.selectionHandler = selectionHandler
    }
}

// MARK: - CellModelConvertible

extension BottomDetailForwardCellModel: CellModelConvertible {
    typealias Cell = BottomDetailForwardCell

    var height: CGFloat {
        68.0
    }
}
