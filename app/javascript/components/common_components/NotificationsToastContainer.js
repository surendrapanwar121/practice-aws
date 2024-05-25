import React from 'react'
import PropTypes from 'prop-types'
import NotificationToast from './NotificationToast'
import { NOTIFICATION_LEVEL } from '../constants'
import './NotificationsToastContainer.scss'

const propTypes = {
  notifications: PropTypes.arrayOf(PropTypes.shape({
    level: PropTypes.oneOf([NOTIFICATION_LEVEL.ERROR, NOTIFICATION_LEVEL.SUCCESS, NOTIFICATION_LEVEL.INFO, NOTIFICATION_LEVEL.WARNING]),
    message: PropTypes.node.isRequired
  })),
  onClose: PropTypes.func
}

const NotificationsToastContainer = ({ notifications, onClose }) => {
  return (
    <div className='notification-toast-container'>
      {notifications.map((notification, indx) => (
        !!notification.message &&
        <NotificationToast
          id={indx}
          level={notification.level}
          onClose={onClose}
        >
          {notification.message}
        </NotificationToast>
      ))}
    </div>
  )
}

NotificationsToastContainer.propTypes = propTypes
export default NotificationsToastContainer
