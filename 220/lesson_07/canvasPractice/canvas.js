const canvas = document.querySelector('canvas');
const ctx = canvas.getContext('2d');
const x = canvas.width / 2;
const y = canvas.width / 2;
const radius = x;

ctx.beginPath();
ctx.arc(x, y, radius, 0, 2 * Math.PI);
ctx.fill();
ctx.closePath();

ctx.beginPath();
ctx.strokeStyle = 'rgba(0, 102, 204, .7)';
ctx.moveTo(x, y - 50);
ctx.lineTo(x + 50, y);
ctx.lineTo(x - 50, y);
ctx.lineTo(x, y - 50);
ctx.stroke();
ctx.closePath();

const imgSrc = canvas.toDataURL('png');
let img = document.createElement('img');

img.src = imgSrc;
document.body.appendChild(img);

img = document.querySelector('img');
canvas.width = img.width;
canvas.height = img.heigth;

ctx.drawImage(img, 0, 0);
