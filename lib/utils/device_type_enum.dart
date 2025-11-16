enum DeviceType { light, fan, ac, camera }

String deviceTypeToString(DeviceType t) {
  switch (t) {
    case DeviceType.light:
      return 'Light';
    case DeviceType.fan:
      return 'Fan';
    case DeviceType.ac:
      return 'AC';
    case DeviceType.camera:
      return 'Camera';
  }
}
