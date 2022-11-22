//
//  RichTextEditor.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/07.
//

import SwiftUI
import RichEditorView

struct RichTextEditor: UIViewRepresentable {
    
    @Binding var htmlText: String
    @Binding var isEditingRichText: Bool
    
    func makeUIView(context: Context) -> RichEditorView {
        let editor = RichEditorView(frame: .zero)
        editor.html = htmlText
        editor.isScrollEnabled = false
        editor.delegate = context.coordinator // Don't forget to connect you UIView's delegate to your coordinator class.

        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        let dismissToolbarItem = RichEditorOptionItem(image: UIImage(named: "ZSSkeyboard"), title: "") { toolbar in
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        toolbar.options = [RichEditorDefaultOption.clear,
                           RichEditorDefaultOption.undo, RichEditorDefaultOption.redo, RichEditorDefaultOption.bold, RichEditorDefaultOption.italic,
                           RichEditorDefaultOption.subscript, RichEditorDefaultOption.superscript, RichEditorDefaultOption.strike, RichEditorDefaultOption.underline,
                           RichEditorDefaultOption.textColor, RichEditorDefaultOption.textBackgroundColor,
                           RichEditorDefaultOption.header(1), RichEditorDefaultOption.header(2), RichEditorDefaultOption.header(3), RichEditorDefaultOption.header(4), RichEditorDefaultOption.header(5), RichEditorDefaultOption.header(6),
                           RichEditorDefaultOption.indent,
                           RichEditorDefaultOption.alignLeft, RichEditorDefaultOption.alignCenter, RichEditorDefaultOption.alignRight, RichEditorDefaultOption.image, RichEditorDefaultOption.link, dismissToolbarItem]
        toolbar.editor = editor
        
        editor.inputAccessoryView = toolbar
        
        return editor
    }
    
    func updateUIView(_ uiView: RichEditorView, context: Context) {
    }
    
    // define what class will be our coordinator class, the rest is handled automatically by SwiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: RichEditorDelegate {
        
        var parent: RichTextEditor
        
        init(_ parent: RichTextEditor) {
            self.parent = parent // tell the coordinator what its parent is, so it can modify values there directly
        }
        
        func richEditorTookFocus(_ editor: RichEditorView) {
            parent.isEditingRichText = true
        }
        
        func richEditorLostFocus(_ editor: RichEditorView) {
            parent.isEditingRichText = false
        }
        
        func richEditor(_ editor: RichEditorView, contentDidChange content: String) {
            parent.htmlText = content
        }
        
    }
    
    
}
