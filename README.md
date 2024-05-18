## Flutter Dropdowns Mock

* Flutter application to showcase 2 Dropdowns, Countries and States of that specific selected country.
* Clicking on Submit button will validate the form.
* IF selections are valid you'll be presented with new screen **Profile Page**.
* You can reselect the country & state.
* Proper Error & Exception Handling with Internet checker.

## Packages Overview

* Folder Structure - inspired from CLEAN but Custom.
* State Management ```flutter_bloc``` - Cubit 
* ```Dartz``` - Functional Programming to return Type Either<Left, Right>
* ```animate_do``` - Basic Premade animation library with inbuilt widgets for any animations
* ```equatable```: Object & State Equality
* ```internet_connection_checker``` - to check device's internet connection
* ```mocktail```- Generate Mocks for testing
* ```dio```- network Client to do API calls
* ```flutter_dotenv```- Makes ```.env``` available in flutter project.




## Architecture Overview

Application Currently uses a basic structure of CLEAN architecture and Good Code Practice. Most Importantly all the Layers are Separated hence any layer can be replaced with any DI object. 

* lib: Application Specific base folder
* core: All common application-specific configurations
  * error: common failure classes used in dartz "Either" to return errors
  * network: network client configurations & Interceptor
    * required ```.env``` file with variable ```API_KEY```
  * shared: shared widgets, painters
  * utils: application utility classes like colors, constants
  * injector : dependency injector global declaration with GetIt
* features
  * home
    * data layer
      * datasources: RemoteDatasource used to call APIs to get all countries and all States
      * models: Place model basic common blueprint to fetch data
      * repositories: The abstract middleware repository's implementation for calling remote data source methods includes an internet checker to check network connection and call API methods.
    * domain layer
      * repositories: Abstract Middleware repository to segregate domain with data layer and call the Implementation Class using singleton object in DI.
    * presentation layer
      * cubit: HomeCubit to manage states
      * pages: HomePage & ProfilePage with actual widgets use case
      * widgets: Contains CommonDropDown Widget used in HomePage



## .ENV

>Create ```.env``` in ```lib/core/network``` to run the code

```
API_KEY="value"
```

## Screenshot


https://github.com/rdunlocked18/flutter_dropdown_mock/assets/29021926/8229b847-e9a7-44f4-ad6d-30aea3336272



## How To Run/Build

- Just How you run any Normal Flutter Project 🐱‍🏍
- Latest Flutter Stable version
- cd project_dir
- create ```.env``` file with the proper key and in the proper location
- ```flutter pub get```
- ```flutter run```
- ```flutter build apk --release```

## PR - SPEC
A pull request is created to showcase Unit Testing in flutter. Only Data Layer is currently testing in the PR for sample usecase. PR is not approved to make sure it stays to check for changes.

- #1 - ```Feature/UT-home-data-layer```
