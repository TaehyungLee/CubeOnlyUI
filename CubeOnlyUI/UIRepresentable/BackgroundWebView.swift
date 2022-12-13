//
//  BackgroundWebView.swift
//  CubeOnlyUI
//
//  Created by Taehyung Lee on 2022/12/12.
//

import SwiftUI
import WebKit
import Combine

struct BackgroundWebView: UIViewRepresentable {
    
    @EnvironmentObject var commonVM: CommonViewModel
    
    // 변경 사항을 전달하는 데 사용하는 사용자 지정 인스턴스를 만듭니다.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func fileReadString(_ fileURL:URL) -> String {
        do {
            let text = try String(contentsOf: fileURL, encoding: .utf8)
            return text
        } catch let e {
            print(e.localizedDescription)
            return ""
        }
    }
    
    //ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false  // JavaScript가 사용자 상호 작용없이 창을 열 수 있는지 여부
            
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.setValue(true, forKey: "allowUniversalAccessFromFileURLs")

        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator    // 웹보기의 탐색 동작을 관리하는 데 사용하는 개체
        webView.allowsBackForwardNavigationGestures = true    // 가로로 스와이프 동작이 페이지 탐색을 앞뒤로 트리거하는지 여부
        webView.scrollView.isScrollEnabled = true    // 웹보기와 관련된 스크롤보기에서 스크롤 가능 여부
        
        let htmlFile = Bundle.main.path(forResource: "test", ofType: "html") ?? "" // 반드시 존재하므로 그냥 처리
        let url = URL(fileURLWithPath: htmlFile)
        let request = URLRequest(url: url)
        webView.load(request)
        
        context.coordinator.parentWKWebView = webView // inject as weak
        
        self.commonVM.webviewScriptStr
            .sink { scriptStr in
                context.coordinator.runJavascript(scriptStr: scriptStr)
            }
            .store(in: &context.coordinator.cancelBag)
        
        return webView
    }
    
    //업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        weak var parentWKWebView: WKWebView?    // weak to avoid reference cycling
        var parent: BackgroundWebView
        var cancelBag = Set<AnyCancellable>()
        
        // 생성자
        init(_ uiWebView: BackgroundWebView) {
            self.parent = uiWebView
            
        }

        // 소멸자
        deinit {
            
        }
        
        private func changeJavascriptStr(str:String) -> String {
            var resultStr = str
//            resultStr = resultStr.replacingOccurrences(of: "\"", with: "\\\"")
            resultStr = resultStr.replacingOccurrences(of: "\n", with: "")
            resultStr = resultStr.replacingOccurrences(of: "\"", with: "\'")
            
            return resultStr
        }
        
        func runJavascript(scriptStr:String) {
            print("runJavascript : \(changeJavascriptStr(str: scriptStr))")
            self.parentWKWebView?.evaluateJavaScript(changeJavascriptStr(str: scriptStr)) { result, err in
                if let error = err {
                    print(error)
                }
            }
        }
            
        // 지정된 기본 설정 및 작업 정보를 기반으로 새 콘텐츠를 탐색 할 수있는 권한을 대리인에게 요청
        func webView(_ webView: WKWebView,
                       decidePolicyFor navigationAction: WKNavigationAction,
                       decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let host = navigationAction.request.url?.host {
                // 특정 도메인을 제외한 도메인을 연결하지 못하게 할 수 있다.
                if host != "velog.io" {
                   return decisionHandler(.cancel)
                }
            }
            
            return decisionHandler(.allow)
        }
         
        // 기본 프레임에서 탐색이 시작되었음
        func webView(_ webView: WKWebView,
                       didStartProvisionalNavigation navigation: WKNavigation!) {
            print("기본 프레임에서 탐색이 시작되었음")
        }
        
        // 웹보기가 기본 프레임에 대한 내용을 수신하기 시작했음
        func webView(_ webView: WKWebView,
                       didCommit navigation: WKNavigation!) {
            print("내용을 수신하기 시작");
        }
        
        // 탐색이 완료 되었음
        func webView(_ webview: WKWebView,
                       didFinish: WKNavigation!) {
            print("탐색이 완료")
        }
        
        // 초기 탐색 프로세스 중에 오류가 발생했음 - Error Handler
        func webView(_ webView: WKWebView,
                       didFailProvisionalNavigation: WKNavigation!,
                       withError: Error) {
            print("초기 탐색 프로세스 중에 오류가 발생했음")
        }
        
        // 탐색 중에 오류가 발생했음 - Error Handler
        func webView(_ webView: WKWebView,
                       didFail navigation: WKNavigation!,
                       withError error: Error) {
            print("탐색 중에 오류가 발생했음")
        }
    }
}

struct BackgroundWebView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundWebView()
    }
}
