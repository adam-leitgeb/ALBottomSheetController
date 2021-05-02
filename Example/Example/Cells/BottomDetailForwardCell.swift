//
//  OrderListOrderCell.swift
//
//  Created by Adam Leitgeb on 09/09/2020.
//  Copyright © 2020 Adam Leitgeb. All rights reserved.
//

import DataSource
import UIKit

final class BottomDetailForwardCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
}

// MARK: - Configuration

extension BottomDetailForwardCell: CellConfigurable {
    func configure(with model: BottomDetailForwardCellModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        contentView.backgroundColor = model.backgroundColor
    }
}
