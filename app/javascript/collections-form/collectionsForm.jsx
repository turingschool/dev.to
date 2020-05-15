import 'preact/devtools';
import { h, Component } from 'preact';
import linkState from 'linkstate';
import Tags from '../shared/components/tags';

export default class CollectionsForm extends Component {
  constructor() {
    super();
    this.state = {
      tagList: ''
    }
  }

  render() {
    return (
    <div className="articleform__detailfields">
      <Tags
        defaultValue={this.state.tagList}
        onInput={linkState(this, 'tagList')}
        maxTags={4}
        autoComplete="off"
        classPrefix="articleform"
      />
    </div>
    )
  }
}
