// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Projects {
  struct Milestone {
    bytes32 name;
    bytes description;
    bool reached;
    bytes proof; // hash returned from IPFS or swarm
    uint64 expected_date;
  }

  struct Project {
    bytes32 name;
    bytes description;
    bytes main_video;
    bytes pitch_deck;
    uint32 target_fund;
    uint32 raised_funds;
    uint32 disbursted_funds;
    address payable fund_address;
    uint64 deadline;
    address[] backers;
    Milestone[] milestones;
  }

  Project[] projects;

  mapping(bytes32 => uint256) private projectIndex;

  /// @dev checks if the Project Name provided is a valid Project or not
  /// @param _projectName which is the bytes32 representation of the name of the Project
  /// @return projectValidity of type bool. Returns true if the project is valid, false otherwise
  function isValidProject(bytes32 _projectName) public view returns (bool) {
    return getHash(getProject(_projectName).name) == getHash(_projectName);
  }

  /// @dev getter function to get Project from the provided bytes32 Project name
  /// @param _projectName which is the bytes32 representation of the name of a Project
  /// @return project of type Project
  function getProject(bytes32 _projectName)
    internal
    view
    returns (Project memory)
  {
    bytes32 hash = getHash(_projectName);
    return projects[projectIndex[hash]];
  }

  function getHash(bytes32 _name) internal pure returns (bytes32) {
    return sha256(abi.encode(_name));
  }
}
