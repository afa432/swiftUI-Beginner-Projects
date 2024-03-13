//
//  ContentView.swift
//  WordScramble
//
//  Created by Ahmet Faruk Arvas on 12.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var Usedwords = [String]()
    @State private var rootWord = ""
    @State private var newword = ""
    @State private var Score = 0
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingAlert = false
    @State private var showing2nAlert = false
    
    
    
    var body: some View {
        NavigationView{
            List{
                Section("Your Score is \(Score)"){
                    
                    
                    TextField("Enter word", text: $newword)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    Button("Restrart game"){
                        showing2nAlert = true
                    }.alert("sure about resseting ?", isPresented: $showing2nAlert){
                        Button("Yes", role: .destructive, action: restartingGame)
                    }
                }
                
                Section{
                        ForEach(Usedwords, id: \.self ){ word in
                            HStack{
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            
            .onSubmit(){
                addingNewWords()
                newword = ""
            }
            .onAppear(perform:startGame)
            .alert(errorTitle, isPresented: $showingAlert){
                Button("Ok"){}
            }message: {
                Text(errorMessage)
            }
        }
    }
    
    func addingNewWords(){
        let trimmedNewWord = newword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard IsWordOriginal(word: trimmedNewWord) else{
            wordError(title: "Word used already", mesage: "yor word is not original")
            return
        }
        
        guard isPosiable(word: trimmedNewWord)else{
            wordError(title: "Word not posiable", mesage: "You can't speel that from rootwor")
            return
        }
        
        guard isReal(word: trimmedNewWord)else{
            wordError(title: "Word can't recoginazed", mesage: "your cant just make them up")
            return
        }
        
        guard trimmedNewWord.count > 0 else {return}
        withAnimation{
            Usedwords.insert(trimmedNewWord, at: 0)
        }
        
        Score += trimmedNewWord.count
        
    }
    
    func startGame(){
        if let starWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: starWordsUrl){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "Silkworm"
                return
            }
        }
        
        fatalError("Could nor load the file 'start.txt' from bunle.  ")
        
    }
    
    func IsWordOriginal(word:String) -> Bool {
        !Usedwords.contains(word)
    }
    
    func isPosiable(word:String) ->Bool{
        var tempword = rootWord
        
        for letter in word{
            if let pos = tempword.firstIndex(of: letter){
                tempword.remove(at: pos)
            }else{
                return false
                
            }
        }
        return true
    }
    
    func isReal(word: String)-> Bool{
        let checker = UITextChecker()
        let range   = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, mesage:String){
        errorTitle = title
        errorMessage = mesage
        showingAlert = true
    }
    
    func restartingGame(){
        Usedwords.removeAll()
        rootWord = ""
        newword = ""
        Score = 0
        errorTitle = ""
        errorMessage = ""
        showingAlert = false
        
        startGame()
        
    }
    
}
#Preview {
    ContentView()
}
