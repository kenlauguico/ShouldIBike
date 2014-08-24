<?php

function getCityDetailsFromZip() {
	$zip = $_GET['zip'];
	$request = 'http://maps.google.com/maps/api/geocode/json?sensor=false&address=' . $zip;
 	$stream = file_get_contents($request);
 	$json = json_decode($stream,true);
	$city_raw = $json['results'][0];

	$_city = new City;

	$_city->lat = $city_raw['geometry']['location']['lat'];
	$_city->lng = $city_raw['geometry']['location']['lng'];

	foreach($city_raw['address_components'] as $component) {
		switch($component['types'][0]) {
			case 'postal_code':
				$_city->zip = $component['long_name'];
				break;
			case 'locality':
				$_city->name = $component['long_name'];
				break;
		}
	}

	return $_city;
}


// Classes & Objects

class City {
	var $name;
	var $zip;
	var $lat;
	var $lng;

	public function get_array() {
		$array = array();
		$array['name'] = $name;
		$array['zip'] = $zip;
		$array['lat'] = $lat;
		$array['lng'] = $lng;

		return $array;
	}
}

?>