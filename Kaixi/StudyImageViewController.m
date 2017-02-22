//
//  StudyImageViewController.m
//  Kaixi
//
//  Created by ❀Ayano☻茶茶 on 15/1/12.
//  Copyright (c) 2015年 ❀Ayano☻茶茶. All rights reserved.
//

#import "StudyImageViewController.h"
#import "ImgShowViewController.h"
#import "UIImageView+WebCache.h"
#import "PhotoCollectionViewCell.h"

@interface StudyImageViewController ()

@end
@implementation StudyImageViewController
{
    NSString *identify;
}



- (void)viewDidLoad {
    //[self requestData];

    //[self initic];
    
   
    [super viewDidLoad];
    _notPhoto.hidden=YES;
    _allPhoto.hidden=NO;
 
       self.navigationController.navigationBarHidden = YES;
    
    
    
    
    //        for(int i=1;i<=[knowledge.pages intValue];i++)
    //        {
    //            NSString*str=[NSString stringWithFormat: @"%@/kaixi/knfiles/%@/%d.jpg",string,knowledge.id,i];
    //            [_images addObject:str];
    //            NSLog(@"%@",_images);
    //
    //             NSLog(@"%@",str);
    //
    //        }
    
    _dictSelect = [[NSMutableDictionary alloc]init];
    _dict= [[NSMutableDictionary alloc]init];
    _imageArray= [[NSMutableArray alloc]init];
    _imgList = [[NSMutableArray alloc]init];
    _num = [NSNumber numberWithInt:0];
    
    _biaoti.text =_name;
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    
    NSMutableString * fileurl =  [NSMutableString stringWithFormat:@""];
    NSMutableString * fileurllocal =  [NSMutableString stringWithFormat:@""];
    
    if([_tag2 isEqualToString:@"1"])
    {
        fileurl = [NSMutableString stringWithFormat:@"knfiles"];
        fileurllocal = [NSMutableString stringWithFormat:@"konFile"];
    }
    else if([_tag2 isEqualToString:@"2"])
        {
            fileurl = [NSMutableString stringWithFormat:@"yxfiles"];
            fileurllocal = [NSMutableString stringWithFormat:@"mkonFile"];
        }
    else if([_tag2 isEqualToString:@"3"])
    {
        fileurl = [NSMutableString stringWithFormat:@"xzfiles"];
        fileurllocal = [NSMutableString stringWithFormat:@"xzfile"];
    }
    else if([_tag2 isEqualToString:@"4"])
    {
        fileurl = [NSMutableString stringWithFormat:@"trace"];
        fileurllocal = [NSMutableString stringWithFormat:@"trace"];
    }
    else if([_tag2 isEqualToString:@"5"])
    {
        fileurl = [NSMutableString stringWithFormat:@"xxfiles"];
        fileurllocal = [NSMutableString stringWithFormat:@"xxfiles"];
    }
    
    if([[online objectForKey:@"online"] isEqualToString:@"1"]&&[_tag isEqualToString:@"1"])
    {
        
        NSUserDefaults *url = [NSUserDefaults standardUserDefaults];
        NSString*string=[url objectForKey:@"string"];
        
        NSMutableString * str_end=[[NSMutableString alloc]init];
        
        if([_tag2 isEqualToString:@"5"])
        {
            str_end =[NSMutableString stringWithFormat: @"JPG"];
        }else
        {
           str_end =[NSMutableString stringWithFormat: @"jpg"];
        }

        
        
        for(int i=1;i<=[_pages intValue];i++)
        {
            
            NSString*str=[NSString stringWithFormat: @"%@/kaixi/%@/%@/%d.%@",string,fileurl,_theid,i,str_end];
            //yxfiles
            //xzfiles
            
            [_imageArray addObject:str];
            
            [_dict setObject:@"0" forKey:[NSString stringWithFormat:@"%d",i]];
            
            NSLog(@"%@",_imageArray);
            
            NSLog(@"%@",str);
            
        }
        
        
    }else
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        //NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *testDirectory = [path stringByAppendingPathComponent:fileurllocal];
        
        for(int i=1;i<=[_pages intValue];i++)
        {
            
            NSString*str=[NSString stringWithFormat: @"%@/%@/%d.jpg",testDirectory,_theid,i];
            [_imageArray addObject:str];
            
            [_dict setObject:@"0" forKey:[NSString stringWithFormat:@"%d",i]];
            
            //NSLog(@"%@",_imageArray);
            
            NSLog(@"%@",_dict);
            
        }
    }
    
    
    

    self.collectionView.allowsMultipleSelection = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initic{
    
    //为当前UICollectionView对象创建布局对象
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake(100, 150);
//    flowLayout.minimumLineSpacing = 6;
//    flowLayout.minimumInteritemSpacing = 6;
//    
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(3, 23, self.view.frame.size.width - 6, self.view.frame.size.height - 25) collectionViewLayout:flowLayout];
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    collectionView.backgroundColor = [UIColor clearColor];
    
    //注册单元格
    identify = @"PhotoCell";
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identify];
    
    //[self.view addSubview:_collectionView];
   
}

