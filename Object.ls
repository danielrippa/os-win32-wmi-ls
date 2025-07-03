
  do ->

    { get-com-object } = dependency 'os.win32.com.ComObject'

    get-wmi-objects = (moniker) -> type '< Object String >' moniker ; get-com-object "#moniker"

    get-wmi-object = ->

    {
      get-wmi-objects, get-wmi-object
    }