import HotwireNative
import UIKit

private let hikesTab = HotwireTab(
    title: "Hikes",
    image: UIImage(systemName: "map")!,
    url: baseURL.appending(path: "hikes")
)

private let hikersTab = HotwireTab(
    title: "Hikers",
    image: UIImage(systemName: "figure.hiking")!,
    url: baseURL.appending(path: "users")
)

extension HotwireTab {
    static let all = [
        hikesTab,
        hikersTab
    ]
}
