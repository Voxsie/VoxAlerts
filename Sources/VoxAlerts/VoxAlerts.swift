import UIKit

public struct VoxAlert {
    
    static var shared = VoxAlert()
    
    var title: String? = "Alert title"
    
    var text: String = "Alert text"
    
    var image: UIImage? = nil
    
    weak var viewController: UIViewController? = nil
    
    var helper = AlertHelper()
    
    public init() {
    }
    
    public static func show(title: String? = "Alert title", text: String = "Alert text", image: UIImage? = nil, with options: VoxOptions = VoxOptions()) {
        if let viewController = shared.getPresentingViewController() {

            let alertView = VoxView(alertType: options.type ?? .system,
                                       title: title,
                                       text: text,
                                       customImage: image)
                       
            shared.helper.makeAnimationFromBottom(for: alertView, with: options.position, on: viewController)
//            shared.helper.setupPosition(for: alertView, with: options.position, on: viewController)
//            
//            shared.helper.makeFeedback(options.hapticFeedback)
//            
//            shared.helper.makeAnimation(for: alertView, with: options.position, on: viewController)
        }
    }
    
    func getPresentingViewController() -> UIViewController? {
        guard let mainWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return nil
        }

        var presentingViewController = mainWindow.rootViewController
        while let nextPresentingViewController = presentingViewController?.presentedViewController {
            presentingViewController = nextPresentingViewController
        }

        return presentingViewController
    }
}
