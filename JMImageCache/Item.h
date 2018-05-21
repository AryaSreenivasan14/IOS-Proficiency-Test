//
//  Item.h
//  ZZGridView
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Item : NSObject {
		NSString *title;
		NSString *link;
		NSString *image;
        UIImage *img1;
    
}
	
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) UIImage *img1;

@end
