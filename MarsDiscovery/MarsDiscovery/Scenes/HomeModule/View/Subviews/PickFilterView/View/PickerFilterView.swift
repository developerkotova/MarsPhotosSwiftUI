//
//  PickFilterView.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 14.07.2024.
//

import SwiftUI

struct PickerFilterView: View {
    
    @Binding var rover: Rovers
    @Binding var camera: Cameras?
    
    @Binding var shouldShowRoversFilterView: Bool
    @Binding var shouldShowCamersFilterView: Bool
    @State var selectedFilter: String = ""
    
    let viewModel: PickerFilterViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 306)
                    .cornerRadius(50, corners: [.topLeft, .topRight])
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
                    .overlay(
                        VStack {
                            HStack(alignment: .center) {
                                Button(action: {
                                    shouldShowRoversFilterView = false
                                    shouldShowCamersFilterView = false
                                }) {
                                    Image("close")
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                }
                                Spacer()
                                Text(viewModel.title)
                                    .font(.custom("SF Pro Display Bold", size: 22))
                                    .foregroundColor(.black)
                                    .padding(.top, 1)
                                Spacer()
                                Button(action: {
                                    getSelectedFilter(filterName: selectedFilter)
                                    shouldShowRoversFilterView = false
                                    shouldShowCamersFilterView = false
                                    
                                }) {
                                    Image("tick")
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                }
                            }
                            .padding(.top, 28)
                            .padding(.horizontal, 20)
                            
                            Picker("", selection: $selectedFilter) {
                                ForEach(viewModel.type.data, id: \.self) { filter in
                                    Text(filter).tag(filter)
                                        .font(.custom("SF Pro Display Bold", size: 22))
                                }
                            }
                            .pickerStyle(.wheel)
                            .padding(.horizontal, 28)
                            .padding(.bottom, 20)
                            .preferredColorScheme(.light)
                            Spacer()
                        }
                    )
            }
            .ignoresSafeArea()
        }
    }
    func getSelectedFilter(filterName: String) {
        if viewModel.type == .rover {
            rover = Rovers.from(fullName: filterName) ?? .curiosity
        } else {
            camera = Cameras.from(fullName: filterName) ?? .chemcam
        }
    }
}

#Preview {
    PickerFilterView(
        rover: .constant(.curiosity),
        camera: .constant(nil),
        shouldShowRoversFilterView: .constant(true),
        shouldShowCamersFilterView: .constant(true),
        viewModel: PickerFilterViewModel(title: "Rovers",
                                         type: .rover))
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
