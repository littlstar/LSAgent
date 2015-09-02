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
  return self;
}
@end
