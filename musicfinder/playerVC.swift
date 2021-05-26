//
//  playerVC.swift
//  musicfinder
//
//  Created by Santi Gracia on 9/7/19.
//  Copyright © 2019 Mixpanel. All rights reserved.
//

import Foundation
import UIKit

class playerVC : UIViewController {
    
    @IBOutlet weak var upgradeBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var allSongs : [Song] = [Song]()
    
    @IBAction func switchPlan(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "plan") == "Premium" {
            UserDefaults.standard.set("Free", forKey: "plan")
        }
        else {
            UserDefaults.standard.set("Premium", forKey: "plan")
        }
        checkPlan()
    }
    
    @IBAction func playSong(_ sender: Any) {
        let alert = UIAlertController(title: "Info", message: "Song Played", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buySong(_ sender: Any) {
        let alert = UIAlertController(title: "Info", message: "Bought Song", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        checkPlan()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
}


extension playerVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSongs.filter { $0.style == "classical" }.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") as! songCell
        cell.title.text = allSongs.filter { $0.style == "classical" }[indexPath.row].songTitle
        cell.author.text = allSongs.filter { $0.style == "classical" }[indexPath.row].songAuthor
        return cell
    }
}

extension playerVC {
    
    func checkPlan() {
        if UserDefaults.standard.string(forKey: "plan") == "Premium" {
            upgradeBtn.setTitle("DOWNGRADE", for: .normal)
        }
        else {
            upgradeBtn.setTitle("UPGRADE", for: .normal)
        }
    }

    func loadData() {
        // classical songs
        allSongs.append(Song(songTitle: "Air on the G String", songAuthor: "Johann Sebastian Bach", style: "classical", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Canon in D Major", songAuthor: "Johann Pachelbel", style: "classical", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Allegro Moderato", songAuthor: "Pyotr Ilyich Tchaikovsky", style: "classical", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Requiem: Lacrimosa", songAuthor: "Wolfgang Amadeus Mozart", style: "classical", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Salvation is Created", songAuthor: "Pavel Chesnokov", style: "classical", songPrice: 0.99))
        
        // electronic
        allSongs.append(Song(songTitle: "I'm Sorry", songAuthor: "Swell", style: "electronic", songPrice: 0.99))
        allSongs.append(Song(songTitle: "How Did I Get Here", songAuthor: "Odesza", style: "electronic", songPrice: 0.99))
        allSongs.append(Song(songTitle: "I Know There Gonna Be", songAuthor: "Jamie xx", style: "electronic", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Jasmine", songAuthor: "Jai Paul", style: "electronic", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Drop The Game", songAuthor: "Chet Faker", style: "electronic", songPrice: 0.99))
        
        // hip-hop
        allSongs.append(Song(songTitle: "Norf Norf", songAuthor: "Vince Staples", style: "hiphop", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Grown Up", songAuthor: "Danny Brown", style: "hiphop", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Street Knowledge", songAuthor: "Ghostface Killah", style: "hiphop", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Everything I Am", songAuthor: "Kanye West", style: "hiphop", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Root of All Evil", songAuthor: "Underachievers", style: "hiphop", songPrice: 0.99))
        
        // folk
        allSongs.append(Song(songTitle: "Fake Palindromes", songAuthor: "Andrew Bird", style: "folk", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Montezuma", songAuthor: "Fleet Foxes", style: "folk", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Late July", songAuthor: "Shakey Graves", style: "folk", songPrice: 0.99))
        allSongs.append(Song(songTitle: "We're All In This Together", songAuthor: "Old Crow Medicine Show", style: "folk", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Beggar In The Morning", songAuthor: "The Barr Brothers", style: "folk", songPrice: 0.99))
        
        // rock
        allSongs.append(Song(songTitle: "Hey", songAuthor: "The Pixies", style: "rock", songPrice: 0.99))
        allSongs.append(Song(songTitle: "D'yer Mak'er", songAuthor: "Led Zeppelin", style: "rock", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Whipping Post", songAuthor: "The Allman Brothers Band", style: "rock", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Rock the Casbah", songAuthor: "The Clash", style: "rock", songPrice: 0.99))
        allSongs.append(Song(songTitle: "Beast Of Burden", songAuthor: "The Rolling Stones", style: "rock", songPrice: 0.99))
    }
}
