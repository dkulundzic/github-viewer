import Foundation
import GithubViewerModel

struct RepositoriesSearchResponse: Decodable {
  let items: [Repository]
}
