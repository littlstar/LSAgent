/**
 * `agent.h' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <Foundation/Foundation.h>
#import "request.h"

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
@end
