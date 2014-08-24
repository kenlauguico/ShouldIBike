<?php

require_once 'lib/SimpleNWS.php';
require_once 'lib/ShouldIBikeModel.php';
require_once 'lib/ZipGeocoder.php';

$city = ShouldIBike\getCityDetailsFromZip();
$lat = $city->lat;
$long = $city->lng;


// instantiate the library
$simpleNWS = new SimpleNWS\SimpleNWS($lat, $long);

try
{
    $forecast = $simpleNWS->getForecastForWeek();

	// Get current weather conditions
	$weather_hour_now = new ShouldIBike\WeatherHourNow;
	$weather_hour_now->temp_in_fahrenheit = array_values($forecast->getHourlyRecordedTemperature())[0];
	$weather_hour_now->timestamp = ShouldIBike\getTimestampHoursFromNow(0);
	$weather_hour_now->weather_condition = array_values($forecast->getWeatherConditions())[0]['weather_type'];


	// Get next ten hour weather conditions
	$hour_limit = 6;
	$ten_hours = array();

	for ($i = 0; $i <= $hour_limit; $i++) {
		$weather_hour = new ShouldIBike\WeatherHour();
		$weather_hour->temp_in_fahrenheit = array_values($forecast->getHourlyRecordedTemperature())[$i];
		$weather_hour->timestamp = ShouldIBike\getTimestampHoursFromNow($i*3);
		$weather_hour->weather_condition = array_values($forecast->getWeatherConditions())[$i]['weather_type'];

		array_push($ten_hours, $weather_hour);
	}

	$nextTenHours = new ShouldIBike\NextTenHours();
	$nextTenHours->init($weather_hour_now, $ten_hours);


	// Print bike answer as JSON
	$answer_type = ShouldIBike\getShouldBikeAnswerType($nextTenHours);
	$answer_json = ShouldIBike\getShouldBikeAnswerJSON($city, $answer_type, $nextTenHours);
	header('Content-Type: application/json; charset=UTF-8', true);
	echo $answer_json;
}
catch (\Exception $error)
{
    echo $error->getMessage();
}

?>