#pragma mark -请求数据
//- (void)requestData{
//    
//    _data = [[NSMutableArray alloc] init];
//    
//    NSLog(@"data==========%@",_data);
//    
//    for (int i = 0; i < _data.count; i++) {
//        NSString *imgName = [NSString stringWithFormat:@"%d.jpg",i];
//        UIImage *img = [UIImage imageNamed:imgName];
//        [_data addObject:img];
//       
//    }
//    
//}
//- (void)sd_setImageWithURL:(NSURL *)url{
//
//    for (int i = 0; i < _data.count; i++) {
//       // NSString *imgName = [NSString stringWithFormat:@"%d.jpg",i];
//       
//        [self.imgView sd_setImageWithURL:_imageArray[i]];
//        [_data addObject:_imageArray];
//        
//    }
//
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


#pragma mark -UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

// 单元格代理
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    if([_num intValue]<=indexPath.row)
    {
        _num = [NSNumber numberWithLong:indexPath.row];
    }
    
//    cell.backgroundColor = [UIColor whiteColor];
    
    // UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];

 //   UIImage *img = self.data[indexPath.row];
    
//    UIImageView *imgView = [[UIImageView alloc] init];
    
//    cell.img.backgroundColor = [UIColor redColor];
   
    cell.img.contentMode = UIViewContentModeScaleToFill;
    
    
    
   // imageView.frame = CGRectMake(0, 0, 313, 211);
//    for (int i=0; i<_imageArray.count; i++) {
//        
    
//        [imgView sd_setImageWithURL:_imageArray[indexPath.row]];
    
    NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
    
    
    
    if([[_dict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]] isEqualToString:@"0"])
    {
        //         cell.backgroundColor = [UIColor whiteColor];
        cell.xuanzhong.hidden = YES;
        cell.nozhong.hidden = NO;
        
        [_dictSelect setObject:@"0" forKey:[NSString stringWithFormat:@"%d",indexPath.row+1]];
    
    }
    else
    {
        cell.xuanzhong.hidden = NO;
        cell.nozhong.hidden = YES;
        //        cell.backgroundColor = [UIColor greenColor];
    }
    
    
    if([[online objectForKey:@"online"] isEqualToString:@"1"]&&[_tag isEqualToString:@"1"])
    {
        [cell.img sd_setImageWithURL:_imageArray[indexPath.row]];
//        UIImage*img= [UIImage imageWithData:[NSData dataWithContentsOfURL:_imageArray[indexPath.row]]];
//        [cell.img setImage:img];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
        [manager downloadImageWithURL:_imageArray[indexPath.row] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            //NSLog(@"显示当前进度");
            
            _notPhoto.hidden=YES;
            _allPhoto.hidden=YES;
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            //NSLog(@"下载完成");
            //cell.xuanzhong.hidden = NO;
            cell.nozhong.hidden = NO;
           [_dictSelect setObject:@"1" forKey:[NSString stringWithFormat:@"%d",indexPath.row+1]];
           // _notPhoto.hidden=NO;
            _allPhoto.hidden=NO;
        }];
    }
    else
    {
//        [cell.img sd_setImageWithURL:_imageArray[indexPath.row]];
//        
//        [cell.img sd_setim]
        
        [cell.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:_imageArray[indexPath.row]]]];

    }
    
    
    
   
    
    

   
//        
//         NSLog(@"%@",_imageArray);
//        
//        [cell.contentView addSubview:imageView];
//        NSLog(@"===========%@",_imageArray[i]);
//
//    }
    
  
    
    
    
    return cell;
}



// 单元格选择代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"indexPath:%@:%@",indexPath,[_dict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]]);
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if([[_dictSelect objectForKey:[NSString stringWithFormat:@"%d",indexPath.row+1]] isEqualToString:@"1"])
        
    {
    if([[_dict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]] isEqualToString:@"0"])
    {
        [_dict setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
//        [cell setBackgroundColor:[UIColor greenColor]];
        cell.xuanzhong.hidden = NO;
        cell.nozhong.hidden = YES;
        
    }
    else
    {
        [_dict setObject:@"0" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
//        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.xuanzhong.hidden = YES;
        cell.nozhong.hidden = NO;
    }
    NSLog(@"%@",[_dict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]]);
    }
   
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath:%@:%@",indexPath,[_dict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]]);
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if([[_dictSelect objectForKey:[NSString stringWithFormat:@"%d",indexPath.row+1]] isEqualToString:@"1"])
        
    {
    
    if([[_dict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]] isEqualToString:@"0"])
    {
        [_dict setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
        //        [cell setBackgroundColor:[UIColor greenColor]];
        cell.xuanzhong.hidden = NO;
        cell.nozhong.hidden = YES;
        
    }
    else
    {
        [_dict setObject:@"0" forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
        //        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.xuanzhong.hidden = YES;
        cell.nozhong.hidden = NO;
    }
    
     NSLog(@"%@",[_dict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]]);
    }
}

