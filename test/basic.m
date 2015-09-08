/**
 * `test/get.m' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <assert.h>
#import <agent/agent.h>

// Base HTTP URI structure.
#define BASE_URI "http://localhost:3000"

// helper for stringifing a URI
#define URLX(u) u

// Creates a URI from BASE_URI
#define URL(u) BASE_URI URLX(u)

// Notify run loop we're done
#define DONE() CFRunLoopStop(CFRunLoopGetCurrent());

int
main (void) {
  [[Agent get: @URL("/echo")]
          end: ^void (AgentRequestError *err, AgentResponse *res) {
    assert(nil == err);
    assert(res);
    assert(200 == res.statusCode);
    DONE();
  }];

  // start CF loop
  CFRunLoopRun();
  return 0;
}
