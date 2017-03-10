const bodyParser = require('body-parser');
const path = require('path');
const session = require('client-sessions');
const bcrypt = require('bcryptjs');
const csrf = require('csurf');
const express = require('express');

const usersFilePath = path.resolve(path.dirname(__dirname), 'nodejs-session/data/users.json');
const usersApi = Object
      .create(require(path.resolve(path.dirname(__dirname), 'nodejs-session/api/JSON-crud')))
      .init(usersFilePath);

const app = express();

// Setup View Engine
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

// Setup middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
  cookieName: 'session',
  secret: 'sad1231312asd12321easd1231',
  duration: 30 * 60 * 1000,
  activeDuration: 5 * 60 * 1000,
  httpOnly: true,
  ephemeral: true,
}));

app.use(function(req, res, next) {
  let user;
  if (req.session && req.session.user) {
    user = usersApi.findOne('email', req.session.user.email);
    if (user) {
      req.user = user;
      delete req.user.password;
      req.session.user = req.user;
      res.locals.user = req.user;
    }
  }

  next();
});

function requireLogin(req, res, next) {
  if (!req.user) {
    res.redirect('/login');
  }

  next();
}

app.use(csrf());

// Routes
app.get('/', function(req, res) {
  res.render('index', { title: 'Home' });
});

app.get('/register', function(req, res) {
  res.render('register', {
    title: 'Register',
    csrfToken: req.csrfToken(),
  });
});

app.post('/register', function(req, res) {
  const hash = bcrypt.hashSync(req.body.password, bcrypt.genSaltSync(10));

  const user = {
    firstName: req.body.firstName,
    lastName: req.body.lastName,
    email: req.body.email,
    password: hash,
  };

  if (usersApi.isUnique('email', user.email)) {
    usersApi.set(user);
    usersApi.record();
    res.redirect('dashboard');
  } else {
    const error = 'That email is already taken, try another.';
    res.render('register', {
      title: 'Register',
      error,
    });
  }
});

app.get('/login', function(req, res) {
  res.render('login', {
    title: 'Login',
    csrfToken: req.csrfToken(),
  });
});

app.post('/login', function(req, res) {
  const user = usersApi.findOne('email', req.body.email);

  if (user && bcrypt.compareSync(req.body.password, user.password)) {
    req.session.user = user;
    res.redirect('/dashboard');
  } else {
    res.render('login', {
      title: 'Login',
      error: 'Invalid username or password!',
    });
  }
});

app.get('/dashboard', requireLogin, function(req, res) {
  res.render('dashboard', { title: 'Dashboard' });
});

app.get('/logout', function(req, res) {
  req.session.reset();
  res.redirect('/');
});

app.listen(3000);
