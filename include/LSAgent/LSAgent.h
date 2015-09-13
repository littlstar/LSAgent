/**
 * `LSAgent.h' - libLSAgent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <Foundation/Foundation.h>
#import <LSAgent/LSAgentRequest.h>
#import <LSAgent/LSAgentResponse.h>

/**
 * Public interface for using the objective
 * agent API. Methods labeled as HTTP verbs
 * return `LSAgentRequest' instances which should
 * be interacted with directly.
 */

@interface LSAgent : NSObject
/**
 * Creates and returns a GET HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) get: (NSString *) url;

/**
 * Creates and returns a POST HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) post: (NSString *) url;

/**
 * Creates and returns a PUT HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) put: (NSString *) url;

/**
 * Creates and returns a DELETE HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) delete: (NSString *) url;

/**
 * Creates and returns a HEAD HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) head: (NSString *) url;

/**
 * Creates and returns a OPTIONS HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) options: (NSString *) url;

/**
 * Creates and returns a PATCH HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) patch: (NSString *) url;
@end
