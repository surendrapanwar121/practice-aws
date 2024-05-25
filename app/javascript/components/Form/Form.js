import React, { useState } from "react"
import PropTypes from 'prop-types'
import { useNavigate, Navigate } from 'react-router-dom'
import { NOTIFICATION_LEVEL } from "../constants"
import { notificationsBuilder } from "../common_components/utilities/notificationBuilder"
import { postForm } from "./form_api"
import './Form.scss'

const propTypes = {
  fields: PropTypes.array.isRequired,
  submitURL: PropTypes.string.isRequired,
  action: PropTypes.string,
  handleFormErrors: PropTypes.func
}

const Form = ({ fields, submitURL, action, handleFormErrors }) => {
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
        if(!result.errors) {
          navigate(-1)
          // navigate(result.redirect_link)
          // return <Navigate to='/' />
        } else {
          handleFormErrors(notificationsBuilder(result.errors, NOTIFICATION_LEVEL.ERROR))
        }
      })
      .catch((errors) => {
        console.log('API call failed:', errors);
        handleFormErrors(notificationsBuilder('An Unexpected error ocurred!', NOTIFICATION_LEVEL.ERROR))
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
