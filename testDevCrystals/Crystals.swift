//
//  Crystals.swift
//  testDevCrystals
//
//  Created by Aaron Ploetz on 6/23/24.
//

import Foundation

struct CrystalResponse: Decodable {
    let results: [Crystal]
}

//struct CrystalKV: Decodable {
//    let image_file: String
//    let crystal_data: Crystal
//}

struct Crystal: Decodable {
    var name: String
    var image_name: String
    var chakra: [String]
    var physical_attributes: String
    var emotional_attributes: String
    var metaphysical_attributes: String
    var origin: String
    var birth_month: String
    var zodiac_sign: String
    var maximum_mohs_hardness: Float
    var minimum_mohs_hardness: Float
}

//class Api : ObservableObject{
//    @Published var crystals = [CrystalKV]()
//
//    func loadData(completion:@escaping ([CrystalKV]) -> ()) {
//        var components = URLComponents(string: "http://127.0.0.1:8080/api/text")!
//
//        components.queryItems = [
//            URLQueryItem(name: "text", value: "digestion")
//        ]
//
//        guard let url = components.url else {
//            print("Invalid url...")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            let crystals = try! JSONDecoder().decode([CrystalKV].self, from: data!)
//            DispatchQueue.main.async {
//                completion(crystals)
//            }
//        }.resume()
//
//    }
//}
