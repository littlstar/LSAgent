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
 * Creates an instance of `AgentResponse' from
 * an initiated request.
 */

+ (id) new: (AgentRequest *) request;

/**
 * Class initializer from `AgentRequest'.
 */

- (id) init: (AgentRequest *) request;
@end
