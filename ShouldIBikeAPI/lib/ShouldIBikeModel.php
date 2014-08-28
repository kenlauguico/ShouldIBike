<?php
namespace ShouldIBike;

require_once 'wunderground.php';

/**
 * ShouldIBike model class
 *
 * @author Ken Lauguico <me@kenlauguico.com>
 * @version 1.0
 * @package SHouldIBikeAPI
 */


// Methods

function getConditionsJSON() {
	global $wkey;
	$q = $_GET['q'];
	$json_string = file_get_contents("http://api.wunderground.com/api/$wkey/conditions/conditions/q/$q.json");
	return json_decode($json_string);
}

function getHourlyJSON() {
	global $wkey;
	$q = $_GET['q'];
	$json_string = file_get_contents("http://api.wunderground.com/api/$wkey/hourly/conditions/q/$q.json");
	return json_decode($json_string);
}

function getShouldBikeAnswerJSON($city, $type, $next_ten) {
	$answer = array();
	$answer['city'] = $city;
	$answer['answer_type'] = $type;
	$answer['next_ten'] = $next_ten;

	return json_encode($answer);
}

function getShouldBikeAnswerType(NextTenHours $next_ten) {
	global $answer_type_no, $answer_type_yes, $answer_type_maybe;

	$rain_chances = 0;

	// Check the next 3 hours for rain
	for ($i = 0; $i < 3; $i++) {
		if ($next_ten[$i]->weather_condition == 'Rain' ||
			$next_ten[$i]->weather_condition == 'Chance of Rain' ||
			$next_ten[$i]->weather_condition == 'Rain Showers' ||
			$next_ten[$i]->weather_condition == 'Drizzle' ||
			$next_ten[$i]->weather_condition == 'Light Drizzle' ||
			$next_ten[$i]->weather_condition == 'Heavy Drizzle' ||
			$next_ten[$i]->weather_condition == 'Light Rain' ||
			$next_ten[$i]->weather_condition == 'Heavy Rain') {
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

	public function init_with_json_conditions($json) {
		$conditions = $json->{'current_observation'};

		$this->weather_condition = $conditions->{'weather'};
		$this->timestamp = $conditions->{'observation_epoch'};
		// $this->sunrise_timestamp = $conditions->{''};
		// $this->sunset_timestamp = $conditions->{''};
		$this->temp_in_fahrenheit = $conditions->{'temp_f'};
		$this->humidity = $conditions->{'relative_humidity'};
		$this->wind_direction = $conditions->{'wind_dir'};
		$this->wind_speed_in_mph = $conditions->{'wind_mph'};
		$this->wind_chill = $conditions->{'windchill_string'};
		$this->precipitation = $conditions->{'precip_today_in'};
		$this->precipitation_per_hour = $conditions->{'precip_1hr_in'};
	}
}

class WeatherHour {
	var $weather_condition;
	var $timestamp;
	var $temp_in_fahrenheit;

	public function init_with_json_forecast_hour($json) {
		$this->timestamp = $json->{'FCTTIME'}->{'epoch'};
		$this->temp_in_fahrenheit = $json->{'temp'}->{'english'};
		$this->weather_condition = $json->{'condition'};
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


$answer_type_no = 0;
$answer_type_yes = 1;
$answer_type_maybe = 2;
?>