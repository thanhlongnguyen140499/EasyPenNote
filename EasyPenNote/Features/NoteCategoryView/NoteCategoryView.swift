//
//  NoteCategory.swift
//  EasyPenNote
//
//  Created by Edward Nguyen on 21/9/24.
//

import SwiftUI

struct NoteCategoryView: View {
    @Binding var selectedCategory: NoteCategory?
    
    var body: some View {
        List(NOTE_CATEGORY_LIST) { category in
            Button(action: {
                selectedCategory = category
            }, label: {
                Text(category.title)
            })
        }
        .navigationTitle("Category")
    }
}

#Preview {
    NoteCategoryView(selectedCategory: Binding(get: {
        return NoteCategory(title: "hello")
    }, set: { _ in
        
    }))
}
