import { h, render } from 'preact';
import { getUserDataAndCsrfToken } from '../chat/util';
import { CollectionsList } from '../collectionsList/collectionsList';

function loadElement() {
  getUserDataAndCsrfToken().then(({ currentUser }) => {
    const root = document.getElementById('reading-list');
    const { collections } = root.dataset;
    if (root) {
      render(
        <CollectionsList
          availableTags={currentUser.followed_tag_names}
          statusView={root.dataset.view}
          collections={JSON.parse(collections)}
          currentUser={currentUser}
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
