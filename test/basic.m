/**
 * `test/get.m' - libLSAgent
 *
 * copyright (2) 2015 - Littlstar
 */

#import "test.h"
#import <assert.h>
#import <LSAgent/LSAgent.h>
#import "../deps/LSBatch/LSBatch.h"

int
main (void) {
  LSBatch *batch = [LSBatch new: 1];
  LABEL("basic");

  [batch push: ^(LSBatchNextCallback next) {
    BEGIN("/echo");
    [[LSAgent get: @URL("/echo")]
              end: ^(LSAgentRequestError *err, LSAgentResponse *res) {
                assert(nil == err);
                assert(res);
                assert(200 == res.statusCode);
                OK("/echo");
                next(nil);
              }];
  }];

  [batch push: ^(LSBatchNextCallback next) {
    BEGIN("/ok");
    [[LSAgent get: @URL("/ok")]
              end: ^(LSAgentRequestError *err, LSAgentResponse *res) {
                assert(nil == err);
                assert(res);
                assert(200 == res.statusCode);
                NSString *str = [NSString stringWithUTF8String: res.body.bytes];
                assert([str isEqualTo: @"ok"]);
                OK("/ok");
                next(err);
              }];
  }];

  [batch end: ^(NSError *err) {
    assert(nil == err);
    END();
  }];

  return START();
}
