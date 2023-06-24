//
//  IssueView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/23.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

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
        .padding()

      Divider()
        .frame(height: 1)
        .foregroundColor(.pdSubBackground)

      TextEditor(text: $viewModel.input.issueContent.value)
        .font(.pdBody2)
        .foregroundColor(.pdSubText)
        .multilineTextAlignment(.leading)
        .frame(height: 180) // dynamic height issue in scrollview
    }
    .cornerRadius(18)
    .overlay(
      RoundedRectangle(cornerRadius: 18)
        .stroke(Color.pdPrimary)
    )
    .padding()
  }

  var tagSection: some View {
    VStack(spacing: 8) {
      HStack {
        Text("태그")
          .font(.pdTitle3)
          .foregroundColor(.pdSubText)

        Spacer()

        Image(systemName: "plus.circle")
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
  }

  var expireDateSection: some View {
    VStack(spacing: 0) {
      HStack {
        Text("마감일")
          .font(.pdTitle3)
          .foregroundColor(.pdSubText)

        Spacer()

        Image(systemName: "plus.circle")
      }
    }
    .padding()
  }

  var locationSection: some View {
    VStack(spacing: 0) {
      HStack {
        Text("위치")
          .font(.pdTitle3)
          .foregroundColor(.pdSubText)

        Spacer()

        Image(systemName: "plus.circle")
      }
    }
    .padding()
  }

  var content: some View {
    ScrollView {
      VStack {
        issueSection

        tagSection

        expireDateSection

        locationSection
      }
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
