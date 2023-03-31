//
//  ResultBox.swift
//  EventLM
//
//  Created by Owen Bress (student LM) on 3/8/23.
//

import SwiftUI

struct ResultBox: View {
    @State var eventData: [String : String]
    @EnvironmentObject var path : Path
    // List of all school logos stored locally within the app
    // We also have to be really careful as the syntax is very sensitive
    @State var logos : [String] = ["Haverford", "Penncrest", "Ridley", "Strath Haven", "Garnet Valley", "Conestoga", "Radnor", ]
    var body: some View {

        ZStack {
            Rectangle()
                .frame(width: ((UIScreen.main.bounds.width/2)-4), height: UIScreen.main.bounds.height/4)
                .foregroundColor(.black.opacity(0.1))
                .border(Color.black, width: 1)

            VStack(spacing: 5) {
                Text(eventData["date"] ?? "?")
                    .foregroundColor(.gray)
                    .font(Constants.SmallFont)
                    .frame(width: (UIScreen.main.bounds.width/2)-UIScreen.main.bounds.width/15, alignment: .leading)
                Text(path.lastSport)
                    .foregroundColor(.Maroon)
                    .font(Constants.SmallFont)
                HStack {
                    Image("LMLogo")
                        .resizable()
                        .frame(width: (UIScreen.main.bounds.width/10), height: (UIScreen.main.bounds.width/10))
                    Text("Lower Merion")
                        .foregroundColor(.black)
                        .font(Constants.gameNameFont)
                    Text(eventData["scorelm"] ?? "?")
                        .foregroundColor(.black)
                        .font(Constants.GameScoreFont)
                }
                HStack {
                    if logos.contains(eventData["name"] ?? "?" ){
                        Image(eventData["name"] ?? "badLogo")
                            .resizable()
                            .opacity(0.8)
                            .frame(width: (UIScreen.main.bounds.width/10), height: (UIScreen.main.bounds.width/10))
                    }
                    else{
                        Image("Unknown")
                            .resizable()
                            .opacity(0.8)
                            .frame(width: (UIScreen.main.bounds.width/10), height: (UIScreen.main.bounds.width/10))
                    }
                    Text(eventData["name"] ?? "?")
                        .foregroundColor(.black.opacity(0.7))
                        .font(Constants.gameNameFont)
                    Text(eventData["scoreOpponent"] ?? "?")
                        .foregroundColor(.black.opacity(0.7))
                        .font(Constants.GameScoreFont)
                }
                Text("Final")
                    .foregroundColor(.black)
                    .font(Constants.SmallFont)
            }


        }

    }
}



struct ResultBox_Previews: PreviewProvider {

    static var previews: some View {
        ResultBox(eventData : [:])
            .environmentObject(Path())

    }

}
