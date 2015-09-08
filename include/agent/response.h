/**
 * `respons.h' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <Foundation/Foundation.h>

/**
 * Class dependencies.
 */

@class AgentRequest;

/**
 * AgentResponse class interface.
 */

@interface AgentResponse : NSObject

/**
 * The initiating request object for this response.
 */

@property (nonatomic, strong) AgentRequest *request;

/**
 * Response headers.
 */

@property (nonatomic, assign) NSDictionary *headers;

/**
 * Native response object.
 */

@property (nonatomic, strong) NSHTTPURLResponse *response;

/**
 * HTTP response status code number.
 */

@property (nonatomic, readonly) long statusCode;

/**
 * Response body.
 */

@property (nonatomic, readonly) NSData *body;

/**
 * Creates an instance of `AgentResponse' from
 * an initiated request.
 */

+ (id) new: (AgentRequest *) request;

/**
 * Class initializer from `AgentRequest'.
 */

- (id) init: (AgentRequest *) request;

/**
 * Initializes response with native response.
 */

- (id) initializeWithNativeResponse: (NSURLResponse *) response;

/**
 * Sets response body.
 */

- (id) setBody: (NSData *) body;
@end
