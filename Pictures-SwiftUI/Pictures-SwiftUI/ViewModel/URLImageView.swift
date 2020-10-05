//
//  URLImageView.swift
//  Pictures-SwiftUI
//
//  Created by Juan Capponi on 9/26/20.
//

import SwiftUI


struct URLImageView: View {
    
    @ObservedObject var urlImageModel: URLImageModel
    
    init(urlString: String?){
        urlImageModel = URLImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? URLImageView.defaultImage!)
            .resizable()
            .scaledToFit()
    }
    
    static var defaultImage = UIImage(named: "loading.jpg")
    
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: nil)
    }
}
