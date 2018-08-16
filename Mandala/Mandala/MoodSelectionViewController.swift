//
//  ViewController.swift
//  Mandala
//
//  Created by Jose Pacheco on 8/16/18.
//  Copyright © 2018 Jose Pacheco. All rights reserved.
//

import UIKit

class MoodSelectionViewController: UIViewController {
    // MARK: Outlets
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var addMoodButton: UIButton!
    
    // MARK: Variables
    var moods: [Mood] = [] {
        didSet {
            moodButtons = moods.map { mood in
               let moodButton = UIButton()
                moodButton.setImage(mood.image, for: .normal)
                moodButton.imageView?.contentMode = .scaleAspectFit
                moodButton.addTarget(self, action: #selector(moodSelectionChanged(_:)), for: .touchUpInside)
                return moodButton
            }
            currentMood  = moods.first
        }
    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
            
            addMoodButton?.setTitle("I'm currently \(currentMood.name)", for: .normal)
            addMoodButton?.backgroundColor = currentMood.color
        }
    }
    
    @objc func moodSelectionChanged(_ sender: UIButton) {
        guard let selectedIndex = moodButtons.index(of: sender) else {
            preconditionFailure("Unable to find the tapped button")
        }
        currentMood = moods[selectedIndex]
    }
    
    var moodButtons: [UIButton] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            moodButtons.forEach { stackView.addArrangedSubview($0) }
        }
    }
    
    // MARK: Functions
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }
    
}


