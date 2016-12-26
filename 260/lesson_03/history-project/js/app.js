function displayPhoto(id) {
  $('article').removeClass('active');
  $(`article#photo${id}`).addClass('active');
  return true;
}

function activateNavItem(id) {
  $('nav ul li').removeClass('active');
  $(`li[data-id=${id}]`).addClass('active');
  return true;
}

function addHistory(id, $el) {
  const $link = $el.find('a');
  const fullPath = `${location.pathname}${$link.attr('href')}`;
  history.pushState({ id }, $link.text(), fullPath);
}

$(window).on('popstate', (e) => {
  const state = e.originalEvent.state;
  displayPhoto(state.id || '1');
  activateNavItem(state.id || '1');
});

$('nav ul').on('click', 'li', function activate() {
  const $el = $(this);
  const photoId = $el.data('id');

  activateNavItem(photoId);
  displayPhoto(photoId);
  addHistory(photoId, $el);
  return false;
});

if (location.hash) {
  const id = location.hash.replace(/[^0-9]/g, '');
  displayPhoto(id);
  activateNavItem(id);
}
