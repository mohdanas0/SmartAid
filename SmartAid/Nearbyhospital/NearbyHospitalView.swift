//
//  NearbyHospitalView.swift
//  SmartAid
//
//  Created by mohdanas on 23/06/25.
//

import SwiftUI
import MapKit

struct NearbyHospitalView: View {
    @State var viewModel = NearbyHospitalViewmodel()
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var isReady = false
    var body: some View {
        ZStack {
            if isReady {
                            Map(position: $cameraPosition) {
                                ForEach(viewModel.hospitals) { place in
                                    Annotation(place.name, coordinate: place.coordinate) {
                                        VStack {
                                            Image(systemName: "cross.case.fill")
                                                .font(.title)
                                                .foregroundColor(.red)
                                                .onTapGesture {
                                                    viewModel.openInMaps(place)
                                                }

                                            Text(place.name)
                                                .font(.caption2)
                                                .background(Color.white.opacity(0.8))
                                        }
                                    }
                                }
                            }
                            .ignoresSafeArea()
                    } else {
                        ProgressView("Loading nearby hospitals...")
                            .padding(.top, 100)
                    }
                }
                .navigationTitle("Nearby Hospitals")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    viewModel.fetchNearbyHospitals{
                        cameraPosition = .region(viewModel.region)
                        self.isReady = true
                    }
                }
    }
}

#Preview {
    NearbyHospitalView()
}
