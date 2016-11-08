/* global Handlebars */
window.onload = () => {
  Handlebars.partials = Handlebars.templates;

  /*
   * Model
   */
  const Model = {
    events: [],
    lastId: null,
    getEventById(id) {
      return this.events.filter((event) => event.id === id)[0];
    },
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
    newEvent(id) {
      return Handlebars.templates.newEvent(id);
    },
    editEvent(event) {
      return Handlebars.templates.editEvent(event);
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
            model.lastId = model.events[model.events.length - 1].id;
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
        this.events.insertAdjacentHTML('beforeend', html);
      }

      this.eventsVisible = !this.eventsVisible;
    },
    addEvent() {
      if (this.elEventListenerStatus[this.newEvent]) {
        const html = Views.newEvent({ id: model.lastId + 1 });
        this.eventAction.insertAdjacentHTML('beforeend', html);
        if (this.elEventListenerStatus[this.newEvent]) this.deactiveEventListener(this.newEvent);
      }
    },
    activateEventListener(element) {
      this.elEventListenerStatus[element] = true;
    },
    deactiveEventListener(element) {
      this.elEventListenerStatus[element] = false;
    },
    editEvent(event) {
      event.preventDefault();
      const target = event.target;
      if (target.parentElement.parentElement.nodeName === 'ARTICLE') {
        const id = target.parentElement.parentElement.dataset.eventId;
        const html = Views.editEvent(model.getEventById(parseInt(id, 10)));
        this.eventAction.insertAdjacentHTML('beforeend', html);
      }
    },
    bindEvents() {
      this.eventsToggle.addEventListener('click', this.toggleEvents.bind(this));
      this.newEvent.addEventListener('click', this.addEvent.bind(this));
      this.events.addEventListener('click', this.editEvent.bind(this));
    },
    initEventStates() {
      this.elEventListenerStatus = {};
      this.elEventListenerStatus[this.eventsToggle] = true;
      this.elEventListenerStatus[this.newEvent] = true;
      this.elEventListenerStatus[this.events] = true;
    },
    init(anchors) {
      this.xhr = new XMLHttpRequest();
      this.loadEvents();
      this.eventsVisible = false;
      this.events = anchors.events;
      this.eventsToggle = anchors.eventsToggle;
      this.eventAction = anchors.eventAction;
      this.newEvent = anchors.newEvent;
      this.bindEvents();
      this.initEventStates();
      return this;
    },
  };

  const controller = Object.create(Controller).init({
    eventsToggle: document.querySelector('#events-toggle'),
    events: document.querySelector('#events'),
    eventAction: document.querySelector('#event-action'),
    newEvent: document.querySelector('#event-action h1.new-event'),
  });
};
