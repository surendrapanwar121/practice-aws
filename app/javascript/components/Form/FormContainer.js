import React, { useState } from "react";
import PropTypes from 'prop-types'
import NotificationsToastContainer from "../common_components/NotificationsToastContainer";
import { BrowserRouter } from "react-router-dom";
import { HTTP_METHODS } from "../constants";
import './FormContainer.scss'
import Form from './Form'

const propTypes = {
  fields: PropTypes.array.isRequired,
  submitURL: PropTypes.string.isRequired,
  heading: PropTypes.string.isRequired,
  action: PropTypes.string
}

const FormContainer = ({ fields, submitURL, heading, action }) => {
  const [formErrors, setFormErrors] = useState([])

  const handleFormErrors = errorMessages => {
    setFormErrors(errorMessages)
  }

  const onClose = () => {
    setFormErrors([])
  }

  return (
    <div className="form-container">
      {!!formErrors.length && <NotificationsToastContainer notifications={formErrors} onClose={onClose} />}
      <h4 className="form-heading"> {heading}</h4>
      <BrowserRouter>
        <Form
          fields={fields}
          submitURL={submitURL}
          action={action ? action : HTTP_METHODS.POST}
          handleFormErrors={handleFormErrors}
        />
      </BrowserRouter>
    </div>
  )
}

FormContainer.propTypes = propTypes
export default FormContainer
