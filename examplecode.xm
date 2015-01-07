if (buttonIndex == 0){
            //Create an object from the AccountStore
            ACAccountStore *accountStore = [[ACAccountStore alloc] init];

            //Create an object specifying the account we want to use ie: Twitter
            ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

            //Request access to the Twitter accounts
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
                if(granted) {
                    //Here we are making an array with the available Twitter accounts
                    NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];

                    //In case there is more than one Twitter account.
                    if ([accountsArray count] > 0) {
                        //Here we set the Twitter account we are going to use as the first one the user added. 
                        ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
                        SLRequest *postRequest = nil;

                        //Setup the message we want sent in the tweet.
                        NSDictionary *message = @{@"status": @"This is an example of where to put the text you want tweeted."};

                        //URL to request
                        NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"];

                        //Make the request and set the Twitter account used
                        postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:requestURL parameters:message];
                        postRequest.account = twitterAccount;

                        //Handle the response
                        [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                            NSLog(@"Here we have Twitters HTTP response: %i", [urlResponse statusCode]);
                            //You could then here specify what happens if you had a sucess repsonse or a failure. For my intentions I was done here.
                            //Twitter response codes can be seen here https://dev.twitter.com/docs/error-codes-responses
                        }];

                    }
                }
            }];
        }
