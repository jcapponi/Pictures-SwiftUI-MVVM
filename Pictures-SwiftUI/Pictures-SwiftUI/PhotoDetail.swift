//
//  PhotoDetail.swift
//  Pictures-SwiftUI
//
//  Created by Juan Capponi on 9/26/20.
//

import SwiftUI

 
struct PhotoDetail: View {
    
    var viewModelPict: ViewModelPictures
    
    @State private var zoomed = true
    
    var body: some View {
        NavigationView {
            VStack {
                URLImageView(urlString: viewModelPict.large)
                    .aspectRatio(contentMode: zoomed ? .fill : .fit)
                    .onTapGesture { withAnimation  {
                        zoomed.toggle()
                        }
                    }
            Spacer()
            }
        }.navigationTitle(viewModelPict.photographerName)
    }
}


