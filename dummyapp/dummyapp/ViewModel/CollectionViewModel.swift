//
//  CollectionViewModel.swift
//  dummyapp
//
//  Created by Jeffrey Clay Setiawan on 02/03/24.
//

import Foundation
import Combine
import FirebaseFirestore
import Firebase

class CollectionViewModel:ObservableObject{
    
    init(){
        getCollection()
        getOrders()
    }
    
    //collection
    @Published var CollectionItems = [CollectionItem]()
    
    func getCollection(){
        //get Reference
        let db = Firestore.firestore()
        //Read Document at specific path
        db.collection("Items").getDocuments{ snapShot, error in
            //check errors
            if error == nil{
                //update the list property in main thread
                DispatchQueue.main.async{
                    self.CollectionItems = snapShot!.documents.map {d in
                        //create collection item for every document return
                        return CollectionItem(category: d["Category"] as? String ?? "Other",
                                              name: d["Name"] as? String ?? "Item Failed to Load",
                                              price: Double(d["Price"] as? String ?? "0")!,
                                              stock: Bool(d["Stock"] as? String ?? "false")!)
                    }
                }
            } else{
                //Handle the error....
                
            }
        }
        
    }
    
    
    //order
    @Published var Orders = [Order]()
    
    func getOrders(){
        //get Reference
        let db = Firestore.firestore()
        //Read Document at specific path
        db.collection("Orders").getDocuments{ snapShot, error in
            //check errors
            if error == nil{
                //update the list property in main thread
                DispatchQueue.main.async{
                    self.Orders = snapShot!.documents.map {d in
                        //create collection item for every document return
                        return Order(id: d.documentID,
                                     name: d["name"] as? String ?? "No Name",
                                     items: d["items"] as? [String] ?? [String](),
                                     total: Double(d["total"] as? String ?? "0")!)
                    }
                }
            } else{
                //Handle the error....
                
            }
        }
    }
    func addOrder(name:String, items:[String], total:String){
        let db = Firestore.firestore()
        //add document to collection
        db.collection("Orders").addDocument(data:[
            "name":name,
            "items":items,
            "total":total
        ]){error in
            if error == nil{
                //No error
                self.getOrders()
            }else{
                //Handle the error
                print("Error")
            }
        }
    }
    
    func deleteOrder(_ orderToDelete:Order){
        //get reference to db
        let db = Firestore.firestore()
        //specify the doc to delete
        db.collection("Orders").document(orderToDelete.id).delete{ error in
            //check for error
            if error == nil{
                //no error
                DispatchQueue.main.async{
                    self.Orders.removeAll{ order in
                        //check for the order to delete
                        return order.id == orderToDelete.id
                    }
                }
            }
        }
    }
    
    
}
