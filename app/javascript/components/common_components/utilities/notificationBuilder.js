export const notificationsBuilder = (notifications, level) => {
  if (typeof notifications === 'string') {
    return [{ message: notifications, level }];
  }
  return notifications.map(message => ({ level, message }));
}
