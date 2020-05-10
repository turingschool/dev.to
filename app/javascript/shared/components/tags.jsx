import { h, Component } from 'preact';
import PropTypes from 'prop-types';
import debounce from 'lodash.debounce';

const KEYS = {
  UP: 'ArrowUp',
  DOWN: 'ArrowDown',
  LEFT: 'ArrowLeft',
  RIGHT: 'ArrowRight',
  TAB: 'Tab',
  RETURN: 'Enter',
  COMMA: ',',
  DELETE: 'Backspace',
};

const NAVIGATION_KEYS = [
  KEYS.COMMA,
  KEYS.DELETE,
  KEYS.LEFT,
  KEYS.RIGHT,
  KEYS.TAB,
];

const LETTERS_NUMBERS = /[a-z0-9]/i;

/* TODO: Remove all instances of this.props.listing
   and refactor this component to be more generic */

class Tags extends Component {
  constructor(props) {
    super(props);

    // ! Stops the same search from being submitted multiple times in quick succession
    this.debouncedTagSearch = debounce(this.handleInput.bind(this), 150, {
      leading: true,
    });

    // ! Local component state
    this.state = {
      selectedIndex: -1,
      searchResults: [],
      additionalTags: [],
      cursorIdx: 0,
      prevLen: 0,
      showingRulesForTag: null,
    };
  }

  // ! On component mounting to the DOM, if the listing prop is true, set the state to contain some additional arrays of tags
  componentDidMount() {
    const { listing } = this.props;
    if (listing === true) {
      this.setState({
        additionalTags: {
          jobs: [
            'remote',
            'remoteoptional',
            'lgbtbenefits',
            'greencard',
            'senior',
            'junior',
            'intermediate',
            '401k',
            'fulltime',
            'contract',
            'temp',
          ],
          forhire: [
            'remote',
            'remoteoptional',
            'lgbtbenefits',
            'greencard',
            'senior',
            'junior',
            'intermediate',
            '401k',
            'fulltime',
            'contract',
            'temp',
          ],
          forsale: ['laptop', 'desktopcomputer', 'new', 'used'],
          events: ['conference', 'meetup'],
          collabs: ['paid', 'temp'],
        },
      });
    }
  }

  // ! When the component is updated, stop the cursor from moving to the last tag in the list when going back to edit a prior tag
  componentDidUpdate() {
    // stop cursor jumping if the user goes back to edit previous tags
    const { cursorIdx, prevLen } = this.state;
    if (
      cursorIdx < this.textArea.value.length &&
      this.textArea.value.length < prevLen + 1
    ) {
      this.textArea.selectionEnd = cursorIdx;
      this.textArea.selectionStart = this.textArea.selectionEnd;
    }
  }

  // ! Creates a property on the class that can be accessed via a function, a getter
  // ! Splits the selection on commas ensures that each is trimmed of whitespace and that the length is > 0 between commas
  get selected() {
    const { defaultValue } = this.props;
    return defaultValue
      .split(',')
      .map(item => item !== undefined && item.trim())
      .filter(item => item.length > 0);
  }

  // ! Returns a boolean of true if the index of the selection is less than or equal to 0 to indicate it is first in an array
  get isTopOfSearchResults() {
    const { selectedIndex } = this.state;
    return selectedIndex <= 0;
  }

  // ! Returns a boolean of true if the index of the selection is last in the search results array
  get isBottomOfSearchResults() {
    const { selectedIndex, searchResults } = this.state;
    return selectedIndex >= searchResults.length - 1;
  }

  // ! If the selectedIndex exists, it is true, indicating a selection has been made
  get isSearchResultSelected() {
    const { selectedIndex } = this.state;
    return selectedIndex > -1;
  }

  // ! Takes in an array of tags and an index
  // ! Returns the tag at specific index
  // ! Finds the index by splitting the array into characters and counting the commas
  getCurrentTagAtSelectionIndex = (value, index) => {
    let tagIndex = 0;
    const tagByCharacterIndex = {};

    value.split('').forEach((letter, letterIndex) => {
      if (letter === ',') {
        tagIndex += 1;
      } else {
        tagByCharacterIndex[letterIndex] = tagIndex;
      }
    });

    const tag = value.split(',')[tagByCharacterIndex[index]];

    if (tag === undefined) {
      return '';
    }
    return tag.trim();
  };

  // ! Given an index of the String value, finds the range between commas.
  // ! This is useful when we want to insert a new tag anywhere in the
  // ! comma separated list of tags.
  getRangeBetweenCommas = (value, index) => {
    let start = 0;
    let end = value.length;

    const toPreviousComma = value
      .slice(0, index)
      .split('')
      .reverse()
      .indexOf(',');

    const toNextComma = value.slice(index).indexOf(',');

    if (toPreviousComma !== -1) {
      start = index - toPreviousComma + 1;
    }

    if (toNextComma !== -1) {
      end = index + toNextComma;
    }

    return [start, end];
  };

