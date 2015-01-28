var app = Application('OmniFocus');
app.includeStandardAdditions = true;
var doc = app.defaultDocument;
var allTasks = doc.flattenedTasks.whose({completed: false})();
var allProjects = doc.flattenedProjects.whose({completed: false})();

function getProjects() {
  var results = [];
  var info = {};

  allProjects.forEach(function(item) {
    info = {};
    info.name = item.name();
    info.container = item.container().name();
    if (typeof item.folder() === 'function') {
      info.folder = item.folder().name();
    }
    info.singletonActionHolder = item.singletonActionHolder();
    info.sequential  = item.sequential();
		if (typeof item.context() === 'function') {
			info.context = item.context().name();
		}
    info.id = item.id();
    info.link = "omnifocus:///item/" + item.id();
    info.note = item.note();
    info.flagged = item.flagged();
    //info.blocked = item.blocked();
    //info.creationDate = item.creationDate();
    //info.deferDate = item.deferDate();
    info.dueDate = item.dueDate();
    info.nextTask = item.nextTask();
    info.estimatedMinutes = item.estimatedMinutes();
    info.numberOfTasks = item.numberOfTasks();
    info.numberOfAvailableTasks = item.numberOfAvailableTasks();
    info.numberOfCompletedTasks = item.numberOfCompletedTasks();

    results.push(info);
  });
  return results;
}

function getTasks() {
  var results = [];
  var info = {};

  allTasks.forEach(function (task) {
    // only add tasks, not projects
    if (task.container().name() !== 'OmniFocus') {
      info = {};
      info.name = task.name();
      info.context = task.context.name();
      info.contextID = task.context.id();
      info.container = task.container().name();
      info.containerID = task.container().id();
      info.containingProject = task.containingProject().name();
      
      //if (typeof x === 'function') {
      info.parentTask = task.parentTask();
      //}
      info.subTask = (info.container !== info.containingProject);
      
      info.id = task.id();
      info.link = "omnifocus:///task/" + task.id();
      info.note = task.note();
      info.flagged = task.flagged();
      info.completed = task.completed();
      info.next = task.next();
      info.blocked = task.blocked();
      info.creationDate = task.creationDate();
      info.deferDate = task.deferDate();
      info.dueDate = task.dueDate();
      info.estimatedMinutes = task.estimatedMinutes();
      info.numberOfTasks = task.numberOfTasks();
      info.numberOfAvailableTasks = task.numberOfAvailableTasks();
      info.repetitionRule = task.repetitionRule();
  
      results.push(info);
    }
  });
  return results;
}

function build() {
  var data = {
    "updated": new Date(),
    "projects": getProjects(),
    "tasks": getTasks()
  };
  //data = data.tasks[5];
  data = JSON.stringify(data);
  //data = JSON.stringify(data, null, '\t');
  //console.log(data);
  return data;
}
build();
