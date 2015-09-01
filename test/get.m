/**
 * `test/get.m' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <agent/agent.h>

int
main (void) {
  AgentRequest *req = [Agent get: @"http://localhost:3000/data/content/most-popular"];
  [req set: @"" value: @""];
  return 0;
}
