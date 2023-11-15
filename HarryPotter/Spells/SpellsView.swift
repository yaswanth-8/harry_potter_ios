import SwiftUI
import ComposableArchitecture

struct SpellsView: View {
    let store: StoreOf<SpellsFeature>
    @State private var selectedSpell: Spell?
    @State private var isShowingSpellDescription = false

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
                List(viewStore.spells, id: \.id) { spell in
                    SpellRowView(spell: spell)
                        .onTapGesture {
                            selectedSpell = spell
                            isShowingSpellDescription = true
                        }
                }
                .onAppear {
                    viewStore.send(.fetch)
                }
                .navigationTitle("Spells")
            .alert(isPresented: $isShowingSpellDescription) {
                Alert(
                    title: Text(selectedSpell?.name ?? ""),
                    message: Text(selectedSpell?.description ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}



#Preview {
    SpellsView(store: Store(initialState: SpellsFeature.State(), reducer: {
        SpellsFeature()._printChanges()
    }))
}