  // ! Handles keydown events
  // ! Using the constants defined on lines 5-24
  handleKeyDown = e => {
    const component = this;
    const { maxTags } = this.props;

    // ! If the tag element was passed a max value of 4 and 4 elements exist in the selected array, prevent further keypresses
    if (component.selected.length === maxTags && e.key === KEYS.COMMA) {
      e.preventDefault();
      return;
    }

    // ! Allows up and down arrow keys to be used to navigate the hovering menu and the enter key to make a selection
    if (
      (e.key === KEYS.DOWN || e.key === KEYS.TAB) &&
      !this.isBottomOfSearchResults &&
      component.props.defaultValue !== ''
    ) {
      e.preventDefault();
      this.moveDownInSearchResults();
    } else if (e.key === KEYS.UP && !this.isTopOfSearchResults) {
      e.preventDefault();
      this.moveUpInSearchResults();
    } else if (e.key === KEYS.RETURN && this.isSearchResultSelected) {
      e.preventDefault();
      this.insertTag(
        component.state.searchResults[component.state.selectedIndex].name,
      );

      setTimeout(() => {
        document.getElementById('tag-input').focus();
      }, 10);

      // ! If hitting the comma key when a menu is open, clear the search results from the menu and close the menu
    } else if (e.key === KEYS.COMMA && !this.isSearchResultSelected) {
      this.resetSearchResults();
      this.clearSelectedSearchResult();

      // ! Remove search results if backspacing when a search result is present
    } else if (e.key === KEYS.DELETE) {
      if (
        component.props.defaultValue[
          component.props.defaultValue.length - 1
        ] === ','
      ) {
        this.clearSelectedSearchResult();
      }

      // ! Block certain keys from being pressed to prevent characters not accepted for a tag, only a-zA-Z1-9
    } else if (
      !LETTERS_NUMBERS.test(e.key) &&
      !NAVIGATION_KEYS.includes(e.key)
    ) {
      e.preventDefault();
    }
  };

  // ! Shows rules for specific tags
  handleRulesClick = e => {
    e.preventDefault();
    const { showingRulesForTag } = this.state;
    if (showingRulesForTag === e.target.dataset.content) {
      this.setState({ showingRulesForTag: null });
    } else {
      this.setState({ showingRulesForTag: e.target.dataset.content });
    }
  };

  // ! This method allows the search results when entering a tag to be clicked on and inserted into the input field
  handleTagClick = e => {
    if (e.target.className === 'articleform__tagsoptionrulesbutton') {
      return;
    }
    const input = document.getElementById('tag-input');
    input.focus();
    // the rules container (__tagoptionrow) is the real target of the event,
    // by using currentTarget we let the event propagation work
    // from the inner rules box as well (__tagrules)
    this.insertTag(e.currentTarget.dataset.content);
  };

  // ! Adds a space after each tag in the input field automatically
  handleInput = e => {
    let { value } = e.target;
    // If we start typing immediately after a comma, add a space
    // before what we typed.
    // e.g. If value = "javascript," and we type a "p",
    // the result should be "javascript, p".
    if (e.inputType === 'insertText') {
      const isTypingAfterComma =
        e.target.value[e.target.selectionStart - 2] === ',';
      if (isTypingAfterComma) {
        value = this.insertSpace(value, e.target.selectionStart - 1);
      }
    }

    if (e.data === ',') {
      value += ' ';
    }

    /* eslint-disable-next-line react/destructuring-assignment */
    this.props.onInput(value);

    const query = this.getCurrentTagAtSelectionIndex(
      e.target.value,
      e.target.selectionStart - 1,
    );

    this.setState({
      selectedIndex: 0,
      cursorIdx: e.target.selectionStart,
      prevLen: this.textArea.value.length,
    });
    return this.search(query);
  };

  // ! Forces a re-render when a selection loses focus in the browser
  handleFocusChange = () => {
    const component = this;
    setTimeout(() => {
      if (document.activeElement.id === 'tag-input') {
        return;
      }
      component.forceUpdate();
    }, 250);
  };

  // ! Helper method for handleInput that actually adds a space after an input
  insertSpace = (value, position) => {
    return `${value.slice(0, position)} ${value.slice(position, value.length)}`;
  };

  // ! Using the enter key invokes the method to handle a tag click
  handleTagEnter = e => {
    if (e.key === KEYS.RETURN) {
      this.handleTagClick();
    }
  };

  // ! Inserts a tag into the input field
  insertTag(tag) {
    const input = document.getElementById('tag-input');
    const { maxTags } = this.props;
    const range = this.getRangeBetweenCommas(input.value, input.selectionStart);
    const insertingAtEnd = range[1] === input.value.length;
    const maxTagsWillBeReached = this.selected.length === maxTags;
    let tagValue = tag;
    if (insertingAtEnd && !maxTagsWillBeReached) {
      tagValue = `${tagValue}, `;
    }

    // Insert new tag between commas if there are any.
    const newInput =
      input.value.slice(0, range[0]) +
      tagValue +
      input.value.slice(range[1], input.value.length);
    /* eslint-disable-next-line react/destructuring-assignment */
    this.props.onInput(newInput);
    this.resetSearchResults();
    this.clearSelectedSearchResult();
  }

