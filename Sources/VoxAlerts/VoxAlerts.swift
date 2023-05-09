import UIKit

public struct VoxAlert {
    
    static var shared = VoxAlert()
    
    var title: String? = "Alert title"
    
    var text: String = "Alert text"
    
    var image: UIImage? = nil
    
    weak var viewController: UIViewController? = nil
    
    public init() {
    }
    
    public static func show(title: String? = "Alert title", text: String = "Alert text", image: UIImage? = nil, with options: VoxOptions = VoxOptions()) {
        if let viewController = shared.getPresentingViewController() {
            

            let alertView = VoxView(options: options,
                                       title: title,
                                       text: text,
                                       customImage: image)
            
            var helper = AlertHelper(alertView: alertView, position: options.position, viewController: viewController)
            
            helper.setupPosition()
//            
            helper.makeFeedback(options.hapticFeedback)
//
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                helper.makeAnimation()
            }
            
            let timeForDismiss = options.duration.getTime()
            if timeForDismiss > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + timeForDismiss) {
                    helper.dismissAlert()
                }
            }
   
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
