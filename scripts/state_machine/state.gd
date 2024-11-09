## 这个类是状态基本类,模拟的一个接口类
class_name State extends Node

# TODO 状态基本类

signal update_state(state_name : String)


func enter(): pass


func update(_delta : float): pass


func physics_update(_delta : float): pass


func exit(): pass
