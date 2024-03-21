//
//  CollectionListView.swift
//  dummyapp
//
//  Created by Jeffrey Clay Setiawan on 02/03/24.
//

import SwiftUI

struct CollectionListView: View {
    @EnvironmentObject var collectionViewModel:CollectionViewModel
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(collectionCategory, id:\.self){categoryName in
                    Section(categoryName){
                        ForEach(collectionViewModel.CollectionItems){collectionItem in
                            if collectionItem.category == categoryName{
                                HStack{
                                    Text(collectionItem.name)
                                    Spacer()
                                    Text(String(format:"$%.2f", collectionItem.price))
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Menu")
        }
    }
}
