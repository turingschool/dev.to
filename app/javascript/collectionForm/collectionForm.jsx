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

  handleSubmit = () => {
    // TODO use the sendFetch function
    const { tagList, title } = this.state;
    const res = fetch('someURLendpoint', {
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'X-CSRF-Token': window.csrfToken,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ tagList, title }),
      credentials: 'same-origin',
    });

    if (!res.ok) {
      throw new Error('Error submitting collection. Please try again.');
    }

    // const resData = await res.json();
    // TODO: Can display success message

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
          <button type="submit" className="collection-form_submit-button">
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
