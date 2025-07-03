
  do ->

    { get-com-object } = dependency 'os.win32.com.ComObject'
    { create-wmi-object-moniker: object-moniker, create-wmi-class-moniker: class-moniker } = dependency 'os.win32.wmi.Moniker'
    { create-wmi-security-descriptor: wmi-security } = dependency 'os.win32.wmi.Security'

    get-wmi-objects = (classname, host, namespace, security = wmi-security!) ->

      get-com-object "#{ class-moniker classname, host, namespace, security }"

    get-wmi-object = (classname, keys = {}, host, namespace, security = wmi-security!) ->

      WScript.Echo 'antes', object-moniker classname, keys, host, namespace, security

      get-com-object "#{ object-moniker classname, keys, host, namespace, security }"

    {
      get-wmi-objects, get-wmi-object
    }