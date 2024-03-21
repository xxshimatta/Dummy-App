//
//  OrderListView.swift
//  dummyapp
//
//  Created by Jeffrey Clay Setiawan on 02/03/24.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var collectionViewModel:CollectionViewModel
    
    @State var showCreateOrderView = false
    
    var body: some View {
        NavigationView{
            List{
                if collectionViewModel.Orders.count > 0{
                    ForEach(collectionViewModel.Orders){thisOrder in
                        Section(thisOrder.name){
                            VStack{
                                ForEach(thisOrder.items, id:\.self){collectname in
                                    if let thisItem = collectionViewModel.CollectionItems.first(where: {$0.name == collectname}){
                                        HStack{
                                            Text(thisItem.name)
                                            Spacer()
                                            Text(String(format: "$%.2f", thisItem.price))
                                        }
                                    }else{
                                        Text("Item not found")
                                    }
                                }
                            }
                            HStack{
                                Text("Total:")
                                Spacer()
                                Text(String(format: "$%.2f", thisOrder.total))
                            }
                            HStack{
                                Spacer()
                                Button(action:{collectionViewModel.deleteOrder(thisOrder)}){Text("Delete Order")}
                                Spacer()
                            }
                        }
                    }
                }else{
                    //No orders
                    Text("No Orders")
                }
            }
            .navigationTitle("Orders")
            .navigationBarItems(trailing: Button(action:{showCreateOrderView = true}){Text("Create Order")})
        }
        .sheet(isPresented: $showCreateOrderView, content: {CreateOrderView()})
    }
}
