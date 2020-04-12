#import "TelephoneFinder.h"

@implementation TelephoneFinder
- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number {
    // good luck
    NSMutableArray *result = [NSMutableArray array];
    NSDictionary *numbers = @{ @"1" : @[@"2", @"4"],
                               @"2" : @[@"1", @"3", @"5"],
                               @"3" : @[@"2", @"6"],
                               @"4" : @[@"1", @"5", @"7"],
                               @"5" : @[@"2", @"4", @"6", @"8"],
                               @"6" : @[@"3", @"5", @"9"],
                               @"7" : @[@"4", @"8"],
                               @"8" : @[@"5", @"7", @"9", @"0"],
                               @"9" : @[@"6", @"8"],
                               @"0" : @[@"8"]};
    NSString *symbol;
    for (int i = 0; i < number.length; i++) {
        symbol = [number substringWithRange:NSMakeRange(i, 1)];
        if ([symbol isEqualToString:@"-"]) {
            return nil;
        }
        for (int j = 0; j < numbers.allKeys.count; j++) {
            NSString *key = numbers.allKeys[j];
            if ([symbol isEqualToString:key]) {
                NSArray *valuesForKey = [NSArray arrayWithArray: numbers[key]];
                for (int k = 0; k <valuesForKey.count; k++) {
                    NSString *value = [NSString stringWithString:valuesForKey[k]];
                    NSMutableString *newNumberString = [NSMutableString stringWithString:number];
                    [newNumberString replaceCharactersInRange:NSMakeRange(i, 1) withString: value];
                    [result addObject:newNumberString];
                }
            }
        }
    }
    return result;
}
@end
