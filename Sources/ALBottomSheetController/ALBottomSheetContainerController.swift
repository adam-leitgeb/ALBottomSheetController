//
//  BottomSheetContainerController.swift
//  BottomSheet
//
//  Created by Adam Leitgeb on 21/07/2020.
//  Copyright © 2020 Adam Leitgeb. All rights reserved.
//

import UIKit

open class ALBottomSheetContainerController: UIViewController {

    // MARK: - Types

    public typealias Completion = () -> Void

    // MARK: - Properties

    private let shadowView = UIView()
    private let contentViewController: UIViewController?
    private lazy var initialSheetFrame = CGRect(x: 0.0, y: view.frame.maxY, width: view.frame.width, height: view.frame.height)

    // MARK: - Object Lifecycle

    required public init(contentViewController: UIViewController) {
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        contentViewController = nil
        super.init(coder: coder)
    }

    // MARK: - View Lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        setupGestureRecognizer()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addShadowView()
        addBottomSheetView()
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        displayBackgroundOverlay()
    }

    // MARK: - Setup

    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        shadowView.addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - Layout

    private func addShadowView() {
        shadowView.backgroundColor = .clear
        shadowView.frame = view.frame
        view.addSubview(shadowView)
    }

    private func addBottomSheetView() {
        guard let contentViewController = contentViewController else {
            return
        }
        contentViewController.view.clipsToBounds = true
        contentViewController.view.layer.cornerRadius = 16.0
        contentViewController.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        addChild(contentViewController)
        view.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)

        // Adjust bottomSheet frame and initial position.
        contentViewController.view.frame = initialSheetFrame
    }

    // MARK: - Animations

    private func displayBackgroundOverlay() {
        UIView.animate(withDuration: 0.2) {
            self.shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }
    }

    private func hideContentView(then completion: @escaping (Bool) -> Void) {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.shadowView.backgroundColor = .clear
                self.contentViewController?.view.frame = self.initialSheetFrame
            },
            completion: completion
        )
    }

    // MARK: - Actions

    @objc
    private func backgroundTapped() {
        dismissSheet()
    }

    // MARK: - Utilities

    public func dismissSheet(then completion: Completion? = nil) {
        hideContentView() { _ in
            self.contentViewController?.willMove(toParent: nil)
            self.contentViewController?.removeFromParent()
            self.contentViewController?.view.removeFromSuperview()
            self.dismiss(animated: false, completion: completion)
        }
    }
}
