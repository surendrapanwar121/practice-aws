import React from "react";
import PropTypes from 'prop-types'
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
  return (
    <div className="form-container">
      <h4 className="form-heading"> {heading}</h4>
      <BrowserRouter>
        <Form
          fields={fields}
          submitURL={submitURL}
          action={action ? action : HTTP_METHODS.POST}
        />
      </BrowserRouter>
    </div>
  )
}

FormContainer.propTypes = propTypes
export default FormContainer
