class Ticket extends React.Component {

  render () {
    let agent = "";
    if (this.props.agent != null) {
      agent = this.props.agent["email"];
    }

    return (
      <tr>
        <td>{ this.props.id }</td>
        <td>{ this.props.category }</td>
        <td>{ this.props.title }</td>
        <td>{ this.props.status }</td>
        <td>{ this.props.priority }</td>
        <td>{ this.props.customer }</td>
        <td>{ this.props.created_at }</td>
        <td>{ this.props.updated_at}</td>
        <td>{ this.props.agent }</td>
      </tr>
    );
  }
}
