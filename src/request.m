/**
 * `request.m' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <agent/agent.h>
#import <agent/request.h>

/**
 * Predicate to determine if `a' is a
 * class of `b'
 */

#define isTypeof(a, b) [a isKindOfClass: [b class]]

/**
 * Converts a string to a base64 encoded
 * string.
 */

#define btoa(s) (                                \
  [[s dataUsingEncoding: NSUTF8StringEncoding]   \
    base64EncodedStringWithOptions: 0]           \
)

/**
 * Determines a content type from
 * an alias string.
 */

static NSString *
determineType (NSString *type) {
  // content type sugar
  if ([type isEqualToString: @"html"]) {
    type = @"text/html";
  }

  if ([type isEqualToString: @"json"]) {
    type = @"application/json";
  }

  if ([type isEqualToString: @"xml"]) {
    type = @"application/xml";
  }

  if ([type isEqualToString: @"urlencoded"] ||
      [type isEqualToString: @"form"] ||
      [type isEqualToString: @"urlencoded"]) {
    type = @"application/x-www-form-urlencoded";
  }

  return type;
}

/**
 * Serializes a dictionary into
 * a URI encoded query string.
 */

static NSString *
serialize (id obj) {
  if (isTypeof(obj, NSString)) return obj;
  NSMutableArray *parts = [[NSMutableArray alloc] init];
  for (id key in obj) {
    if (obj[key]) {
      NSString *enc = [
        NSString stringWithFormat: @"%@=%@",
        [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
        [(NSString *) obj[key] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
      [parts addObject: enc];
    }
  }
  return [parts componentsJoinedByString: @"&"];
}

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
 * Unsets a header field by key.
 */

- (instancetype) unset: (NSString *) key {
  [_headers removeObjectForKey: [key lowercaseString]];
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

/**
 * Aborts request
 */

- (instancetype) abort {
  _aborted = YES;
  return self;
}

/**
 * Sets the content type.
 */

- (instancetype) type: (NSString *) type {
  return [self set: @"Content-Type" value: determineType(type)];
}

/**
 * Gets the content type.
 */

- (NSString *) type {
  return _headers[@"content-type"];
}

/**
 * Sets the accept content type.
 */

- (instancetype) accept: (NSString *) type {
  return [self set: @"Accept" value: determineType(type)];
}

/**
 * Sets authorization header with user
 * and password.
 */

- (instancetype) auth: (NSString *) user pass: (NSString *) pass {
  NSString *auth = [NSString stringWithFormat: @"%@:%@", user, pass];
  NSString *value = [NSString stringWithFormat: @"Basic %@", btoa(auth)];
  return [self set: @"Authorization" value: value];
}

/**
 * Adds dictionary of key<>value pairs to query
 * string dictionary.
 */

- (instancetype) query: (id) query {
  if (isTypeof(query, NSString)) {

  } else if (isTypeof(query, NSDictionary)) {

  } else {
    [NSException raise: @"Invalid query value"
                format: @"query of %@ is invalid", query];
  }
  return self;
}

/**
 * Gets the query string dictionary.
 */

- (NSDictionary *) query {
  return [NSDictionary dictionaryWithDictionary: _query];
}

@end
