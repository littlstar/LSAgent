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

/**
 * Creates and returns a POST HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) post: (NSString *) url {
  return [AgentRequest new: AGENT_POST url: url];
}

/**
 * Creates and returns a PUT HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) put: (NSString *) url {
  return [AgentRequest new: AGENT_PUT url: url];
}

/**
 * Creates and returns a DELETE HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) delete: (NSString *) url {
  return [AgentRequest new: AGENT_DELETE url: url];
}

/**
 * Creates and returns a HEAD HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) head: (NSString *) url {
  return [AgentRequest new: AGENT_HEAD url: url];
}

/**
 * Creates and returns a OPTIONS HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) options: (NSString *) url {
  return [AgentRequest new: AGENT_OPTIONS url: url];
}

/**
 * Creates and returns a PATCH HTTP `AgentRequest' instance.
 */

+ (AgentRequest *) patch: (NSString *) url {
  return [AgentRequest new: AGENT_PATCH url: url];
}
@end
