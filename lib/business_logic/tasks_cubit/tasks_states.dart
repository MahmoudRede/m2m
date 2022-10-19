abstract class TasksStates{


}

class InitialState extends TasksStates{}

class GetUserSuccessState extends TasksStates{}
class GetUserLoadingState extends TasksStates{}
class GetUserErrorState extends TasksStates{}

class PickPersonalImageErrorState extends TasksStates{}
class UploadImageSuccessState extends TasksStates{}
class UploadImageErrorState extends TasksStates{}


class UrlLaunchState extends TasksStates{}

class UploadTaskScreenLoadingState extends TasksStates{}
class UploadTaskScreenSuccessState extends TasksStates{}
class UploadTaskScreenErrorState extends TasksStates{}

class GetTodayTaskLoadingState extends TasksStates{}
class GetTodayTaskSuccessState extends TasksStates{}
class GetTodayTaskErrorState extends TasksStates{}
