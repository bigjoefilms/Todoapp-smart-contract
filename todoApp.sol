//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    struct  Task {
        string description;
        bool isCompleted;
    }
    
    mapping(uint => Task)  tasks;
    uint public taskCount;
    
    event TaskCreated(uint indexed id, string description, bool isCompleted);
    event TaskCompleted(uint indexed id, bool isCompleted);
    event TaskDeleted(uint indexed id);
    event TaskUpdated(uint indexed id, string description, bool isCompleted);

    
    function createTask(string memory _description) public {
        taskCount++;
        tasks[taskCount] = Task(_description, false);
        emit TaskCreated(taskCount, _description, false);
    }
    
    function toggleCompleted(uint _id) public {
        Task storage task = tasks[_id];
        task.isCompleted = !task.isCompleted;
        emit TaskCompleted(_id, task.isCompleted);
    }

    function deleteTask(uint _id) public {
          require(_id > 0 && _id <= taskCount, "Invalid task ID");
        for (uint i = _id; i < taskCount; i++) {
            tasks[i] = tasks[i+1];
        }
        delete tasks[taskCount];
        taskCount--;
        emit TaskDeleted(_id);
    }
     function showTask(uint _id) public view returns (string memory description, bool isCompleted) {
        require(_id > 0 && _id <= taskCount, "Invalid task ID");
        Task storage task = tasks[_id];
        description = task.description;
        isCompleted = task.isCompleted;
    }
    function updateTask(uint _id, string memory _description, bool _isCompleted) public {
        require(_id > 0 && _id <= taskCount, "Invalid task ID");
        Task storage task = tasks[_id];
        task.description = _description;
        task.isCompleted = _isCompleted;
        emit TaskUpdated(_id, _description, _isCompleted);
    }


}



