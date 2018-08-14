//
//  ViewController.swift
//  Quiz
//
//  Created by Jose Pacheco on 8/13/18.
//  Copyright © 2018 Jose Pacheco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentQuestionIndex = 0
    
    let questionsAndAnswers: [(question: String, answer: String)] = [
        (question: "what is cognac made of", answer: "grapes" ),
        (question: "how cold was it in this room?", answer: "too cold"),
        (question: "how cold is it in this room now?", answer: "just right")
    ]
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questionsAndAnswers.count {
            currentQuestionIndex = 0
        }
        questionLabel.text = questionsAndAnswers[currentQuestionIndex].question
        answerLabel.text = "???"
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        answerLabel.text = questionsAndAnswers[currentQuestionIndex].answer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       questionLabel.text = questionsAndAnswers[currentQuestionIndex].question
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

