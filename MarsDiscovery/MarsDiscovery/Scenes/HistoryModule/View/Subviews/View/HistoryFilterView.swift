//
//  HistoryFilterView.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//

import SwiftUI

struct HistoryFilterView: View {
    var viewModel: HistoryModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Rectangle()
                    .fill(Color("MainOrange"))
                    .frame(height: 1)
                
                Text("Filter")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color("MainOrange"))
                    .padding(.leading, 6)
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
            
            VStack(alignment: .leading, spacing: 6) {
                formatText(text: viewModel.rover, prefix: "Rover:")
                formatText(text: viewModel.camera ?? "All", prefix: "Camera:")
                formatText(text: viewModel.date.toString(format: .long), prefix: "Date:")
            }
            .padding(.top, 20)
            .padding(.leading, 16)
            .padding(.trailing, 12)
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
        .padding(.vertical, 6)
    }
    func formatText(text: String, prefix: String) -> some View {
        let formattedText = "\(prefix) \(text)"
        
        if let colonIndex = formattedText.firstIndex(of: ":") {
            let beforeColon = String(formattedText.prefix(upTo: colonIndex))
            let afterColon = String(formattedText.suffix(from: formattedText.index(after: colonIndex)))
            
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
            return Text(formattedText)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    HistoryFilterView(viewModel: HistoryModel())
}
