//
//  WeatherData.swift
//  weather-app
//
//  Created by ShahJee on 22/11/2023.
//

import Foundation

struct WeatherData: Codable
{
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Wind: Codable
{
    let speed: Double
    let deg: Int
}

struct Clouds: Codable
{
    let all: Int
}

struct Coord: Codable
{
    let lon, lat: Double
}

struct Main: Codable
{
    let temp: Double
}

struct Sys: Codable
{
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Codable
{
    let id: Int
    let description: String
}
