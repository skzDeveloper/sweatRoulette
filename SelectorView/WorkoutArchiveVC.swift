//
//  WorkoutArchiveVC.swift
//  SelectorView
//
//  Created by Saad Omar on 6/1/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit
import CoreData

class WorkoutArchiveVC: UITableViewController {
    
    var delegate : WorkoutSelectorVCDelegate?
    var rows     : Int      = 0
    var archives :[String]? = nil
    
    let archiveCellID: String = "ArchiveCell"

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewDidLoad                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the Navigation Bar
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0.0, green: 0.20, blue: 0.20, alpha: 1.0)
        //print("The navigation bar height is \(self.navigationController?.navigationBar.bounds.height)")
        
        //Set the Logo on the navigation bar
        let image = UIImage(named: "SweatRouletteLogo")
        let LOGO_HEIGHT = (self.navigationController?.navigationBar.bounds.height)! * 0.90
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: LOGO_HEIGHT))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        navigationItem.titleView = imageView
        
        //Set Hamburger Icon Button on Right Navigation Bar
        let hamburgerButton: UIButton = UIButton()
        hamburgerButton.setImage(UIImage(named: "HamburgerIcon"), forState: .Normal)
        hamburgerButton.frame = CGRectMake(0, 0, 20, 20)
        hamburgerButton.addTarget(self, action: "slideNavigation:", forControlEvents: .TouchDown)
        let leftItem:UIBarButtonItem = UIBarButtonItem()
        leftItem.customView = hamburgerButton
        self.navigationItem.leftBarButtonItem = leftItem
        
        let hv: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        hv.backgroundColor = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        let hLabel: UILabel = UILabel(frame: CGRectInset(hv.bounds, 5, 5))
        hLabel.text = "Archives"
        hLabel.textAlignment = .Center
        hLabel.textColor = UIColor(colorLiteralRed: 0.0, green: 0.20, blue: 0.20, alpha: 1.0)
        hv.addSubview(hLabel)
        self.tableView.tableHeaderView = hv
        
        tableView.registerNib(UINib(nibName: "ArchiveCell", bundle: nil), forCellReuseIdentifier: "ArchiveCell")

    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
       
        let fetchRequest:NSFetchRequest = WorkoutCD.fetchRequest()
        
        do {
            let appDelegate    : AppDelegate            = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext : NSManagedObjectContext = appDelegate.managedObjectContext
            let serchResults = try managedContext.executeFetchRequest(fetchRequest)
            
            self.rows = serchResults.count
            
            if self.rows > 1 {
                self.archives = [String] ()
                for result in serchResults as! [WorkoutCD] {
                    self.archives!.append(result.title!)
                }
            }
            else {
                self.rows = 0
            }
        }
        catch
        {
            print("The Fetch Failed")
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: slideNavigation                                                                                                      //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func slideNavigation (sender: UIButton) {
        //print("Slide Navigation Time")
        //delegate?.toggleLeftPanel?()
        if (delegate != nil) {
            delegate?.toggleLeftPanel!()
        }
        else {
            //print("delegate is nil")
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: didReciveMemoryWarning                                                                                               //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: numberOfSectionsInTableView                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: numberOfRowsInSection                                                                                                //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.rows
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ArchiveCell = tableView.dequeueReusableCellWithIdentifier(archiveCellID, forIndexPath: indexPath) as! ArchiveCell
        
        if let archiveArray : [String] = self.archives {
            cell.archiveTitle.text = archiveArray[indexPath.row]
        }
        
        return cell
    }

}
