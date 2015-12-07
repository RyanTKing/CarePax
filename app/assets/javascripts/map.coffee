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
    'http://cnsmaryland.org/interactives/Uber/uberXicon.png'
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

  pickupMarker = new (google.maps.Marker)(
    map: null
    position: null
    draggable: true
  )

  cOneInventory = '<div id="content">'+
      '<div id="siteNotice">'+
      '</div>'+
      '<h1>Perry Donham</h1>'+ '<img style = "display: inline" src="https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/2/000/01b/2aa/25ceac4.jpg">' + '<h2>Item Inventory</h2>'+
      '<div id="bodyContent">'+
      '<h3 style = "display: inline">Puff Ball Mushroom: 4</h3>'+ '<h4><a>Order Now!</a></h4>'+ '<img src = "http://thumbs.dreamstime.com/x/puff-ball-mushroom-8667256.jpg">'+ '</br>' + '</br>' + '<h3 style = "display: inline"><b>Yellow Lab: 1</h3> </p>' + '<h4 style = "display: inline"><a>Order Now!</a></h4>' + '</br>' + '<img src = "http://petcaregt.com/blog/wp-content/uploads/2008/11/orvis_yellow_labrador_retriever_01_w450.jpg">' + '</br>' + 
      '</div>'+
      '</div>'

  cOneWindow = new google.maps.InfoWindow (
    content: cOneInventory
  )

  cOneLocation = new (google.maps.LatLng)(current.lat+.0015, current.lng+.001)
  carOne = new (google.maps.Marker)(
    map: map
    icon: car
    visible: true
    optimized: false
    position: cOneLocation
    title: 'Car One'
  )

  cTwoInventory = '<div id="content">'+
      '<div id="siteNotice">'+
      '</div>'+
      '<h1>Driving Doug</h1>'+ '<img style = "display: inline" src="http://s.hswstatic.com/gif/safe-driving-tips1.jpg">' + '<h2>Item Inventory</h2>'+
      '<div id="bodyContent">'+
      '<h3 style = "display: inline">Toothpaste: 20</h3>'+ '<h4><a>Order Now!</a></h4>'+ '<img src = "http://www.moneysavingmadness.com/wp-content/uploads/2013/04/Crest-Pro-Health-toothpaste.jpg">'+ '</br>' + '</br>' + '<h3 style = "display: inline"><b>BandAid: 6</h3> </p>' + '<h4 style = "display: inline"><a>Order Now!</a></h4>' + '</br>' + '<img src = "http://www.medonthego.com/thumbnail.asp?file=assets/images/ab2215.jpg&maxx=500&maxy=0">' + '</br>' + 
      '</div>'+
      '</div>'

  cTwoWindow = new google.maps.InfoWindow (
    content: cTwoInventory
  )

  cTwoLocation = new (google.maps.LatLng)(current.lat-.0015, current.lng+.003)
  carTwo = new (google.maps.Marker)(
    map: map
    icon: car
    visible: true
    optimized: false
    position: cTwoLocation
    title: 'Car Two'
  )

  cThreeInventory = '<div id="content">'+
      '<div id="siteNotice">'+
      '</div>'+
      '<h1>Red Light Rick</h1>'+ '<img style = "display: inline" src="http://2paragraphs.com/wp-content/uploads/2014/09/Matthew-McConaughey-Lincoln.jpg">' + '<h2>Item Inventory</h2>'+
      '<div id="bodyContent">'+
      '<h3 style = "display: inline">Cotton Swabs: 1</h3>'+ '<h4><a>Order Now!</a></h4>'+ '<img src = "http://pics2.ds-static.com/prodimg/162353/300.jpg">'+ '</br>' + '</br>' + '<h3 style = "display: inline"><b>Mouth Wash: 3</h3> </p>' + '<h4 style = "display: inline"><a>Order Now!</a></h4>' + '</br>' + '<img src = "http://pics1.ds-static.com/prodimg/15711/300.jpg">' + '</br>' + 
      '</div>'+
      '</div>'

  cThreeWindow = new google.maps.InfoWindow (
    content: cThreeInventory
  )

  cThreeLocation = new (google.maps.LatLng)(current.lat-.0001, current.lng-.003)
  carThree= new (google.maps.Marker)(
    map: map
    icon: car
    visible: true
    optimized: false
    position: cThreeLocation
    title: 'Car Three'
  )

  cFourInventory = '<div id="content">'+
      '<div id="siteNotice">'+
      '</div>'+
      '<h1>Traffic Ticket Tim</h1>'+ '<img style = "display: inline" src="http://www.defensivedrivingsolutions.com/wp-content/uploads/2011/10/traffic-school.gif">' + '<h2>Item Inventory</h2>'+
      '<div id="bodyContent">'+
      '<h3 style = "display: inline">Toilet Paper: 30</h3>'+ '<h4><a>Order Now!</a></h4>'+ '<img src = "http://happymoneysaver.com/wp-content/uploads/2011/11/scott-toilet-paper1.jpg">'+ '</br>' + '</br>' + '<h3 style = "display: inline"><b>Pencils: 3</h3> </p>' + '<h4 style = "display: inline"><a>Order Now!</a></h4>' + '</br>' + '<img src = "http://ecx.images-amazon.com/images/I/71EdfZBsztL._SY355_.jpg">' + '</br>' + 
      '</div>'+
      '</div>'

  cFourWindow = new google.maps.InfoWindow (
    content: cFourInventory
  )

  cFourLocation = new (google.maps.LatLng)(current.lat-.003, current.lng+.005)
  carFour= new (google.maps.Marker)(
    map: map
    icon: car
    visible: true
    optimized: false
    position: cFourLocation
    title: 'Car Four'
  )

  cFiveInventory = '<div id="content">'+
      '<div id="siteNotice">'+
      '</div>'+
      '<h1>Steering Wheel Stacy</h1>'+ '<img style = "display: inline" src="http://www.drivers.com/img/articles/976_woman_turning_wheel.jpg">' + '<h2>Item Inventory</h2>'+
      '<div id="bodyContent">'+
      '<h3 style = "display: inline">Batteries: 10 AA, 15 AAA</h3>'+ '<h4><a>Order Now!</a></h4>'+ '<img src = "http://blog.codinghorror.com/content/images/uploads/2008/03/6a0120a85dcdae970b0128777030bf970c-pi.jpg">'+ '</br>' + '</br>' + '<h3 style = "display: inline"><b>Deoderant: 7</h3> </p>' + '<h4 style = "display: inline"><a>Order Now!</a></h4>' + '</br>' + '<img src = "http://pics2.ds-static.com/prodimg/11804/300.jpg">' + '</br>' + 
      '</div>'+
      '</div>'

  cFiveWindow = new google.maps.InfoWindow (
    content: cFiveInventory
  )
  cFiveLocation = new (google.maps.LatLng)(current.lat+.00001, current.lng-.01)
  carFive= new (google.maps.Marker)(
    map: map
    icon: car
    visible: true
    optimized: false
    position: cFiveLocation
    title: 'Car Five'
  )

  cSixInventory = '<div id="content">'+
      '<div id="siteNotice">'+
      '</div>'+
      '<h1>Merging Maggie</h1>'+ '<img style = "display: inline" src="http://fooyoh.com/files/attach/images/591/568/685/004/angry-woman-driver.jpg">' + '<h2>Item Inventory</h2>'+
      '<div id="bodyContent">'+
      '<h3 style = "display: inline">Tylenol: 12</h3>'+ '<h4><a>Order Now!</a></h4>'+ '<img src = "http://www.jenkinschiroandwellness.com/wp-content/uploads/2015/04/tylenol.jpg">'+ '</br>' + '</br>' + '<h3 style = "display: inline"><b>Candy: 4</h3> </p>' + '<h4 style = "display: inline"><a>Order Now!</a></h4>' + '</br>' + '<img src = "http://www.mms.com/Resources/img/nutrition/im-mms.png">' + '</br>' + 
      '</div>'+
      '</div>'

  cSixWindow = new google.maps.InfoWindow (
    content: cSixInventory
  )
  cSixLocation = new (google.maps.LatLng)(current.lat+.0003, current.lng+.003)
  carSix = new (google.maps.Marker)(
    map: map
    icon: car
    visible: true
    optimized: false
    position: cSixLocation
    title: 'Car Six'
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
  
  carOne.addListener 'click', (e) ->
    cOneWindow.open(map,carOne)

  carTwo.addListener 'click', (e) ->
    cTwoWindow.open(map,carTwo)
  
  carThree.addListener 'click', (e) ->
    cThreeWindow.open(map,carThree)

  carFour.addListener 'click', (e) ->
    cFourWindow.open(map,carFour)
  
  carFive.addListener 'click', (e) ->
    cFiveWindow.open(map,carFive)

  carSix.addListener 'click', (e) ->
    cSixWindow.open(map,carSix)

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

