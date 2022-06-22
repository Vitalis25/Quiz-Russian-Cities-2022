//
//  QuestionViewController.swift
//  Quiz 2022
//
//  Created by Vitally Ochnev on 14.06.2022.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multiLabels: [UILabel]!
    @IBOutlet var multiSwitches: [UISwitch]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet weak var segmentStackView: UIStackView!
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var segmentButton: UIButton!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var sliderValueLabel: UILabel?
    
    private var answersGiven = [Answer]() {
        didSet {
            print(#line, #function, answersGiven)
        }
    }
    
    private var currentAnswers: [Answer] {
        currentQuestion.answer
    }
    private var currentQuestion: Question {
        Question.all[questionIndex]
    }
        
    var questionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        rangedSlider.maximumValue = 0.99999
        updateUI()
    }

    func updateUI() {
        
        func updateSingleStack () {
            singleStackView.isHidden = false
            for (index, button) in singleButtons.enumerated() {
                button.setTitle(nil, for: [])
                button.tag = index
            }
            for (button, answer) in zip(singleButtons, currentAnswers) {
                button.setTitle(answer.text, for: [])
            }
        }
        
        func updateMultipleStack () {
            multipleStackView.isHidden = false
            for label in multiLabels {
                label.text = nil
            }
            for (label, answer) in zip(multiLabels, currentAnswers) {
                label.text = answer.text
            }
        }
        
        func updateRangedStack () {
            
            let answerRow = UIStackView()
            answerRow.axis = .vertical
            answerRow.alignment = .fill
            answerRow.distribution = .fill
            answerRow.spacing = 0
                    
            sliderValueLabel = UILabel()
            sliderValueLabel!.text = currentAnswers.first?.text
            sliderValueLabel!.textAlignment = .center
            sliderValueLabel!.font = UIFont.systemFont(ofSize: 24)
                    
            let slider = UISlider()
            slider.minimumValue = 0
            slider.maximumValue = Float(currentAnswers.count - 1)
            slider.addTarget(self, action: #selector(rangedSliderMoved), for: .valueChanged)
                    
            let minMaxRow = UIStackView()
            minMaxRow.axis = .horizontal
            minMaxRow.alignment = .fill
            minMaxRow.distribution = .fillEqually
            minMaxRow.spacing = 0

            let minValueTitle = UILabel()
            minValueTitle.text = currentAnswers.first?.text
            minValueTitle.textAlignment = .left
            minValueTitle.font = UIFont.systemFont(ofSize: 20)

            let maxValueTitle = UILabel()
            maxValueTitle.text = currentAnswers.last?.text
            maxValueTitle.textAlignment = .right
            maxValueTitle.font = UIFont.systemFont(ofSize: 20)

            minMaxRow.addArrangedSubview(minValueTitle)
            minMaxRow.addArrangedSubview(maxValueTitle)
                    
            answerRow.addArrangedSubview(sliderValueLabel!)
            answerRow.addArrangedSubview(slider)
            answerRow.addArrangedSubview(minMaxRow)
                    
            rangedStackView.addArrangedSubview(answerRow)
            
            rangedStackView.isHidden = false
            rangedLabels.first?.text = currentAnswers.first?.text
            rangedLabels.last?.text = currentAnswers.last?.text
            
        }
        
        func updateSegmentStack () {
            segmentStackView.isHidden = false
        }
        
        for stackView in [singleStackView, multipleStackView, rangedStackView, segmentStackView] {
            stackView?.isHidden = true
        }
        
        let totalProgress = Float(questionIndex) / Float(Question.all.count)
        
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack()
        case .multiple:
            updateMultipleStack()
        case .range:
            updateRangedStack()
        case .segment:
            updateSegmentStack()

        }
        
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < Question.all.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results Segue", sender: nil)
        }
    }
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let answers = Question.all[questionIndex].answer
        let index = sender.tag
        guard 0 <= index && index < answers.count else {
            return
        }
        let answer = answers[index]
        answersGiven.append(answer)
        nextQuestion()
    }
    
    @IBAction func multiButtonPressed() {
        for (index, multiSwitch) in multiSwitches.enumerated() {
            if multiSwitch.isOn && index < currentAnswers.count {
                let answer = currentAnswers[index]
                answersGiven.append(answer)
            }
        }
        nextQuestion()
    }
    
    @objc func rangedSliderMoved(_ sender: UISlider) {
        sender.value =  roundf(sender.value)
        let tag = Int(sender.value)
        
        sliderValueLabel?.text = currentAnswers[tag].text
        
                }
    
    @IBAction func rangedButtonPressed() {
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        if index < currentAnswers.count {
            let answer = currentAnswers[index]
            answersGiven.append(answer)
        }
        nextQuestion()
    }
    
    @IBAction func segmentButtonPressed(_ sender: UIButton) {
        let index = segments.selectedSegmentIndex
        if index < currentAnswers.count {
            let answer = currentAnswers[index]
            answersGiven.append(answer)
        }
        nextQuestion()
    }
    
    @IBSegueAction func resultsSegue(_ coder: NSCoder) -> ResultViewController? {
        return ResultViewController(coder: coder, answersGiven)
    }
}
    
    
    


    
