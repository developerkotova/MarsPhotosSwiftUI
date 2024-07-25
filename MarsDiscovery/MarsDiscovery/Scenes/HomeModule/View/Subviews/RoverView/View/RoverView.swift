//
//  RoverView.swift
//  Test
//
//  Created by  Liza Kotova on 12.07.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct RoverView: View {
    let rover: RoverModel
    @State private var imageURL: String!
    
    
    // MARK: - Init
    init(rover: RoverModel) {
        self.rover = rover
        self._imageURL = State(initialValue: rover.image)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                formatText(text: rover.rover)
                formatText(text: rover.camera)
                formatText(text: rover.date)
            }
            
            Spacer()
            WebImage(url: URL(string: imageURL))
                .resizable()
                .onFailure { _ in
                    imageURL = "https://cdn.osxdaily.com/wp-content/uploads/2013/12/there-is-no-connected-camera-mac.jpg"
                }
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 130, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(.clear)
                .padding(.trailing, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
        .padding(.vertical, 6)
    }
    
    func formatText(text: String) -> some View {
        if let colonIndex = text.firstIndex(of: ":") {
            let beforeColon = String(text.prefix(upTo: colonIndex))
            let afterColon = String(text.suffix(from: text.index(after: colonIndex)))
            return Text(beforeColon.trimmingCharacters(in: .whitespaces))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("GreyText"))
            + Text(": ")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("GreyText"))
            + Text(afterColon.trimmingCharacters(in: .whitespaces))
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        } else {
            return Text(text)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
    }
}

struct RoverView_Previews: PreviewProvider {
    static var previews: some View {
        RoverView(rover: RoverModel(id: "bar_foo", rover: "Rover: Liza", camera: "Camera", date: Date().toString(format: .long), image: "https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg"))
    }
}
