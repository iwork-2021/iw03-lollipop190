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

    @State var titleA: String = ""
    @State var contentA: String = ""
    @State var timeA = ""
    @State var countA = ""
    
    func load() async -> (String, String, String, String) {
        do {
            let html = try String(contentsOf: URL(string: url)!)
            let document = try SwiftSoup.parse(html)
            let title = try document.select("h1.arti_title").text()
            let content = try document.select("div.wp_articlecontent > p").text()
            let time = try document.select("span.arti_update").text()
            var s =  try document.select("span.WP_VisitCount").text()
            s = "浏览次数：" + s;
            return (title, content, time, s)
            }catch {
            print(error)
            }
            return ("","","","")
    }
    
    var body: some View {
    
        VStack{
            Text(titleA)
                .foregroundColor(.red)
                .font(.system(size: 25))
            Text(timeA + "   " + countA).padding().font(.system(size: 15))
            ScrollView{
                Text(contentA).padding(.horizontal)
            }
       
        }.task {
            let (a,b,c,d) = await load()
            titleA = a
            contentA = b
            timeA = c
            countA = d
        }

    }
}

struct newsContent_Previews: PreviewProvider {
    static var previews: some View {
        newsContent(url:"https://itsc.nju.edu.cn/4f/ab/c21414a544683/page.htm")
    }
}
