//
//  ExpertType.swift
//  Quiz 2022
//
//  Created by Vitally Ochnev on 16.06.2022.
//

enum ExpertType: String {
    case homester = "homester.jpeg"
    case traveller = "traveller.png"
    case tourist = "tourist.png"
    case student = "student.png"
    case guide = "guide.png"
    
    init (points: Int) {
        switch points {
        case -100..<0:
            self = .homester
        case 0..<100:
            self = .traveller
        case 100..<200:
            self = .tourist
        case 200..<300:
            self = .student
        default:
            self = .guide
        }
    }
    
    var name: String {
        switch self {
        case .homester:
            return "домосед"
        case .traveller:
            return "путешественник"
        case .tourist:
            return "турист"
        case .student:
            return "студент истфака"
        case .guide:
            return "гид-переводчик"
        }
    }
    
    var image: String {
        switch self {
        case .homester:
            return "homester"
        case .traveller:
            return "traveller"
        case .tourist:
            return "tourist"
        case .student:
            return "student"
        case .guide:
            return "guide"
        }
    }
    
    var definition: String {
        switch self {
        case .homester:
            return "Пора уже увидеть Россию воочию!"
        case .traveller:
            return "Даёшь спонтанные приключения по городам и весям России!"
        case .tourist:
            return "У Вас всегда есть план пешего тура по российскому городу с указанием достопримечательностей!"
        case .student:
            return "Краеведение родных просторов всё больше захватывает Вас!"
        case .guide:
            return "Знание городских историй и традиций регионов России на 5+!"
        }
    }
}
