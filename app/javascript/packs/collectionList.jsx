import { h, render } from 'preact';
import { getUserDataAndCsrfToken } from '../chat/util';
import { CollectionList } from '../collectionList/collectionList';

function loadElement() {
  getUserDataAndCsrfToken().then(() => {
    const root = document.getElementById('machine-collections');
    if (root) {
      render(
        <CollectionList collections={JSON.parse(root.dataset.collections)} />,
        root,
        root.firstElementChild,
      );
    }
  });
}

window.InstantClick.on('change', () => {
  loadElement();
});

loadElement();
