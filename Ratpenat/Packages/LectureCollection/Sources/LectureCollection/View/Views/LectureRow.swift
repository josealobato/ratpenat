import SwiftUI

struct LectureRow: View {

    var title: String
    var subTitle: String
    var imageName: String
    var isStacked: Bool
    var timesPlayed: Int

    private let handlers: ActionHandlers = .init()

    let font = Font.system(size: 14)

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .scaledToFit()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                if !subTitle.isEmpty {
                    Text(subTitle)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        .lineLimit(4)
                }


            }
            Spacer()
            VStack {
                if isStacked {
                    Image(systemName: "play.square.stack")
                }
                if timesPlayed > 0 {
                    HStack(spacing: 2) {
                        Image(systemName: "play.fill").font(font)
                        Text("\(timesPlayed)").font(font)
                    }
                    .padding(.top, 4)
                }
            }
        }
        .swipeActions(edge: .trailing) {
            if isStacked {
                Button { dequeue() } label: {
                    Label(LocalizationKey.dequeue.localize(),
                          systemImage: "rectangle.stack.badge.minus")
                }
                .tint(.red)
            } else {
                Button { enqueue() } label: {
                    Label(LocalizationKey.enqueue.localize(),
                          systemImage: "rectangle.stack.badge.plus")
                }
                .tint(.green)
            }
        }
        .swipeActions(edge: .trailing) {
            Button { play() } label: {
                Label(LocalizationKey.play.localize(),
                      systemImage: "play")
            }
            .tint(.blue)
        }
        .swipeActions(edge: .leading) {
            Button { delete() } label: {
                Label(LocalizationKey.delete.localize(),
                      systemImage: "trash")
            }
            .tint(.red)
        }
        .contextMenu {

            if isStacked {
                Button { dequeue() } label: {
                    Label(LocalizationKey.dequeue.localize(),
                          systemImage: "rectangle.stack.badge.minus")
                }
            } else {
                Button { enqueue() } label: {
                    Label(LocalizationKey.enqueue.localize(),
                          systemImage: "rectangle.stack.badge.plus")
                }
            }
            Button { play() } label: {
                Label(LocalizationKey.play.localize(),
                      systemImage: "play")
            }

            Divider()
            Button(role: .destructive) { delete() } label: {
                Label(LocalizationKey.delete.localize(),
                      systemImage: "trash")
            }
        }
    }

    // MARK: - Actions
    
    public func onPlay(_ action: @escaping (() -> Void)) -> Self {
        handlers.onPlay = action
        return self
    }

    public func onEnqueue(_ action: @escaping (() -> Void)) -> Self {
        handlers.onEnqueue = action
        return self
    }

    public func onDequeue(_ action: @escaping (() -> Void)) -> Self {
        handlers.onDequeue = action
        return self
    }

    public func onDelete(_ action: @escaping (() -> Void)) -> Self {
        handlers.onDelete = action
        return self
    }
}

private class ActionHandlers {

    var onPlay: (() -> Void)?
    var onEnqueue: (() -> Void)?
    var onDequeue: (() -> Void)?
    var onDelete: (() -> Void)?
}

private extension LectureRow {

    func play() {
        handlers.onPlay?()
    }

    func enqueue() {
        handlers.onEnqueue?()
    }

    func dequeue() {
        handlers.onDequeue?()
    }

    func delete() {
        handlers.onDelete?()
    }
}

struct LectureRow_Previews: PreviewProvider {
    static var previews: some View {
        let basicRow1 = LectureRow(title: "Egypt rivers",
                                   subTitle: "In all their glory",
                                   imageName: "pin",
                                   isStacked: false,
                                   timesPlayed: 3)
            .onPlay { print("onPlay") }
            .onDelete { print("onDelete") }
            .onEnqueue { print("onEnqueue") }
        let basicRow2 = LectureRow(title: "The best book ever written",
                                   subTitle: "It is about love of course",
                                   imageName: "book.closed",
                                   isStacked: false,
                                   timesPlayed: 34)

        let basicRow3 = LectureRow(title: "The best book ever written",
                                   subTitle: "",
                                   imageName: "book.closed",
                                   isStacked: false,
                                   timesPlayed: 25)
        Group {
            List {
                basicRow1
                    .previewDisplayName("Short title")

                basicRow2
                    .previewDisplayName("Long Row")
                basicRow3
                    .previewDisplayName("No Subtitle")
            }
            .listStyle(.plain)
            
//            .preferredColorScheme(.dark)
        }
    }
}
