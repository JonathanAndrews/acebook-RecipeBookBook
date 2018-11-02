import React, { Component } from 'react';
class EditPostForm extends Component {
    constructor(props) {
        super(props)
        this.state = {
            id: this.props.post.id,
            message: this.props.post.message,
        }
        this.handleChange = this.handleChange.bind(this)
        this.handleSubmit = this.handleSubmit.bind(this)
    }
    handleChange = (e) => {
        this.setState({[e.target.name]: e.target.value})
    }
    handleSubmit(e){
        e.preventDefault();
        const { id, message } = this.state;
        this.props.editPost(id, message);
    }
    render(){
        return(
            <form onSubmit={this.handleSubmit}>
            <input  name="message"
                    type="text"
                    placeholder="Message..."
                    value={this.state.message}
                    onChange={this.handleChange} />
            <button>Update Post</button>
        </form>
        )
    }
}
export default EditPostForm;
