import React from 'react';

const NewPostForm = ({ onNewPost = f => f }) => {
  let message;
  const submit = e => {
    e.preventDefault();
    onNewPost(message.value);
    message.value = '';
    message.focus();
  };

  return (
    <form onSubmit={submit}>
      <input
        className="message"
        ref={input => (message = input)}
        type="text"
        placeholder="Message..."
        required
      />
      <button className="submess">Add Post</button>
    </form>
  );
};

export default NewPostForm;
