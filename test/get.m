/**
 * `test/get.m' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <agent/agent.h>

int
main (void) {
  AgentRequest *req = [Agent get: @"http://localhost:3000/data/content/most-popular"];
  //AgentRequest *req = [Agent get: @"http://google.com"];
  [[req accept: @"json"] end: ^void (AgentRequestError *err, AgentResponse *res) {
    if (err) {
      NSLog(@"Error: %@", err);
    } else {
      NSLog(@"Success");
    }

    CFRunLoopStop(CFRunLoopGetCurrent());
  }];

  // start CF loop
  CFRunLoopRun();
  return 0;
}
