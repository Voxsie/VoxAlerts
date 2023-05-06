import UIKit

public struct VoxAlert {
    
    static var shared = VoxAlert()
    
    weak var viewController: UIViewController? = nil
    
    var helper = AlertHelper()
    
    public private(set) var options: VoxOptions = VoxOptions(type: .success, hapticFeedback: .success, position: .bottom)
    
    public init(options: VoxOptions) {
        self.options = options
    }
    
    public init() {
    }
    
    public static func show() {
        if let viewController = shared.getPresentingViewController() {
            
            shared.helper.makeFeedback(shared.options.hapticFeedback)
            
            let alertView = VoxView(alertType: shared.options.type ?? .system, title: "2323", text: "23233")
            viewController.view.addSubview(alertView)
            alertView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                alertView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
                alertView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
                alertView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
            ])
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
