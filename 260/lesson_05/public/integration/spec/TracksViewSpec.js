const tracks = [{
  "title": "Welcome To New York",
  "length": "3:32"
}, {
  "title": "Blank Space",
  "length": "3:51"
}, {
  "title": "Style",
  "length": "3:51"
}, {
  "title": "Out of the Woods",
  "length": "3:55"
}, {
  "title": "All You Had To Do Was Stay",
  "length": "3:13"
}, {
  "title": "Shake It Off",
  "length": "3:39"
}, {
  "title": "I Wish You Would",
  "length": "3:27"
}, {
  "title": "Bad Blood",
  "length": "3:31"
}, {
  "title": "Wildest Dreams",
  "length": "3:40"
}, {
  "title": "How You Get the Girl",
  "length": "4:07"
}, {
  "title": "This Love",
  "length": "4:10"
}, {
  "title": "I Know Places",
  "length": "3:15"
}, {
  "title": "Clean",
  "length": "4:31"
}];

const TracksViewTest = TracksView.extend({
  initialize() {
    this.duration = 0;
    this.collection = new Tracks();
    this.collection.reset(tracks);
    this.album = new Album(albums[1]);
  },
});

describe('Tracks View', function() {
  beforeEach(function() {
    this.tracks = new TracksViewTest();
  });

  it('has a collection property assigned', function() {
    expect(this.tracks.collection).toBeDefined();
    expect(this.tracks.collection.first().get('title')).toBe('Welcome To New York');
  });

  it('has a handlebars template compiled', function() {
    expect(this.tracks.template).toBeDefined();
  });

  it('renders a modal to the body when render called', function() {
    this.tracks.render();
    expect($('tbody tr').length).toBe(13);
  });

  it('removes the view when fadeOut called', function() {
    this.tracks.render();
    this.tracks.fadeOut();
    expect($('tbody tr').length).toBe(0);
  });

  afterEach(function() {
    this.tracks.remove();
  });
});
