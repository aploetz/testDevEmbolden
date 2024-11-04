//
//  CrystalView.swift
//  testDevCrystals
//
//  Created by Aaron Ploetz on 8/18/24.
//

import SwiftUI

struct CrystalView: View {
    let crystal: Crystal
    var body: some View {
        VStack(alignment: .center) {
            Text(crystal.name)
                .font(.title)
                .bold()
            HStack {
                if crystal.image_name.contains(".jpeg") {
                    Image(String(crystal.image_name.dropLast(5)))
                        .resizable()
                        .frame(width: 160, height: 160)
                } else {
                    Image(String(crystal.image_name.dropLast(4)))
                        .resizable()
                        .frame(width: 160, height: 160)
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("chakras: ").fontWeight(.thin).italic()
                        ForEach (crystal.chakra, id: \.self) { chakra_i in
                            Text(chakra_i)
                        }
                    }
                    HStack {
                        Text("birth month: ").fontWeight(.thin).italic()
                        Text(crystal.birth_month)
                    }
                    HStack {
                        Text("zodiac sign: ").fontWeight(.thin).italic()
                        Text(crystal.zodiac_sign)
                    }
                    HStack {
                        Text("mohs hardness: ").fontWeight(.thin).italic()
                        if crystal.maximum_mohs_hardness == crystal.minimum_mohs_hardness {
                            Text(String(crystal.maximum_mohs_hardness))
                        } else {
                            Text(String(crystal.minimum_mohs_hardness)) +
                            Text("-") +
                            Text(String(crystal.maximum_mohs_hardness))
                        }
                    }
                }
            }
            Text("physical attributes: ").fontWeight(.thin).italic() + Text(crystal.physical_attributes)
            Text("emotional attributes: ").fontWeight(.thin).italic() + Text(crystal.emotional_attributes)
            Text("metaphysical attributes: ").fontWeight(.thin).italic() + Text(crystal.metaphysical_attributes)
        }
    }
}

struct CrystalView_Previews: PreviewProvider {
    static var crystal = Crystal.sampleData[0]
    static var previews: some View{
        CrystalView(crystal: crystal)
            .background(Color("seafoam"))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
