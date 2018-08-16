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
                return moodButton
            }
        }
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

