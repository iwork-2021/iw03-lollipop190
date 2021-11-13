//
//  ContentView.swift
//  ITSC
//
//  Created by lollipop on 2021/11/13.
//

import SwiftUI

struct ContentView: View {
    let category = ["新闻动态","通知公告","信息化动态", "安全公告","关于"]
    let imgName = ["newspaper","note.text","desktopcomputer","network","info.circle"]
    let urls = [
        "https://itsc.nju.edu.cn/xwdt/list.htm",
        "https://itsc.nju.edu.cn/tzgg/list.htm",
        "https://itsc.nju.edu.cn/wlyxqk/list.htm",
        "https://itsc.nju.edu.cn/aqtg/list.htm",
        "https://itsc.nju.edu.cn/main.htm"
    ]
    var body: some View {
        TabView {
            ForEach(0..<category.count - 1){ index in
                    newsList(name: category[index], url: urls[index])
                        .tabItem {
                            Image(systemName: imgName[index])
                            Text(category[index])
                        }
            }
            
            VStack{
                Text(
                """
                关于我们\n
                服务电话\n
                025-89683791\n
                服务时间：每天（8：00-19：00）\n
                校园卡电话\n
                025-89683791\n
                服务时间：每天（8：00-19：00）\n
                服务邮箱\n
                ITSC@nju.edu.cn\n
                招聘邮箱\n
                ITSChr@nju.edu.cn\n
                仙林信息化中心楼\n
                前台工作时间：每天8：00–19：00\n
                鼓楼综合服务大厅\n
                工作日：9:00–12:00、13:00–17:00\n
                """)
            }
                        .tabItem {
                            Image(systemName: imgName[4])
                            Text(category[4])
                        }
        }
        .font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
