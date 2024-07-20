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
    
    @State var emojis = generateCards(chars: themeCountries)
    @State var themeColor = Color.red
        
    @State var emojiCount = 4
    
    struct Card: Hashable {
        var id = UUID()
        var isFirst: Bool
        var char: String
        var isFaceUp: Bool
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount*2], id: \.self) {card in
                        CardView(content: card)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(themeColor)
            Spacer()
            HStack{
                themeButton(themeName: "countries",themeEmojis: ContentView.themeCountries, imageId:  "flag", color: .red)
                themeButton(themeName: "transport",themeEmojis:  ContentView.themeTransport, imageId:  "car", color: .green)
                themeButton(themeName: "animals", themeEmojis: ContentView.themeAnimals, imageId:  "dog", color: .brown)
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
            if(emojiCount > 3){
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    var add: some View {
        Button {
            if(emojiCount*2 < emojis.count ){
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    func themeButton(themeName: String, themeEmojis: Array<String>, imageId: String, color: Color) -> some View {
        return Button{
            emojiCount = 4
            emojis = generateCards(chars: themeEmojis)
            themeColor = color
        } label: {
            VStack {
                Image(systemName: imageId)
                Text(themeName)
                    .font(.caption)
            }
        }
    }
}

func generateCards(chars: Array<String>) -> Array<ContentView.Card>{
    return chars
        .flatMap({
            return [
                    ContentView.Card(
                    isFirst: true,
                    char: $0,
                    isFaceUp: false),
                    ContentView.Card(
                        isFirst: false,
                        char: $0,
                        isFaceUp: false
                    )
            ]
        }
    )
        .shuffled()
}

struct CardView: View {
    
    @State var content: ContentView.Card
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if content.isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .strokeBorder(lineWidth: 3)
                
                Text(content.char)
                    .font(.largeTitle)
                
            } else {
                shape
                    .fill()
            }
        }
        .onTapGesture {
            content.isFaceUp = !content.isFaceUp
        }
    }
}

#Preview {
    ContentView()
}
