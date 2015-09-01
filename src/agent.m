/**
 * `agent.m' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <agent/agent.h>
#import <agent/request.h>

@implementation Agent

/**
 * Creates and returns a GET HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) get: (NSString *) url {
  return [AgentRequest new: AGENT_GET url: url];
}
@end
