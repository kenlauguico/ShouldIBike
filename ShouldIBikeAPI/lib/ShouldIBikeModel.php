<?php
namespace ShouldIBike;

/**
 * ShouldIBike model class
 *
 * @author Ken Lauguico <me@kenlauguico.com>
 * @version 1.0
 * @package SHouldIBikeAPI
 */


// Methods

function getShouldBikeAnswerJSON($city, $type, $next_ten) {
	$answer = array();
	$answer['city'] = $city;
	$answer['answer_type'] = $type;
	$answer['next_ten'] = $next_ten;

	return json_encode($answer);
}

function getShouldBikeAnswerType(NextTenHours $next_ten) {
	$answer_type_no = 0;
	$answer_type_yes = 1;
	$answer_type_maybe = 2;

	$rain_chances = 0;

	// Check the next 3 hours for rain
	for ($i = 0; $i < 3; $i++) {
		if ($next_ten[$i]->weather_condition == 'rain' ||
			$next_ten[$i]->weather_condition == 'rain showers' ||
			$next_ten[$i]->weather_condition == 'thunderstorms') {
			$rain_chances += 1;
		}
	}

	switch($rain_chances) {
		case 0:
			return $answer_type_yes;
			break;
		case 1:
			return $answer_type_maybe;
			break;
		case 2:
			return $answer_type_maybe;
			break;
		case 3:
			return $answer_type_no;
			break;
	}
}

function getHoursFromNow($hours) {
	// TODO: Change timezone based on zip code
	date_default_timezone_set('America/Los_Angeles');
	$_now = date('g');
	$_now += $hours;

	do {
		if ($_now <= 12) {
			break;
		}

		$_now -= 12;
	} while($_now > 12);

	return $_now;
}

function getTimestampHoursFromNow($hours) {
	// TODO: Change timezone based on zip code
	date_default_timezone_set('America/Los_Angeles');

	return strtotime('+'.$hours.' hours');
}


// Classes

class WeatherHourNow {
	var $weather_condition;
	var $timestamp;
	var $sunrise_timestamp;
	var $sunset_timestamp;
	var $temp_in_fahrenheit;
	var $humidity;
	var $wind_direction;
	var $wind_speed_in_mph;
	var $wind_chill;
	var $precipitation;
	var $precipitation_per_hour;

	public function get_array() {
		$array = array();
		$array['weather_condition'] = $weather_condition;
		$array['timestamp'] = $timestamp;
		$array['sunrise_timestamp'] = $sunrise_timestamp;
		$array['sunset_timestamp'] = $sunset_timestamp;
		$array['temp_in_fahrenheit'] = $temp_in_fahrenheit;
		$array['humidity'] = $humidity;
		$array['wind_direction'] = $wind_direction;
		$array['wind_speed_in_mph'] = $wind_speed_in_mph;
		$array['wind_chill'] = $wind_chill;
		$array['precipitation'] = $precipitation;
		$array['precipitation_per_hour'] = $precipitation_per_hour;

		return $array;
	}
}

class WeatherHour {
	var $weather_condition;
	var $timestamp;
	var $temp_in_fahrenheit;

	public function get_array() {
		$array = array();
		$array['weather_condition'] = $weather_condition;
		$array['timestamp'] = $timestamp;
		$array['temp_in_fahrenheit'] = $temp_in_fahrenheit;

		return $array;
	}
}

class NextTenHours extends \ArrayObject {
	public function init(WeatherHourNow $weather_hour_now, Array $ten_hours) {
		$this->append($weather_hour_now);
		foreach($ten_hours as $weather_hour) {
            $this->append($weather_hour);
        }
	}
}
?>