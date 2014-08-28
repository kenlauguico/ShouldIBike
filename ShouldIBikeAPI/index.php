<?php
namespace ShouldIBike;

/**
 * ShouldIBike API - Wrapper around wunderground
 *
 * @author Ken Lauguico <me@kenlauguico.com>
 * @version 1.0
 * @package ShouldIBikeAPI
 */

require_once 'lib/ShouldIBikeModel.php';
require_once 'lib/ZipGeocoder.php';


$conditions_json = getConditionsJSON();
$hourly_json = getHourlyJSON();

$city = new City;
$city->init_with_json_conditions($conditions_json);


// Get current weather conditions
$weather_hour_now = new WeatherHourNow;
$weather_hour_now->init_with_json_conditions($conditions_json);


// Get next ten hour weather conditions
$hour_limit = 10;
$ten_hours = array();

for ($i = 0; $i < $hour_limit; $i++) {
	$current_hour = $hourly_json['hourly_forecast'][$i];

	$weather_hour = new WeatherHour();
	$weather_hour->init_with_json_forecast_hour($current_hour);

	array_push($ten_hours, $weather_hour);
}

$nextTenHours = new NextTenHours();
$nextTenHours->init($weather_hour_now, $ten_hours);


// Print bike answer as JSON
$answer_type = getShouldBikeAnswerType($nextTenHours);
$answer_json = getShouldBikeAnswerJSON($city, $answer_type, $nextTenHours);
header('Content-Type: application/json; charset=UTF-8', true);
echo $answer_json;

?>