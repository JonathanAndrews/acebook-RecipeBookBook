
import React from 'react';
import { shallow } from 'enzyme';
import { mount } from 'enzyme';
import  App from '../../App.js';
import axios from 'axios';
import PostsContainer from '../PostsContainer.js'
import NewPostForm from '../NewPostForm.js'

describe('should render title', () => {

  it('should render correctly with no props', () => {
    const component = shallow(<App/>);
    expect(component).toMatchSnapshot();
  });


  it('should have title', () => {
    const component = shallow(<App/>);
    const node = component.find('h1')
    expect(node.hasClass('App-title')).toBeTruthy();
    expect(node.html()).toEqual('<h1 class="App-title">RecipeBookBook!</h1>')
  });
})

describe('should render posts', () => {
  it('should fetch a post', () => {
    const getSpy = jest.spyOn(axios, 'get');
    const postInstance = shallow(
      <PostsContainer/>
    );
    expect(getSpy).toBeCalled();
  })

  it('should have an add post button', () => {
    const wrapper = shallow(<NewPostForm />);
    // console.log("asdfj;alsdkjf;lakjsdf;ljkasddd;fjl;asd");
    // console.log(wrapper.debug());
    const node = wrapper.find("button")
    expect(node.hasClass('submess')).toBeTruthy();
    // expect(wrapper.contains(<div />)).toBeTruthy();
  })

  it('can add post', () => {
    const message = 'potato'
    const component = shallow(<NewPostForm />);
    var node = component.find('.message')
    node.value = message

    component.find('.submess').simulate('click')
    expect(actual).to.equal(message)
  })

})
