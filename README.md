# EasyPenNote

A SwiftUI note-taking app for handwriting with Apple Pencil. Notes are grouped into categories, and each note opens onto a PencilKit canvas you can draw on directly.

<img width="834" alt="EasyPenNote" src="https://github.com/user-attachments/assets/3ccf47eb-74f4-4f99-9bb1-c77085d841e1">

## How it's built

- **SwiftUI** throughout, organised feature-first rather than by layer type
- **PencilKit** bridged into SwiftUI via `PencilKitCanvasView` — the drawing surface Apple Pencil writes on
- Plain model types (`NoteCategory`, `NoteItem`) keep state simple

```
EasyPenNote/
├── App/                    # entry point, ContentView
├── Features/
│   ├── HomeView/
│   ├── NoteCategoryView/
│   ├── NoteItemView/
│   └── PencilCanvasView/   # PencilKit ↔ SwiftUI bridge
├── Models/
└── Resources/
```

## Running it

Open `EasyPenNote.xcodeproj` in Xcode and run. Best on an iPad with Apple Pencil — the simulator works, but you'll be drawing with a mouse.
