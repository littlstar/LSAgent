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
 * Request timeout in seconds.
 */

@property (nonatomic, readwrite) NSInteger timeout;

/**
 * Indicates if request should be aborted.
 */

@property (nonatomic, readwrite) BOOL aborted;

/**
 * Query dictionary that is serialized before a request occurs.
 */

@property (nonatomic, strong) NSMutableDictionary *query;

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
 * Unsets a header field by key.
 */

- (instancetype) unset: (NSString *) key;

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

/**
 * Aborts request
 */

- (instancetype) abort;

/**
 * Sets the content type.
 */

- (instancetype) type: (NSString *) type;

/**
 * Gets the content type.
 */

- (NSString *) type;

/**
 * Sets the accept content type.
 */

- (instancetype) accept: (NSString *) type;

/**
 * Sets authorization header with user
 * and password.
 */

- (instancetype) auth: (NSString *) user
                 pass: (NSString *) pass;

/**
 * Deserializes (split by '=') a string and adds it
 * to the query string dictionary if input is an instance
 * of NSString or adds a dictionary of key<>value pairs to query
 * string dictionary if input is an instance of NSDictionary.
 */

- (instancetype) query: (id) query;

/**
 * Gets the query string dictionary.
 */

- (NSDictionary *) query;

@end
