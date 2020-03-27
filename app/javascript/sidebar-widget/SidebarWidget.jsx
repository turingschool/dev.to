// deconstruct h and component from preact
// import proptypes for testing
import { h, Component } from 'preact';
import sendFollowUser from '../src/utils/sendFollowUser';
// import SidebarUser component
import SidebarUser from './sidebarUser';

class SidebarWidget extends Component {
  constructor(props) {
    super(props);
    // The bind() method creates a new function that,
    // when called, has its this keyword set to the provided value
    this.getSuggestedUsers = this.getSuggestedUsers.bind(this);
    this.getTagInfo = this.getTagInfo.bind(this);
    this.followUser = this.followUser.bind(this);
    this.state = {
      tagInfo: {},
      suggestedUsers: [],
    };
  }

  // on initialization component calls two fns getTagInfo and getSuggestedUsers
  componentDidMount() {
    this.getTagInfo();
    this.getSuggestedUsers();
  }

  // this fn sets state to a parsed json of tag info
  getTagInfo() {
    this.setState({
      tagInfo: JSON.parse(
        document.getElementById('sidebarWidget__pack').dataset.tagInfo,
      ),
    });
  }

  // this fn does a fetch call for taginfo name
  // then sets state of suggestedUsers to the parsed json of the data
  // catch for fetch errors
  getSuggestedUsers() {
    const { tagInfo } = this.state;
    fetch(`/api/users?state=sidebar_suggestions&tag=${tagInfo.name}`, {
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json',
      },
      credentials: 'same-origin',
    })
      .then(response => response.json())
      .then(json => {
        this.setState({ suggestedUsers: json });
      })
      .catch(error => {
        console.log(error);
      });
  }

  // this fn takes in a user parameter
  // sets state with suggestedUsers
  // runs anonymous function toggleFollowState whcih sets a couple different variables
  // sets state of suggestedUsers with updatedSuggestedUsers
  // runs the fn sendFollowUser with user and toggleFollowState values
  followUser(user) {
    const { suggestedUsers } = this.state;
    const updatedUser = user;
    const updatedSuggestedUsers = suggestedUsers;
    const userIndex = suggestedUsers.indexOf(user);

    const followBtn = document.getElementById(
      `widget-list-item__follow-button-${updatedUser.username}`,
    );
    followBtn.innerText = updatedUser.following ? '+ FOLLOW' : '✓ FOLLOWING';

    const toggleFollowState = newFollowState => {
      updatedUser.following = newFollowState === 'followed';
      updatedSuggestedUsers[userIndex] = updatedUser;
      this.setState({ suggestedUsers: updatedSuggestedUsers });
    };
    sendFollowUser(user, toggleFollowState);
  }

  // this function is what shows on the page
  // sets state with suggestedUsers
  // displays the sidebar component for each user in suggestedUsers array
  // if array length = 0, then it renders a header and a section with users to follow
  render() {
    const { suggestedUsers } = this.state;
    const users = suggestedUsers.map((user, index) => (
      <SidebarUser
        key={user.id}
        user={user}
        followUser={this.followUser}
        index={index}
      />
    ));

    if (suggestedUsers.length > 0) {
      return (
        <div className="widget" id="widget-00001">
          <div className="widget-suggested-follows-container">
            <header>
              <h4>who to follow</h4>
            </header>
            <div className="widget-body">{users}</div>
          </div>
        </div>
      );
    }
    return <div />;
  }
}

export default SidebarWidget;
