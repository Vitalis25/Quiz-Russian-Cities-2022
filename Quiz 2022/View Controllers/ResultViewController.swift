//
//  ResultViewController.swift
//  Quiz 2022
//
//  Created by Vitally Ochnev on 15.06.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    let answers: [Answer]
    
    init?(coder: NSCoder, _ answers: [Answer]) {
        self.answers = answers
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#line) \(#function) init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "Ваш Результат"
        
        var totalPoints: Int
        totalPoints = answers.reduce(0, {$0 + $1.points})
        
        let expert = ExpertType(points: totalPoints)
        resultLabel.text = "Вы - \(expert.name)"
        
        personImage.image = UIImage(named: expert.image)
                
        descriptionLabel.text = expert.definition
        
 

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
