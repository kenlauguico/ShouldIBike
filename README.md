

Should I Bike?
===

<p align="center">
  <img src="http://i.imgur.com/GlhXsDE.png" />
</p>

Originally a web app influenced by [Victor Tolosa](http://victortolosa.com/bike/). I wanted to convert this to an iOS app from the ground up.

<p align="center">
  <img src="http://victortolosa.com/portfolio/imgs/projectmockups/bikenow.png" />
</p>

ShouldIBikeApp
---
Contains the source for the ShouldIBike iOS 8 app. **Should I Bike** simply grabs the phone's current location and, through some logic, determines whether or not it is appropriate to bike based on the weather conditions.

Future version will have the ability to input the zip code of a city to see if it's safe to bike there as well.

ShouldIBikeAPI
---
A custom wrapper around SimpleNWS to get necesarry object calls for weather.

Contains two simple calls that the iOS app calls:

```
// returns details, answer, and weather as `BikeAnswer` object, containing 
// `City`, `BikeAnswerType`, and `NextTenHours` of weather information
[manager getCityDetailsWithZip:(NSString *)zip callback:(NSDictionary *dictionary) {
  // handle response
}];

// or

[manager getCityDetailsWithLocation:(CLLocation *)location callback:(NSDictionary *dictionary) {
  // handle response
}];
```
