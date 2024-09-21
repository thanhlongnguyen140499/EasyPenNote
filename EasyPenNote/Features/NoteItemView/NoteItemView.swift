//
//  NoteItemView.swift
//  EasyPenNote
//
//  Created by Edward Nguyen on 21/9/24.
//

import SwiftUI

struct NoteItemView: View {
    @Binding var selectedCategory: NoteCategory?
    @Binding var selectedNote: NoteItem?
    
    var body: some View {
        ZStack {
            VStack {
                if let selectedCategory {
                    Group {
                        switch selectedCategory.id {
                        case NOTE_CATEGORY_LIST[0].id:
                            List(NOTE_ITEM_LIST) { note in
                                Button(action: {
                                    selectedNote = note
                                }, label: {
                                    Text(note.title)
                                })
                            }
                        case NOTE_CATEGORY_LIST[1].id:
                            EmptyView()
                        default:
                            EmptyView()
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            // Adding a button to the trailing side of the navigation bar
                            Button(action: {
                                print("Toolbar Button tapped")
                                // Add your button action here
                            }) {
                                Label("Add", systemImage: "plus") // You can customize the button text or icon here
                            }
                        }
                    }
                    .navigationTitle(selectedCategory.title.capitalized)
                } else {
                    Text("Select a category to begin!")
                        .toolbar {
                            // Adding a button to the toolbar
                            Button(action: {
                                print("Toolbar Button tapped")
                                // Add your button action here
                            }) {
                                Label("Add", systemImage: "plus") // You can customize the button text or icon here
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    NoteItemView(selectedCategory: Binding(get: {
        return NoteCategory(title: "Hello")
    }, set: { Value in
        
    }), selectedNote: Binding(get: {
        return NoteItem(title: "Hello")
    }, set: { Value in
        
    }))
}
