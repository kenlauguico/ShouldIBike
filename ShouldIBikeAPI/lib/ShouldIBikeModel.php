<?php
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

class NextTenHours extends ArrayObject {
	public function init(WeatherHourNow $weather_hour_now, Array $ten_hours) {
		$this->append($weather_hour_now);
		foreach($ten_hours as $weather_hour) {
            $this->append($weather_hour);
        }
	}
}


// Objects

$answer_type_no = 0;
$answer_type_yes = 1;
$answer_type_maybe = 2;
?>