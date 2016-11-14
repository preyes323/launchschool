const Car = ModelConstructor();
const bmw = Object.create(Car).init();

bmw.set('make', 'BMW');
bmw.set('model', '328i');

$("#make").text(bmw.get("make"));
$("#model").text(bmw.get("model"));
