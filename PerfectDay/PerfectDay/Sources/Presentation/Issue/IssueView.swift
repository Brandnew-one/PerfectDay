//
//  IssueView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/23.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI
import MapKit

// MARK: - (2, 2-1)
/// 이슈 생성(EmptyValue), 이슈 수정(Issue)
struct IssueView: View {
  @StateObject
  var viewModel: IssueViewModel

  @Environment(\.dismiss)
  private var dismiss

  var body: some View {
    if viewModel.output.viewMode == .modal {
      NavigationView {
        content
          .navigationTitle("이슈 생성")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
              Image(systemName: "xmark")
                .wrapToButton { dismiss() }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
              Image(systemName: "chevron.down")
                .wrapToButton { }
            }
          }
      }
    } else {
      content
        .navigationTitle("이슈 수정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Image(systemName: "chevron.down")
              .wrapToButton { }
          }
        }
    }
  }
}

extension IssueView {
  var issueSection: some View {
    VStack(spacing: 0) {
      TextField("Issue Title", text: $viewModel.input.issueTitle.value)
        .font(.pdBody1)
        .foregroundColor(.pdMainText)
        .textFieldStyle(.plain)
        .padding()

      Divider()
        .frame(height: 1)
        .foregroundColor(.pdSubBackground)

      TextEditor(text: $viewModel.input.issueContent.value)
        .font(.pdBody2)
        .foregroundColor(.pdSubText)
        .multilineTextAlignment(.leading)
        .frame(height: 180) // dynamic height issue in scrollview
        .scrollContentBackground(.hidden)
    }
    .padding()
    .background(Color.pdMainBackground)
    .cornerRadius(18)
  }

  var tagSection: some View {
    VStack(spacing: 12) {
      HStack {
        Text("태그")
          .font(.pdTitle3)
          .foregroundColor(.pdMainText)

        Spacer()

        Image(systemName: "plus.circle")
          .resizable()
          .renderingMode(.template)
          .frame(width: 28, height: 28)
          .foregroundColor(.pdPrimary)
          .wrapToButton { viewModel.action(.tagTapped) }
      }

      HStack {
        ForEach(viewModel.output.tags) { tag in
          TagView(tag: tag)
        }

        Spacer()
      }
    }
    .padding()
    .background(Color.pdMainBackground)
    .cornerRadius(18)
  }

  var expireDateSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text("마감일")
          .font(.pdTitle3)
          .foregroundColor(.pdMainText)

        Spacer()

        Toggle("", isOn: $viewModel.input.expireToggle.value)
          .tint(Color.pdPrimary)
      }

      if viewModel.output.expireisShow {
        DatePicker("", selection: $viewModel.input.expireDate.value)
          .labelsHidden()
          .datePickerStyle(.compact)
      }
    }
    .padding()
    .background(Color.pdMainBackground)
    .cornerRadius(18)
  }

  var locationSection: some View {
    VStack(spacing: 12) {
      HStack {
        Text("위치")
          .font(.pdTitle3)
          .foregroundColor(.pdMainText)

        Spacer()

        Toggle("", isOn: $viewModel.input.locationToggle.value)
          .tint(Color.pdPrimary)
      }

      if viewModel.output.locationisShow {
        Map(coordinateRegion: $viewModel.output.location)
          .frame(height: 80)
      }
    }
    .padding()
    .background(Color.pdMainBackground)
    .cornerRadius(18)
  }

  var content: some View {
    ScrollView {
      VStack(spacing: 16) {
        issueSection

        tagSection

        expireDateSection

        locationSection

        Divider().opacity(0)
          .frame(height: 10)
      }
      .padding(.horizontal, 8)
    }
    .background(Color.pdSubBackground)
    .sheet(
      isPresented: $viewModel.output.tagSheetisShow,
      onDismiss: { }
    ) {
      TagListView()
    }
  }
}
