import _ from 'lodash';

const NUM_BUBBLES = 1000;

export function generateDataset() {
  const rowsById = {};
  const rowIds = [];
  for (let i=0; i<NUM_BUBBLES; i++) {
    const id = _generateId();
    rowsById[id] = _generateBubble();
    rowIds.push(id);
  }
  return { rowsById, rowIds };
}

function _generateId() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
    return v.toString(16);
  });
}

function _generateBubble() {
  const r = Math.random();
  if (r < 0.75) {
    return _generateTextBubble();
  } else {
    return _generateImageBubble();
  }
}

function _generateTextBubble() {
  const words = [
    'lorem', 'ipsum', 'dolor', 'sit', 'amet', 'consectetur',
		'adipiscing', 'elit', 'curabitur', 'vel', 'hendrerit', 'libero',
		'eleifend', 'blandit', 'nunc', 'ornare', 'odio', 'ut',
		'orci', 'gravida', 'imperdiet', 'nullam', 'purus', 'lacinia',
		'a', 'pretium', 'quis', 'congue', 'praesent', 'sagittis',
		'laoreet', 'auctor', 'mauris', 'non', 'velit', 'eros',
		'dictum', 'proin', 'accumsan', 'sapien', 'nec', 'massa',
		'volutpat', 'venenatis', 'sed', 'eu', 'molestie', 'lacus',
		'quisque', 'porttitor', 'ligula', 'dui', 'mollis', 'tempus',
		'at', 'magna', 'vestibulum', 'turpis', 'ac', 'diam',
		'tincidunt', 'id', 'condimentum', 'enim', 'sodales', 'in',
		'hac', 'habitasse', 'platea', 'dictumst', 'aenean', 'neque',
		'fusce', 'augue', 'leo', 'eget', 'semper', 'mattis',
		'tortor', 'scelerisque', 'nulla', 'interdum', 'tellus', 'malesuada',
		'rhoncus', 'porta', 'sem', 'aliquet', 'et', 'nam',
		'suspendisse', 'potenti', 'vivamus', 'luctus', 'fringilla', 'erat',
		'donec', 'justo', 'vehicula', 'ultricies', 'varius', 'ante',
		'primis', 'faucibus', 'ultrices', 'posuere', 'cubilia', 'curae',
		'etiam', 'cursus', 'aliquam', 'quam', 'dapibus', 'nisl',
		'feugiat', 'egestas', 'class', 'aptent', 'taciti', 'sociosqu',
		'ad', 'litora', 'torquent', 'per', 'conubia', 'nostra',
		'inceptos', 'himenaeos', 'phasellus', 'nibh', 'pulvinar', 'vitae',
		'urna', 'iaculis', 'lobortis', 'nisi', 'viverra', 'arcu',
		'morbi', 'pellentesque', 'metus', 'commodo', 'ut', 'facilisis',
		'felis', 'tristique', 'ullamcorper', 'placerat', 'aenean', 'convallis',
		'sollicitudin', 'integer', 'rutrum', 'duis', 'est', 'etiam',
		'bibendum', 'donec', 'pharetra', 'vulputate', 'maecenas', 'mi',
		'fermentum', 'consequat', 'suscipit', 'aliquam', 'habitant', 'senectus',
		'netus', 'fames', 'quisque', 'euismod', 'curabitur', 'lectus',
		'elementum', 'tempor', 'risus', 'cras'
  ];
  const numWords = _.random(2, 20);
  const sentence = [];
  for (let i=0; i<numWords; i++) {
    sentence.push(_.sample(words));
  }
  return {
    type: 'text',
    text: sentence.join(' '),
    side: _.sample(['left', 'right'])
  };
}

function _generateImageBubble() {
  return {
    type: 'image',
    url: 'https://loremflickr.com/250/150?random=' + _.random(1, 999999),
    side: _.sample(['left', 'right'])
  };
}
