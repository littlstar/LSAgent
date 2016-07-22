/**
 * `LSAgentRequest.h' - libLSAgent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <Foundation/Foundation.h>

/**
 * Class dependencies.
 */

@class LSAgentResponse;
@class LSAgentRequestError;

/**
 * LSAgent request HTTP verbs.
 */

typedef NS_ENUM(NSInteger, LSAgentRequestMethod) {
  AGENT_GET,
  AGENT_POST,
  AGENT_PUT,
  AGENT_DELETE,
  AGENT_HEAD,
  AGENT_OPTIONS,
  AGENT_PATCH
};

/**
 * Request response callback.
 */

typedef void (^LSAgentRequestResponseBlock)(LSAgentRequestError *err,
                                            LSAgentResponse *res);

/**
 * LSAgentRequestError class interface.
 */

@interface LSAgentRequestError : NSError

/**
 * Error message string.
 */

@property (nonatomic, readonly) NSString *message;
@end

/**
 * LSAgentRequest class interface.
 */

@interface LSAgentRequest : NSObject

/**
 * The type of HTTP request to make.
 */

@property (readwrite) LSAgentRequestMethod method;

/**
 * Headers dictionary used by set/get.
 */

@property (readwrite, strong) NSMutableDictionary *headers;

/**
 * The HTTP request URL as an instance of NSURL
 */

@property (nonatomic, strong) NSURL *url;

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
 * Form data dictionary.
 */

@property (nonatomic, strong) NSMutableDictionary *form;

/**
 * Attachment file paths dictionary.
 */

@property (nonatomic, strong) NSMutableDictionary *attachments;

/**
 * Request data.
 */

@property (nonatomic, strong) id data;

/**
 * Internal request object.
 */

@property (nonatomic, strong) NSMutableURLRequest *request;

/**
 * Received request data.
 */

@property (nonatomic, strong) NSMutableData *received;

/**
 * Request callback.
 */

@property (nonatomic, copy) LSAgentRequestResponseBlock callback;

/**
 * The native request response instance.
 */

@property (nonatomic, strong) NSURLResponse *response;

/**
 * Creates an instance of `LSAgentRequest' from
 * an agent request method and URL.
 */

+ (id) new: (LSAgentRequestMethod) method
       url: (id) url;

/**
 * Class initializer from url.
 */

- (id) init: (LSAgentRequestMethod) method
        url: (NSURL *) url;

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

/**
 * Adds a field for form data.
 */

- (instancetype) field: (NSString *) key
                 value: (NSString *) value;

/**
 * Append an attach
 */

- (instancetype) attach: (NSString *) key
                   path: (NSString *) path;

/**
 * Sends data and will infer content type
 * from class type.
 */

- (instancetype) send: (id) data;

/**
 * Invokes request calling a given callback
 * block.
 */

- (instancetype) end: (LSAgentRequestResponseBlock) done;
@end
