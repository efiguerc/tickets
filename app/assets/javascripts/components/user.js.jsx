class User extends React.Component {

  render () {
    return (
      <tr>
        <td>{ this.props.id }</td>
        <td>{ this.props.email }</td>
        <td>{ this.props.role }</td>
        <td>{ this.props.created_at }</td>
        <td>{ this.props.updated_at}</td>
      </tr>
    );
  }
}
