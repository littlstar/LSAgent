/**
 * `LSAgentResponse.h' - libLSAgent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <Foundation/Foundation.h>

/**
 * Class dependencies.
 */

@class LSAgentRequest;

/**
 * LSAgentResponse class interface.
 */

@interface LSAgentResponse : NSObject

/**
 * The initiating request object for this response.
 */

@property (nonatomic, strong) LSAgentRequest *request;

/**
 * Response headers.
 */

@property (nonatomic, strong) NSDictionary *headers;

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
 * Creates an instance of `LSAgentResponse' from
 * an initiated request.
 */

+ (id) new: (LSAgentRequest *) request;

/**
 * Class initializer from `LSAgentRequest'.
 */

- (id) init: (LSAgentRequest *) request;

/**
 * Initializes response with native response.
 */

- (id) initializeWithNativeResponse: (NSURLResponse *) response;

/**
 * Sets response body.
 */

- (id) setBody: (NSData *) body;
@end
