import UIKit

public struct VoxAlert {
    
    static var shared = VoxAlert()
    
    var title: String? = "Alert title"
    
    var text: String = "Alert text"
    
    var image: UIImage? = nil
    
    lazy var alertView: VoxView = VoxView()
    
    weak var viewController: UIViewController? = nil
    
    var helper = AlertHelper()
    
    public private(set) var options: VoxOptions = VoxOptions()
    
    public init(options: VoxOptions) {
        self.options = options
    }
    
    public init() {
    }
    
    public static func show() {
        if let viewController = shared.getPresentingViewController() {
            
            shared.helper.makeFeedback(shared.options.hapticFeedback)

            shared.alertView = VoxView(alertType: shared.options.type ?? .system,
                                       title: shared.title,
                                       text: shared.text,
                                       customImage: shared.image)
                       
            shared.helper.setupPosition(for: shared.alertView, with: shared.options.position, on: viewController)
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
