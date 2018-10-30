import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import PostsContainer from './components/PostsContainer';


class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">RecipeBookBook!</h1>
        </header>
        <PostsContainer />
      </div>
    );
  }
}

export default App;
