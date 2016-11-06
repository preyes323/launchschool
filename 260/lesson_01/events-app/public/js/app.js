/* global Handlebars */
window.onload = () => {
  Handlebars.partials = Handlebars.templates;

  /*
   * Model
   */
  const Model = {
    events: [],
    init() {
      return this;
    },
  };

  const model = Object.create(Model);

  /*
   * Views
   */
  const Views = {
    getEvents(events) {
      return Handlebars.templates.events({ events });
    },
  };

  /*
   * Controller
   */
  const Controller = {
    loadEvents() {
      this.xhr.open('GET', '/events');
      this.xhr.onreadystatechange = () => {
        if (this.xhr.readyState === XMLHttpRequest.DONE) {
          if (this.xhr.status === 200) {
            model.events = JSON.parse(this.xhr.responseText);
          }
        }
      };

      this.xhr.send();
    },
    toggleEvents(e) {
      e.preventDefault();
      if (this.eventsVisible) {
        console.log('hello');
      } else {
        const html = Views.getEvents(model.events);
        this.events.insertAdjacentHTML('afterbegin', html);
      }

      this.eventsVisible = !this.eventsVisible;
    },
    bindEvents() {
      this.eventsToggle.addEventListener('click', this.toggleEvents.bind(this));
    },
    init(anchors) {
      this.xhr = new XMLHttpRequest();
      this.loadEvents();
      this.eventsVisible = false;
      this.events = anchors.events;
      this.eventsToggle = anchors.eventsToggle;
      this.bindEvents();
      return this;
    },
  };

  const controller = Object.create(Controller).init({
    eventsToggle: document.querySelector('#events-toggle'),
    events: document.querySelector('#events'),
  });
};
