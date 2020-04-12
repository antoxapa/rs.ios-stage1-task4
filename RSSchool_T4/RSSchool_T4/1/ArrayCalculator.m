#import "ArrayCalculator.h"

@implementation ArrayCalculator
+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    // good luck
    
    //    NSSortDescriptor *sd = [[NSSortDescriptor alloc]initWithKey:nil ascending:YES];
    //    NSArray *sorted = [array sortedArrayUsingDescriptors:@[sd]];
    
    NSArray *sorted = [NSArray array];
    sorted = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        if (abs([obj1 intValue]) > abs([obj2 intValue])) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if (abs([obj1 intValue]) < abs([obj2 intValue])) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    int composition = 1;
    
    NSMutableArray *reversed = [[[sorted reverseObjectEnumerator]allObjects]mutableCopy];
    
    NSMutableArray *newArray = [NSMutableArray array];
    
    for (int i = 0; i < reversed.count; i++) {
         if ([reversed[i] isKindOfClass: [NSNumber class]]) {
             [newArray addObject:reversed[i]];
         }
    }
    
    for (int i = 0; i < numberOfItems; i++) {
//
//        if ([reversed[i] isKindOfClass: [NSString class]]) {
//            [reversed removeObjectAtIndex:i];
//            if (reversed.count ==0) {
//                break;
//            }
//            i--;
//        }
        if (numberOfItems > newArray.count) {
            if (newArray.count == 0) {
                return 0;
            }
            for (NSNumber *number in newArray) {
                composition *= number.intValue;
            }
            return composition;
        }
    }

    for (int i = 0; i < numberOfItems; i++) {
        NSNumber *number = newArray[i];
        if (number !=0) {
            composition *= number.intValue;
        }
    }

    if (composition < 0) {
        composition = 1;
        [reversed removeObjectAtIndex:0];
        for (int i = 0; i < numberOfItems; i++) {
            NSNumber *number = reversed[i];
            composition *= number.intValue;
        }
    }
    return composition;
}
@end
