//
//  newsContent.swift
//  ITSC
//
//  Created by lollipop on 2021/11/13.
//

import SwiftUI
import SwiftSoup
struct newsContent: View {
    let url: String
    var document: Document? {
        get async {
        do {
            let html = try String(contentsOf: URL(string: url)!)
            let document = try SwiftSoup.parse(html)
            return document
            }catch {
            print(error)
            }
            return nil
        }
        }
    
    @State var titleA: String = ""
    @State var contentA: String = ""
    @State var timeA = ""
    @State var countA = ""
    var title: String? {
        get async {
        try? await document?.select("h1.arti_title").text()
        }
    }
    var content: String? {
        get async {
        try? await document?.select("div.wp_articlecontent > p").text()
        }
    }
    var time: String? {
        get async {
        try? await document?.select("span.arti_update").text()
        }
    }
    var count: String? {
        get async {
        let s =  try? await document?.select("span.WP_VisitCount").text()
        return "浏览次数：" + (s ?? "0")
        }
    }
    var body: some View {
    
        VStack{
            Text(titleA)
                .foregroundColor(.red)
                .font(.system(size: 25))
            Text(timeA + countA).padding().font(.system(size: 15))
            ScrollView{
                Text(contentA).padding(.horizontal)
            }
       
        }.task {
            let s = await [title!,time!, count!, content!]
            titleA = s[0]
            timeA = s[1]
            countA = s[2]
            contentA = s[3]
        
        }

    }
}

struct newsContent_Previews: PreviewProvider {
    static var previews: some View {
        newsContent(url:"https://itsc.nju.edu.cn/4f/ab/c21414a544683/page.htm")
    }
}
