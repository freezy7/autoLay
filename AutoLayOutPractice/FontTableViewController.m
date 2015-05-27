//
//  FontTableViewController.m
//  AutoLayOutPractice
//
//  Created by R_style Man on 15/5/26.
//  Copyright (c) 2015年 R_style_Man. All rights reserved.
//

#import "FontTableViewController.h"
#import <CoreText/CoreText.h>
#import "SCFontViewController.h"

@interface FontTableViewController ()
{
    NSMutableDictionary* _fontList;
}

@end

@implementation FontTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Families";
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // 解压字体列表数据
    NSData* data = [[NSMutableData alloc] initWithContentsOfFile:[self getFilePath]];
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSMutableDictionary* fontData = [unarchiver decodeObjectForKey:@"FontData"];
    
    [unarchiver finishDecoding];
    if (fontData) {
        _fontList = [fontData copy];
    }else{
        [self requestDownloadFontList];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request download fontList

-(void)requestDownloadFontList
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSDictionary* descriptorOptions = @{(id)kCTFontDownloadableAttribute:@YES};
        CTFontDescriptorRef descriptor = CTFontDescriptorCreateWithAttributes((CFDictionaryRef)descriptorOptions);
        CFArrayRef fontDescriptors = CTFontDescriptorCreateMatchingFontDescriptors(descriptor, NULL);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self fontListDownloadComplete:(NSArray*)CFBridgingRelease(fontDescriptors)];
        });
        
        // Need release the font descriptor
        CFRelease(descriptor);
    });
}

-(void)fontListDownloadComplete:(NSArray*)fontList
{
    // Need to reorganise array into dictionary
    // 获取后台的字体列表，注意用法
    NSMutableDictionary* fontFamilies = [NSMutableDictionary new];
    for (UIFontDescriptor* descriptor in fontList) {
        NSString* fontFamilyName = [descriptor objectForKey:UIFontDescriptorFamilyAttribute];
        NSMutableArray* fontDescriptors = [fontFamilies objectForKey:fontFamilyName];
        if (!fontDescriptors) {
            fontDescriptors = [NSMutableArray new];
            [fontFamilies setObject:fontDescriptors forKey:fontFamilyName];
        }
        [fontDescriptors addObject:descriptor];
    }
    _fontList = [fontFamilies copy];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:_fontList forKey:@"FontData"];
    
    [archiver finishEncoding];
    
    [data writeToFile:[self getFilePath] atomically:YES];
    
    
    
    [self.tableView reloadData];
}

-(NSString*)getFilePath
{
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:@"font"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _fontList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* strID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID forIndexPath:indexPath];
    
    // Configure the cell...
    NSString* fontFamilyName = [_fontList allKeys][indexPath.row];
    cell.textLabel.text = fontFamilyName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowFontFamily" sender:indexPath];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowFontFamily"]) {
        SCFontViewController* vc = [segue destinationViewController];
        NSIndexPath* indexPath = sender;
        NSString* fontFamilyName = [_fontList allKeys][indexPath.row];
        NSArray* fontList = _fontList[fontFamilyName];
        vc.fontList = fontList;
        vc.title = fontFamilyName;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
