import SwiftUI
import ComposableArchitecture

struct SavedCharactersView: View {
    var store: StoreOf<SavedCharactersFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if viewStore.characters.isEmpty {
                Text("No saved characters")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding()
            } else {
            ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem(spacing: 0), GridItem(spacing: 0)], spacing: 0) {
                        ForEach(viewStore.characters) { character in
                            if let url = character.image, !url.isEmpty {
                                NavigationLink(state: AppFeature.Path.State.characterDetail(.init(character: character))) {
                                    ImageCardLayout(urlString: url)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SavedCharactersView(store: Store(initialState: SavedCharactersFeature.State(), reducer: {
        SavedCharactersFeature()
    }))
}
