let currentId = 2;

module.exports = {
  get: url => {
    console.log('in get axios.js');
    return Promise.resolve({
      data: [
        {
          id: 1,
          message: 'message',
          created_at: '2018-10-26T09:59:53.234Z',
          updated_at: '2018-10-26T09:59:53.234Z',
          user_id: 34,
          user: {
            email: 'jon@urry.me'
          },
          comments: [
            {
              id: 1,
              body: 'comment 1 by abc',
              post_id: 1,
              user_id: 35,
              created_at: '2018-10-29T11:17:14.662Z',
              updated_at: '2018-10-29T11:17:14.662Z',
              user: {
                email: 'a@b.com'
              }
            }
          ]
        }
      ]
    });
  },

  post: (url, data) => {
    return Promise.resolve({
      data: {
        post: {
          message: data.post,
          id: currentId++
        }
      }
    });
  },

  delete: (url, data) => {
    console.log('in delete axios.js');
    return Promise.resolve({
      data: {
        post: {
          message: data.post,
          id: currentId
        }
      }
    });
  }
};
