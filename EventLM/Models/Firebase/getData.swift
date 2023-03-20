//
//  getData.swift
//  EventLM
//
//  Created by Owen Bress (student LM) on 3/15/23.
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
//import FirebaseDatabasSwift
// This class is what is actually updating the information in Firebase.
class getData: ObservableObject{
    
    private let ref = Database.database().reference()
    
    //GETS DATA FROM DATABASE
    static func readData(path : String , completion: @escaping (Result<DataSnapshot, Error>) -> Void){
        let ref = Database.database().reference()
        ref.child(path).observe(.value) { snapshot in
            completion(.success(snapshot))
        } withCancel: { error in
            completion(.failure(error))
        }
    }
    
    //MAKES IT SO BOTH READ DATA IN SORTED AREN'T CALLED WHEN VALUE IS CHANGED
    private static func readDataSingle(path : String , completion: @escaping (Result<DataSnapshot, Error>) -> Void){
        let ref = Database.database().reference()
        ref.child(path).observeSingleEvent(of: .value) { snapshot in
            completion(.success(snapshot))
        } withCancel: { error in
            completion(.failure(error))
        }
    }
    
    //EVENTS FROM ALL SPORTS SORTED BY DATE.
    static func getSortedScheduled(path: Path, completion: @escaping ([(id: UUID, key: String, value: AnyObject)]) -> Void) {
        var events: [(id: UUID, key: String, value: AnyObject)] = []
        let dispatchGroup = DispatchGroup()
        
        getData.readData(path: path.fPath()) { result in
            switch result {
            case .success(let snapshot):
                if let data = snapshot.value as? [String: AnyObject] {
                    var sNames = data.map { $0.key }
                    events = []
                    for name in sNames {
                        path.addPath(aPath: name as String)
                        dispatchGroup.enter()
                        getData.readDataSingle(path: path.fPath()) { result1 in
                            switch result1 {
                            case .success(let snapshot1):
                                if let data1 = snapshot1.value as? [String: AnyObject] {
                                    DispatchQueue.main.async {
                                        events += ManageData.dictionaryToTuples(data1)
                                    }
                                } else {
                                    print("Bad Path")
                                }
                            case .failure(let error1):
                                print("Error: \(error1.localizedDescription)")
                            }
                            dispatchGroup.leave()
                        }
                        path.remPath()
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        events = ManageData.sortArray(array: events, ascending: true)
                        DispatchQueue.main.async {
                            completion(events)
                        }
                    }
                } else {
                    print("No data found")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    static func getSortedResults(path: Path, completion: @escaping ([(id: UUID, key: String, value: AnyObject)]) -> Void) {
        var events: [(id: UUID, key: String, value: AnyObject)] = []
        let dispatchGroup = DispatchGroup()
        
       
        getData.readData(path: path.fPath()) { result in
            switch result {
            case .success(let snapshot):
                if let data = snapshot.value as? [String: AnyObject] {
                    DispatchQueue.main.async {
                        events = ManageData.dictionaryToTuples(data)
                    }
                    dispatchGroup.notify(queue: .main) {
                        events = ManageData.sortArray(array: events, ascending: false)
                        DispatchQueue.main.async {
                            completion(events)
                        }
                        
                    }
                } else {
                    print("Bad Path")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
    
}
