![GitHub all releases](https://img.shields.io/github/downloads/bilaldurnagol/Mushrooms/total?logo=Github&style=flat-square)
![GitHub language count](https://img.shields.io/github/languages/count/bilaldurnagol/Mushrooms)
![GitHub followers](https://img.shields.io/github/followers/bilaldurnagol?style=social)
![GitHub forks](https://img.shields.io/github/forks/bilaldurnagol/Mushrooms?style=social)
![GitHub Repo stars](https://img.shields.io/github/stars/bilaldurnagol/Mushrooms?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/bilaldurnagol/Mushrooms?style=social)
![Twitter Follow](https://img.shields.io/twitter/follow/bilaldurnagol?style=social)

<!-- PROJECT LOGO -->
<br />
<p align="center">
   <a href="https://github.com/bilaldurnagol/Mushrooms">
    <img src="githubImages/logo.png" alt="Logo" width="60" height="60">
  </a>

  <h3 align="center">Mushroom Finder</h3>
  
  <p align="center">
    I did this project to learn Vision and Core ML, which are Apple image processing and artificial intelligence libraries.
    <br />
    <a href="https://github.com/bilaldurnagol/Mushrooms"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/bilaldurnagol/Mushrooms">View Demo</a>
    ·
    <a href="https://github.com/bilaldurnagol/Mushrooms/issues">Report Bug</a>
    ·
    <a href="https://github.com/bilaldurnagol/Mushrooms/issues">Request Feature</a>
  </p>
</p>


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#Requirements">Requirements</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

  This application is made for you to find the mushroom species you photographed with artificial intelligence and share it with the world.
  You can also find the location of the shared mushroom using maps and navigate to the area where the mushroom is located with the navigation feature.

   <a href="https://github.com/bilaldurnagol/Mushrooms">
    <img src="githubImages/screenshot_1.png" alt="Logo" width="300" height="600">
  </a>
   <a href="https://github.com/bilaldurnagol/Mushrooms">
    <img src="githubImages/screenshot_2.png" alt="Logo" width="300" height="600">
  </a>
     <a href="https://github.com/bilaldurnagol/Mushrooms">
    <img src="githubImages/screenshot_3.png" alt="Logo" width="300" height="600">
  </a>
   <a href="https://github.com/bilaldurnagol/Mushrooms">
    <img src="githubImages/screenshot_4.png" alt="Logo" width="300" height="600">
  </a>


Here's why:
* To learn image processing and artificial intelligence

### Built With

The frameworks I used in this project are listed below.
* CoreML
* Vision
* CoreLocation
* Alamofire

<!-- GETTING STARTED -->
## Getting Started

 This is an example of how you may give instructions on setting up your project locally. To get a local copy up and running follow these simple example steps.

### Requirements

* Xcode 12.x
* Swift 5.x

### Installation
There is no external library.

<!-- USAGE EXAMPLES -->
## Usage

<table>
  <tr>
    <th width="30%">Here's an example</th>
  </tr>
  <tr>
    <td>Get all articles...</td>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
    
     private func recognizeImage(image: CIImage) {
        //1)request
        //2)handle
        if let model = try? VNCoreMLModel(for: Mushrooms().model) {
            let request = VNCoreMLRequest(model: model, completionHandler: {[weak self] vnRequest, error in
                guard let strongSelf = self else {return}
                if let result = vnRequest.results as? [VNClassificationObservation] {
                    if result.count > 0 {
                        let topResult = result.first
                        DispatchQueue.main.async {
                            let confidenceLevel = (topResult?.confidence ?? 0 ) * 100
                            let rounded = Int(confidenceLevel * 100) / 100
                            strongSelf.resultLabel.text = "\(rounded)% it's \(topResult!.identifier)"
                            strongSelf.resultLabel.isHidden = false
                            strongSelf.mushroomName = topResult?.identifier
                        }
                    }
                }
            })
            let handle = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handle.perform([request])
                } catch {
                    print("failed")
                }
            }
        }
    }
  </tr>
</table>


<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact
   <a href="https://twitter.com/bilaldurnagol">
  <img align="left" alt="Bilal Durnagöl | Twitter" width="21px" src="https://raw.githubusercontent.com/anuraghazra/anuraghazra/master/assets/twitter.svg"/>
</a>

   <a href="https://medium.com/@BilalDurnagol">
  <img align="left" alt="Bilal Durnagöl | Medium" width="21px" src="https://github.com/leungwensen/svg-icon/blob/master/dist/svg/logos/medium.svg"/>
</a>

   <a href="https://www.instagram.com/bilaldurnagol/">
  <img align="left" alt="Bilal Durnagöl | Instagram" width="21px" src="https://github.com/shgysk8zer0/logos/blob/master/instagram.svg"/>
</a>

   <a href="https://www.linkedin.com/in/bilaldurnagol">
  <img align="left" alt="Bilal Durnagöl | LinkedIn" width="21px" src="https://github.com/shgysk8zer0/logos/blob/master/linkedin.svg"/>
</a>
<br/>
<br/>
  
Project Link: [https://github.com/bilaldurnagol/Mushrooms](https://github.com/bilaldurnagol/Mushrooms)
