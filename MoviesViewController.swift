//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Javier Bustillo on 1/22/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var movies: [NSDictionary]?
    var endpoint: String!
    
   
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
     
        tableView.dataSource = self
        
       
        
        tableView.dataSource = self
        tableView.delegate = self
        loadDataFromNetwork()
        
        
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
        self.movies = (responseDictionary["results"] as! [NSDictionary])
                           
                            self.tableView.reloadData()
                            
                            
                            
        let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:"refreshControlAction:",forControlEvents: UIControlEvents.ValueChanged)
                self.tableView.insertSubview(refreshControl, atIndex: 0)
        
                   

              
                            
    

            
                    }
                }
        })
        task.resume()
  
        
        
        
        
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies{
            return movies.count
        }else{
            return 0
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCells", forIndexPath: indexPath) as! MovieCells
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String{
        let imageUrl = NSURL(string: baseUrl + posterPath)
        cell.posterView.setImageWithURL(imageUrl!)
        }
    
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
    
        cell.selectionStyle = .None
        print("row \(indexPath.row)")
        return cell
        
        
      
        
        }
    
    
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (data, response, error) in
                
                self.tableView.reloadData()
                
                
                refreshControl.endRefreshing()
        });
        task.resume()
    }
        
        func loadDataFromNetwork(){
           
            let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
            let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
            let request = NSURLRequest(URL: url!)
            
            let session = NSURLSession(
                configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
                delegate:nil,
                delegateQueue:NSOperationQueue.mainQueue()
            )
            
            
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
                completionHandler: { (data, response, error) in
                    
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    
                    
            });
            task.resume()
            
            
            
            }
    
    




     //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        let detailsViewController = segue.destinationViewController as! DetailsViewController
        detailsViewController.movie = movie
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}


