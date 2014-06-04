//
//  JVSignupViewController.m
//  ParseUserBoilerplate
//
//  Created by Joao Victor Chencci Marques on 04/06/14.
//  Copyright (c) 2014 devnup. All rights reserved.
//

#import "JVSignupViewController.h"

#import "JVModels.h"

@interface JVSignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextfield;
@property (weak, nonatomic) IBOutlet UITextField *rpwdTextfield;

@end

@implementation JVSignupViewController

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

- (IBAction)performSignup:(id)sender {
    
    if (![self validEmail]) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Erro ao cadastrar";
        NSString *message = @"Por favor, insira um email válido.";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (![self.pwdTextfield.text isEqualToString:self.rpwdTextfield.text]) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Erro ao cadastrar";
        NSString *message = @"As senhas devem ser iguais";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (self.pwdTextfield.text.length < 6 || self.rpwdTextfield.text.length < 6) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        NSString *title = @"Erro ao cadastrar";
        NSString *message = @"Sua senha deve conter pelo menos 6 caracteres.";
        
        alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    JVUser *myUser = [[JVUser alloc] initWithUsername:self.emailTextfield.text andPassword:self.pwdTextfield.text];
    [myUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"SUCCESS: %d", succeeded);
            [self performSegueWithIdentifier:@"successSignup" sender:self];
        } else {
            NSLog(@"ERROR: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] init];
            
            NSString *title = @"Erro ao cadastrar";
            NSString *message = @"";
            
            if (error.code == 200) {
                message = @"Por favor, insira seu email.";
            }
            
            if (error.code == 201) {
                message = @"Por favor, insira sua senha corretamente.";
            }
            
            if (error.code == 202 || error.code == 203) {
                message = @"Este email já está sendo utilizado.";
            }
            
            alert = [alert initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

#pragma mark - Support Methods

- (BOOL)validEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if(![emailTest evaluateWithObject:self.emailTextfield.text])
    {
        return NO;
    }
    return YES;
}

-(void)dismissKeyboard
{
    [self.emailTextfield resignFirstResponder];
    [self.pwdTextfield resignFirstResponder];
    [self.rpwdTextfield resignFirstResponder];
    
}

@end