  // ! Searches for tags already present in the DB on entry into the tag input field
  search(query) {
    if (query === '') {
      return new Promise(resolve => {
        setTimeout(() => {
          this.resetSearchResults();
          resolve();
        }, 5);
      });
    }
    const { listing } = this.props;
    return fetch(`/search/tags?name=${query}`, {
      method: 'GET',
      headers: {
        Accept: 'application/json',
        'X-CSRF-Token': window.csrfToken,
        'Content-Type': 'application/json',
      },
      credentials: 'same-origin',
    })
      .then(response => response.json())
      .then(response => {
        if (listing === true) {
          const { additionalTags } = this.state;
          const { category } = this.props;
          const additionalItems = (additionalTags[category] || []).filter(t =>
            t.includes(query),
          );
          const resultsArray = response.result;
          additionalItems.forEach(t => {
            if (!resultsArray.includes(t)) {
              resultsArray.push({ name: t });
            }
          });
        }
        // updates searchResults array according to what is being typed by user
        // allows user to choose a tag when they've typed the partial or whole word
        this.setState({
          searchResults: response.result,
        });
      });
  }

  // ! Sets search results to an empty array
  resetSearchResults() {
    this.setState({
      searchResults: [],
    });
  }

  // ! Shifts the currently selected tag upwards in the search results
  moveUpInSearchResults() {
    this.setState(prevState => ({
      selectedIndex: prevState.selectedIndex - 1,
    }));
  }

  // ! Shifts the currently selected tag downwards in the search results
  moveDownInSearchResults() {
    this.setState(prevState => ({
      selectedIndex: prevState.selectedIndex + 1,
    }));
  }

  // ! Clears the selected search result to indicate that nothing is currently selected
  clearSelectedSearchResult() {
    this.setState({
      selectedIndex: -1,
    });
  }

  // ! The render method of this component controlling what is rendered to the DOM
  // ! Contains logic to render the search results and rules (if applicable)
  // ! Contains a lot of conditional logic for various aspects of the UI
  // ! Ultimately contains an the input element
  render() {
    let searchResultsHTML = '';
    const { searchResults, selectedIndex, showingRulesForTag } = this.state;
    const { classPrefix, defaultValue, maxTags, listing } = this.props;
    const { activeElement } = document;
    const searchResultsRows = searchResults.map((tag, index) => (
      <div
        tabIndex="-1"
        role="button"
        className={`${classPrefix}__tagoptionrow ${classPrefix}__tagoptionrow--${
          selectedIndex === index ? 'active' : 'inactive'
        }`}
        onClick={this.handleTagClick}
        onKeyDown={this.handleTagEnter}
        data-content={tag.name}
      >
        {tag.name}
        {tag.rules_html && tag.rules_html.length > 0 ? (
          <button
            type="button"
            className={`${classPrefix}__tagsoptionrulesbutton`}
            onClick={this.handleRulesClick}
            data-content={tag.name}
          >
            {showingRulesForTag === tag.name ? 'Hide Rules' : 'View Rules'}
          </button>
        ) : (
          ''
        )}
        <div
          className={`${classPrefix}__tagrules--${
            showingRulesForTag === tag.name ? 'active' : 'inactive'
          }`}
          dangerouslySetInnerHTML={{ __html: tag.rules_html }}
        />
      </div>
    ));
    if (
      searchResults.length > 0 &&
      (activeElement.id === 'tag-input' ||
        activeElement.classList.contains(
          'articleform__tagsoptionrulesbutton',
        ) ||
        activeElement.classList.contains('articleform__tagoptionrow'))
    ) {
      searchResultsHTML = (
        <div className={`${classPrefix}__tagsoptions`}>
          {searchResultsRows}
          <div className={`${classPrefix}__tagsoptionsbottomrow`}>
            Some tags have rules and guidelines determined by community
            moderators
          </div>
        </div>
      );
    }

    return (
      <div className={`${classPrefix}__tagswrapper`}>
        {listing && <label htmlFor="Tags">Tags</label>}
        <input
          id="tag-input"
          type="text"
          ref={t => {
            this.textArea = t;
            return this.textArea;
          }}
          className={`${classPrefix}__tags`}
          placeholder={`${maxTags} tags max, comma separated, no spaces or special characters`}
          autoComplete="off"
          value={defaultValue}
          onInput={this.debouncedTagSearch}
          onKeyDown={this.handleKeyDown}
          onBlur={this.handleFocusChange}
          onFocus={this.handleFocusChange}
        />
        {searchResultsHTML}
      </div>
    );
  }
}

Tags.propTypes = {
  defaultValue: PropTypes.string.isRequired,
  onInput: PropTypes.func.isRequired,
  maxTags: PropTypes.number.isRequired,
  classPrefix: PropTypes.string.isRequired,
  listing: PropTypes.string.isRequired,
  category: PropTypes.string.isRequired,
};

export default Tags;
