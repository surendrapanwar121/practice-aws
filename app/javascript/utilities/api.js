const handleResponse = (res, err, callback) => {
  callback(res, err)
}

const fetchData = async (url, options, callback) => {
  try {
    const response = await fetch(url, options)
    if (!response.ok) {
      throw new Error('Network response was not ok')
    }
    const jsonData = await response.json();
    handleResponse(jsonData, null, callback)
  } catch (error) {
    handleResponse(null, error, callback)
  }
}

const get = (opts, csrfToken, callback) => {
  const options = {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    }
  }
  return fetchData(opts.url, options, callback)
}

const post = async (opts, csrfToken, callback) => {
  const options = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(opts.payload)
  }
  await fetchData(opts.url, options, callback)
}

const put = async (opts, csrfToken, callback) => {
  const options = {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(opts.payload),
  }
  await fetchData(opts.url, options, callback)
}

const delet = async (opts, csrfToken, callback) => {
  const options = {
    method: 'DELETE',
    'X-CSRF-Token': csrfToken
  }
  await fetchData(opts.url, options, callback)
}

const invokeAPI = (opts, callback) => {
  const meta = document.querySelector('meta[name="csrf-token"]')
  const csrfToken = meta ? meta.getAttribute('content') : null

  switch (opts.action) {
    case 'get':
      get(opts, csrfToken, callback)
      break
    case 'post':
      post(opts, csrfToken, callback)
      break
    case 'put':
      put(opts, csrfToken, callback)
      break
    case 'delete':
      delet(opts, csrfToken, callback)
      break
    default:
      break
  }
}

// why I need promise with API2
const API2 = {
  begin: (opts = {}) => {
    let [result, error] = [null, null]
    const callback = (res, err) => {
      const isError = err || !res
      if(isError) {
        error = err
      } else {
        result = res
      }
    }
    invokeAPI(opts, callback)
    return { result, error }
  }
}

const API = {
  begin: (opts = {}) => {
    return new Promise((resolve, reject) => {
      const callback = (res, err) => {
        if (err || !res) {
          reject(err)
          console.log(err)
        } else {
          resolve(res)
        }
      }
      invokeAPI(opts, callback)
    })
  }
}

export default API
