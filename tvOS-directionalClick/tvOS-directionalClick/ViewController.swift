//
//  ViewController.swift
//  tvOS-directionalClick
//
//  Created by David Cordero on 10.07.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import UIKit
import GameController

class ViewController: UIViewController {

    @IBOutlet private weak var directionLabel: UILabel!
    
    private var dPadState: DPadState = .select

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpDirectionalPad()
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        
        for press in presses {
            switch press.type {
            case .select where dPadState == .up:
                directionLabel.text = "⬆️"
            case .select where dPadState == .down:
                directionLabel.text = "⬇️"
            case .select:
                directionLabel.text = "🆗"
            default:
                super.pressesBegan(presses, with: event)
            }
        }
    }
    
    // MARK: - Private
    
    private func setUpDirectionalPad() {
        guard let controller = GCController.controllers().first else { return }
        guard let micro = controller.microGamepad else { return }
        micro.reportsAbsoluteDpadValues = true
        micro.dpad.valueChangedHandler = {
            [weak self] (pad, x, y) in
            
            let threshold: Float = 0.7
            if y > threshold {
                self?.dPadState = .up
            }
            else if y < -threshold {
                self?.dPadState = .down
            }
            else {
                self?.dPadState = .select
            }
            
        }
    }
}

