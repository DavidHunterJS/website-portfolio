// this script is used to send email using emailjs and a gmail account

var express    = require('express'),
	app        = express(),
	bodyParser = require('body-parser'),
	email      = require('emailjs'),
	creds      = require('./creds.js').creds;

// this is for cross-origin POSTs, it's a response to the OPTIONS request
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", creds.urlDev);
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

// parses the body of the request
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

// collects the form's input data and adds it to the headers object
app.post('/myAction', function(req, res) {
	var headers = {
		text:     req.body.message + req.body.email,
		from:     req.body.name,
		to:       creds.toEmail,
		cc:       "",
		subject:  req.body.subject
	};
	// creates an emailjs message using the headers object
	var message = email.message.create(headers);
	// sends the message using the server created below 
	server.send(message, function(err, message) {
		console.log(err || message); // remove the 'or message' part after it's been verified working>>>>>>
	});
	res.end();
});

// emailjs server used to send message using my gmail account credentials
// sensitive data comes from required module 'creds' which I can then .gitignore and encrypt on the host server 
var server  = email.server.connect({
    user:       creds.usr,
    password:   creds.pwd,
    host:       "smtp.gmail.com",
    ssl:        true
});

// starts the express server
app.listen(8182, function() {
  console.log('Server running at http://127.0.0.1:8182/');
});
