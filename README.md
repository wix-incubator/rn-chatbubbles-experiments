# React Native Chat Bubbles Experiments

Experiments for efficient chat bubbles list view in React Native

## Adding another implementation

* Add your code in a new folder `src/<IMPLEMENTATION-NAME>`

* Wrap your implementation in a React component. Your component will receive 2 props:

`rowsById` - map of row id (string) -> row data (object)

`rowIds` - array of row ids (in the order that they should appear)

You will receive a large number of rows (around 2000)

* The structure of the row data is:

for text bubbles

```js
{
  type: 'text',
  text: 'hello world content goes here',
  side: 'left' // can be 'right' too
}
```

for image bubbles

```js
{
  type: 'image',
  url: 'https://loremflickr.com/250/150?random=234',
  side: 'left' // can be 'right' too
}
```

* Compare your implementation to the default [JavaScript ListView](src/js-listview/index.js)

* Don't forget to add your implementation to the [menu](src/app.js) so others can play with it
