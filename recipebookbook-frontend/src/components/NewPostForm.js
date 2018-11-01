import React from 'react';

const NewPostForm = ({onNewPost = f => f}) => {
    let message
    const submit = e => {
        e.preventDefault()
        onNewPost(message.value)
        message.value = ''
        message.focus()
    }

    return (
        <form onSubmit={submit}>
            <input class='message' ref={input => message = input}
                    type="text"
                    placeholder="Message..." required />
            <button class='submess'>Add Post</button>
        </form>
    )
}

export default NewPostForm;
