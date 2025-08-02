import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        var result = ""
        switch conditionId {
        case 200, 201, 230, 231, 232:
            result = "cloud.bolt.rain" // thunderstorm variations with rain/drizzle
        case 203, 211, 221: result = "cloud.bolt" // general thunderstorm variations
        case 202: result = "cloud.bolt.rain.fill" // heavy thunderstorm with rain
        case 212: result = "cloud.bolt.fill" // heavy thunderstorm
        case 300, 301, 310, 311, 321: result = "cloud.drizzle" // light/moderate drizzle
        case 302, 312: result = "cloud.drizzle.fill" // heavy drizzle
        case 500, 501, 520, 521, 531: result = "cloud.rain" // light/moderate rain
        case 502, 313, 522: result = "cloud.heavyrain" // heavy rain
        case 503, 504: result = "cloud.heavyrain.fill" // extreme rain
        case 511: result = "cloud.hail" // freezing rain
        case 600, 620, 621: result = "snowflake" // light snow (621 использует cloud.snow в оригинале, но snowflake более точный для "light")
        case 601: result = "cloud.snow" // general snow
        case 602, 622: result = "cloud.snow.fill" // heavy snow
        case 611, 612, 615: result = "cloud.sleet" // sleet variations
        case 613, 616: result = "cloud.sleet.fill" // heavy sleet/rain-snow mix
        case 701, 741: result = "cloud.fog" // mist/fog
        case 711, 762: result = "smoke" // smoke/volcanic ash (762 использует smoke.fill в оригинале)
        case 721: result = "sun.haze" // haze
        case 731, 771: result = "wind" // sand whirls/squalls
        case 751: result = "sun.dust" // sand
        case 761: result = "sun.dust.fill" // dust
        case 781: result = "tornado" // tornado
        case 800: result = "sun.max" // clear sky
        case 801: result = "cloud.sun" // few clouds
        case 802: result = "cloud" // scattered clouds
        case 803: result = "cloud.fill" // broken clouds
        case 804: result = "smoke.fill"
        default: fatalError()
        }
        return result
    }
}
