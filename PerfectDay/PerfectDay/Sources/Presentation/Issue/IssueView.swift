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
          .navigationTitle(LS.Issue0000.localized)
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
        .navigationTitle(LS.Issue0010.localized)
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
      TextField(LS.Issue0020.localized, text: $viewModel.input.issueTitle.value)
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

  var stateSection: some View {
    Text(viewModel.output.issueState.title)
      .font(.pdTitle3)
      .foregroundColor(.pdMainText)
      .padding()
      .background(Color.pdPrimary)
      .wrapToButton { viewModel.action(.stateTapped) }
  }

  var tagSection: some View {
    VStack(spacing: 12) {
      HStack {
        Text(LS.Issue0030.localized)
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
        Text(LS.Issue0040.localized)
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
        Text(LS.Issue0050.localized)
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
      VStack(alignment: .leading, spacing: 16) {
        issueSection

        stateSection

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
    .alert(LS.Issue0060.localized, isPresented: $viewModel.output.expierAlertShow) {
      Button(LS.Issue0070.localized, role: .cancel) {
        viewModel.input.expireToggle.value = false
      }
      Button(LS.Issue0080.localized, role: .destructive) {
        guard
          let url = URL(string: UIApplication.openSettingsURLString)
        else { return }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
      }
    }
    // FIXME: -
    .bottomSheet(isShow: $viewModel.output.stateSheetisShow) {
      VStack(alignment: .leading) {
        Text("전환선택")
          .font(.pdTitle3)
          .foregroundColor(.pdMainText)
          .padding()

        Text("전환대상 -> SUSPEND")
          .font(.pdBody1)
          .foregroundColor(.pdMainText)
          .padding()

        Text("할일 -> 해야할 일")
          .font(.pdBody1)
          .foregroundColor(.pdMainText)
          .padding()

        Text("완료 -> 완료됨")
          .font(.pdBody1)
          .foregroundColor(.pdMainText)
          .padding()
      }
      .background(Color.pdMainBackground)
    }
  }
}
