import { h, render } from 'preact';
import { getUserDataAndCsrfToken } from '../chat/util';
import { CollectionsList } from '../collectionsList/collectionsList';

function loadElement() {
  getUserDataAndCsrfToken().then(({ currentUser }) => {
    console.log(currentUser);
    const root = document.getElementById('reading-list');
    if (root) {
      render(
        <CollectionsList
          availableTags={currentUser.followed_tag_names}
          statusView={root.dataset.view}
        />,
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
