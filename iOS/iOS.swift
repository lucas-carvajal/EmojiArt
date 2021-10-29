//
//  iOS.swift
//  EmojiArt (iOS)
//
//  Created by Lucas Carvajal on 25.08.21.
//

import SwiftUI

extension UIImage {
    var imageData: Data? { jpegData(compressionQuality: 1.0) }
}

struct PasteBoard {
    static var imageData: Data? {
        UIPasteboard.general.image?.imageData
    }
    static var imageURL: URL? {
        UIPasteboard.general.url?.imageURL
    }
}

extension View {
    func paletteControlButtonStyle() -> some View {
        self
    }
    
    func popoverPadding() -> some View {
        self
    }
    
    @ViewBuilder
    func wrappedNavigationViewToMakeDismissable(_ dismiss: (() -> Void)?) ->  some View {
        if UIDevice.current.userInterfaceIdiom != .pad, let dismiss = dismiss {
            NavigationView{
                self
                    .navigationBarTitleDisplayMode(.inline)
                    .dismissable(dismiss)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        } else {
            self
        }
    }
    
    @ViewBuilder
    func dismissable(_ dismiss: (() -> Void)?) -> some View {
        if UIDevice.current.userInterfaceIdiom != .pad, let dismiss = dismiss {
            self.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        } else {
            self
        }
    }
}
