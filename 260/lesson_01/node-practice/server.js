const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const multer = require('multer');

const app = express();
const urlencoderParsesr = bodyParser.urlencoded({ extended: false });
const upload = multer({ dest: 'tmp/' });
app.use(express.static('public'));


// app.get('/', (req, res) => {
//   res.sendFile(`${__dirname}/index.html`);
// });

app.post('/process_get', urlencoderParsesr, (req, res) => {
  const response = {
    firstName: req.body.first_name,
    lastName: req.body.last_name,
  };

  res.json(response);
});

app.post('/file_upload', upload.single('file'), (req, res) => {
  console.log(req);
  res.end();
});

const server = app.listen(8081, () => {
  const host = server.address().address;
  const port = server.address().port;
  console.log('Example app listening at http://%s:%s', host, port);
});
