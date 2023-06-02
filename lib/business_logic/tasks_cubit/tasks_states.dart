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

class GetUsersWhoUploadedTaskLoadingState extends TasksStates{}
class GetUsersWhoUploadedTaskSuccessState extends TasksStates{}
class GetUsersWhoUploadedTaskErrorState extends TasksStates{}

class GetUserUploadedTaskLoadingState extends TasksStates{}
class GetUserUploadedTaskSuccessState extends TasksStates{}
class GetUserUploadedTaskErrorState extends TasksStates{}

class ConfirmTaskLoadingState extends TasksStates{}
class ConfirmTaskSuccessState extends TasksStates{}
class ConfirmTaskErrorState extends TasksStates{}

class ChangeWalletSuccessState extends TasksStates{}
class ChangeWalletErrorState extends TasksStates{}