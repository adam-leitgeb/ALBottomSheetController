//
//  ViewController.swift
//  Example
//
//  Created by Adam Leitgeb on 02.05.2021.
//

import DataSource
import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    private var cellModels: [CellModel] = [
        BottomDetailForwardCellModel(title: "Title", subtitle: "Subtitle", selectionHandler: { print("1") }),
        BottomDetailForwardCellModel(title: "Title", subtitle: "Subtitle", selectionHandler: { print("2") }),
        BottomDetailForwardCellModel(title: "Title", subtitle: "Subtitle", selectionHandler: { print("3") })
    ]
    
    private var section: Section {
        Section(cells: cellModels)
    }
    
    // MARK: - View Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        displayBottomSheet()
    }
    
    // MARK: - Actions

    @IBAction private func buttonTapped(_ sender: UIButton) {
        displayBottomSheet()
    }
    
    // MARK: - Utilities

    private func displayBottomSheet() {
        let coordinator = ALBottomSheetCoordinator(sourceController: self, sections: [section])
        coordinator.start()
    }
    
    private func displayLegacyBottomSheet() {
        let contentController = DataSourcedController(sections: [section])
        let containerController = ALBottomSheetContainerController(contentViewController: contentController)
        containerController.modalPresentationStyle = .overFullScreen
        
        present(containerController, animated: false, completion: nil)
    }
}
