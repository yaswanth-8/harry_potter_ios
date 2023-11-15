//
//  ImageCardLayout.swift
//  HarryPotter
//
//  Created by Yaswanth on 02/11/23.
//

import SwiftUI

struct ImageCardLayout: View {
    let urlString : String
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: urlString)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    ZStack{
                        image
                            .resizable()
                            .cornerRadius(20)
                    }
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .frame(maxWidth: 200, maxHeight: 280)
        .padding()
    }
}

#Preview {
    ImageCardLayout(urlString: "https://ik.imagekit.io/hpapi/harry.jpg")
}