#pragma mark -View生命周期
- (void)viewWillAppear:(BOOL)animated{
    
//    // 导航栏不透明
//    if (self.navigationController.navigationBar.translucent) {
//        self.navigationController.navigationBar.translucent = NO;
//    }
//    
//    // 隐藏导航栏
//    if (self.navigationController.navigationBarHidden) {
//        self.navigationController.navigationBarHidden = NO;
//    }
           [self.navigationController setNavigationBarHidden:YES animated:animated];
        [super viewWillAppear:animated];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fullAction:(id)sender {
    
        // 深拷贝数据

    
    
        int d=0;
    
//        for (int i = 0; i < [_pages intValue]; i++) {
    
        for (int i =0; i <=[_pages intValue]; i++) {
            
            NSLog(@"%@",_pages);
            if([[_dict objectForKey:[NSString stringWithFormat:@"%d",i]] isEqualToString:@"1"])
            {
//                UIImage *imgMod = _imageArray[i];
                
                
                NSUserDefaults *online=[NSUserDefaults standardUserDefaults];
                
                if([[online objectForKey:@"online"] isEqualToString:@"1"]&&[_tag isEqualToString:@"1"])
                {
                    if(i<=[_num intValue]+1)
                    {
                        UIImageView * imageone = [[UIImageView alloc]init];
                        [imageone sd_setImageWithURL:_imageArray[i-1]];
                        UIImage * imgMod = imageone.image;
                        
                        // [cell.img sd_setImageWithURL:_imageArray[indexPath.row]];
                        //                    UIImage *imgMod =[UIImage imageWithData:[NSData dataWithContentsOfURL:_imageArray[i-1]]];
                        
                        [_imgList addObject:imgMod];
                    }
                    
                }
                else
                {
                    UIImage *imgMod =[UIImage imageWithData:[NSData dataWithContentsOfFile:_imageArray[i-1]]];
                    [_imgList addObject:imgMod];
                    
                }

                if(d==0)
                {
                    d=i;
                }
            }
        }
    
      //   调用展示窗口
        ImgShowViewController *imgShow = [[ImgShowViewController alloc] initWithSourceData:_imgList withIndex:0];
        imgShow.data1 = self;
    imgShow.tag=_tag2;
    
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imgShow];
    
        //[self presentViewController:[nav autorelease] animated:YES completion:nil];
        [self presentViewController:nav animated:YES completion:nil];
    
    
    
    
}
- (IBAction)allPhoto:(id)sender {
    _notPhoto.hidden=NO;
    _allPhoto.hidden=YES;
    for(int i=0;i<[_pages intValue];i++)
    {
//        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:i inSection:0];
//        NSLog();
//        NSLog(@"indexPath:%@",indexPath);
//        PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)[_collectionView cellForItemAtIndexPath:indexPath];
//        cell.xuanzhong.hidden = NO;
//        cell.nozhong.hidden = YES;
        
        [_dict setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",(long)i+1]];
    }
    [_collectionView reloadData];
}

- (IBAction)notPhoto:(id)sender {
    _notPhoto.hidden=YES;
    _allPhoto.hidden=NO;
    for(int i=0;i<[_pages intValue];i++)
    {
//        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:i inSection:0];
//        NSLog(@"indexPath:%@",indexPath);
//        PhotoCollectionViewCell *cell = (PhotoCollectionViewCell*)[_collectionView cellForItemAtIndexPath:indexPath];
//        cell.xuanzhong.hidden = YES;
//        cell.nozhong.hidden = NO;
        
        [_dict setObject:@"0" forKey:[NSString stringWithFormat:@"%ld",(long)i+1]];
    }
    [_collectionView reloadData];
    
}

- (IBAction)goBack:(id)sender {
//    NSDictionary * kindarr = [NSDictionary dictionaryWithObjectsAndKeys:@"chanpin",@"1",@"yixue",@"2",@"zhengce",@"3", @"trace",@"4",nil];
//    [self performSegueWithIdentifier:[kindarr objectForKey:_tag2] sender:self];
    [[self navigationController] popViewControllerAnimated:YES];
    

}
@end
