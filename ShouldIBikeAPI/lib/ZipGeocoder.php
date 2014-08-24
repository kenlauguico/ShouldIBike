<?php
namespace ShouldIBike;

/**
 * Zip Geocoder model
 *
 * @author Ken Lauguico <me@kenlauguico.com>
 * @version 1.0
 * @package SHouldIBikeAPI
 */


function getCityDetailsFromZip() {
	$_zip = $_GET['zip'];
	$_request = 'http://maps.google.com/maps/api/geocode/json?sensor=false&address=' . $_zip;

	$_city_raw = getArrayFromJSONFile($_request)['results'][0];

	$_city = new City;

	$_city->lat = $_city_raw['geometry']['location']['lat'];
	$_city->lng = $_city_raw['geometry']['location']['lng'];

	foreach($_city_raw['address_components'] as $component) {
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

function getCityDetailsFromLatLng() {
	//http://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&result_type=locality|postal_code
}

function getArrayFromJSONFile($_url) {
	$_stream = file_get_contents($_url);
 	$_array = json_decode($_stream,true);
 	return $_array;
}


// Classes

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