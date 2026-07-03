import SwiftUI
import UIKit

public enum LiquidGlassHUDStyle {
    case loading
    case success
    case error
}

public struct LiquidGlassLoadingView: View {
    private let title: String?
    private let style: LiquidGlassHUDStyle

    public init(title: String? = nil, style: LiquidGlassHUDStyle = .loading) {
        self.title = title
        self.style = style
    }

    public var body: some View {
        ZStack {
            Color.black.opacity(0.08)
                .ignoresSafeArea()

            VStack(spacing: 14) {
                content
                    .font(.system(size: 28, weight: .semibold))

                if let title, !title.isEmpty {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 26)
            .padding(.vertical, 22)
            .background(GlassBackground(cornerRadius: 24))
        }
    }

    @ViewBuilder
    private var content: some View {
        switch style {
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.primary)
                .scaleEffect(1.15)
        case .success:
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
        case .error:
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.red)
        }
    }
}

@MainActor
public final class LiquidGlassHUD {
    private static var controllers = [ObjectIdentifier: UIHostingController<LiquidGlassLoadingView>]()

    public static func showLoading(in view: UIView, title: String? = nil) {
        show(in: view, title: title, style: .loading)
    }

    public static func showSuccess(in view: UIView, title: String, delay: TimeInterval = 2) {
        show(in: view, title: title, style: .success)
        dismiss(from: view, after: delay)
    }

    public static func showError(in view: UIView, title: String, delay: TimeInterval = 2) {
        show(in: view, title: title, style: .error)
        dismiss(from: view, after: delay)
    }

    public static func dismiss(from view: UIView) {
        let key = ObjectIdentifier(view)
        guard let hosting = controllers.removeValue(forKey: key) else { return }
        hosting.willMove(toParent: nil)
        hosting.view.removeFromSuperview()
        hosting.removeFromParent()
    }

    public static func dismiss(from view: UIView, after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            dismiss(from: view)
        }
    }

    private static func show(in view: UIView, title: String?, style: LiquidGlassHUDStyle) {
        dismiss(from: view)

        let hosting = UIHostingController(rootView: LiquidGlassLoadingView(title: title, style: style))
        hosting.view.backgroundColor = .clear
        hosting.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(hosting.view)
        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: view.topAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        controllers[ObjectIdentifier(view)] = hosting
    }
}

private struct GlassBackground: UIViewRepresentable {
    let cornerRadius: CGFloat

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
        view.layer.cornerCurve = .continuous
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.35).cgColor

        if #available(iOS 26.0, *) {
            let effect = UIGlassEffect(style: .regular)
            effect.isInteractive = true
            view.effect = effect
        } else {
            view.effect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        }

        return view
    }

    func updateUIView(_ view: UIVisualEffectView, context: Context) {}
}
