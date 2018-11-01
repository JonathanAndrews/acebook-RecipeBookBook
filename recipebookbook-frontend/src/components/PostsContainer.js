import React, { Component } from 'react';
import axios from 'axios';
import Post from './Post';
import NewPostForm from './NewPostForm';
import EditPostForm from './EditPostForm';

class PostsContainer extends Component {

  constructor(props){
    super(props)
    this.state = {
      posts: [],
      editingPostId: null
    }
    this.addNewPost = this.addNewPost.bind(this)
    this.removePost = this.onRemovePost.bind(this)
    this.editingPost = this.editingPost.bind(this)
    this.editPost = this.editPost.bind(this)
  }

  componentDidMount() {
    axios.get('http://localhost:3001/api/v1/posts')
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

  editingPost(id) {
        this.setState({
            editingPostId: id
        })
    }

editPost(id, message) {
    axios.put( '/api/v1/posts/' + id, {
        post: {
            message
        }
    })
    .then(response => {
        console.log(response);
        const posts = this.state.posts;
        posts[id-1] = {id, message}
        this.setState(() => ({
            posts,
            editingPostId: null
        }))
    })
    .catch(error => console.log(error));
}

  onRemovePost(id) {
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

        <NewPostForm onNewPost={this.addNewPost}/>
        {this.state.posts.map( post => {
          if (this.state.editingPost === post.id) {
              return (<EditPostForm
                        post={post}
                        key={post.id}
                        editPost={this.editPost}
                  />)
          } else {
              return (<Post
                post={post}
                key={post.id}
                onRemovePost={this.removePost}
                editingPost={this.editPost}
              />)
            }
          })}
      </div>
    )
  }
}

export default PostsContainer;
