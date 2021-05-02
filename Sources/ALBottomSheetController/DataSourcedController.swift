//
//  BottomSheetController.swift
//
//  Created by Adam Leitgeb on 28/03/2020.
//  Copyright © 2020 Adam Leitgeb. All rights reserved.
//

import DataSource
import UIKit

public class DataSourcedController: ALBottomSheetTableViewContentController, DataSourcedControllerDataSourceDelegate {

    // MARK: - Types

    public typealias Completion = () -> Void

    // MARK: - Properties

    private let dataSource: DataSourcedControllerDataSource
    private let impactGenerator = UIImpactFeedbackGenerator(style: .light)

    public override var sheetHeight: CGFloat {
        tableView.contentSize.height + bottomSafeAreaInset + tableView.frame.minY
    }

    // MARK: - Object Lifecycle

    required public init(sections: [Section]) {
        dataSource = DataSourcedControllerDataSource(sections: sections)
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        dataSource = DataSourcedControllerDataSource()
        super.init(coder: coder)
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupContent()
    }

    // MARK: - Setup

    private func setupContent() {
        tableView.reloadData()
    }

    public override func setupTableView() {
        super.setupTableView()

        dataSource.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.separatorStyle = .none
    }

    // MARK: - Actions

    public func updateWithSections(_ sections: [Section]) {
        dataSource.sections = sections
        tableView.reloadData()
        updateSheetHeight()
    }

    public func playHapticImpact() {
        impactGenerator.impactOccurred()
    }
}
