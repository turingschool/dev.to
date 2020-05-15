import { h, Component } from 'preact';
import linkState from 'linkstate';
import Tags from '../shared/components/tags';
import Title from '../article-form/elements/title';

export class CollectionForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      tagList: '',
      title: '',
    };
  }

  handleChange = e => {
    this.setState({ [e.target.name]: e.target.value });
  };

  convertTagsToArray = () => {
    const { tagList } = this.state;
    const tagArray = tagList.split(', ').filter(tag => tag !== '');
    return tagArray;
  };

  handleSubmit = e => {
    e.preventDefault();
    const { tagList, title } = this.state;
    const formattedTags = this.convertTagsToArray(tagList);

    fetch('http://localhost:3000/api/v0/machine_collections', {
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'X-CSRF-Token': window.csrfToken,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ title, tag_list: formattedTags }),
      credentials: 'same-origin',
    })
      .then(res => res.json())
      .then(data => {
        console.log(data);
      })
      .catch(error => {
        console.error(error);
      });

    this.setState({ tagList: '', title: '' });
  };

  handleTitleKeyDown = e => {
    if (e.keyCode === 13) {
      e.preventDefault();
    }
  };

  render() {
    const { tagList, title } = this.state;

    return (
      <section className="collection-form-container">
        <a href="/need-link-still">&lt; return to collections dashboard </a>
        <h1>Create a Collection</h1>
        <form className="collection-form" onSubmit={this.handleSubmit}>
          <div
            className={`collection-form-title ${
              title.length > 128 ? 'articleform__titleTooLong' : ''
            }`}
          >
            <Title
              defaultValue={title}
              onKeyDown={this.handleTitleKeyDown}
              name="title"
              onChange={this.handleChange}
              value={title}
            />
          </div>
          <div className="collection-form-tags articleform__detailfields">
            <Tags
              defaultValue={tagList}
              name="tagList"
              onInput={linkState(this, 'tagList')}
              maxTags={4}
              autoComplete="off"
              classPrefix="articleform"
              onChange={this.handleChange}
            />
          </div>
          <button
            className="collection-form_submit-button"
            disabled={!!(!title || !tagList)}
            type="submit"
          >
            CREATE
          </button>
        </form>
      </section>
    );
  }
}

CollectionForm.defaultProps = {
  collections: [],
};
