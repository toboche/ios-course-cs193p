//
//  ContentView.swift
//  Memorize
//
//  Created by Tomasz Bochenek on 29/06/2024.
//

import SwiftUI

struct ContentView: View {
    static let themeCountries = ["🇬🇧", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇺🇸", "🏴󠁧󠁢󠁳󠁣󠁴󠁿", "🇩🇰", "🇦🇪", "🇲🇲", "🇨🇮", "🇲🇦", "🇵🇳", "🇻🇪"]
    static let themeTransport = ["✈️",
                          "🚙",
                          "🚂",
                          "🚴",
                          "🚀",
                            "🚍",
                            "🛥️",
                            "🛩️",
                            "🚔",
            "🚁",
            "⛵️"]
    static let themeAnimals = ["🐱", "🐩", "🦔", "🐼", "🐄", "🙈", "🐇", "🐖", "🦬"]
    
    @State var emojis = themeCountries
    
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) {emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack{
                themeButton(themeName: "countries",themeEmojis: ContentView.themeCountries)
                themeButton(themeName: "transport",themeEmojis:  ContentView.themeTransport)
                themeButton(themeName: "animals", themeEmojis: ContentView.themeAnimals)
            }
            HStack{
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    var remove: some View {
        Button{
            if(emojiCount > 1){
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    var add: some View {
        Button {
            if(emojiCount < emojis.count ){
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    func themeButton(themeName: String, themeEmojis: Array<String>) -> some View{
        return Button{
            emojiCount = 4
            emojis = themeEmojis
        } label: {
            Text(themeName)
        }
    }
}

struct CardView: View {
    
    @State var isFaceUp: Bool = true
    var content: String
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                
                Text(content)
                    .font(.largeTitle)
                
            } else {
                shape
                    .fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
        
    }
    
    
}

#Preview {
    ContentView()
}
