/**
 * `request.m' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <agent/agent.h>
#import <agent/request.h>

/**
 * AgentRequest class implementation. This class
 * is never used directly but rather returned from
 * the agent API interface.
 */

@implementation AgentRequest

/**
 * Creates an instance of `AgentRequest' from
 * an agent request method and URL.
 */

+ (id) new: (AgentRequestMethod) method url: (NSString *) url {
  AgentRequest *me = [[self alloc] init: method url: url];
  return (id) me;
}

/**
 * Class initializer.
 */

- (id) init: (AgentRequestMethod) method url: (NSString *) url {
  [super init];
  _method = AGENT_GET;
  _url = @"";
  _timeout = 0;
  return self;
}

/**
 * Sets header field by key with value.
 */

- (instancetype) set: (NSString *) key value: (NSString *) value {
  _headers[[key lowercaseString]] = value;
  return self;
}

/**
 * Sets header fields with a dictionary.
 */

- (instancetype) set: (NSDictionary *) headers  {
  for (id key in headers)
    [self set: key value: headers[key]];
  return self;
}

/**
 * Gets header field value by key.
 */

- (NSString *) get: (NSString *) key {
  return _headers[[key lowercaseString]];
}

/**
 * Set a timeout in seconds.
 */

- (instancetype) timeout: (NSInteger) timeout {
  _timeout = timeout;
  return self;
}

/**
 * Get timeout in seconds
 */

- (NSInteger) timeout {
  return _timeout;
}
@end
