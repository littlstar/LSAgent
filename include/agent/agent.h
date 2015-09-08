/**
 * `agent.h' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <Foundation/Foundation.h>
#import <agent/request.h>
#import <agent/response.h>

/**
 * Public interface for using the objective
 * agent API. Methods labeled as HTTP verbs
 * return `AgentRequest' instances which should
 * be interacted with directly.
 */

@interface Agent : NSObject

/**
 * Creates and returns a GET HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) get: (NSString *) url;

/**
 * Creates and returns a POST HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) post: (NSString *) url;

/**
 * Creates and returns a PUT HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) put: (NSString *) url;

/**
 * Creates and returns a DELETE HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) delete: (NSString *) url;

/**
 * Creates and returns a HEAD HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) head: (NSString *) url;

/**
 * Creates and returns a OPTIONS HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) options: (NSString *) url;

/**
 * Creates and returns a PATCH HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) patch: (NSString *) url;
@end
