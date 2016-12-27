if (window.Worker) {
  const myWorker = new Worker('/js/worker.js');

  const form = document.querySelector('form');
  form.onsubmit = function getLargest(e) {
    e.preventDefault();
    e.stopPropagation();
    const formEl = e.currentTarget;
    const digitString = formEl.elements[1].value.replace(/[^0-9]/g, '');
    const numAdjacent = parseInt(formEl.elements[2].value, 10);

    myWorker.postMessage([digitString, numAdjacent]);
  };

  myWorker.onmessage = (e) => {
    form.elements[3].value = e.data;
  };
}
