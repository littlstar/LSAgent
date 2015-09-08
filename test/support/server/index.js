'use strict';

/**
 * objective-agent test file based on the work
 * done here:
 * https://github.com/visionmedia/superagent/blob/master/test/support/server.js
 */

/**
 * Module dependencies.
 */

const fs = require('fs');
const http = require('http');
const path = require('path');
const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');

/**
 * Port to listen on for requests.
 */

const PORT = process.env.PORT || 3000;

/**
 * Test express application.
 */

const app = express();

/**
 * Test HTTP server.
 */

const server = http.createServer(app);

/**
 * Set 'Cache-Control' header for each
 * request response.
 */

app.use((req, res, next) => {
  res.set('Cache-Control', 'no-cache, no-store');
  next();
});

/**
 * Echo headers back for all request types.
 */

app.all('/echo', (req, res) => {
  res.writeHead(200, req.headers);
  req.pipe(res);
});

/**
 * Install request plugins.
 */

app.use(cookieParser());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

/**
 * Handle cross domain requests.
 */

app.use('/xdomain', (req, res, next) => {
  if (!req.get('Origin')) return next();
  res.set('Access-Control-Allow-Origin', req.get('Origin'));
  res.set('Access-Control-Allow-Credentials', 'true');
  res.set('Access-Control-Allow-Methods', 'POST');
  res.set('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type');
  if ('OPTIONS' == req.method) return res.send(200);
  next();
});

/**
 * Handle GET cross domain requests.
 */

app.get('/xdomain', (req, res) => {
  res.send('agent');
});

/**
 * Initialize test server.
 */

server.listen(PORT, _ => {
  const file = path.resolve(__dirname, 'pid');
  const pid = process.pid;
  console.log("Listening on port %d with pid %d", PORT, pid);
  try { fs.unlinkSync(file); }
  catch (e) {}
  try { fs.writeFileSync(file, String(pid)); }
  catch (e) { console.warn(e); }
});

// handle errors
process.on('uncaughtException', err => {
  console.warn("Server already started or port in use.");
  process.exit(0);
});
