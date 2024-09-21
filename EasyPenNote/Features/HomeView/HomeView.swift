//
//  HomeView.swift
//  EasyPenNote
//
//  Created by Edward Nguyen on 20/9/24.
//

import SwiftUI
import PencilKit

struct HomeView: View {
    @State private var visibility: NavigationSplitViewVisibility = .all
    @State private var canvasView = PKCanvasView()
    
    @State private var selectedCategory: NoteCategory? = nil
    @State private var selectedNote: NoteItem? = nil

    
    var body: some View {
        VStack {
            NavigationSplitView(columnVisibility: $visibility) {
                NoteCategoryView(selectedCategory: $selectedCategory)
            } content: {
                NoteItemView(selectedCategory: $selectedCategory, selectedNote: $selectedNote)
            } detail: {
                if let selectedNote {
                    VStack {
                        PencilKitCanvasView(canvasView: $canvasView)
                    }
                    .navigationTitle(selectedNote.title.capitalized)
                } else {
                    VStack {
                        Text("Please create a new one")
                    }
                    
                }
            }
        }
        .navigationSplitViewStyle(.automatic)
    }
}

#Preview {
    HomeView()
}
