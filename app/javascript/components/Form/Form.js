import React, { useState } from "react"
import PropTypes from 'prop-types'
import './Form.scss'
import { postForm } from "./form_api"
import { useNavigate, Navigate } from 'react-router-dom'

const propTypes = {
  fields: PropTypes.array.isRequired,
  submitURL: PropTypes.string.isRequired,
  action: PropTypes.string
}

const Form = ({ fields, submitURL, action }) => {
  const navigate = useNavigate()
  const [formData, setFormData] = useState({});

  const handleInputChange = (e) => {
    const { name, value } = e.target
    setFormData({ ...formData, [name]: value })
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    postForm({ action, url: submitURL, payload: formData })
      .then((result) => {
        console.log('API call succeeded:', result);
        if(result.redirect_link) {
          // navigate('/')
          navigate(-1)
          // return <Navigate to='/' />
        }
      })
      .catch((error) => {
        console.log('API call failed:', error);
      })
  }

  const renderFields = () => {
    return fields.map((field, index) => {
      const { field_name, field_type, options } = field

      switch (field_type) {
        case 'textarea':
          return (
            <div key={index} className="form-field-container">
              <label className="form-field-label">{field_name}</label>
              <textarea
                className="form-field"
                name={field_name}
                value={formData[field_name] || ''}
                onChange={handleInputChange}
              />
            </div>
          )
        case 'select':
          return (
            <div key={index} className="form-field-container">
              <label className="form-field-label">{field_name}</label>
              <select
                className="form-field"
                name={field_name}
                value={formData[field_name] || ''}
                onChange={handleInputChange}
              >
                {options.map((option, optionIndex) => (
                  <option key={optionIndex} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            </div>
          )
        default:
          return (
            <div key={index} className="form-field-container">
              <label className="form-field-label">{field_name}</label>
              <input
                className="form-field"
                type={field_type}
                name={field_name}
                value={formData[field_name] || ''}
                onChange={handleInputChange}
              />
            </div>
          )
      }
    })
  }

  return (
    <div className="form-fields-container">
      <form onSubmit={handleSubmit}>
        {renderFields()}
        <button type="submit" className="btn btn-primary form-button">Submit</button>
      </form>
    </div>
  )
}

Form.propTypes = propTypes
export default Form
