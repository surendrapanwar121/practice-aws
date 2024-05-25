import React from 'react'
import PropTypes from 'prop-types'
import './NotificationToast.scss'

const NotificationToast = ({ children, level, onClose }) => {
  const colorClass = `notification-toast--${level}`;
  return (
    <div className={`notification-toast ${colorClass}`}>
      <span className='notification-header'>{children}</span>
      <button className="btn-close notification-close-button" onClick={onClose} />
    </div>
  )
}

NotificationToast.propTypes = {
  children: PropTypes.node,
  level: PropTypes.string,
  onClose: PropTypes.func
}

export default NotificationToast
