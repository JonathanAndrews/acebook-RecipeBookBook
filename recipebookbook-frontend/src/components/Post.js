import React from 'react';
const Post = ({post, onRemovePost=f=>f, editingPost=f=>f}) =>
    <div className="single-post" key={post.id}>
        <h4>{post.post.message} - {post.id}</h4>
        <button onClick={() => onRemovePost(post.id)}>Erase</button>
        <button onClick={() => editingPost(post.id)}>Edit</button>

        <hr/>
    </div>
export default Post;
