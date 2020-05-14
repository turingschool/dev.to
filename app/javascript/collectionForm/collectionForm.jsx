import { h, Component } from 'preact';
import linkState from 'linkstate';
import Tags from '../shared/components/tags';

export class CollectionForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      tagList: '',
    };
  }

  handleChange = e => {
    this.setState({ tagList: e.target.value });
  };

  render() {
    const { tagList } = this.state;

    return (
      <section className="collection-form">
        <a href="/need-link-still">&lt; return to collections dashboard </a>
        <h1>Create a Collection</h1>
        <form className="collection-form">
          <input type="text" className="collection-form__title" />
          <div className="articleform__detailfields">
            <Tags
              defaultValue={tagList}
              onInput={linkState(this, 'tagList')}
              maxTags={4}
              autoComplete="off"
              classPrefix="articleform"
              onChange={this.handleChange}
            />
          </div>
          <button type="submit" className="collection-form_submit-button">
            create
          </button>
        </form>
      </section>
    );
  }
}

CollectionForm.defaultProps = {
  collections: [],
};

// TODO need a way to tell if a collection is being created or edited
