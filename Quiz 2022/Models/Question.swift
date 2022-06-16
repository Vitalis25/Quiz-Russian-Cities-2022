//
//  Question.swift
//  Quiz 2022
//
//  Created by Vitally Ochnev on 16.06.2022.
//

import Foundation

struct Question {
    let text: String
    let type: ResponseType
    let answer: [Answer]
    
    static let all: [Question] = [
        Question(text: "Какой самый большой храм Ростова-на-Дону?", type: .single,
                 answer: [Answer(text: "Старо-Покровский храм"),
                          Answer(text: "Свято-Троицкий приход"),
                          Answer(text: "Рождества Пресвятой Богородицы", points: 100)]),
        Question(text: "На территории усадьбы Кусково в Москве находятся:", type: .multiply,         answer: [Answer(text: "Менажереи", points: 33),
                          Answer(text: "Оранжереи", points: -33),
                          Answer(text: "Кавалерийский корпус", points: -33),
                          Answer(text: "Грот", points: 33),
                          Answer(text: "Домик Петра I", points: -34),
                          Answer(text: "Голландский Домик", points: 34)]),
        Question(text: "Сергиев Посад входит в маршрут «Золотое кольцо России»; он рядом со столицей, до него всего __ км:", type: .range,
                 answer: [Answer(text: "50"),
                          Answer(text: "60"),
                          Answer(text: "70", points: 100),
                          Answer(text: "80"),
                          Answer(text: "90")]),
        Question(text: "Какой смайлик лучше всего характеризует город Тулу:", type: .segment,
                 answer: [Answer(text: "Пляж"),
                          Answer(text: "Сопки"),
                          Answer(text: "Музеи"),
                          Answer(text: "Пряники", points: 100),
                          Answer(text: "Барабаны")]),
    ]
}
