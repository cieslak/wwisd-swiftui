import SwiftUI
import MapKit

#if os(iOS)
struct MapView: UIViewRepresentable {
    @Binding var foundIt: Bool
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let region = MKCoordinateRegion(.world)
        mapView.setRegion(region, animated: false)
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
        if !foundIt {
            let region = MKCoordinateRegion(.world)
            view.setRegion(region, animated: true)
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
}
#elseif os(macOS)
struct MapView: NSViewRepresentable {
    @Binding var foundIt: Bool

    func makeNSView(context: NSViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let region = MKCoordinateRegion(.world)
        mapView.setRegion(region, animated: false)
        return mapView
    }
    
    func updateNSView(_ view: MKMapView, context: NSViewRepresentableContext<MapView>) {
        if !foundIt {
            let region = MKCoordinateRegion(.world)
            view.setRegion(region, animated: true)
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
}
#endif

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if parent.foundIt {
            return
        }
        let lat = mapView.region.center.latitude
        let lon = mapView.region.center.longitude
        let delta = mapView.region.span.latitudeDelta
        if (lat > 32.0 && lat < 33.0) && (lon < -117.0 && lon > -118.0) && (delta < 1.2) {
            withAnimation {
                parent.foundIt = true
            }
        }
    }
}
