//
//  PaletteManager.swift
//  EmojiArt
//
//  Created by Lucas Carvajal on 14.08.21.
//

import SwiftUI

struct PaletteManager: View {
    @EnvironmentObject var store: PaletteStore
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.palettes) { palette in
                    NavigationLink(destination: PaletteEditor(palette: $store.palettes[palette])) {
                            VStack(alignment: .leading) {
                                Text(palette.name)
                                Text(palette.emojis)
                            }
                            .gesture(editMode == .active ? tab : nil)
                        }
                }
                .onDelete { indexSet in
                    store.palettes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.palettes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Manage Palettes")
            .navigationBarTitleDisplayMode(.inline)
            .dismissable {
                presentationMode.wrappedValue.dismiss()
            }
            .toolbar(content: {
                ToolbarItem { EditButton() }
            })
            .environment(\.editMode, $editMode)
        }
        
    }
    
    var tab: some Gesture {
        TapGesture().onEnded {  }
    }
}

struct PaletteManager_Previews: PreviewProvider {
    static var previews: some View {
        PaletteManager()
            .previewDevice("iPhone 8")
            .environmentObject(PaletteStore(named: "Preview"))
            .preferredColorScheme(.light)
    }
}
