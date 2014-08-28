<?php
namespace ShouldIBike;

/**
 * Zip Geocoder model
 *
 * @author Ken Lauguico <me@kenlauguico.com>
 * @version 1.0
 * @package ShouldIBikeAPI
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
	$_latlng = $_GET['latlng'];
	$_request = 'http://maps.google.com/maps/api/geocode/json?latlng=' . $_latlng;

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
			case 'sublocality_level_1':
				$_city->name = $component['long_name'];
				break;
			case 'sublocality':
				$_city->name = $component['long_name'];
				break;
		}
	}

	return $_city;
}


function isUsingZip() {
	return ($_GET['zip'] != '');
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

	public function init_with_json_conditions($json) {
		$display_location = $json['current_observation']['display_location'];

		$this->name = $display_location['city'];
		$this->zip = $display_location['zip'];
		$this->lat = $display_location['latitude'];
		$this->lng = $display_location['longitude'];
	}
}

?>