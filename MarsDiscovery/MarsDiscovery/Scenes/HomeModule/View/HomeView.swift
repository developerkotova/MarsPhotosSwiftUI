
//
//  HomeView.swift
//  MarsDiscovery
//
//  Created by Liza Kotova on 12.07.2024.
//

import SwiftUI

struct HomeView: View {
    private let viewModel = HomeViewModel(networkService: NetworkService())
    
    @State private var rovers = [RoverItem]()
    @State var shouldShowCalendar = false
    @State var shouldShowRoversFilterView = false
    @State var shouldShowCamersFilterView = false
    @State var selectedDate = Date()
    @State var rover: Rovers = .curiosity
    @State var camera: Cameras? = nil
    @State var shouldShowEmptyState = true
    @State var isLoading = false
    @State private var selectedHistoryFilter: HistoryModel?
    @State private var isFromFilter = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                HomeHeaderView(
                    shouldShowCalendar: $shouldShowCalendar,
                    shouldShowRoversFilterView: $shouldShowRoversFilterView,
                    shouldShowCamersFilterView: $shouldShowCamersFilterView,
                    selectedDate: $selectedDate,
                    rover: $rover,
                    camera: $camera
                )
                .frame(height: 150)
                
                if isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    if shouldShowEmptyState {
                        Spacer()
                        Text("No data for selected filters.")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    } else {
                        List {
                            ForEach(rovers) { rover in
                                RoverView(rover: rover)
                                    .overlay {
                                        NavigationLink(destination: { PhotoView(imageStringUrl: rover.image).navigationBarBackButtonHidden(true) },
                                                       label: { EmptyView() })
                                        .opacity(0)
                                    }
                            }
                            .padding(.horizontal, -20)
                        }
                        .listStyle(PlainListStyle())
                        .listRowInsets(EdgeInsets())
                        .padding(.top, 0)
                    }
                }
            }
            .padding(.horizontal, 0)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: {
                        HistoryView(
                            selectedDate: $selectedDate,
                            rover: $rover,
                            camera: $camera,
                            choosenFilter: $selectedHistoryFilter
                        )
                        .navigationBarBackButtonHidden(true)
                    }) {
                        Image("history")
                            .frame(width: 70, height: 70)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            }
            .ignoresSafeArea()
            
            if shouldShowCalendar {
                CalendarView(shouldShowCalendar: $shouldShowCalendar, selectedDate: $selectedDate)
            }
            if shouldShowRoversFilterView {
                PickerFilterView(
                    rover: $rover,
                    camera: $camera,
                    shouldShowRoversFilterView: $shouldShowRoversFilterView,
                    shouldShowCamersFilterView: $shouldShowCamersFilterView,
                    viewModel: PickerFilterViewModel(title: "Rovers", type: .rover)
                )
            }
            if shouldShowCamersFilterView {
                PickerFilterView(
                    rover: $rover,
                    camera: $camera,
                    shouldShowRoversFilterView: $shouldShowRoversFilterView,
                    shouldShowCamersFilterView: $shouldShowCamersFilterView,
                    viewModel: PickerFilterViewModel(title: "Camera", type: .camera)
                )
            }
          }
        .onChange(of: selectedDate) { _ in
            guard !isFromFilter else {return}
            fetchData()
        }
        .onChange(of: rover) { _ in
            guard !isFromFilter else {return}
            fetchData()
        }
        .onChange(of: camera) { _ in
            guard !isFromFilter else {return}
            fetchData()
        }
        .onChange(of: selectedHistoryFilter) { _ in
            guard let selectedHistoryFilter = selectedHistoryFilter else {return}
            isFromFilter = true
            selectedDate = selectedHistoryFilter.date
            rover = Rovers.from(fullName: selectedHistoryFilter.rover) ?? .curiosity
            camera = Cameras.from(fullName: selectedHistoryFilter.rover) ?? nil
            fetchData()
        }
        .onAppear {
            fetchData()
        }
        .preferredColorScheme(.light)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    showAlert = false
                }
            )
        }
    }
    
    
    private func fetchData() {
        isLoading = true
        viewModel.fetchPhotos(
            from: rover,
            camera: camera,
            and: selectedDate.toString(format: .short),
            with: 1
        ) { rovers, error in
            isLoading = false
            guard let rovers = rovers, error == nil else {
                showAlert = true
                alertMessage = error?.localizedDescription ?? ""
                return
            }
            shouldShowEmptyState = rovers.isEmpty
            self.rovers = rovers
            isFromFilter = false
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
