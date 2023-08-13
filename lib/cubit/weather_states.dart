abstract class weatherStates {}

class InitialWeatherState extends weatherStates{}
class LoadingWeatherState extends weatherStates{}
class SuccessWeatherState extends weatherStates{}
class FailureWeatherState extends weatherStates{}