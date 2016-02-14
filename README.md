# ASBubbleDrag

Bubble drag control integrate in storyboard :


![alt tag](https://github.com/scamps88/ASBubbleDrag/blob/master/README/animated.gif)


### installation :

- Just copy the ASBubbleDrag folder to your project
- Or, if you are using CocoaPod, add the followind line to yur Podfile (adding the use_frameworks! flag at the end)
    pod 'ASBubbleDrag', :git => 'https://github.com/scamps88/ASBubbleDrag.git'

    use_frameworks!

### implementation :

- ti implement ASBubbleMenu, first create a UIView and add it to your UIViewController in storyboard; then set the class as ASBubbleDrag :
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

