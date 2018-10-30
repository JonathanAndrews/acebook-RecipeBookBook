import React from 'react';
const Post = ({post, onRemovePost=f=>f}) =>
    <div className="single-post" key={post.id}>
        <h4>{post.message}</h4>
        <button onClick={() => onRemovePost(post.id)}>Erase</button>
        <hr/>
    </div>
export default Post;