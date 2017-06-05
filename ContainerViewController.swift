import UIKit

enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
}

class ContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var centerViewController      : WorkoutSelectorVC!
    var archiveViewController     : WorkoutArchiveVC = WorkoutArchiveVC(style:UITableViewStyle.Grouped)
    var requestViewController     : WorkoutRequestVC = WorkoutRequestVC()
    var workoutTableController    : WorkoutTableVC   = WorkoutTableVC(style:UITableViewStyle.Grouped)
    var leftViewController        : SidePanelViewController?
    let centerPanelExpandedOffset : CGFloat       = 60
    var currentState              : SlideOutState = .BothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: viewDidLoad                                                                                                 //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the Workout Selector VC
        centerViewController = WorkoutSelectorVC()
        centerViewController.request          = self.requestViewController
        centerViewController.delegate         = self
        
        // Configure the Workout Table VC
        requestViewController.workoutTable    = self.workoutTableController
        requestViewController.workoutSelector = self.centerViewController
        requestViewController.delegate        = self
        
        // Configure the Workout Table VC
        workoutTableController.delegate       = self
        workoutTableController.request        = self.requestViewController
        
        // Configure the Workout Archive VC
        archiveViewController.delegate        = self
        archiveViewController.workoutTable    = self.workoutTableController
        
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        centerNavigationController.didMoveToParentViewController(self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: pushArchiveView                                                                                             //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func pushArchiveView() {
        //
        if centerNavigationController.topViewController !== archiveViewController {
            print("The Top VC is not the same take action")
            centerNavigationController.popToRootViewControllerAnimated(false)
            centerNavigationController.pushViewController(archiveViewController, animated: false)
            toggleLeftPanel()
        }
        //
        else {
            print("The top is button pressed so do nothing")
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: pushSelectorView                                                                                            //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func pushSelectorView() {
        if centerNavigationController.topViewController !== centerViewController {
            print("The top VC is not the same take action")
            centerNavigationController.popToRootViewControllerAnimated(false)
            toggleLeftPanel()
        }
        else {
             print("The top is button pressed so do nothing")
        }
       
    }
}

// MARK: CenterViewController delegate
extension ContainerViewController: WorkoutSelectorVCDelegate {
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: toggleLeftPanel                                                                                             //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: addLeftPanelViewController                                                                                  //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = SidePanelViewController(container: self)
            
            addChildSidePanelController(leftViewController!)
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: addChildSidePanelController                                                                                 //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: animateLeftPanel                                                                                            //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func animateLeftPanel(shouldExpand shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .BothCollapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: animateCenterPanelXPosition                                                                                 //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func animateCenterPanelXPosition(targetPosition targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: showShadowForCenterViewController                                                                           //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
}

// MARK: Gesture recognizer
extension ContainerViewController: UIGestureRecognizerDelegate {
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: handlePanGesture                                                                                            //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
            case .Changed:
                // Left Panel is showing drag the Center
                if (currentState == .LeftPanelExpanded) {
                    recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
                    recognizer.setTranslation(CGPointZero, inView: view)
                }
            case .Ended:
                if (leftViewController != nil) {
                    // animate the side panel open or closed based on whether the view has moved more or less than halfway
                    let hasMovedGreaterThanHalfway = gestureIsDraggingFromLeftToRight//recognizer.view!.center.x > view.bounds.size.width
                    animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
                }
            default:
                    break
        }
    }
    
}

