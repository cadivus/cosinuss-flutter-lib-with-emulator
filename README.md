# A Flutter library for Cosinuss° One

For the KIT module "Mobile Computing and Internet of Things" (https://teco.edu/education-mociot/), we got the exercises to build a creative mobile app for Cosinuss° One sensors based on https://github.com/teco-kit/cosinuss-flutter.

Another exercise was to build a HTML5 application. I decided to build a Cosinuss° One emulator as a HTML5 application and a Cosinuss° One library supporting it. My mobile app (https://github.com/cadivus/early-bird) uses this library and can be tested with my HTML5 submission.


## Use the emulator

To start the emulator, you just need to run `npm install` and `npm run start` in `cosinuss_emulator`. The web interface can be used on port 3000.

For using the emulator, you have to start your application with  
`flutter run --dart-define=COSINUSS_EMULATOR_MODE=true` or  
`flutter run --dart-define=COSINUSS_EMULATOR_MODE=true --dart-define=COSINUSS_EMULATOR_HOST=your-host`

For recording data using the UI, you have to start an app using this library with  
`flutter run --dart-define=COSINUSS_EMULATOR_LOG_MODE=true --dart-define=COSINUSS_EMULATOR_HOST=your-host`

You can use the example app for this.



### The emulator UI

The emulator UI is written in pure HTML, CSS and Javascript without a Framework.


#### Desktop UI

<img src="https://user-images.githubusercontent.com/51089187/212550636-64de2e97-36ad-4c74-b52a-f0dc21b6650c.png" width="550px">


<img src="https://user-images.githubusercontent.com/51089187/212562856-22a89c95-ec03-432f-8eb3-dacbb03bc54f.png" width="550px">


#### Mobile UI

<img src="https://user-images.githubusercontent.com/51089187/212563294-67a83320-80d8-414a-950f-8c7ab30d59f1.png" width="250px">    <img src="https://user-images.githubusercontent.com/51089187/212563435-cf5cc8c0-2e89-47eb-9300-e8ccb64a1732.png" width="250px">    <img src="https://user-images.githubusercontent.com/51089187/212563379-aef3b09f-b9ef-483d-aa25-02a77d15467e.png" width="250px">
