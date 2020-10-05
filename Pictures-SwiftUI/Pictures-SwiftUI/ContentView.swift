//
//  ContentView.swift
//  Pictures-SwiftUI
//
//  Created by Juan Capponi on 9/25/20.
//

import SwiftUI
import Combine


struct ContentView: View {
    @ObservedObject private var viewModel = PictureListViewModel()

    var body: some View {
        NavigationView {
        List(viewModel.viewModelPictures, id: \.self) {
            pictVM in
            NavigationLink(
                destination: PhotoDetail(viewModelPict: pictVM)) {
            HStack {
                URLImageView(urlString: pictVM.medium).cornerRadius(8).frame(width: 80.0, height: 100.0)
                VStack {
                    Text(pictVM.photographerName)
                    }
                }
            }
        }.onAppear{
            self.viewModel.fetchPicts()
        }.navigationTitle("Pictures")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class PictureListViewModel : ObservableObject {
    private let viewModelService = ViewModelDataSource()
    
    @Published var viewModelPictures = [ViewModelPictures]()

    var cancellable : AnyCancellable?
    func fetchPicts () {
        cancellable = viewModelService.fetchPictures().sink(receiveCompletion: {
            _ in
        },
        receiveValue:  { pictsContainer in
            self.viewModelPictures = pictsContainer.photos.map { ViewModelPictures(photographerName: $0.photographer, urlSmall: $0.src.small, medium: $0.src.large, large: $0.src.large2x)
            }
        })
    }
}

class URLImageModel : ObservableObject {
    @Published var image: UIImage?
    var urlString : String?
    
    init(urlString: String? ){
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        guard let urlString = urlString else {
            return
        }
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: getImageFromREsponse(data:response:error:))
        task.resume()
    }
    
    func getImageFromREsponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("error..:\(error?.localizedDescription)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.image = loadedImage
        }
    }
}
