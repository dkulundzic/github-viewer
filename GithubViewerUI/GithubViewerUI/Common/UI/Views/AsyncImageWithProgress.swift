import SwiftUI

struct AsyncImageWithProgress: View {
  let url: URL
  let imageSize: CGFloat
  let onTap: Action?

  init(
    url: URL,
    imageSize: CGFloat,
    onTap: Action? = nil
  ) {
    self.url = url
    self.imageSize = imageSize
    self.onTap = onTap
  }

  var body: some View {
    AsyncImage(url: url) { image in
      image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .cornerRadius(16)
        .frame(width: imageSize, height: imageSize)
        .onTapGesture { onTap?() }
    } placeholder: {
      ProgressView()
        .frame(width: imageSize, height: imageSize)
    }
  }
}

struct AsyncImageWithProgress_Previews: PreviewProvider {
  static var previews: some View {
    AsyncImageWithProgress(
      url: URL(string: "https://avatars.githubusercontent.com/u/47359?v=4")!,
      imageSize: 50
    ) { }
  }
}
