#import "SquareDecomposer.h"

@implementation SquareDecomposer
- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
    // good luck
    
    NSNumber *squareNumber = [NSNumber numberWithDouble: (pow(number.doubleValue, 2))];
    NSMutableArray <NSNumber *> *result = [NSMutableArray array];
    
    
    NSInteger maxValue = number.integerValue - 1;
    NSInteger sum = squareNumber.integerValue - pow(maxValue, 2);
    [result addObject: [NSNumber numberWithInteger:maxValue]];
    
    NSInteger numberBeforeMax = sqrt(squareNumber.integerValue - pow(maxValue,2));
    
    for (NSInteger i = numberBeforeMax; i>0; i--) {
        NSInteger balance = sum;
        //
        NSArray *elements = [NSArray arrayWithArray: [self checkBalance:balance andIterations:(i)]];
        if (elements.count != 0) {
            for (NSNumber *number in elements) {
                [result addObject:number];
            }
            NSSortDescriptor *sd = [[NSSortDescriptor alloc]initWithKey:nil ascending:YES];
            NSArray *sorted = [result sortedArrayUsingDescriptors:@[sd]];
            return sorted;
        }
    }
    return nil;
}

- (NSMutableArray *)checkBalance:(NSInteger)balance andIterations:(NSInteger)numberOfIterations {
    NSInteger incomingBalance = balance;
    NSMutableArray *betweenArray = [NSMutableArray array];
    
    for (NSInteger i = numberOfIterations; i > 0; i--) {
        if (pow(i, 2) <= incomingBalance) {
            incomingBalance -= pow(i, 2);
            [betweenArray addObject:[NSNumber numberWithInteger:i]];
        }
    }
    if (incomingBalance == 0) {
        return betweenArray;
    } else {
        betweenArray = [NSMutableArray arrayWithArray:[self removeLastObject:incomingBalance newArray:betweenArray andOldBetweenArray:betweenArray isFirstIteration:YES]];
        return betweenArray;
        
        
        //        if (betweenArray.count !=0) {
        //            NSNumber *firstNumber = betweenArray.firstObject;
        //            if (betweenArray.count !=1) {
        //
        //                NSNumber *secondNumber = [betweenArray objectAtIndex:1];
        //                NSNumber *newSecondValue = [NSNumber numberWithInteger: secondNumber.integerValue -1];
        //
        //                [betweenArray removeAllObjects];
        //                [betweenArray addObject:firstNumber];
        //                [betweenArray addObject:newSecondValue];
        //
        //                incomingBalance = balance;
        //                incomingBalance -= pow(numberOfIterations,2);
        //                if (incomingBalance >0 || newSecondValue >0) {
        //                    NSMutableArray *newBetweenArray = [NSMutableArray array];
        //                    newBetweenArray = [self checkBalance:incomingBalance andIterations: newSecondValue.integerValue];
        //                    [newBetweenArray insertObject:firstNumber atIndex:0];
        //                    return newBetweenArray;
        //                }
        //            }
        //            return nil;
        //        }
        
        
        return nil;
    }
}

- (NSMutableArray *)removeLastObject:(NSInteger)balance newArray:(NSMutableArray *)betweenArray andOldBetweenArray:(NSMutableArray *)oldBetweenArray isFirstIteration:(BOOL)currentIteration  {
    NSMutableArray *testArray = [NSMutableArray arrayWithArray:betweenArray];
    NSNumber *objectToRemove = oldBetweenArray.lastObject;
    NSInteger newBalance = balance;
    if (currentIteration) {
        newBalance = balance + [NSNumber numberWithDouble: pow(objectToRemove.intValue, 2)].integerValue;
    }
    [testArray removeLastObject];
    [oldBetweenArray removeLastObject];
    NSNumber *lastObject = testArray.lastObject;
    NSInteger currentBalance = newBalance + [NSNumber numberWithDouble: pow(lastObject.intValue, 2)].integerValue;
    NSNumber *newLastObject = [NSNumber numberWithInteger: lastObject.integerValue - 1];
    if (testArray.count ==0){
        return nil;
    }
    [testArray replaceObjectAtIndex:(testArray.count - 1) withObject:newLastObject];
    //    currentBalance -= pow(newLastObject.integerValue,2);
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray: [self checkBalanceSecondChance:currentBalance andIterations:newLastObject.integerValue andInputArray:testArray andOldBetweenArray:oldBetweenArray andOldBalance:currentBalance]];
    return resultArray;
}

- (NSMutableArray*)checkBalanceSecondChance:(NSInteger)incomingBalance andIterations:(NSInteger)numberOfIterations andInputArray:(NSMutableArray *)newBetweenArray andOldBetweenArray:(NSMutableArray *)oldBetweenArray andOldBalance:(NSInteger)oldBalance {
    NSInteger newBalance = incomingBalance;
    NSMutableArray *checkArray = [NSMutableArray arrayWithArray:newBetweenArray];
    for (NSInteger i = numberOfIterations; i > 0; i--) {
        if (pow(i, 2) <= newBalance) {
            newBalance -= pow(i, 2);
            if (![checkArray containsObject:[NSNumber numberWithInteger:i]]){
                [checkArray addObject:[NSNumber numberWithInteger:i]];
            }
        }
    }
    if (newBalance == 0) {
        return checkArray;
    } else {
        NSMutableArray *result = [NSMutableArray arrayWithArray:[self removeLastObject:oldBalance newArray:newBetweenArray andOldBetweenArray:oldBetweenArray isFirstIteration:NO]];
        return result;
    }
    return nil;
}

@end
