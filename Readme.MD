# Scan to Pay With Visa
> Disclaimer: This is a reference implementation of a usecase described at ![Visa Developer Portal - Innovation Corner](http://developer.visa.com). This is not intended for production use.

Help enable making payment to a friend quickly, using a mobile app to transfer funds between an enrolled cardholder’s eligible Visa card and a friend or family member’s eligible Visa card.


## Prerequisites
An Apple Developer account. 
- A recent version of the development software for the use with such provider's devices (in this case we used The Apple iOS mobile development platform. You may choose to do otherwise 
- A Visa Developer Platform account [Register Here].
- A new project with Visa Direct as an API [Create here].
- A dependancy manager tool to install third party libraries (in this case we used Cocoapods) 
- The mVisa and mVisa merchant SDKs [Download Here].

## Setup
1.  Obtain the application code.

2.  Clone the pay a friend Visa GitHub repository or download the code.

3.  Drag and drop the mVisa and mVisa merchant SDKs to the project root folder.

4.  Using a Terminal application, navigate to the project folder and then install the required dependency libraries. Type:

```sh
$pod install
```

5. Open the workspace file .xcworkspace.

6. Once you setup a server endpoint with VDP API node.js client, link the payMerchantEndpoint endpoint to the server endpoint. In `Constants.swift`
```swift
static let payMerchantEndpoint: String = "YOUR_ENDPOINT"
```
7. In the ViewController.swift file, enter sample payee information, including:
     - The last four digits of the card in lastFour.
     - Friend’s name in PayeeName.


## Run the App
- After you've built the application, run it on a connected device.
- Connect your smart phone to your computer.
- Run the application with the device as the target.
- On the main page of the app, enter Sample information for card type and Last four digits of card 
- Click the Merchant QR button to view the sample QR code. Save and print it.
- Then, tap the Scan to Pay button and scan the QR code.
- Enter an amount and then tap Pay.
- The amount is transferred between cards and confirmations are sent.


   [Register Here]: <https://developer.visa.com/portal/#users/new>
   [Create here]: <https://developer.visa.com/vdpguide#create_project>
   [Download Here]: <https://developer.visa.com/capabilities/visa_direct/docs#using_mvisa_sdk>
   [Setup Instructions]: <https://cocoapods.org/>

## Built With
- mVisa SDK for iOS [Download Here]

## Release History


* 1.0.2
    * Name change
    * Added UI for entering customer card information
* 1.0.1
    * First version

## License

This project is licensed under the MIT License 


   [Register Here]: <https://developer.visa.com/portal/#users/new>
   [Create here]: <https://developer.visa.com/vdpguide#create_project>
   [Download Here]: <https://developer.visa.com/capabilities/visa_direct/docs#using_mvisa_sdk>
   [Setup Instructions]: <https://cocoapods.org/>
   [Github Page]: <https://github.com/Alamofire/Alamofire>


