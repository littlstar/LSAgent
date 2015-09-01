/**
 * `request.h' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <Foundation/Foundation.h>
#import <agent/agent.h>

/**
 * Agent request HTTP verbs.
 */

typedef NS_ENUM(NSInteger, AgentRequestMethod) {
  AGENT_GET,
  AGENT_POST,
  AGENT_PUT,
  AGENT_DELETE,
  AGENT_HEAD,
  AGENT_OPTIONS,
  AGENT_PATCH
};

/**
 * AgentRequest class interface.
 */

@interface AgentRequest : NSObject

/**
 * The type of HTTP request to make.
 */

@property (readwrite) AgentRequestMethod method;

/**
 * Headers dictionary used by set/get.
 */

@property (readwrite, strong) NSMutableDictionary *headers;

/**
 * The HTTP request URL.
 */

@property (nonatomic, assign) NSString *url;

/**
 * The HTTP request query string dictionary.
 */

@property (readwrite, strong) NSMutableDictionary *query;

/**
 * Request timeout in seconds.
 */

@property (nonatomic, readwrite) NSInteger timeout;

/**
 * Creates an instance of `AgentRequest' from
 * an agent request method and URL.
 */

+ (id) new: (AgentRequestMethod) method
       url: (NSString *) url;

/**
 * Class initializer.
 */

- (id) init: (AgentRequestMethod) method
        url: (NSString *) url;

/**
 * Sets header field by key with value.
 */

- (instancetype) set: (NSString *) key
               value: (NSString *) value;

/**
 * Sets header fields with a dictionary.
 */

- (instancetype) set: (NSDictionary *) headers;

/**
 * Gets header field value by key.
 */

- (NSString *) get: (NSString *) key;

/**
 * Set a timeout in seconds.
 */

- (instancetype) timeout: (NSInteger) timeout;

/**
 * Get timeout in seconds
 */

- (NSInteger) timeout;

@end
