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
    this.addNewPost = this.addNewPost.bind(this)
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

  removePost(id) {
    axios.delete( '/api/v1/posts/' + id )
    .then(response => {
        const posts = this.state.posts.filter(
            post => post.id !== id
        )
        this.setState({posts})
    })
    .catch(error => console.log(error))
  }


  render() {
    return (
      <div className="Posts-container">
        {this.state.posts.map( post => {
          return (
            <Post post={post} key={post.id} onRemovePost={this.removePost} />
            )
          })}
          <NewPostForm onNewPost={this.addNewPost}/>
      </div>
    )
  }
}

export default PostsContainer;
