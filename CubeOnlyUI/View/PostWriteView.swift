//
//  PostWriteView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/11/01.
//

import SwiftUI
import RichTextKit
import Combine

extension NSAttributedString {
    func toHtml() -> String? {
        let documentAttributes = [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html]
        do {
            let htmlData = try self.data(from: NSMakeRange(0, self.length), documentAttributes:documentAttributes)
            if let htmlString = String(data:htmlData, encoding:String.Encoding.utf8) {
                return htmlString
            }
        }
        catch {
            print("error creating HTML from Attributed String")
        }
        return nil
    }
}

extension View {

    func highlighted(if condition: Bool) -> some View {
        foregroundColor(condition ? .accentColor : .primary)
    }
}

extension Image {

    static let about = symbol("lightbulb")
    static let documentation = symbol("doc.text")
    static let highlighter = symbol("highlighter")
    static let menu = symbol("line.3.horizontal")
    static let minus = symbol("minus")
    static let plus = symbol("plus")
    static let safari = symbol("safari")
    static let textEditor = symbol("doc.richtext")

    static func symbol(_ named: String) -> Image {
        Image(systemName: named)
    }
}


class PostWriteViewModel:ObservableObject {
    @Published var text = NSAttributedString(string: "Type here...")
    @Published var titleStr = ""
//    @Published var section = DemoSection.textEditor
    var cancellable = Set<AnyCancellable>()
    
    
    deinit {
        
    }
    
    init() {
        $text
            .sink { attrStr in
                print("attr str : \(attrStr.string)")
                
                if let htmlStr = attrStr.toHtml() {
                    print("attrToHtml : \(htmlStr)")
                }
                
            }.store(in: &cancellable)
    }
}

struct PostWriteView: View {
    
    @StateObject var vm = PostWriteViewModel()
    @StateObject
    var context = RichTextContext()
      
    var body: some View {
        VStack {
            VStack(spacing:0) {
                HStack {
                    Text("포스트 쓰기")
                        .padding()
                    Spacer()
                }
                
                HStack {
                    TextField("제목", text: $vm.titleStr)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1)
                                .fill(Color.init(white: 0.8))
                        )
                        
                }
                .padding(.horizontal)
                
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                            .fill(Color.init(white: 0.8))
                        editor
                            
                    }
                        
                }
                .padding()
                
                HStack(spacing:20) {
                    Button {
                        
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(Color.init(white: 0.3))
                                .frame(width: 140, height: 45)
                            
                            Text("저장")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(Color.init(white: 0.7))
                                .frame(width: 140, height: 45)
                            
                            Text("아니오")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
            }
            Spacer()
            HStack (spacing:0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:5) {
                        editorTopToolbar
                        Divider()
                            .padding(.horizontal, 5)
                        editorMidToolbar
                        Divider()
                            .padding(.horizontal, 5)
                        actionButtons
                    }
                }
                button(icon: Image("ZSSkeyboard")) {
                    
                }
                .padding(.leading, 7)
            }
            .frame(height: 50)
            .padding(.horizontal)
        }
    }
    
    var editor: some View {
        RichTextEditor(text: $vm.text, context: context) {
            $0.textContentInset = CGSize(width: 10, height: 20)
        }
        .background(Color.white)
        .cornerRadius(5)
    }
    
    var editorTopToolbar: some View {
        HStack {
//            fontPicker(for: $context.fontName)
//            Spacer()
            sizeTools(for: $context.fontSize)
        }
    }
    
    var editorMidToolbar: some View {
        HStack {
            styleButtons
            Spacer()
            alignmentPicker(for: $context.alignment)
            Spacer()
            colorPickers
        }
    }
    
    var actionButtons: some View {
        HStack {
            button(icon: .richTextActionCopy, action: context.copyCurrentSelection)
                .disabled(!context.canCopy)
            button(icon: .richTextActionUndo, action: context.undoLatestChange)
                .disabled(!context.canUndoLatestChange)
            button(icon: .richTextActionRedo, action: context.redoLatestChange)
                .disabled(!context.canRedoLatestChange)
        }
    }

    func alignmentPicker(for alignment: Binding<RichTextAlignment>) -> some View {
        RichTextAlignmentPicker(selection: alignment)
            .pickerStyle(.segmented)
            .labelsHidden()
    }

    var colorPickers: some View {
        HStack {
            Text("배경색")
                .font(.subheadline)
            ColorPicker("Background", selection: context.backgroundColorBinding)
            Text("글자색")
                .font(.subheadline)
            ColorPicker("Foreground", selection: context.foregroundColorBinding)
        }.labelsHidden()
    }

    var divider: some View {
        Divider().frame(height: 10)
    }

    func fontPicker(for font: Binding<String>) -> some View {
        FontPicker(selection: font, fontSize: 12)
    }

    func sizeTools(for size: Binding<CGFloat>) -> some View {
        HStack(spacing: sizeToolSpacing) {
            button(icon: .minus) {
                context.decrementFontSize()
            }
            FontSizePicker(selection: size)
                .labelsHidden()
            button(icon: .plus) {
                context.incrementFontSize()
            }
        }
    }

    var sizeToolSpacing: CGFloat {
        #if os(macOS)
        return 5
        #else
        return 0
        #endif
    }

    var styleButtons: some View {
        HStack(spacing: 5) {
            button(for: .bold)
            button(for: .italic)
            button(for: .underlined)
        }
    }
    
    func button(icon: Image, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            icon.frame(height: 17)
                .padding(.all, 12)
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.init(white: 0.9))
        )
        
    }

    func button(for style: RichTextStyle) -> some View {
        button(icon: style.icon) {
            context.toggle(style)
        }.highlighted(if: context.hasStyle(style))
    }

    func button(for alignment: RichTextAlignment) -> some View {
        button(icon: alignment.icon) {
            context.alignment = alignment
        }.highlighted(if: context.alignment == alignment)
    }
}

struct PostWriteView_Previews: PreviewProvider {
    static var previews: some View {
        PostWriteView()
    }
}
