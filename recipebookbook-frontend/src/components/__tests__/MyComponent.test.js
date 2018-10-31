
import React from 'react';
import { shallow } from 'enzyme';
import  App from '../../App.js';
import axios from 'axios';
import PostContainer from '../PostsContainer.js'

describe('should render title', () => {

  it('should render correctly with no props', () => {
    const component = shallow(<App/>);
    expect(component).toMatchSnapshot();
  });
  

  it('should have title', () => {
    const component = shallow(<App/>);
    var node = component.find('h1')
    expect(node.hasClass('App-title')).toBeTruthy();
    expect(node.html()).toEqual('<h1 class="App-title">RecipeBookBook!</h1>')
  });
})

describe('should render posts', () => {
  it('should fetch a post', () => {
    const getSpy = jest.spyOn(axios, 'get');
    const postInstance = shallow(
      <PostContainer/>
    );
    expect(getSpy).toBeCalled();
  })
})
