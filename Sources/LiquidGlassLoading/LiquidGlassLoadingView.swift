import SwiftUI
import UIKit

public struct LiquidGlassLoadingView: View {
    private let title: String?

    public init(title: String? = nil) {
        self.title = title
    }

    public var body: some View {
        ZStack {
            Color.black.opacity(0.08)
                .ignoresSafeArea()

            VStack(spacing: 14) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.primary)
                    .scaleEffect(1.15)

                if let title, !title.isEmpty {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.primary)
                }
            }
            .padding(.horizontal, 26)
            .padding(.vertical, 22)
            .background(GlassBackground(cornerRadius: 24))
        }
    }
}

private struct GlassBackground: UIViewRepresentable {
    let cornerRadius: CGFloat

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
        view.layer.cornerCurve = .continuous
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.35).cgColor
        return view
    }

    func updateUIView(_ view: UIVisualEffectView, context: Context) {}
}
