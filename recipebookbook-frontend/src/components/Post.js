import React from 'react';
import Moment from 'react-moment';
const Post = ({post, onRemovePost=f=>f, editingPost=f=>f}) =>
    <div className="single-post" key={post.id}>
        <strong>{post.user.email}</strong><h4> {post.message}</h4>
       <Moment format="YYYY-MM-DD - HH:mm">{post.created_at}</Moment>
       <button onClick={() => onRemovePost(post.id)}>Erase</button>
   <button onClick={() => editingPost(post.id)}>Edit</button>

   <hr />
    </div>
export default Post;
