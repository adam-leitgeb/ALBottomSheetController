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

    @IBOutlet weak public var tableView: UITableView!

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
    }
}
