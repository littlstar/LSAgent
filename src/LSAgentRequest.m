/**
 * `request.m' - libagent
 *
 * copyright (2) 2015 - Littlstar
 */

#import <LSAgent/LSAgentRequest.h>
#import <LSAgent/LSAgentResponse.h>

/**
 * Predicate to determine if `a' is a
 * class of `b'
 */

#define isTypeof(a, b) [a isKindOfClass: [b class]]

/**
 * Converts a string to a base64 encoded
 * string.
 */

#define btoa(s) (                                \
[[s dataUsingEncoding: NSUTF8StringEncoding]   \
base64EncodedStringWithOptions: 0]           \
)

/**
 * Make a new thing.
 */

#define new(C) C.alloc.init

/**
 * Determines a content type from
 * an alias string.
 */

static NSString *
determineType (NSString *type) {
    // content type sugar
    if ([type isEqualToString: @"html"]) {
        type = @"text/html";
    }
    
    if ([type isEqualToString: @"json"]) {
        type = @"application/json";
    }
    
    if ([type isEqualToString: @"xml"]) {
        type = @"application/xml";
    }
    
    if ([type isEqualToString: @"urlencoded"] ||
        [type isEqualToString: @"form"] ||
        [type isEqualToString: @"urlencoded"]) {
        type = @"application/x-www-form-urlencoded";
    }
    
    return type;
}

/**
 * Serializes a dictionary into
 * a URI encoded query string.
 */

