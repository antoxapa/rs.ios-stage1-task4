#import "FullBinaryTrees.h"

@interface Node: NSObject
@property (strong, nonatomic) NSNumber *value;
@property (weak, nonatomic) Node *left;
@property (weak, nonatomic) Node *right;

@end

@implementation Node

- (instancetype)init
{
    self = [super init];
    if (self) {
        _value = @0;
        _left = NULL;
        _right = NULL;
    }
    return self;
}
@end

@implementation FullBinaryTrees
- (NSString *)stringForNodeCount:(NSInteger)count {
    // good luck
    NSArray *resultArray = [self addChilds:count];
    return [self getStingValues:resultArray];
}

- (NSArray*)addChilds:(NSInteger)count {
     NSMutableArray *resultArray = [NSMutableArray array];
    if (count == 1) {
        Node *rootNode = [[Node alloc]init];
        [resultArray addObject:rootNode];
    } else if (count %2 == 1) {
        for (int i = 0; i < count; i++) {
            NSArray *leftNodes = [NSArray arrayWithArray:[self addChilds:i]];
            for (int l = 0; l<leftNodes.count; l++) {
                NSArray *rightNodes = [NSArray arrayWithArray:[self addChilds:count - i - 1]];
                for (int r = 0; r<rightNodes.count; r++) {
                    Node *rootNode = [[Node alloc]init];
                    Node *leftNode = leftNodes[l];
                    Node *rightNode = rightNodes[r];
    
                    [rootNode setLeft:leftNode];
                    [rootNode setRight:rightNode];
                    
                    [resultArray addObject:rootNode];
                }
            }
        }
    }
    return resultArray;
}

- (NSString *)getStingValues:(NSArray *)array {
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    
    for (Node *node in array) {
        NSMutableArray *betweenResult = [NSMutableArray array];
        NSMutableArray *untreated= [NSMutableArray array];
        [self addNode:node onLevel:0 toArray:betweenResult];

        for (NSMutableArray *levelArray in betweenResult) {
            for (int i = 0; i < ceil((double)levelArray.count / 4); i++) {
                
                NSArray *subArray = [levelArray subarrayWithRange:NSMakeRange(i * 4 , (i + 1) * 4 > levelArray.count ? levelArray.count - i * 4 : 4)];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self isEqual: %@", @"0"];
                NSArray *nodesArray = [subArray filteredArrayUsingPredicate:predicate];
                
                if (nodesArray.count > 0) {
                    NSString *levelString = [levelArray componentsJoinedByString:@","];
                    [untreated addObject:levelString];
                }
            }
        }
        
        NSMutableArray *stringsWithExtraNulls = [[[untreated componentsJoinedByString:@","] componentsSeparatedByString:@","]mutableCopy];
        NSArray *stringsWithoutExtraNulls = [self removeSymbols:stringsWithExtraNulls];
        
        [resultArray addObject:[NSString stringWithFormat:@"[%@]", [stringsWithoutExtraNulls componentsJoinedByString:@","]]];
    }
    NSString *resultString = [NSString stringWithFormat:@"[%@]", [resultArray componentsJoinedByString:@","]];
    return resultString;
}

- (void)addNode:(Node *)node onLevel:(int)level toArray:(NSMutableArray *)inputArray {
    while (inputArray.count <= level) {
        [inputArray addObject:[NSMutableArray array]];
    }
    NSMutableArray *arrayOnLevel = inputArray[level];
    if ([node isKindOfClass:[Node class]]) {
        [arrayOnLevel addObject:@"0"];
        [self addNode:node.left onLevel:(level + 1) toArray:inputArray];
        [self addNode:node.right onLevel:(level + 1) toArray:inputArray];
    } else {
        [arrayOnLevel addObject:@"null"];
    }
}

- (NSArray *)removeSymbols:(NSMutableArray *)incomingArray {
    BOOL prefixDeleted = NO;
    while(!prefixDeleted) {
        NSString *node = incomingArray[0];
        if ([node isEqualToString:@"null"]) {
            [incomingArray removeObjectAtIndex:0];
        } else {
            prefixDeleted = YES;
        }
    }
    
    BOOL postfixDeleted = NO;
    while(!postfixDeleted) {
        NSUInteger lastIndex = incomingArray.count - 1;
        NSString *node = incomingArray[lastIndex];
        if ([node isEqualToString:@"null"]) {
            [incomingArray removeObjectAtIndex:lastIndex];
        } else {
            postfixDeleted = YES;
        }
    }
    return incomingArray;
}
@end
