
  do ->

    { object-from-array } = dependency 'unsafe.Object'
    { round-brackets } = dependency 'unsafe.Circumfix'
    { keep-array-items: keep, array-size, map-array-items: map } = dependency 'unsafe.Array'
    { type } = dependency 'reflection.Type'
    { camel-case } = dependency 'unsafe.StringCase'
    { create-dcom-security-descriptor: dcom-security } = dependency 'os.win32.com.Security'

    wmi-privilege-names = <[
      create-token primary-token lock-memory increase-quota machine-account tcb
      security audit system-environment change-notify remote-shutdown undock
      sync-agent enable-delegation manage-volume impersonate
      create-global trusted-cred-man-access relabel increase-working-set
      time-zone create-symbolic-link debug
    ]>

    wmi-privileges = object-from-array map wmi-privilege-names, camel-case

    create-wmi-privileges-descriptor = (privileges = []) ->

      type '[ *:String ]' privileges

      for privilege in privileges => throw new Error "Invalid wmi privilege '#privilege'. Valid privilege values are: #{ wmi-privilege-names * ', ' }" \
        if wmi-privileges[privilege] is void

      to-string = -> if (array-size @privileges) is 0 then '' else @privileges * ',' |> round-brackets

      { privileges, to-string }

    isnt-void = -> it isnt void

    create-wmi-security-descriptor = (security = dcom-security!, privileges) ->

      type '< Object Undefined >' security ; type '< Object Undefined >' privileges

      to-string = -> [ @security, @privileges ] |> keep _ , isnt-void |> (* ',')

      { security, privileges, to-string }

    {
      create-wmi-privileges-descriptor,
      create-wmi-security-descriptor,
      wmi-privileges
    }