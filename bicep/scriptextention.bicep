resource customscriptextension 'Microsoft.Compute/virtualMachines/extensions@2022-03-01' = {
  name: '${vmname}/SetPageFile'
  location: location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        fileurl
      ]
      commandToExecute: 'powershell -ExecutionPolicy Bypass -File SetPagefileonTempStorage.ps1'
    }
  }
}
