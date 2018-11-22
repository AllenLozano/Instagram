//
//  HomePageViewController.swift
//  Instagram
//
//  Created by Allen Lozano on 10/8/18.
//  Copyright © 2018 Allen Lozano. All rights reserved.
//
import UIKit
import Parse

class HomePageViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var postTableView: UITableView!
    var posts: [Post] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchPostsData), for: .valueChanged)
        postTableView.insertSubview(refreshControl, at: 0)
        
        postTableView.delegate = self as UITableViewDelegate
        postTableView.dataSource = self as UITableViewDataSource
        postTableView.rowHeight = 400
        
        fetchPostsData()
        postTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.indexPath = indexPath
        if let imageFile: PFFile = post.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    cell.postImageView.image = UIImage(data: data!)
                }
            }
        }
        let time = post.createdAt?.description
        cell.createdAtLabel.text = time
        cell.authorLabel.text = PFUser.current()?.username
        if cell.captionLabel == nil
        {
            cell.captionLabel.text = "Default caption."
        }
        else{
            cell.captionLabel.text = post.caption
        }
        //cell.captionLabel.text = post.caption
        return cell
    }
    
    @objc func fetchPostsData() {
        // Create New PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("createdAt")
        query?.includeKey("caption")
        query?.limit = 20
        
        // Fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts, error) in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.postTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            else {
                print(error.debugDescription)
            }
        })
    }
    @IBAction func logout(_ sender: Any) {
     
        PFUser.logOutInBackground { (error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        fetchPostsData()
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        
    }
    @IBAction func photoLibary(_ sender: Any) {

    self.performSegue(withIdentifier: "photoSegue", sender: nil)
    }
  
    
}
