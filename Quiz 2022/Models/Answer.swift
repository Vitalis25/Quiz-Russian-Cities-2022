//
//  Answer.swift
//  Quiz 2022
//
//  Created by Vitally Ochnev on 16.06.2022.
//

struct Answer {
    let text: String
    let points: Int
    private var isSelected: Bool
    
    init(text: String, points: Int = 0) {
        self.text = text
        self.points = points
        self.isSelected = false
    }
    
    mutating func setSelection(_ selected: Bool) {
        self.isSelected = selected
    }
}
