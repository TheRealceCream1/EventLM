//
//  ResultsDetailView.swift
//  EventLM
//
//  Created by Owen Bress (student LM) on 3/29/23.
//

import SwiftUI

struct ResultsDetailView: View {
    @State var eventData: [String : String]
    var body: some View {
        VStack{
            Text("Lower Merion vs\(eventData["name"] ?? "?")")
                .font(.largeTitle)
                .padding(.bottom)
            Text(eventData["date"] ?? "_")
            // Putting a crown over the winning teams logo
            
            if eventData["scorelm"] ?? "0" > eventData["scoreOpponent"] ?? "0" {
                HStack{
                    VStack{
                        Image("Crown")
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width/4), height: (UIScreen.main.bounds.width/4))
                        VStack{
                            Image("LMLogo")
                                .resizable()
                                .frame(width: (UIScreen.main.bounds.width/3), height: (UIScreen.main.bounds.width/3))
                            Text(eventData["scorelm"] ?? "?")
                        }
                    }
                    VStack{
                        Image(eventData["name"] ?? "badLogo")
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width/3), height: (UIScreen.main.bounds.width/3))
                        Text(eventData["scoreOpponent"] ?? "?")
                    }
                }
            }
            else if eventData["scorelm"] ?? "0" < eventData["scoreOpponent"] ?? "0" {
                HStack{
                    VStack{
                        Image("LMLogo")
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width/3), height: (UIScreen.main.bounds.width/3))
                        Text(eventData["scorelm"] ?? "?")
                    }
                    VStack{
                        Image("Crown")
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width/4), height: (UIScreen.main.bounds.width/4))
                        
                        VStack{
                            Image(eventData["name"] ?? "badLogo")
                                .resizable()
                                .frame(width: (UIScreen.main.bounds.width/3), height: (UIScreen.main.bounds.width/3))
                            Text(eventData["scoreOpponent"] ?? "?")
                        }
                    }
                }
            }
            else{
                Text("Draw")
            }
            
            
            
            
            //            if eventData["scorelm"] ?? "0" > eventData["scoreOpponent"] ?? "0" {
            //                VStack{
            //                    Image("Crown")
            //                        .resizable()
            //                    Image("LMLogo")
            //                        .resizable()
            //                }
            //            }
            //            else if eventData["scorelm"] ?? "0" < eventData["scoreOppomemt"] ?? "0" {
            //                VStack{
            //                    Image("Crown")
            //                        .resizable()
            //                    Image("LMLogo")
            //                        .resizable()
            //                }
            //            }
            //            else{
            //                Text("draw")
        }
    }
}

struct ResultsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsDetailView(eventData : [:])
    }
}
