//
//  CreateOrderView.swift
//  dummyapp
//
//  Created by Jeffrey Clay Setiawan on 02/03/24.
//

import SwiftUI

struct CreateOrderView: View {
    @State var name = ""
    @State var total = 0.0
    @State var items = [String]()
    @State var showColList = false
    @EnvironmentObject var collectionViewModel:CollectionViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack{
            HStack{
                Text("New Order")
                    .font(.largeTitle)
                Spacer()
            }
            Form{
                Section("Customer"){
                    HStack{
                        Text("Name:")
                        Spacer()
                        TextField("Name", text: $name)
                    }
                }
                Section("Items"){
                    VStack{
                        Button(action:{showColList = true}){Text("Add Item to Order")}
                        List(items, id:\.self){collectionItemName in
                            if let thisItem = collectionViewModel.CollectionItems.first(where:{$0.name == collectionItemName}){
                                HStack{
                                    Text(thisItem.name)
                                    Spacer()
                                    Text(String(format:"$%.2f",thisItem.price))
                                }
                            }else{
                                Text("Item not Found")
                            }
                        }
                        Divider()
                        HStack{
                            Text("Total:")
                            Spacer()
                            Text(String(format:"$%.2f", total))
                        }.font(.headline)
                    }
                }
                Button(action:{
                    //Submit order to Firestore
                    collectionViewModel.addOrder(name: name, items: items, total: String(total))
                    
                    //Dismiss the order
                    presentationMode.wrappedValue.dismiss()
                }){Text("Place Order")}
            }.padding()
                .sheet(isPresented: $showColList, content: {OrderColList(items: $items, total: $total)})
        }
    }
}

struct OrderColList: View{
    @Binding var items: [String]
    @Binding var total: Double
    
    @EnvironmentObject var collectionViewModel:CollectionViewModel
    @Environment(\.presentationMode) var presentationModeHere
    
    var body: some View{
        NavigationView{
            List{
                ForEach(collectionCategory, id:\.self){categoryName in
                    Section(categoryName){
                        ForEach(collectionViewModel.CollectionItems){collectionItem in
                            if collectionItem.category == categoryName{
                                //Button on another view
                                collectionbutton(item: collectionItem, items: $items, total: $total, presentationModeHere: presentationModeHere)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Menu")
        }
    }
}


struct collectionbutton: View{
    @State var item: CollectionItem
    @Binding var items:[String]
    @Binding var total:Double
    @Binding var presentationModeHere:PresentationMode
    
    var body: some View{
        Button(action:{
            //add item to the list
            items.append(item.name)
            //update total price
            total += item.price
            //go back to summary view
            $presentationModeHere.wrappedValue.dismiss()
        }){
            HStack{
                Text(item.name)
                Spacer()
                Text(String(format:"$%.2f", item.price))
            }
        }
    }
    
}
