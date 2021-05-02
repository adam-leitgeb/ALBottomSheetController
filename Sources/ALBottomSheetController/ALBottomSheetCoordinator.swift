//
//  File.swift
//  
//
//  Created by Adam Leitgeb on 02.05.2021.
//

import DataSource
import UIKit

open class ALBottomSheetCoordinator {
    
    // MARK: - Properties

    private weak var sourceController: UIViewController?
    private let contentController: DataSourcedController
    private let containerController: ALBottomSheetContainerController
    
    // MARK: - Object Lifecycle

    public init(sourceController: UIViewController, sections: [Section]) {
        self.sourceController = sourceController
        contentController = DataSourcedController(sections: sections)
        containerController = ALBottomSheetContainerController(contentViewController: contentController)
        containerController.modalPresentationStyle = .overFullScreen
    }
        
    // MARK: - Actions

    func start() {
        containerController.modalPresentationStyle = .overFullScreen
        sourceController?.present(containerController, animated: false, completion: nil)
    }
}
