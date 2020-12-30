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
    
    @State private var searchText : String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            
            List {
                ForEach(self.cities.filter {
                    if (self.searchText.count > 2) {
                        return $0.name.lowercased().contains(self.searchText.lowercased())
                    } else if (self.searchText.count == 2) {
                        return $0.country.lowercased().contains(self.searchText.lowercased())
                    } else {
                        return false
                    }
                    
                }, id: \.self) { city in
                    CityList(city: city, unit: unit)
                }
            }
                .navigationBarTitle("Cities")
                .simultaneousGesture(DragGesture().onChanged({ _ in
                    UIApplication.shared.endEditing()
                }))
        }
        .onAppear() {
            DecodeCityList.decode() { (citiesData) in
                cities = citiesData
            }
        }
    }
    
}

struct CityListView_Previews : PreviewProvider {
    static var previews: some View {
        
        CityListView(cities: citiesList, unit: .Celsius)
    }
}

struct CityList: View {
    let city: City
    let unit: unitOfTemperature
    
//    @Binding var showSecond: Bool
//    @Binding var showThird: Bool

    var body: some View {
        NavigationLink(destination: CityDetail(city: city, unit: unit, weatherDetail: OpenWeather.WeatherDetail())) {
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
