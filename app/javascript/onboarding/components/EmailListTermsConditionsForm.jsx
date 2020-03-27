/* eslint camelcase: "off" */

// deconstructing and importing component and h
import { h, Component } from 'preact';
// importing proptypes for testing
import PropTypes from 'prop-types';

// import Navigation component
import Navigation from './Navigation';

// deconstructing two methods, getContentOfToken and updateOnboarding, out of utilities
import { getContentOfToken, updateOnboarding } from '../utilities';

/* eslint-disable camelcase */

class EmailTermsConditionsForm extends Component {
  // import props passed down from parent container
  constructor(props) {
    super(props);
    // define state variables - handelChange, onSubmit, checkRequirements
    // The bind() method creates a new function that,
    // when called, has its this keyword set to the provided value
    this.handleChange = this.handleChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
    this.checkRequirements = this.checkRequirements.bind(this);

    // setting default state for the component when it mounts to have boolean values and one string value
    this.state = {
      checked_code_of_conduct: false,
      checked_terms_and_conditions: false,
      email_newsletter: true,
      email_digest_periodic: true,
      message: '',
      textShowing: null,
    };
  }

  // on initialization of the component call the fn updateOnboarding with arguments passed in
  componentDidMount() {
    updateOnboarding('emails, COC and T&C form');
  }

  // this fn checks if requirements is truthy / falsey
  // on falsey it ends the fn call
  // on truthy it does a fetch call for a PATCH with the csrfToken inserted
  // .then it sets the response to local storage with setItem function being invoked
  // ends by calling next fn
  onSubmit() {
    if (!this.checkRequirements()) return;
    const csrfToken = getContentOfToken('csrf-token');

    fetch('/onboarding_checkbox_update', {
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': csrfToken,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ user: this.state }),
      credentials: 'same-origin',
    }).then(response => {
      if (response.ok) {
        localStorage.setItem('shouldRedirectToOnboarding', false);
        const { next } = this.props;
        next();
      }
    });
  }

  // this fn declares two new variables checked_code_of_conduct and checked_terms_and_conditions with either true false values
  // these two values live in state as false, but are changed to true in the render fn
  // it then checks if falsey values it sets the component state's key of message to the value of
  // 'You must agree to our Code of Conduct || Terms and Conditions before continuing!'
  // and returns false
  // else if the variable values are truthy it returns true
  checkRequirements() {
    const {
      checked_code_of_conduct,
      checked_terms_and_conditions,
    } = this.state;
    if (!checked_code_of_conduct) {
      this.setState({
        message: 'You must agree to our Code of Conduct before continuing!',
      });
      return false;
    }
    if (!checked_terms_and_conditions) {
      this.setState({
        message:
          'You must agree to our Terms and Conditions before continuing!',
      });
      return false;
    }
    return true;
  }

  // this fn sets state for event.target = to name, and then name to the oppositie of currentState at name is
  handleChange(event) {
    const { name } = event.target;
    this.setState(currentState => ({
      [name]: !currentState[name],
    }));
  }

  // this fn takes in an event and id, and sets state for textShowing to the innerHtml at the provided id
  handleShowText(event, id) {
    event.preventDefault();
    this.setState({ textShowing: document.getElementById(id).innerHTML });
  }

  // this fn sets state for textshowing to null
  backToSlide() {
    this.setState({ textShowing: null });
  }

  render() {
    // declares six new variables values to state
    const {
      message,
      checked_code_of_conduct,
      checked_terms_and_conditions,
      email_newsletter,
      email_digest_periodic,
      textShowing,
    } = this.state;
    const { prev } = this.props;
    // conditional to check if textShowing is truthy render the below code otherwise render line 144
    if (textShowing) {
      // this looks like a section with a button that calls the fn backToSlide on click and a div containing textShowing html
      return (
        <div className="onboarding-main">
          <div className="onboarding-content checkbox-slide">
            <button type="button" onClick={() => this.backToSlide()}>
              BACK
            </button>
            <div
              /* eslint-disable react/no-danger */
              dangerouslySetInnerHTML={{ __html: textShowing }}
              style={{ height: '360px', overflow: 'scroll' }}
              /* eslint-enable react/no-danger */
            />
          </div>
        </div>
      );
    }
    return (
      // this looks like it holds a header above a form with four input fields for
      // check code of conduct
      // check terms and conditions
      // email preference for weekly emails
      // email preference for top digest topics
      // each of these inputs invokes the function handelChange to update state
      <div className="onboarding-main">
        <div className="onboarding-content checkbox-slide">
          <h2>Some things to check off!</h2>
          {message && <span className="warning-message">{message}</span>}
          <form>
            <label htmlFor="checked_code_of_conduct">
              <input
                type="checkbox"
                id="checked_code_of_conduct"
                name="checked_code_of_conduct"
                checked={checked_code_of_conduct}
                onChange={this.handleChange}
              />
              You agree to uphold our
              {' '}
              <a
                href="/code-of-conduct"
                data-no-instant
                onClick={e => this.handleShowText(e, 'coc')}
              >
                Code of Conduct
              </a>
            </label>
            <label htmlFor="checked_terms_and_conditions">
              <input
                type="checkbox"
                id="checked_terms_and_conditions"
                name="checked_terms_and_conditions"
                checked={checked_terms_and_conditions}
                onChange={this.handleChange}
              />
              You agree to our
              {' '}
              <a
                href="/terms"
                data-no-instant
                onClick={e => this.handleShowText(e, 'terms')}
              >
                Terms and Conditions
              </a>
            </label>
            <h3>Email Preferences</h3>
            <label htmlFor="email_newsletter">
              <input
                type="checkbox"
                id="email_newsletter"
                name="email_newsletter"
                checked={email_newsletter}
                onChange={this.handleChange}
              />
              Do you want to receive our weekly newsletter emails?
            </label>

            <label htmlFor="email_digest_periodic">
              <input
                type="checkbox"
                id="email_digest_periodic"
                name="email_digest_periodic"
                checked={email_digest_periodic}
                onChange={this.handleChange}
              />
              Do you want to receive a periodic digest with some of the top
              posts from your tags?
            </label>
          </form>
        </div>
        <Navigation prev={prev} next={this.onSubmit} />
      </div>
    );
  }
}

// proptypes checks the data type values for the data passed into the component
EmailTermsConditionsForm.propTypes = {
  prev: PropTypes.func.isRequired,
  next: PropTypes.string.isRequired,
};

export default EmailTermsConditionsForm;
