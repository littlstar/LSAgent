
static const char *label = "";

// Base HTTP URI structure.
#define BASE_URI "http://localhost:3000"

// helper for stringifing a URI
#define URLX(u) u

// Creates a URI from BASE_URI
#define URL(u) BASE_URI URLX(u)

// Notify run loop we're done
#define DONE() CFRunLoopStop(CFRunLoopGetCurrent())

// start CF loop
#define START() (CFRunLoopRun(), 0)

// Test label
#define LABEL(s) ((label = s), printf("TEST: %s\n", s))

// Start sub test label
#define BEGIN(s) printf("> BEGIN: %s\n", s)

// Notify okay
#define OK(s) printf("> OK: %s\n", s)

// Notify test completion
#define END() (printf("TESTEND: %s\n", label), DONE())
