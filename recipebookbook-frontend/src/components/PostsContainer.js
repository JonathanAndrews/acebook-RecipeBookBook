import React, { Component } from 'react';
import axios from 'axios';
import Post from './Post';
import NewPostForm from './NewPostForm';

class PostsContainer extends Component {

  constructor(props){
    super(props)
    this.state = {
      posts: []
    }
  }

  componentDidMount() {
    axios.get('http://localhost:3001/api/v1/posts.json')
    .then(response => {
      console.log(response)
      this.setState({
        posts: response.data
      })
    })
    .catch(error => console.log(error))
  }

  addNewPost(message) {
    axios.post( '/api/v1/posts', { post: {message} })
    .then(response => {
        console.log(response)
        const posts = [ ...this.state.posts, response.data ]
        this.setState({posts})
    })
    .catch(error => {
        console.log(error)
    })
}


  render() {
    return (
      <div>
        <div><NewPostForm onNewPost={this.addNewPost}/></div>
        <div className="Posts-container">
          {this.state.posts.map( post => {
            return (
              <Post post={post} key={post.id} />
            )
          })}
        </div>
      </div>
    )
  }
}

export default PostsContainer;
