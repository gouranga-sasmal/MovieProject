//
//  BaseViewController.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    /// Get the ViewController from storyboard
    /// - Parameter storyboard: Storyboard name
    /// - Returns: ViewController
    ///
    ///       // Call this function like below
    ///       let vc: AMLoginViewController? = self.getViewController(from: StoryBoard.main)
    func getViewController<T: UIViewController>(from storyboard: StoryBoard) -> T? {
        let storyBoard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: String(describing: T.self))
        return vc as? T
    }
    
    /// Get the ViewController from storyboard
    /// - Parameter storyboard: Storyboard name
    /// - Returns: ViewController
    ///
    ///       // Call this function like below
    ///       let vc: AMLoginViewController? = self.getViewController(from: StoryBoard.main)
    func getViewController<T: UIViewController, U: UIViewController>(subClassOf vc: U.Type) -> T {
        let vc = T.init(nibName: String(describing: U.self), bundle: nil)
        return vc
    }

}
