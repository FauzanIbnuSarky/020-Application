//
//  karyawanTableViewController.swift
//  Data Karyawan
//
//  Created by muqorrobin aimar on 11/17/17.
//  Copyright © 2017 muqorrobin aimar. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class KaryawanTableViewController: UITableViewController {
    
    
    var idSelected:String?
    var namaSelected:String?
    var posisiSelected:String?
    var gajiSelected:String?
    var alamatSelected:String?
    var tanggalSelected:String?
    //  var gambarSelcetd:String?
    
    var karyawan = [Karyawan]()
    var arrKar = [[String: AnyObject]]()//array data karyawan
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //memanggil data json menggunakan alamofire
        Alamofire.request("http://localhost/Latihan/index.php/Api/getKaryawan").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.arrKar = resData as! [[String:AnyObject]]
                }
                if self.arrKar.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrKar.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "karyawan", for: indexPath) as! KaryawanTableViewCell
        
        // Configure the cell...
        var dict = arrKar[indexPath.row]
        cell.lblNama.text = dict["nama_employee"] as? String
        cell.lblPosisi.text = dict["posisi"] as? String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        print("Row \(indexPath.row)selected")
        
        let task = arrKar[indexPath.row]
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        idSelected = task["id_employee"] as? String
        //  gambarSelcetd = task["gambar"] as! String
        namaSelected = task["nama_employee"] as? String
        posisiSelected = task["posisi"] as? String
        gajiSelected = task["gaji"] as? String
        alamatSelected = task["alamat"] as? String
        tanggalSelected = task["tanggal_masuk"] as? String
        
        //memamnggil segue passDataDetail
        performSegue(withIdentifier: "passData", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak`
        if segue.identifier == "passData"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            //        let kirimData = segue.destination as! KontakViewController
            //mengirimkan data ke masing2 variable
            //mengirimkan nama wisata
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailDataViewController
                let value = arrKar[indexPath.row]
            
                controller.passId = value["id_employee"] as? String
                controller.passNama = value["nama_employee"] as? String
                controller.posisi = value["posisi"] as? String
                controller.gaji = value["gaji"] as? String
                controller.alamat = value["alamat"] as? String
                controller.tanggalMasuk = value["tanggal_masuk"] as? String
                // controller.passgambar = value["gambar"] as? UIImage
            }
        }
    }
}

