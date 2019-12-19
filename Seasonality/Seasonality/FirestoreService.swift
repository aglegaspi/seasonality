//
//  FirestoreService.swift
//  Seasonality
//
//  Created by Tia Lendor on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation
import FirebaseFirestore

fileprivate enum FireStoreCollections: String {
    case users
    case posts
    case comments
    case markets
    case produceByMonth = "Produce"
    case produce = "ProduceByType"
}

enum SortingCriteria: String {
    case fromNewestToOldest = "dateCreated"
    var shouldSortDescending: Bool {
        switch self {
        case .fromNewestToOldest:
            return true
        }
    }
}


class FirestoreService {
    static let manager = FirestoreService()
    
    private let db = Firestore.firestore()
    
    //MARK: AppUsers
    func createAppUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = user.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.users.rawValue).document(user.uid).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }
    
    func updateCurrentUser(userName: String? = nil, photoURL: URL? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let user = userName {
            updateFields["userName"] = user
        }
        
        if let photo = photoURL {
            updateFields["photoURL"] = photo.absoluteString
        }
        
       
        //PUT request
        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
            
        }
    }
    
    /*
    func getAllUsers(completion: @escaping (Result<[AppUser], Error>) -> ()) {
        db.collection(FireStoreCollections.users.rawValue).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let users = snapshot?.documents.compactMap({ (snapshot) -> AppUser? in
                    let userID = snapshot.documentID
                    let user = AppUser(from: snapshot.data(), id: userID)
                    return user
                })
                completion(.success(users ?? []))
            }
        }
    }
 */
    
    
    func createMarket(market: MarketFire, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = market.fieldsDict
        
        db.collection(FireStoreCollections.markets.rawValue).document(market.name).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }
    
    func getMarket(marketName: String, completion: @escaping (Result<MarketFire, AppError>) -> ()) {
        db.collection(FireStoreCollections.markets.rawValue).whereField(FireStoreCollections.markets.rawValue, isEqualTo: marketName).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(.noDataReceived))
            } else if let snapshot = snapshot {
                guard let firstDoc = snapshot.documents.first else {
                    completion(.failure(.noDataReceived))
                    return
                }
                let market = MarketFire(from: firstDoc.data())
                completion(.success(market!))
            }
        }
    }
    
    func getAllProduce(completion: @escaping (Result<[Produce], Error>) -> ()) {
        db.collection(FireStoreCollections.produce.rawValue).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let users = snapshot?.documents.compactMap({ (snapshot) -> Produce? in
                    let item = snapshot.documentID
                    let produceItem = Produce(from: snapshot.data(), item: item)
                    return produceItem
                })
                completion(.success(users ?? []))
            }
        }
    }
    
    
    
//MARK: Posts

       func createPost(post: Post, completion: @escaping (Result<(), Error>) -> ()) {
           db.collection(FireStoreCollections.posts.rawValue).addDocument(data: post.fieldsDict) { (error) in
               if let error = error {
                   completion(.failure(error))
               } else {
                   completion(.success(()))
               }
           }
       }
 
       
       func getAllPosts(completion: @escaping (Result<[Post], Error>) -> ()) {
           db.collection(FireStoreCollections.posts.rawValue).getDocuments { (snapshot, error) in
               if let error = error {
                   completion(.failure(error))
               } else {
                   let posts = snapshot?.documents.compactMap({ (snapshot) -> Post? in
                       let postID = snapshot.documentID
                       let post = Post(from: snapshot.data(), id: postID)
                       return post
                   })
                   completion(.success(posts ?? []))
               }
           }
       }

    

//    MARK: Faves
       /*
       
       func createfave(faved: FavedEvents, completion: @escaping (Result<(), Error>) -> ()) {
           let fields = faved.fieldsDict
           
           db.collection(FireStoreCollections.posts.rawValue).addDocument(data: fields) { (error) in
               if let error = error {
                   completion(.failure(error))
               } else {
                   completion(.success(()))
               }
           }
       }
       
       func getUserFaved(userId: String, completion: @escaping(Result<[FavedEvents], Error>) -> () ) {
           db.collection(FireStoreCollections.posts.rawValue).whereField("creatorID", isEqualTo: userId).getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let posts = snapshot?.documents.compactMap({ (snapshot) -> FavedEvents? in
                        let postId = snapshot.documentID
                        let post = FavedEvents(from: snapshot.data(), id: postId)
                        return post
                    })
                    completion(.success(posts ?? []))
                }
            }
        }
    
    */
       


    private init () {}
}
