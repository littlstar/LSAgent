/**
 * `response.m' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <agent/response.h>

/**
 * AgentResponse implementation.
 */

@implementation AgentResponse
@synthesize body;
@synthesize headers;
@synthesize statusCode;

/**
 * Creates an instance of `AgentResponse' from
 * an initiated request.
 */

+ (id) new: (AgentRequest *) request {
  return (id) [[self alloc] init: request];
}

/**
 * Class initializer from `AgentRequest'.
 */

- (id) init: (AgentRequest *) request {
  [super init];
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
