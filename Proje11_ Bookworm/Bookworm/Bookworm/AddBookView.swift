//
//  AddBookView.swift
//  Bookworm
//
//  Created by Ahmet Faruk Arvas on 1.03.2024.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var showingAlert = false

    
    
    let genres = ["Fantasy", "Horror","Kids","Mystery","Poetry","Romance","Thriller"]
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name of book",text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("genre's name", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                Section("Wriate a review"){
                    TextEditor(text: $review)
                    
                    RaringView(rating: $rating)
                }
                Section{
                    Button("Save"){
                        if(title.isEmpty || author.isEmpty || genre.isEmpty || review.isEmpty ){
                            showingAlert = true
                        }
                        else {
                            let newBook = Book(title: title, author: author, genre: genre, review:  review, rating: rating, date: Date.now)
                            modelContext.insert(newBook)
                            dismiss()
                        }
                    }
                }
            }.navigationTitle("Add Book")
        }.alert("Fill all boxes",isPresented: $showingAlert){
            Button("Ok",role: .cancel){ }
        }message: {
            Text("You should fill al the boxes")
        }
    }
}

#Preview {
    AddBookView()
}
