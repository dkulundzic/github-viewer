import SwiftUI
import ComposableArchitecture
import GithubViewerModel
import GithubViewerDomain

struct UserView: View {
  let store: StoreOf<UserReducer>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        VStack(alignment: .center) {
          AsyncImageWithProgress(
            url: viewStore.user.image,
            imageSize: 200
          )
          .aspectRatio(contentMode: .fill)
          Text(viewStore.user.name)
            .font(.largeTitle)
        }

        Form {
          Section {
            Link(destination: viewStore.user.url) {
              Text(L10n.repositoryWebPageCta)
            }
          }
        }
      }
    }
  }
}

struct UserView_Previews: PreviewProvider {
  static var previews: some View {
    UserView(
      store: Store(
        initialState: UserReducer.State(user: .mock),
        reducer: UserReducer()
      )
    )
  }
}
