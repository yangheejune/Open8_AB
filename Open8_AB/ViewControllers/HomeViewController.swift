//
//  HomeViewController.swift
//  Open8_AB
//
//  Created by 양희준 on 2017. 7. 18..
//  Copyright © 2017년 양희준. All rights reserved.
//

import UIKit
import Segmentio

class HomeViewController: UIViewController {
    
    fileprivate var currentStyle = SegmentioStyle.onlyLabel
    fileprivate var containerViewController: EmbedContainerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: EmbedContainerViewController.self) {
            containerViewController = segue.destination as? EmbedContainerViewController
            containerViewController?.style = currentStyle
        }
    }

    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        SideMenuViewController.create().showSideMenu(
            viewController: self,
            currentStyle: currentStyle,
            sideMenuDidHide: { [weak self] style in
                self?.dismiss(
                    animated: false,
                    completion: {
                        if self?.currentStyle != style {
                            self?.currentStyle = style
                            self?.containerViewController?.swapViewControllers(style)
                        }
                }
                )
            }
        )
    }
}
