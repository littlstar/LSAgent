/**
 * `LSAgent.m' - libLSAgent
 *
 * Copyright (2) 2015 - Littlstar
 */

#import <LSAgent/LSAgent.h>
#import <LSAgent/LSAgentRequest.h>

@implementation LSAgent

/**
 * Creates and returns a GET HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) get: (NSString *) url {
  return [LSAgentRequest new: AGENT_GET url: url];
}

/**
 * Creates and returns a POST HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) post: (NSString *) url {
  return [LSAgentRequest new: AGENT_POST url: url];
}

/**
 * Creates and returns a PUT HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) put: (NSString *) url {
  return [LSAgentRequest new: AGENT_PUT url: url];
}

/**
 * Creates and returns a DELETE HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) delete: (NSString *) url {
  return [LSAgentRequest new: AGENT_DELETE url: url];
}

/**
 * Creates and returns a HEAD HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) head: (NSString *) url {
  return [LSAgentRequest new: AGENT_HEAD url: url];
}

/**
 * Creates and returns a OPTIONS HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) options: (NSString *) url {
  return [LSAgentRequest new: AGENT_OPTIONS url: url];
}

/**
 * Creates and returns a PATCH HTTP `LSAgentRequest' instance.
 */

+ (LSAgentRequest *) patch: (NSString *) url {
  return [LSAgentRequest new: AGENT_PATCH url: url];
}
@end
