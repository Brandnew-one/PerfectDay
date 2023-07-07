//
//  MapDetailView.swift
//  PerfectDay
//
//  Created by Bran on 2023/07/04.
//  Copyright © 2023 sangwon. All rights reserved.
//

import MapKit
import SwiftUI

struct MapDetailView: View {
  @StateObject
  var viewModel: MapDetailViewModel

  @Environment(\.dismiss)
  var dismiss

  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        ZStack(alignment: .center) {
          Map(coordinateRegion: $viewModel.input.coordinateSbj.value)

          Image(systemName: "arrow.down")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.pdPrimary)
            .frame(width: 24, height: 24)
            .padding(.bottom, viewModel.output.isChanging ? 24 : 0)
        }

        VStack(alignment: .trailing) {
          Text(viewModel.output.centerAddress)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white.opacity(0.3))
            .cornerRadius(12)
            .padding()

          // TODO: - Animation
          Image(systemName: "location.circle")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.pdPrimary)
            .frame(width: 40, height: 40)
            .cornerRadius(12)
            .padding()
            .wrapToButton { viewModel.action(.resetPosition) }
        }
      }
      .navigationTitle("위치 선택")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Text("save")
            .font(.pdBody3)
            .foregroundColor(.pdMainText)
            .wrapToButton {
              viewModel.action(.dismiss)
              dismiss()
            }
        }
      }
    }
  }
}
