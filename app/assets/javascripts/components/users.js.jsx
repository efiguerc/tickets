class Users extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      users: []
    };
  }

  componentDidMount() {
    $.ajax({
      url: '/api/v1/users',
      dataType: 'json',
      method: 'GET',
      beforeSend(xhr) {
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.setRequestHeader('Content-Type', 'application/json');
      },
      success: (data) => {
        this.setState({users: data});
      },
      error: (xhr, ststus, err) => {
        e = {name: 'loadallReportNews', message: 'err: "' + err + '" Status: "'  + xhr.status + '" responseText:   ' + xhr.responseText};
      }
    });  
  }

  render () {
    return (
      <div>
        <table className="table table-striped">
          <thead>
            <tr>
              <th>Id</th>
              <th>Email</th>
              <th>Role</th>
              <th>Created at</th>
              <th>Updated at</th>
            </tr>
          </thead>
          <tbody>
            { this.state.users.map( user =>

              <User
                key={ user["id"] }
                id={ user["id"] }
                email={ user["email"] }
                role={ user["role"] }
                created_at={ user["created_at"] }
                updated_at={ user["updated_at"] } />
            )}
          </tbody>
        </table>
      </div>
    );
  }
}
