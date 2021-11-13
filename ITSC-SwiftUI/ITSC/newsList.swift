//
//  newsList.swift
//  ITSC
//
//  Created by lollipop on 2021/11/13.
//

import SwiftUI
import SwiftSoup
struct newsList: View {
    let name: String
    let url: String
    @State var lstA: [String:String] = [" ":" "]
    var lst: [String: String] {
        get async{
        var list = [String: String]()
      
        do {
                let document = try await getHtml()
                let all_a = try document.select("span.news_title > a")
                for a in all_a.array() {
                    let linkHref: String = try a.attr("href")
                    let linkText: String = try a.text()
                    list[linkText] = linkHref
                }
            
    
        }catch {
            print(error)
        }
        return list
    }
    }
    
    func getHtml() async throws -> Document{
        let html = try String(contentsOf: URL(string: url)!)
        return try SwiftSoup.parse(html)
    }
    var body: some View {
        NavigationView {
            List(Array(lstA.keys), id: \.self){
                NavigationLink($0, destination: newsContent(url: "https://itsc.nju.edu.cn" + lstA[$0]!))
            }.navigationTitle(name)
                .task {
                    lstA = await lst
                }
        }
    }
}

struct newsList_Previews: PreviewProvider {
    static var previews: some View {
        let url = "https://itsc.nju.edu.cn/xwdt/list.htm"
        newsList(name: "name", url: url)
    }
}
