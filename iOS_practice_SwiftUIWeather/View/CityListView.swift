//
//  CityListView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/12/16.
//

import SwiftUI

struct CityListView : View{
    
    @State var cities: [City] = []
    
    var unit: unitOfTemperature
    
    @State private var searchText: String = ""
    
    // onAppear 時寫入
    @State var favoriteList: [Int] = []
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            
            List {
                let textCount = self.searchText.count
                ForEach(self.cities.filter {
                    if (textCount > 2) {
                        return $0.name.lowercased().contains(self.searchText.lowercased())
                    } else if (textCount == 2) {
                        return $0.country.lowercased().contains(self.searchText.lowercased())
                    } else if (textCount == 0) {
                        return favoriteList.contains($0.id)
                    } else {
                        return false
                    }
                    
                }, id: \.self) { city in
                    CityList(city: city, unit: unit)
                }
                
            }
            .navigationBarTitle("Cities")
            //.cornerRadius(25)
            .simultaneousGesture(DragGesture().onChanged({ _ in
                // 如果滑動頁面就把鍵盤收回
                UIApplication.shared.endEditing()
            }))
        }
        .onAppear() {
            DecodeCityList.decode() { (citiesData) in
                cities = citiesData
            }
            favoriteList = DefaultWeather.getDefault(forKey: DefaultsKeys.favoriteList) as! [Int]
        }
        //.listRowBackground(Color.white)
        .buttonStyle(PlainButtonStyle())
        
    }
    
}

struct CityListView_Previews : PreviewProvider {
    static var previews: some View {
        
        CityListView(cities: citiesList, unit: .Celsius)
    }
}

private struct CityList: View {
    let city: City
    let unit: unitOfTemperature
    
    @State private var selectedCity: String?

    var body: some View {
        NavigationLink(
            destination: CityDetail(city: city, unit: unit),
            tag: "\(city.id)",
            selection: self.$selectedCity) {
                VStack(alignment: .leading, spacing: nil, content: {
                    Text(city.name)
                    Text(city.country)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                })
        }
    }
}

struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

extension UIApplication {
    
    // 關閉鍵盤
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
