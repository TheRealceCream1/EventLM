//
//  ResultsView.swift
//  EventLM
//
//  Created by Owen Bress (student LM) on 2/28/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth

struct ResultsView: View {
    @EnvironmentObject var path : Path
    @Binding var viewState : ViewState
    @State private var events: [(id: UUID, key: String, value : AnyObject)] = []
    
    
    
    var body: some View {
        NavigationView{
        VStack{
            if events.count != 0{
                ScrollView{
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 0), spacing: -5),
                        GridItem(.flexible(minimum: 0), spacing: -5)
                        
                    ],spacing:1, content: {
                        ForEach(events, id: \.id) { i in
                            if let event = i.value as? [String: String]{
                                NavigationLink{
                                    ResultsDetailView(eventData: event)
                                }label:{
                                    ResultBox(eventData : event)
                                }
                            }
                            
                        }
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    })
                }
                
            }
            else{
                Text("No results for \(path.lastSport)")
            }
            Spacer()
            SportScrollView()
                .padding(.bottom)
            
            
            
        }
        .onReceive(path.$pathChanged) { _ in
            getData.getSortedResults(path: path) { sortedEvents in
                DispatchQueue.main.async {
                    events = sortedEvents
                }
            }
        }
        .task{
            //CHANGE FIREBASE PATH
            path.remAllPath()
            path.addPath(aPath: "results/\(path.lastSport)")
            //GETS DATA
            getData.getSortedResults(path: path) { sortedEvents in
                DispatchQueue.main.async {
                    events = sortedEvents
                }
            }
        }.navigationTitle("Results")
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(viewState: Binding.constant(ViewState.authentication))
            .environmentObject(Path())
        
    }
}
