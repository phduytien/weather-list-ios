# Weather Forecast iOS

## Introduce

An iOS app to retrieve weather information based on their searching criteria and render the searched results on dashboard screen. It just an MVP version with a very limited set of functionalities:

1. The application is a simple iOS application which is written by Swift.
2. The application is able to retrieve the weather information from OpenWeatherMaps API.
3. The application is able to allow user to input the searching term.
4. The application is able to proceed searching with a condition of the search term length must be from 3 characters or above.
5. The application is able to render the searched results as a list of weather items.
6. The application is able to support caching mechanism so as to prevent the app from generating a bunch of API requests.
7. The application is able to manage caching mechanism & lifecycle.
8. The application is able to handle failures.
9. The application is able to support the disability to scale large text for who can't see the
text clearly.
10. The application is able to support the disability to read out the text using VoiceOver
controls.

Weather List Main Screen

<img src="https://github.com/phduytien/weather-list-ios/blob/master/Diagrams/app-main-screen.png" data-canonical-src="https://github.com/phduytien/weather-list-ios/blob/master/Diagrams/app-main-screen.png" width="300" height="650" />

## Explaination

1. Software architecture:

- MVVM: Model-View-ViewModel (MVVM) is a structural design pattern that separates objects into three distinct groups. It is easy to implement a simple MVP version and create effectively unit tests for each layers, maintenance and develop in future.
- Caching mechanism: Use memory cache of iOS system to store a same query string which users had fetched before to prevent the app from generating a bunch of API requests.
- Singleton: (In Cache Manager class) Init only one time and use all places in application
- Error Handling: Improve UI/UX and make app more friendly for users when getting error from server API.

2. Code structure:

<img src="https://github.com/phduytien/weather-list-ios/blob/master/Diagrams/folder-structure-p1.png" data-canonical-src="https://github.com/phduytien/weather-list-ios/blob/master/Diagrams/folder-structure-p1.png" width="308" height="702" />

Project folder structure is separated follow MVVVM architecture:
- `AppDelegate`: Store AppDelegate
- Each feature will include subfolder: View, Model and ViewModel
   * `View`: Store all UI classes
   * `Model`: Include 2 subfolders: Networking & UI, one for request, response and parse data, another for displaying data on UI.
   * `Protocol`: Delegate class to commute between View and ViewModel
   * `ViewModel`: Store ViewModel class
- We also have support folders
   * `Shared`: Store shared classes for all application: `Cache` for caching manager, `Networking` for making request and some helpers classes
   * `Extension`: Some extension classes for supporting helpful methods
   * `Resources`: Store application resources like storyboard, Info.plist, launch screen.

The folder structure is the same in testing target

<img src="https://github.com/phduytien/weather-list-ios/blob/master/Diagrams/folder-structure-p2.png" data-canonical-src="https://github.com/phduytien/weather-list-ios/blob/master/Diagrams/folder-structure-p2.png" width="285" height="421" />

## Installation

1. Clone or download zip file from: [Github](https://github.com/phduytien/weather-list-ios) branch `master`
2. Extract zip if downloaded zip file in local machine
3. Make sure local machine has installed latest Xcode 11.5 and install Simulator 
4. Go to main project dictionary, open `WeatherList.xcodeproj`
5. Choose target Simulator, and click `Build`
6. After build succeeded, click `Run` to see on Simulator

## Requirements

- Xcode 11.5/MacOS 10.15.5
- Swift 5.0
- iOS 11.0 or later
- All devices (iPhone/iPad)
- Support Landscape/Portrait

## Checklists

- [x] 1. Programming language: Swift.
- [x] 2. Design app's architecture (MVVM)
- [x] 3. UI should be looks like in document attachment.
- [x] 4. Write Unit Tests
- [ ] 5. Acceptance Tests (UITests)
- [x] 6. Exception handling
- [x] 7. Caching handling
- [x] 8. Accessibility for Disability Supports:
  - a. Voice Over: Use a screen reader.
  - b. Scaling Text: Display size and font size: To change the size of items on your screen, adjust the display size or font size.
- [x] 9. Entity relationship diagram for the database and solution diagrams for the components, infrastructure design if any
  - a. Caching mechanism diagram
<img src="https://github.com/phduytien/weather-list-ios/blob/master/Diagrams/caching-mechanism-diagram.png" data-canonical-src="https://github.com/phduytien/weather-list-ios/blob/master/Diagrams/caching-mechanism-diagram.png" width="300" height="251" />
  - b. Error handling diagram
<img src="https://github.com/phduytien/weather-list-ios/blob/master/Diagrams/error-handling.png" data-canonical-src="https://github.com/phduytien/weather-list-ios/blob/master/Diagrams/error-handling.png" width="400" height="356" />
- [x] 10. Readme file includes:
  - a. Brief explanation for the software development principles, patterns & practices being applied
  - b. Brief explanation for the code folder structure and the key Java/Kotlin libraries and frameworks being used
  - c. All the required steps in order to get the application run on local computer
  - d. Checklist of items the candidate has done.

## Author

* Tien Pham, phduytien4891@gmail.com

## License

Weather Forecast is available under the MIT license. See the LICENSE file for more info.
