window.initMap = ->
  mapStyle = new (google.maps.StyledMapType)([
    {
      'featureType': 'administrative'
      'elementType': 'labels.text.fill'
      'stylers': [ { 'color': '#444444' } ]
    }
    {
      'featureType': 'landscape'
      'elementType': 'all'
      'stylers': [ { 'color': '#f2f2f2' } ]
    }
    {
      'featureType': 'poi'
      'elementType': 'all'
      'stylers': [ { 'visibility': 'off' } ]
    }
    {
      'featureType': 'road'
      'elementType': 'all'
      'stylers': [
        { 'saturation': -100 }
        { 'lightness': 45 }
      ]
    }
    {
      'featureType': 'road.highway'
      'elementType': 'all'
      'stylers': [ { 'visibility': 'simplified' } ]
    }
    {
      'featureType': 'road.arterial'
      'elementType': 'labels.icon'
      'stylers': [ { 'visibility': 'off' } ]
    }
    {
      'featureType': 'transit'
      'elementType': 'all'
      'stylers': [ { 'visibility': 'off' } ]
    }
    {
      'featureType': 'water'
      'elementType': 'all'
      'stylers': [
        { 'color': '#3498DB' }
        { 'visibility': 'on' }
      ]
    }
  ], name: 'Blue Water')
  mapStyleId = 'blue_water'

  map = new (google.maps.Map)(document.getElementById('map'),
    center:
      lat: 42.350
      lng: -71.108
    zoom: 16
    disableDefaultUI: true
    mapTypeControlOptions: mapTypeIds: [
      google.maps.MapTypeId.ROADMAP
      mapStyleId
    ])

  map.mapTypes.set mapStyleId, mapStyle
  map.setMapTypeId mapStyleId

  blueDot = new google.maps.MarkerImage(
    'http://plebeosaur.us/etc/map/bluedot_retina.png'
    null,
    null,
    new google.maps.Point( 8, 8 )
    new google.maps.Size( 17, 17 )
  )

  userMarker = new (google.maps.Marker)(
    flat: true
    icon: blueDot
    optimized: false
    visible: true
    position:
      lat: 42.350
      lng: -71.108
    map: map
    title: 'Your location'
  )

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition ((position) ->
      pos =
        lat: position.coords.latitude
        lng: position.coords.longitude
      map.setCenter pos
      userMarker.setPosition(pos)
      return
    ), ->
      handleLocationError true
      return
  else
    handleLocationError false
    return

  pickupMarker = new (google.maps.Marker)(
    map: null
    position: null
    draggable: true
  )

  geocoder = new (google.maps.Geocoder)

  map.addListener 'click', (e) ->
    pickupMarker.setMap(map)
    geocodeLatLng geocoder, map, e.latLng, pickupMarker
    return

  pickupMarker.addListener 'dragend', (e) ->
    geocodeLatLng geocoder, map, e.latLng, pickupMarker
    return

  userMarker.addListener 'click', (e) ->
    pickupMarker.setMap(map)
    geocodeLatLng geocoder, map, e.latLng, pickupMarker

  input = document.getElementById('pac-input')
  searchBox = new (google.maps.places.SearchBox)(input)
  map.controls[google.maps.ControlPosition.TOP_CENTER].push input

  map.addListener 'bounds_changed', ->
    searchBox.setBounds map.getBounds()
    return

  searchBox.addListener 'places_changed', ->
    places = searchBox.getPlaces()
    if places.length == 0
      return
    pickupLoc = places[0]
    pickupMarker.setMap map
    pickupMarker.setPosition pickupLoc.geometry.location
    pickupMarker.setTitle pickupLoc.name
    map.setCenter pickupLoc.geometry.location
    return

handleLocationError = (browserHasGeolocation) ->
  if browserHasGeolocation
    console.log('Error: The Geolocation service failed.')
  else
    console.log('Error: Your browser doesn\'t support geolocation')
  return

geocodeLatLng = (geocoder, map, latlng, marker) ->
  geocoder.geocode { 'location': latlng }, (results, status) ->
    if status == google.maps.GeocoderStatus.OK
      if results[1]
        marker.setPosition latlng
        marker.setTitle results[1].formatted_address
      else
        window.alert 'No results found'
    else
      window.alert 'Geocoder failed due to: ' + status
    return
  return

