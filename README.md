# ASBubbleDrag

Bubble drag control integrate in storyboard :


![alt tag](https://github.com/scamps88/ASBubbleDrag/blob/master/README/animated.gif)


## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `ASBubbleDrag` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
    pod 'ASBubbleDrag', :git => 'https://github.com/scamps88/ASBubbleDrag.git'
```

To get the full benefits import `ASBubbleDrag` wherever you import UIKit

``` swift
import UIKit
import ASBubbleDrag
```

#### Manually
1. Download and drop ```/ASBubbleDrag```folder in your project.  
2. Congratulations!  

### implementation :

- to implement ASBubbleMenu, first create a UIView and add it to your UIViewController in storyboard; then set the class as ASBubbleDrag :
    ![alt tag](https://github.com/scamps88/ASBubbleDrag/blob/master/README/image9.png)
- then attach it to an iboutlet

    ```swift
    @IBOutlet var bubbleDragView : ASBubbleDrag!
    ```
- and populate it with an array of UIImage

    ```swift
    self.bubbleDragView.populate(icons)
    ```

- the ASBubbleDragDelegate protocol will return the index selected :
    ```swift
    self.bubbleDragView.delegate = self

    func ASBubbleDragSelectedMenuItemAtIndex(index: NSInteger) {
    }
    ```

### licence :

ASBubbleDrag is available under the MIT license. See the LICENSE file for more info.
