class TicketsShow extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      comments: [],
    };
  }

  componentWillMount() {
    this._fetchComments();
  }

  _fetchComments() {
    $.ajax({
      url: '/api/v1/tickets/' + this.props.ticket.id + '/comments',
      dataType: 'json',
      method: 'GET',
      beforeSend: (xhr) => {
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.setRequestHeader('Authorization', this.props.access_token);
      },
      success: (comments) => {
        this.setState({ comments });
      },
      error: (xhr, ststus, err) => {
        e = {name: 'loadallReportNews', message: 'err: "' + err + '" Status: "'  + xhr.status + '" responseText:   ' + xhr.responseText};
        console.log(e);
      }
    });  
  }

  componentDidMount() {
    this._timer = setInterval(
      () => this._fetchComments(),
      5000
    );
  }

  componentWillUnmount() {
    clearInterval(this._timer);
  }

  _handleCommentPost(event) {
    event.preventDefault();

    let body = this._body;

    console.log(body.value);
  }

  render () {
    return (
      <div>
        <h1>{ this.props.ticket.category }</h1>

        <div className="row">
        <dl className="dl-horizontal">
          <div className="col-md-6 col-xs-12">
            <dt><h5><strong>Title:</strong></h5></dt>
            <dd><h4>{ this.props.ticket.title }</h4></dd>
            <dt><h5><strong>Description:</strong></h5></dt>
            <dd><h4>{ this.props.ticket.description }</h4></dd>
          </div>
          <div className="col-md-6 col-xs-12">
            <dt><h5><strong>Status:</strong></h5></dt>
            <dd><h4>{ this.props.ticket.status }</h4></dd>
            <dt><h5><strong>Priority:</strong></h5></dt>
            <dd><h4>{ this.props.ticket.priority }</h4></dd>
            <dt><h5><strong>Customer:</strong></h5></dt>
            <dd><h4>{ this.props.ticket.customer.name }</h4></dd>
            <dt><h5><strong>Agent:</strong></h5></dt>
            <dd><h4>{ this.props.ticket.agent && this.props.ticket.agent.name }</h4></dd>
          </div>
        </dl>     
        </div>

        <form id="comment" onSubmit={ this._handleCommentPost.bind(this) }>
          <div className="form-group">
            <label htmlFor="exampleInputComment">Comment</label>
            <input type="text" className="form-control" id="exampleInputComment" placeholder="Comment..." ref={ (input) => this._body = input } />
          </div>
          <button type="submit" className="btn btn-primary">Post Comment</button>
        </form>

            { this.state.comments.map( comment =>

              <Comment
                key={ comment["id"] }
                id={ comment["id"] }
                user={ comment["user"]["name"] }
                role={ comment["user"]["role"] }
                body={ comment["body"] }
                created_at={ comment["created_at"] } />

            )}
      </div>
    );
  }
}