static NSString *
serialize (id obj) {
    if (isTypeof(obj, NSString)) return obj;
    NSMutableArray *parts = new(NSMutableArray);
    for (id key in obj) {
        if (obj[key]) {
            NSString *enc = [
                             NSString stringWithFormat: @"%@=%@",
                             [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
                             [(NSString *) obj[key] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
            [parts addObject: enc];
        }
    }
    return [parts componentsJoinedByString: @"&"];
}

/**
 * LSAgentRequestError implementation.
 */

@implementation LSAgentRequestError
@synthesize message;
@end

/**
 * NSURLConnection protocol methods.
 */

@interface LSAgentResponse ()

/**
 * Handle event when request connection receives
 * a response.
 */

- (void) connection: (NSURLConnection *) connection
 didReceiveResponse: (NSURLResponse *) response;

/**
 * Handle event when request connection receives
 * response data.
 */

- (void) connection: (NSURLConnection *) connection
     didReceiveData: (NSData *) data;

/**
 * Handle event when request connection receives
 * an error.
 */

- (void) connection: (NSURLConnection *) connection
   didFailWithError: (NSError *) error;

/**
 * Handle event when request connection finishes
 * receiving data.
 */

- (void) connectionDidFinishLoading: (NSURLConnection *) connection;
@end

/**
 * LSAgentRequest class implementation. This class
 * is never used directly but rather returned from
 * the agent API interface.
 */

@implementation LSAgentRequest

/**
 * Creates an instance of `LSAgentRequest' from
 * an agent request method and URL.
 */

+ (id) new: (LSAgentRequestMethod) method url: (id) input {
    NSURL *url;
    if (isTypeof(input, NSString)) {
        url = [NSURL URLWithString: input];
    }
    
    NSLog(@"URL is %@", url);
    if (!isTypeof(url, NSURL)) {
        [NSException raise: @"Invalid URL"
                    format: @"[LSAgentRequest new:url] expects NSString or NSURL."];
        return nil;
    }
    
    id me = (id) [[self alloc] init: method url: url];
    return me;
}

/**
 * Class initializer from url
 */

- (id) init: (LSAgentRequestMethod) method url: (NSURL *) url {
    self = [super init];
    _url = url;
    _data = nil;
    _form = new(NSMutableDictionary);
    _query = new(NSMutableDictionary);
    _method = method;
    _headers = new(NSMutableDictionary);
    _aborted = NO;
    _timeout = 0;
    _attachments = new(NSMutableDictionary);
    return self;
}

/**
 * Sets header field by key with value.
 */

- (instancetype) set: (NSString *) key value: (NSString *) value {
    _headers[[key lowercaseString]] = value;
    return self;
}

/**
 * Sets header fields with a dictionary.
 */

- (instancetype) set: (NSDictionary *) headers  {
    for (id key in headers)
        [self set: key value: headers[key]];
    return self;
}

/**
 * Unsets a header field by key.
 */

- (instancetype) unset: (NSString *) key {
    [_headers removeObjectForKey: [key lowercaseString]];
    return self;
}

/**
 * Gets header field value by key.
 */

- (NSString *) get: (NSString *) key {
    return _headers[[key lowercaseString]];
}

/**
 * Set a timeout in seconds.
 */

- (instancetype) timeout: (NSInteger) timeout {
    _timeout = timeout;
    return self;
}

/**
 * Get timeout in seconds
 */

- (NSInteger) timeout {
    return _timeout;
}

/**
 * Aborts request
 */

- (instancetype) abort {
    _aborted = YES;
    return self;
}

/**
 * Sets the content type.
 */

- (instancetype) type: (NSString *) type {
    return [self set: @"Content-Type" value: determineType(type)];
}

/**
 * Gets the content type.
 */

- (NSString *) type {
    return _headers[@"content-type"];
}

/**
 * Sets the accept content type.
 */

- (instancetype) accept: (NSString *) type {
    return [self set: @"Accept" value: determineType(type)];
}

/**
 * Sets authorization header with user
 * and password.
 */

- (instancetype) auth: (NSString *) user pass: (NSString *) pass {
    NSString *auth = [NSString stringWithFormat: @"%@:%@", user, pass];
    NSString *value = [NSString stringWithFormat: @"Basic %@", btoa(auth)];
    return [self set: @"Authorization" value: value];
}

/**
 * Adds dictionary of key<>value pairs to query
 * string dictionary.
 */

- (instancetype) query: (id) query {
    if (isTypeof(query, NSString)) {
        NSArray *parts = [query componentsSeparatedByString: @"="];
        NSString *key = (NSString *) parts[0];
        NSString *value = (NSString *) parts[1];
        _query[key] = value;
    } else if (isTypeof(query, NSDictionary)) {
        for (id key in query)
            _query[key] = query[key];
    } else {
        [NSException raise: @"Invalid query value"
                    format: @"query of %@ is invalid", query];
    }
    return self;
}

/**
 * Gets the query string dictionary.
 */

- (NSDictionary *) query {
    return [NSDictionary dictionaryWithDictionary: _query];
}

/**
 * Adds a field for form data.
 */

- (instancetype) field: (NSString *) key value: (NSString *) value {
    _form[key] = value;
    return self;
}

/**
 * Append an attach
 */

- (instancetype) attach: (NSString *) key path: (NSString *) path {
    _attachments[key] = path;
    return self;
}

/**
 * Sends data and will infer content type
 * from class type.
 */

- (instancetype) send: (id) data {
    NSString *type = [self get: @"content-type"];
    _data = data;
    if (!type) {
        if (isTypeof(data, NSString)) {
            [self type: @"html"];
        }
        
        if (isTypeof(data, NSArray)) {
            [self type: @"json"];
        }
        
        if (isTypeof(data, NSDictionary)) {
            [self type: @"json"];
        }
    }
    return self;
}

/**
 * Invokes request calling a given callback
 * block.
 */

- (instancetype) end: (LSAgentRequestResponseBlock) done {
    NSString *queryString = nil;
    NSString *httpmethod = nil;
    NSData *payload = nil;
    
    if (_query && [_query count]) {
        queryString = serialize(_query);
    }
    
    // set callback
    _callback = [done copy];
    
    // initialize request
    _request = [[NSMutableURLRequest alloc]
                initWithURL: _url
                ];
    
    // set timeout
    [_request setTimeoutInterval: _timeout];
    
    // determine HTTP method
    switch (_method) {
        case AGENT_GET: httpmethod = @"GET"; break;
        case AGENT_PUT: httpmethod = @"PUT"; break;
        case AGENT_POST: httpmethod = @"POST"; break;
        case AGENT_HEAD: httpmethod = @"HEAD"; break;
        case AGENT_PATCH: httpmethod = @"PATCH"; break;
        case AGENT_DELETE: httpmethod = @"DELETE"; break;
        case AGENT_OPTIONS: httpmethod = @"OPTIONS"; break;
        default: [NSException raise: @"Invalid method" format: @""];
    }
    
    // set method
    [_request setHTTPMethod: httpmethod];
    
    // set content length if applicable
    if (_method == AGENT_PUT || _method == AGENT_POST) {
        NSLog(@"data in JSON is %@", _data);
        
        if (isTypeof(_data, NSString)) {
            [self set: @"Content-Length" value: [
                                                 NSString stringWithFormat: @"%d",
                                                 (unsigned int) [(NSString *) _data length]
                                                 ]];
            
            payload = [_data dataUsingEncoding: NSUTF8StringEncoding];
            [_request setHTTPBody: payload];
        } else if (isTypeof(_data, NSMutableDictionary) ||
                   isTypeof(_data, NSMutableArray) ||
                   isTypeof(_data, NSDictionary)){
            NSError *err = nil;
            payload = [NSJSONSerialization dataWithJSONObject: _data
                                                      options: 0
                                                        error: &err];
            
            if (err == nil) [_request setHTTPBody: payload];
            else {
                NSLog(@"SerializationError: %@", err);
                return self;
            }
        }
    }
    
    // initialize headers
    for (id key in _headers) {
        [_request setValue: _headers[key]
        forHTTPHeaderField: key
         ];
    }
    
    // create connection
    NSURLConnection *conn = [[NSURLConnection alloc]
                             initWithRequest: _request
                             delegate: self
                             startImmediately: YES
                             ];
    
    // shutup
    (void) conn;
    return self;
}

#pragma mark NSURLConnection delegate methods

/**
 * Handle event when request connection receives
 * a response.
 */

- (void) connection: (NSURLConnection *) connection
 didReceiveResponse: (NSURLResponse *) response {
    _received = new(NSMutableData);
    _response = response.copy;
}

/**
 * Handle event when request connection receives
 * response data.
 */

- (void) connection: (NSURLConnection *) connection
     didReceiveData: (NSData *) data {
    [_received appendData: data];
}

/**
 * Handle event when request connection receives
 * an error.
 */

- (void) connection: (NSURLConnection *) connection
   didFailWithError: (NSError *) error {
    _callback((LSAgentRequestError *) error, nil);
}

/**
 * Handle event when request connection finishes
 * receiving data.
 */

- (void) connectionDidFinishLoading: (NSURLConnection *) connection {
    LSAgentResponse *res = [LSAgentResponse new: self];
    [res initializeWithNativeResponse: _response];
    if (_received) {
        [res setBody: [NSData dataWithData: _received]];
    }
    _callback(nil, res);
}
@end
