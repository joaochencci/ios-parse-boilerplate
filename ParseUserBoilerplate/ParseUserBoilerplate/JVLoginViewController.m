//
//  JVLoginViewController.m
//  ParseUserBoilerplate
//
//  Created by Joao Victor Chencci Marques on 04/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "JVLoginViewController.h"

#import "JVModels.h"

@interface JVLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usrTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextfield;

@end

@implementation JVLoginViewController

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
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogin:(id)sender {
    if (![self validEmail]) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Erro ao cadastrar";
        NSString *message = @"Por favor, insira um email válido.";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (self.pwdTextfield.text.length < 6) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Erro ao entrar";
        NSString *message = @"Sua senha deve conter pelo menos 6 caracteres.";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [JVUser logInWithUsernameInBackground:self.usrTextfield.text password:self.pwdTextfield.text block:^(PFUser *    user, NSError *error) {
        if (error) {
            NSLog(@"ERROR: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] init];
            
            NSString *title = @"Erro ao entrar";
            NSString *message = @"";
            
            if (error.code == 101) {
                message = @"Email ou senha inválidos!";
            }
            
            alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            JVUser *myUser = (JVUser *)user;
            NSLog(@"DATA %@", myUser);
            
            [self performSegueWithIdentifier:@"successLogin" sender:self];
        }
    }];
}

#pragma mark - Support Methods
- (BOOL)validEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if(![emailTest evaluateWithObject:self.usrTextfield.text])
    {
        return NO;
    }
    return YES;
}

-(void)dismissKeyboard
{
    [self.usrTextfield resignFirstResponder];
    [self.pwdTextfield resignFirstResponder];
    
}

@end
