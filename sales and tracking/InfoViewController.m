//
//  InfoViewController.m
//  sales and tracking
//
//  Created by Sejal Pandya on 10/8/12.
//
//

#import "InfoViewController.h"
#import "PDFScrollView.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *pdfURL = [[NSBundle mainBundle] URLForResource:@"Info" withExtension:@"pdf"];

    CGPDFDocumentRef PDFDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfURL);

    CGPDFPageRef PDFPage = CGPDFDocumentGetPage(PDFDocument, 1);
    PDFScrollView *pdfView = [self.view.subviews objectAtIndex:0];
    pdfView.minimumZoomScale = 2.5f;
    pdfView.maximumZoomScale = 2.5f;

    [pdfView setPDFPage:PDFPage];


    CGPDFDocumentRelease(PDFDocument);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
