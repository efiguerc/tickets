class Comment extends React.Component {

  render () {
    return (
      <div className ="comment">
        <p className ="comment-header">{ this.props.user } ({ this.props.role }): { this.props.created_at }</p>
        <p className ="comment-body">
          { this.props.body }
        </p>
      </div>
    );
  }
}
