/**
 * `LSAgentResponse.m' - libLSAgent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <LSAgent/LSAgentResponse.h>

/**
 * LSAgentResponse implementation.
 */

@implementation LSAgentResponse
@synthesize body;
@synthesize headers;
@synthesize statusCode;

/**
 * Creates an instance of `LSAgentResponse' from
 * an initiated request.
 */

+ (id) new: (LSAgentRequest *) request {
  return (id) [[self alloc] init: request];
}

/**
 * Class initializer from `LSAgentRequest'.
 */

- (id) init: (LSAgentRequest *) request {
  self = [super init];
  _request = request;
  _response = nil;
  headers = nil;
  return self;
}

/**
 * Initializes response with native response.
 */

- (id) initializeWithNativeResponse: (NSURLResponse *) response {
  _response = (NSHTTPURLResponse *) response;
  if ([_response respondsToSelector: @selector(allHeaderFields)]) {
    headers = _response.allHeaderFields;
  }
  statusCode = _response.statusCode;
  return self;
}

/**
 * Sets response body.
 */

- (id) setBody: (NSData *) b {
  body = b;
  return self;
}
@end
