const Todo = ModelConstructor();
const Todos = CollectionConstructor();
const TodoView = ViewConstructor({
  tagName: 'li',
  template: Handlebars.templates.todo,
  events: {
    click(e) {
      const $editForm = $(Handlebars.templates.todoEdit(this.model.attributes));
      const $el = this.$el;
      this.$el.after($editForm);
      this.$el.remove();
      $editForm.find('input').on('blur', (e) => {
        const name = $editForm.find('input')[0].value;
        this.model.set('name', name);
        $editForm.after($el);
        $editForm.find('input').off(e);
        $editForm.remove();
      });
    },
    'click a.toggle': function toggle(e) {
      this.$el.toggleClass('complete');
      this.model.set('complete', !this.model.get('complete'));
      e.stopPropagation();
    },
  },
});

const Controller = {
  todos: {},
  view: {},
  $todos: {},
  $clear: {},
  $newTodoForm: {},
  addTodo(event) {
    event.preventDefault();
    const $form = $(event.target);
    const model = this.todos.add({
      name: $form.serializeArray()[0].value,
      complete: false,
    });
    this.$todos.append(Object.create(TodoView).init(model).$el);
    event.target.reset();
  },
  clearAllCompleted(event) {
    event.preventDefault();
    const completed = this.todos.models.filter((model) => model.attributes.complete);
    completed.forEach((model) => model.view.$el.remove());
  },
  bindEvents() {
    this.$newTodoForm.on('submit', this.addTodo.bind(this));
    this.$clear.on('click', this.clearAllCompleted.bind(this));
  },
  init() {
    this.todos = Object.create(Todos).init(Todo);
    this.$newTodoForm = $('form');
    this.$todos = $('#todos');
    this.$clear = $('#clear');
    this.bindEvents();
  },
};

Controller.init();
