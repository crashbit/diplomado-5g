

import UIKit

class TracksTableViewController: UITableViewController, UISearchBarDelegate {
    
    var tracks: [Track] = []
    
    let searchBarController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchBarController.dimsBackgroundDuringPresentation = true
        
        searchBarController.searchBar.delegate = self
        
        
        
        
        getTracks(cadena: "")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tracks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)

        let track = tracks[indexPath.row]
        
        cell.textLabel?.text = track.trackName

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func getTracks(cadena: String){
        let url = URL(string: "https://itunes.apple.com/search?term=\(cadena)")

        let jsonDecoder = JSONDecoder()

        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
           
            if (error != nil){
                print(error?.localizedDescription)
            }
            
            if let data = data, let tracksList = try? jsonDecoder.decode(ResultsSearch.self, from: data){
                for track in tracksList.results{
                    print(track.trackName)
                }
                
                self.tracks = tracksList.results
                
                DispatchQueue.main.async { // Correct
                   self.tableView.reloadData()
                }
                
            }
        }
        task.resume()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 4{
            getTracks(cadena: searchText)
        }
    }
    
    
    
    

}
