import UIKit

public struct VoxAlert {
    
    static var shared = VoxAlert()
    
<<<<<<< Updated upstream
    public private(set) var options: VoxOptions = VoxOptions(type: .success, hapticFeedbak: .success, position: .bottom)
=======
    lazy var alertView: VoxView = VoxView()
    
    weak var viewController: UIViewController? = nil
    
    var helper = AlertHelper()
    
    public private(set) var options: VoxOptions = VoxOptions(type: .success, hapticFeedback: .success, position: .bottom)
>>>>>>> Stashed changes
    
    public init(options: VoxOptions) {
        self.options = options
    }
    
    public init() {
    }
    
    public static func show() {
<<<<<<< Updated upstream
        if let vc = shared.getPresentingViewController() {
            let alertView = VoxView(alertType: shared.options.type ?? .success, title: "2323", text: "23233")
            vc.view.addSubview(alertView)
            alertView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                alertView.topAnchor.constraint(equalTo: vc.view.topAnchor),
                alertView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
                alertView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
                alertView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor)
            ])
=======
        if let viewController = shared.getPresentingViewController() {
            
            shared.helper.makeFeedback(shared.options.hapticFeedback)
            
            shared.alertView = VoxView(alertType: shared.options.type ?? .system, title: "2323", text: "23233")
            
            shared.helper.setupPosition(for: shared.alertView, with: .bottom, on: viewController)
            


>>>>>>> Stashed changes
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
    
    static func hide() {
//        if let viewController = shared.getPresentingViewController() {
//            shared.alertView.alpha = 0
//        }
    }
}
