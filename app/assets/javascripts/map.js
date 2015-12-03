function createMap(map_container) {
    var darkMap = [{
        "featureType": "all",
        "elementType": "labels.text.fill",
        "stylers": [{"color": "#ffffff"}]
    }, {
        "featureType": "all",
        "elementType": "labels.text.stroke",
        "stylers": [{"color": "#000000"}, {"lightness": 13}]
    }, {
        "featureType": "administrative",
        "elementType": "geometry.fill",
        "stylers": [{"color": "#000000"}]
    }, {
        "featureType": "administrative",
        "elementType": "geometry.stroke",
        "stylers": [{"color": "#144b53"}, {"lightness": 14}, {"weight": 1.4}]
    }, {"featureType": "landscape", "elementType": "all", "stylers": [{"color": "#08304b"}]}, {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [{"color": "#0c4152"}, {"lightness": 5}]
    }, {
        "featureType": "road.highway",
        "elementType": "geometry.fill",
        "stylers": [{"color": "#000000"}]
    }, {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [{"color": "#0b434f"}, {"lightness": 25}]
    }, {
        "featureType": "road.arterial",
        "elementType": "geometry.fill",
        "stylers": [{"color": "#000000"}]
    }, {
        "featureType": "road.arterial",
        "elementType": "geometry.stroke",
        "stylers": [{"color": "#0b3d51"}, {"lightness": 16}]
    }, {
        "featureType": "road.local",
        "elementType": "geometry",
        "stylers": [{"color": "#000000"}]
    }, {"featureType": "transit", "elementType": "all", "stylers": [{"color": "#146474"}]}, {
        "featureType": "water",
        "elementType": "all",
        "stylers": [{"color": "#021019"}]
    }];

    var handler = Gmaps.build('Google');
    var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';

    handler.buildMap({
            internal: {id: 'map'},
            provider: {
                zoom:      16,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                styles:    darkMap,
                disableDefaultUI: true
            }
        },
        function(){
            if(navigator.geolocation)
                navigator.geolocation.getCurrentPosition(function(position) {
                    var marker = handler.addMarker({
                        lat: position.coords.latitude,
                        lng: position.coords.longitude,
                        icon: 'http://plebeosaur.us/etc/map/bluedot_retina.png'
                    });
                    handler.map.centerOn(marker);
                });
        }
    );

    var input = document.getElementById('pac-input');
    var searchBox = new Gmaps.places.SearchBox(input);
    map.controls[Gmaps.ControlPosition.TOP_LEFT].push(input);
}

function displayOnMap(position){
    var marker = handler.addMarker({
        lat: position.coords.latitude,
        lng: position.coords.longitude
    });
    handler.map.centerOn(marker);
};
