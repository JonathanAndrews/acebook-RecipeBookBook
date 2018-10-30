import React from 'react';
const Post = ({post}) =>
    <div className="single-post" key={post.id}>
        <h4>{post.title}</h4>
    </div>
export default Post;
