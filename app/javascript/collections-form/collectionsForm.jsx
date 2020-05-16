import 'preact/devtools';
import { h, Component } from 'preact';
import linkState from 'linkstate';
import Tags from '../shared/components/tags';

export default class CollectionsForm extends Component {
  constructor() {
    super();
    this.state = {
      tagList: '',
      title: '',
    }
  }

  updateTitle = (e) => {
    this.setState({title: e.target.value})
  }

  postData = (e) => {
    e.preventDefault();
    fetch("http://localhost:3000/machinecollections", {
      method: "POST",
      headers: {
        Accept: 'application/json',
        'X-CSRF-Token': window.csrfToken,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(this.state),
      credentials: 'same-origin',
    })
    .then(res => console.log(res))
    // .then(data => console.log(data))
    // .catch(err => console.log(err))
  }

  render() {
    return (
      <div>
      <input
        class="articleform__title articleform__titlepreview"
        type="text"
        placeholder="Title"
        onInput={this.updateTitle}
      />
      <div className="articleform__detailfields" style={{marginBottom: "2rem"}}>
        <Tags
          defaultValue={this.state.tagList}
          onInput={linkState(this, 'tagList')}
          maxTags={4}
          autoComplete="off"
          classPrefix="articleform"
        />
      </div>
      <div class="articleform__buttons">
          <p><button class="clear-button">clear</button></p>
          <button class="articleform__buttons--publish" onClick={this.postData}>PUBLISH</button>
      </div>
      </div>
    )
  }
}
