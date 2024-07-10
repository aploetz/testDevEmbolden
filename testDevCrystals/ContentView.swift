//
//  ContentView.swift
//  testDevCrystals
//
//  Created by Aaron Ploetz on 5/11/24.
//

import SwiftUI

struct ContentView: View {

    @State var crystals = [Crystal]()
    @State private var searchText: String = ""

    var body: some View {
        
        NavigationView {
            List {
                ForEach(crystals, id: \.image_name) { crystal in
                    HStack {
                        Text("\(crystal.name)")
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Crystal Search")
            .onChange(of: searchText, initial: false) { oldSearch, newSearch in
            Task
                {
                    crystals = await searchByText()
                }
            }
        }
    }
    
    func searchByText() async -> [Crystal] {
        
        if searchText.isEmpty || searchText.count < 3 {
            return []
        } else {
            let url = URL(string: "http://127.0.0.1:8080/api/text/\(searchText)")!
            let (data, _) = try! await URLSession.shared.data(from: url)

            do {
                return try JSONDecoder().decode([Crystal].self, from: data)
            } catch {
                return []
            }
        }
    }
}

#Preview {
    ContentView()
}
