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

  car = new google.maps.MarkerImage(
    'http://cliparts.co/cliparts/6ip/o6X/6ipo6XBMT.png'
    null,
    null,
    new google.maps.Point( 8, 8 )
    new google.maps.Size( 30, 30 )
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

  current =
    lat: 42.350
    lng: -71.108

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition ((position) ->
      current.lat = position.coords.latitude
      current.lng = position.coords.longitude
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

  window.pickupMarker = new (google.maps.Marker)(
    map: null
    position: null
    draggable: true
  )

  carMarkers = [
    [current.lat+.015, current.lng+.001, 'Car 1']
    [current.lat-.01, current.lng+.003, 'Car 2']
    [current.lat-.005, current.lng-.003, 'Car 3']
    [current.lat+.0005, current.lng+.005, 'Car 4']
    [current.lat+.003, current.lng+.003, 'Car 6']
    [current.lat+.002, current.lng-.01, 'Perry Donham']
  ]
  carLocation = new (google.maps.LatLng)(carMarkers[5][0], carMarkers[5][1])
  carMarker = new (google.maps.Marker)(
    map: map
    icon: car
    visible: true
    optimized: false
    position: new (google.maps.LatLng)(carMarkers[5][0], carMarkers[5][1])
    title: carMarkers[5][2]
  )
  i = 0
  while i < 5
    marker = new (google.maps.Marker)(
      map: map
      icon: car
      visible: true
      optimized: false
      position: new (google.maps.LatLng)(carMarkers[i][0], carMarkers[5][1])
      title: carMarkers[i][2]
    )
    i++

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

  carMarker.addListener 'click', (e) ->
    $('#order-form').show()

  $('#order-form div.order-close a').click ->
    $('#order-form').hide()

  $('button.order').click ->
    directionsService = new (google.maps.DirectionsService)
    directionsDisplay = new (google.maps.DirectionsRenderer)(
      preserveViewport: true
      suppressMarkers: true
    )
    directionsDisplay.setMap(map);
    polyline = new (google.maps.Polyline)(
      path: []
      strokeColor: '#3498DB'
      strokeWeight: 3)
    poly2 = new (google.maps.Polyline)(
      path: []
      strokeColor: '#3498DB'
      strokeWeight: 3)
    steps = []
    request =
      origin: carLocation
      destination: pickupMarker.position
      travelMode: google.maps.TravelMode.DRIVING
    directionsService.route request, (response, status) ->
      if status == google.maps.DirectionsStatus.OK
        directionsDisplay.setDirections(response);
        pathCoords = response.routes[0].overview_path
        route = new (google.maps.Polyline)(
          path: []
          geodesic: true
          strokeColor: '#FF0000'
          strokeOpacity: 0
          strokeWeight: 2
          editable: false
          map: map)
        i = 0
        while i < pathCoords.length
          setTimeout ((coords) ->
            route.getPath().push coords
            carMarker.setPosition coords
            return
          ),  2000 * i, pathCoords[i]
          i++
      return
    return

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
