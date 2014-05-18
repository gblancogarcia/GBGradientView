GBGradientView
==============

`GBGradientView` class provides an animated gradient view.

![Alt Screencapture](https://dl.dropboxusercontent.com/u/5359105/GBGradientView/GBGradientView.gif)

## Requirements

`GBGradientView` works on iOS 7.1 SDK or later and is compatible with ARC projects.

## Adding GBGradientView to your project

### Source files

You can directly add the header and implementation files to your project.

1. Download the [latest code version](https://github.com/gblancogarcia/GBGradientView/archive/master.zip). 
2. Open your project in Xcode, then drag and drop the header and implementation files onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project. 
3. Include `GBGradientView` wherever you need it with `#import <GBInfiniteScrollView/GBGradientView.h>`.

## Usage

This is an example of use:

First, import `GBGradientView` lib. Your view controller must conform to the `GBGradientVieDelegate` protocol.


```objective-c
#import <UIKit/UIKit.h>

#import <GBGradientView/GBGradientView.h>

@interface GBViewController : UIViewController <GBGradientVieDelegate>

@end
```

Then, initialize a `GBGradientView` new instance.

```objective-c
GBGradientView gradientView = [[GBGradientView alloc] initWithFrame:self.view.bounds
                                                        orientation:GBGradientViewOrientationVertical];
gradientView.delegate = self;
gradientView.translatesAutoresizingMaskIntoConstraints = NO;
gradientView.animationDuration = 3.0f;
gradientView.animationDelay = 3.0f;
        
[self.view addSubview:gradientView];
```

Finally, implement the `GBGradientVieDelegate` protocols methods.

```objective-c
- (NSArray *)gradientColorsForGradientView:(GBGradientView *)gradientView
{
    ...
}

- (void)gradientViewAnimationDidStop:(GBGradientView *)gradientView
{
    ...
}

```
