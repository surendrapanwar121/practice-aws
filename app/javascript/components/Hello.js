import React, { useState } from 'react'
import PropTypes from 'prop-types'
import './Hello.scss'

const propTypes = {
  title: PropTypes.string,
  body: PropTypes.string
}

const Hello = ({ title, body }) => {
  const [name, setName] = useState('Surendra Panwar')
  const handleChange = (e) => {
    if (!e.target.value.length) setName('Surendra Panwar')
    else setName(e.target.value)
  }
  return (
    <div className='hello-container'>
      <input onChange={handleChange} placeholder='Type your name here' />
      <div>Name: {name}</div>
      <div>Title: {title}</div>
      <div>Account: {gon.current_account ? gon.current_account.name : 'Find Me!'}</div>
      <div>Body: {body}</div>
    </div>
  )
}

Hello.propTypes = propTypes
export default Hello
