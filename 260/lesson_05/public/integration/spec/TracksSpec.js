describe('Tracks collection', function() {
  it('fetches a collection of tracks for a given album', function(done) {
    const AlbumTracks = Tracks.extend({ url: '/albums/1989.json' });
    const tracks = new AlbumTracks();
    tracks.fetch({
      success() {
        console.log(tracks);
        expect(tracks.length).not.toBe(0);
        expect(typeof tracks.first().get('title')).toBe('string');
        done();
      },

      error() {
        console.log('problem fetching!');
      },
    });
  });
});
