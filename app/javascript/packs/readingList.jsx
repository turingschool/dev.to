import { h, render } from 'preact';
// get user and csrf token

import { getUserDataAndCsrfToken } from '../chat/util';

// import this component
import { ReadingList } from '../readingList/readingList';

function loadElement() {
  // current user is assigned to this token
  getUserDataAndCsrfToken().then(({ currentUser }) => {
    // root is the reading list element
    const root = document.getElementById('reading-list');
    // if you have an element render it on the screen
    if (root) {
      render(
        <ReadingList
          availableTags={currentUser.followed_tag_names}
          statusView={root.dataset.view}
        />,
        root,
        root.firstElementChild,
      );
    }
  });
}

// insta click has to do with preloading this to make them faster
window.InstantClick.on('change', () => {
  loadElement();
});

// load on to the page 
loadElement();
