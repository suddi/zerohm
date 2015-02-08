#import "ZWeb.h"

#define SALT1 251
#define SALT2 131
#define SALT3 3571

#define SUBMIT_URL "http://mike.struct.cn/zerohm/submit/"
#define REGISTER_URL "http://mike.struct.cn/zerohm/register/"

// Submit result and get the server response 
static NSString* __get_server_response(NSString* url, NSString* queryString)
{
    NSData* body = [[NSData alloc] initWithBytes: [queryString UTF8String]
                                          length: [queryString length]];
    NSMutableURLRequest* req = [[NSMutableURLRequest alloc]
                                   initWithURL: [NSURL URLWithString: url]];
    [req setHTTPMethod: @"POST"];
    [req setHTTPBody: body];
    NSData* responseData = [NSURLConnection sendSynchronousRequest: req 
                                                 returningResponse: nil
                                                             error: nil];
    [body release];
    [req release];
    
    return [[[NSString alloc] initWithData: responseData
                                  encoding: NSUTF8StringEncoding] autorelease];
}

// Submit score to server
NSString* ZWebSubmitScore(NSString* username, NSString* password, int score)
{
    int salt = SALT1 * (score + SALT2) % SALT3;
    NSString* queryString = [NSString stringWithFormat: @"username=%@&password=%@&score=%d&salt=%d",
                                      [username stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
                                      [password stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
                                      score, salt];
    return __get_server_response(@SUBMIT_URL, queryString);
}

// Pass new user registration to server
NSString* ZWebRegisterUser(NSString* username, NSString* password, NSString* email)
{
    NSString* queryString = [NSString stringWithFormat: @"username=%@&password=%@&email=%@",
                                      [username stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
                                      [password stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
                                      [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    printf("%s\n", [queryString UTF8String]);
    return __get_server_response(@REGISTER_URL, queryString);
}

