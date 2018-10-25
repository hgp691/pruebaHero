//
//  MapViewController.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/24/18.
//  Copyright © 2018 hero. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    var venuesViewModel: VenuesViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.venuesViewModel = VenuesViewModel()
        
        self.title = "Map"
        
        self.map.delegate = self
        self.map.showsUserLocation = true
        
        self.venuesViewModel.initialLoad(completion: {[weak self] (error) in
            DispatchQueue.main.async {
                self?.renderVenues()
            }
        })
        
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

}

//MARK: MapKit
extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if #available(iOS 11.0, *) {
            var annotationView = MKMarkerAnnotationView()
            guard let annotation = annotation as? LocationAnnotation else {return nil}
            let identifier = "pru"
            if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                annotationView = dequedView
            } else{
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            annotationView.markerTintColor = Theme.mainColor
            if let imag = CategoriesService.shared.imageForId(id: annotation.categorieId){
                annotationView.glyphImage = imag
            }else{
                let urlString = CategoriesService.shared.imageUrlForId(id: annotation.categorieId)
                if urlString.isEmpty{
                    print("Camara broken para la categoria: \(annotation.categorieId)")
                    annotationView.glyphImage = UIImage(named: "camerabroken")!
                }else{
                    
                    NetworkService.loadImageByURL(url: urlString) { (imagen) in
                        annotationView.glyphImage = imagen
                    }
                    
                }
            }
            annotationView.clusteringIdentifier = identifier
            return annotationView
        } else {
            // Fallback on earlier versions
            return nil
        }
        
    }
    
    func renderVenues(){
        let allAnotations = self.map.annotations
        self.map.removeAnnotations(allAnotations)
        
        let annotations = self.venuesViewModel.venues.map { (venue) -> LocationAnnotation in
            return LocationAnnotation(venue: venue)
        }
        
        map.addAnnotations(annotations)
        
        self.map.showAnnotations(self.map.annotations, animated: true)
        
        
    }
    
}
