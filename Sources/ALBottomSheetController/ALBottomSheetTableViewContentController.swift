//
//  BottomSheetTableViewContentController.swift
//  BottomSheet
//
//  Created by Adam Leitgeb on 21/07/2020.
//  Copyright © 2020 Adam Leitgeb. All rights reserved.
//

import UIKit

open class ALBottomSheetTableViewContentController: ALBottomSheetContentController {

    // MARK: - Outlets

    public var tableView = UITableView()

    // MARK: - Properties

    override open var sheetHeight: CGFloat {
        tableView.contentSize.height + bottomSafeAreaInset
    }

    // MARK: - View Lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    // MARK: - Setup

    open func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: tableView.topAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            view.leftAnchor.constraint(equalTo: tableView.leftAnchor),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor)
        ])
    }
}
