//
//  BottomSheetViewController.swift
//  BottomSheet
//
//  Created by Adam Leitgeb on 21/07/2020.
//  Copyright © 2020 Adam Leitgeb. All rights reserved.
//

import UIKit

open class ALBottomSheetContentController: UIViewController {

    // MARK: - Properties

    private var impactJustOccured = false
    @IBInspectable public var isInteractiveDismissEnabled: Bool = false

    // Helpers

    private var dismissTresholdPosition: CGFloat {
        UIScreen.main.bounds.height - sheetHeight + 32.0
    }

    private var maximumSheetHeight: CGFloat {
        UIScreen.main.bounds.height * 0.75
    }

    public var bottomSafeAreaInset: CGFloat {
        UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
    }

    open var sheetHeight: CGFloat {
        fatalError("Needs to be overriden in child")
    }

    // MARK: - View Lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()

        setupGestures()
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateSheetToDefaultPosition()
    }

    // MARK: - Setup

    private func setupGestures() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(panGestureRecognizer)
    }

    // MARK: - Animation

    private func animateSheetToDefaultPosition() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.8,
            options: .curveEaseOut,
            animations: {
                let frame = self.view.frame
                let yComponent = UIScreen.main.bounds.height - min(self.sheetHeight, self.maximumSheetHeight)
                self.view.frame = .init(x: 0.0, y: yComponent, width: frame.width, height: frame.height)
            },
            completion: nil
        )
    }

    // MARK: - Actions

    public func updateSheetHeight() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.animateSheetToDefaultPosition()
        }
    }

    // MARK: - Utilities

    @objc
    private func panGesture(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .cancelled, .ended:
            dismissIfPossibe()
        case .changed:
            moveSheet(recognizer: recognizer)
        default:
            break
        }
    }

    private func moveSheet(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let yTranslation = translation.y / 4.0
        let yPosition = view.frame.minY

        guard view.frame.minY > (UIScreen.main.bounds.height - sheetHeight - 32.0) else {
            return playImpactIfPossible()
        }

        if isInteractiveDismissEnabled, view.frame.minY >= dismissTresholdPosition, view.frame.minY <= (dismissTresholdPosition + 4.0) {
            playImpactIfPossible()
        } else {
            impactJustOccured = false
        }

        view.frame = .init(x: 0.0, y: yPosition + yTranslation, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(.zero, in: view)
    }

    private func playImpactIfPossible() {
        guard !impactJustOccured else {
            return
        }
        let impactGenerator = UIImpactFeedbackGenerator(style: .light)
        impactGenerator.impactOccurred()
        impactJustOccured = true
    }

    private func dismissIfPossibe() {
        guard isInteractiveDismissEnabled, view.frame.minY >= dismissTresholdPosition else {
            return animateSheetToDefaultPosition()
        }
        if let parent = parent as? ALBottomSheetContainerController {
            parent.dismissSheet()
        }
    }
}
