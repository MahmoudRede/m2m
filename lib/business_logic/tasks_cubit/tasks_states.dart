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

class UploadTaskImageLoadingState extends TasksStates{}
class UploadTaskImageSuccessState extends TasksStates{}
class UploadTaskImageErrorState extends TasksStates{}

class UploadTaskLoadingState extends TasksStates{}
class UploadTaskSuccessState extends TasksStates{}
class UploadTaskErrorState extends TasksStates{}

class GetTodayTaskLoadingState extends TasksStates{}
class GetTodayTaskSuccessState extends TasksStates{}
class GetTodayTaskErrorState extends TasksStates{}
