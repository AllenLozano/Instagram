//
//  HomePageViewController.swift
//  Instagram
//
//  Created by Allen Lozano on 10/8/18.
//  Copyright © 2018 Allen Lozano. All rights reserved.
//
import UIKit
import Parse

class HomePageViewController: UIViewController{

    
    @IBOutlet weak var postTableView: UITableView!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postTableView.delegate = self as? UITableViewDelegate
        postTableView.dataSource = self as? UITableViewDataSource
        postTableView.rowHeight = UITableViewAutomaticDimension
        postTableView.estimatedRowHeight = 100
        
        //fetchPostsData()
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
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.indexPath = indexPath
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    cell.postImageView.image = UIImage(data: data!)
                }
            }
        }
        cell.captionLabel.text = post.caption
        return cell
    }
    @IBAction func logout(_ sender: Any) {
     
        PFUser.logOutInBackground { (error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    @IBAction func photoLibary(_ sender: Any) {

    self.performSegue(withIdentifier: "photoSegue", sender: nil)
    }
}
