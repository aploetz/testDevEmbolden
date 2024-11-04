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
//    @State private var imageSearch = false
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 60)
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.1)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 60)
                        .padding(.horizontal)
                }
                HStack {
                    Button {
                        vm.source = .camera
                        vm.showPhotoPicker()
                        //imageSearch = true
                    } label: {
                        Text("Camera")
                    }
                    Button {
                        vm.source = .library
                        vm.showPhotoPicker()
                        //imageSearch = true
                    } label: {
                        Text("Photos")
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $vm.showPicker) {
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
            }
            .navigationTitle("Search by Image")
            .onChange(of: vm.image, initial: false) {
                Task {
                    crystals = await searchByImage(img: vm.image)
                }
            }
        }
        NavigationView {
            List {
                ForEach(crystals, id: \.image_name) { crystal in
                    NavigationLink(destination: CrystalView(crystal: crystal)) {
                        HStack(spacing: 50) {
                            Text("\(crystal.name)")
                                .font(.title)
                            
                            if crystal.image_name.contains(".jpeg") {
                                Image(String(crystal.image_name.dropLast(5)))
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            } else {
                                Image(String(crystal.image_name.dropLast(4)))
                                    .resizable()
                                    .frame(width: 60, height: 60)
                            }
                            
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Search by Text")
            .onChange(of: searchText, initial: false) { oldSearch, newSearch in
            Task
                {
                    //imageSearch = false
                    crystals = await searchByText()
                }
            }
        }
    }
    
    func searchByText() async -> [Crystal] {
        print("here1T")
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
    
    func searchByImage(img: UIImage?) async -> [Crystal] {
        if img != nil {
            let url = URL(string: "http://127.0.0.1:8080/api/image")!

            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

            var body = [String:Any]()
            body["image"] = img?.base64

            do {
                let imgData = try JSONSerialization.data(withJSONObject: body, options: [])
                
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = imgData
                
                let (data, _) = try await URLSession.shared.upload(for: request, from: imgData)
                do {
                    return try JSONDecoder().decode([Crystal].self, from: data)
                } catch {
                    return []
                }
            } catch {
                return []
            }
        } else {
            return []
        }
    }
}

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
