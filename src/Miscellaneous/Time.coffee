Time =
  init: ->
    return unless g.VIEW in ['index', 'thread', 'archive'] and Conf['Time Formatting']

    Callbacks.Post.push
      name: 'Time Formatting'
      cb:   @node

  node: ->
    return if @isClone
    @nodes.date.textContent = Time.format Conf['time'], @info.date
  format: (formatString, date) ->
    formatString.replace /%(.)/g, (s, c) ->
      if c of Time.formatters
        Time.formatters[c].call(date)
      else
        s

  day: [
    'Sunday'
    'Monday'
    'Tuesday'
    'Wednesday'
    'Thursday'
    'Friday'
    'Saturday'
  ]

  month: [
    'January'
    'February'
    'March'
    'April'
    'May'
    'June'
    'July'
    'August'
    'September'
    'October'
    'November'
    'December'
  ]

  zeroPad: (n) -> if n < 10 then "0#{n}" else n

  formatters:
    a: -> Time.day[@getDay()][...3]
    A: -> Time.day[@getDay()]
    b: -> Time.month[@getMonth()][...3]
    B: -> Time.month[@getMonth()]
    d: -> Time.zeroPad @getDate()
    e: -> @getDate()
    H: -> Time.zeroPad @getHours()
    I: -> Time.zeroPad @getHours() % 12 or 12
    k: -> @getHours()
    l: -> @getHours() % 12 or 12
    m: -> Time.zeroPad @getMonth() + 1
    M: -> Time.zeroPad @getMinutes()
    p: -> if @getHours() < 12 then 'AM' else 'PM'
    P: -> if @getHours() < 12 then 'am' else 'pm'
    S: -> Time.zeroPad @getSeconds()
    y: -> @getFullYear().toString()[2..]
    Y: -> @getFullYear()
    '%': -> '%'
