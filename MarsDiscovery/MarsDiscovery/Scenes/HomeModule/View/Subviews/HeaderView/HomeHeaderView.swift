//
//  HomeHeader.swift
//  Test
//
//  Created by Liza Kotova on 12.07.2024.
//

import SwiftUI

struct HomeHeaderView: View {
    @Binding var shouldShowCalendar: Bool
    @Binding var shouldShowRoversFilterView: Bool
    @Binding var shouldShowCamersFilterView: Bool
    @Binding var selectedDate: Date
    @Binding var rover: Rovers
    @Binding var camera: Cameras?
    @State private var showAlert = false
    private let realm = RealmManager.shared
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("MainOrange")
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("MARS.CAMERA")
                            .font(.custom("SF Pro Display Bold", size: 34))
                            .foregroundColor(.black)
                        
                        Text(selectedDate.toString(format: .long))
                            .font(.custom("SF Pro Display Bold", size: 17))
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 19)
                    
                    Spacer()
                    
                    Button(action: {
                        if shouldShowRoversFilterView || shouldShowCamersFilterView == true {
                            shouldShowCalendar = false
                        } else {
                            shouldShowCalendar = true
                        }
                    }) {
                        Image("calendar")
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                    }
                    .padding(.trailing, 17)
                }
                .padding(.top, 56)
                
                HStack {
                    ZStack(alignment: .leading) {
                        Color.white
                        Button(action: {
                            if shouldShowRoversFilterView || shouldShowCamersFilterView {
                                return
                            }
                            shouldShowRoversFilterView = true
                        }) {
                            Text("")
                                .frame(width: 140, height: 38)
                                .background(Color.clear)
                                .font(.custom("SF Pro Display Bold", size: 17))
                                .foregroundColor(.black)
                        }
                        HStack {
                            Image("cpu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .padding(.leading, 7)
                            Text(rover.fullName)
                                .font(.custom("SF Pro Display Bold", size: 17))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: 140, height: 38)
                    .cornerRadius(8)
                    .padding(.leading, 20)
                    
                    ZStack(alignment: .leading) {
                        Color.white
                        Button(action: {
                            if shouldShowRoversFilterView || shouldShowCamersFilterView {
                                return
                            }
                            shouldShowCamersFilterView = true
                        }) {
                            Text("")
                                .frame(width: 140, height: 38)
                                .background(Color.clear)
                                .font(.custom("SF Pro Display Bold", size: 17))
                                .foregroundColor(.black)
                        }
                        HStack {
                            Image("camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .padding(.leading, 7)
                            Text(camera?.fullName ?? "All")
                                .font(.custom("SF Pro Display Bold", size: 17))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: 140, height: 38)
                    .cornerRadius(8)
                    
                    Spacer()
                    
                    ZStack {
                        Color.white
                        Button(action: {
                            if shouldShowRoversFilterView || shouldShowCamersFilterView == true {
                                showAlert = false
                            } else {
                                showAlert = true
                            }
                        }) {
                            Image("add")
                                .scaledToFit()
                                .frame(width: 38, height: 38)
                                .background(Color.clear)
                        }
                    }
                    .frame(width: 38, height: 38)
                    .cornerRadius(8)
                    .padding(.trailing, 20)
                }
                .padding(.top, 22)
                .padding(.bottom, 22)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Save filters"),
                    message: Text("Current filters and the selected date can be saved in the filter history."),
                    primaryButton: .default(Text("Save")) {
                        let model = HistoryModel()
                        model.rover = rover.fullName
                        model.camera = camera?.fullName ?? nil
                        model.date = selectedDate
                        realm.add(historyModel: model)
                    },
                    secondaryButton: .cancel(Text("Cancel")) {
                        showAlert = false
                    }
                )
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    HomeHeaderView(
        shouldShowCalendar: .constant(false),
        shouldShowRoversFilterView: .constant(false),
        shouldShowCamersFilterView: .constant(false),
        selectedDate: .constant(Date()),
        rover: .constant(Rovers.curiosity),
        camera: .constant(Cameras?.none))
}
