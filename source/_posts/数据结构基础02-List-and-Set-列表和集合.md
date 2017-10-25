---
title: 数据结构基础02 List and Set 列表和集合
date: 2017-10-25 11:45:19
tags:
---

# 02 列表和集合

## 概览

- Collection/Set
- List/Array/Link List
- Stack
- Queue/Double Ended Queue
- Priority Queue
- 作业
	- Linked List
	- Queue
	- Stack

## Collection 集合
集合中的内容不需要是相同类型的对象。如： Set('a', 123, {m: 'm'})

## List / Array / Linked List
Linked List 与 Array 的差异：

- 内存分配差异
- 和array差异： 
	- Array更利于查找和修改值
	- Linked List更利于增加和删除节点

## Stack
.push(value) // python中为 List.append(value)
.pop()

## Queue
.enqueue() 对尾入队
.peek() 返回队首
.dequeue() 队首出队

## Double Ended Queue
双端队列： double-ended queue

	// python
	from collections import deque

## Priority Queue
优先队列  

- 优先队列中所有的节点都有权重
- 每次出队，返回的节点都为权重最高/最低的节点
- 每次入队，节点都会存在相应的位置
- 有多种数据结构可以用来生成优先队列。如 Binary Search Tree，等。其他结构暂不了解


## 作业

**Linked List作业：**	

	class Element(object):
	    def __init__(self, value):
	        self.value = value
	        self.next = None	

	class LinkedList(object):
	    def __init__(self, head=None):
	        self.head = head
	
			def append(self, new_element):
	        current = self.head
	        if self.head:
	            while current.next:
	                current = current.next
	            current.next = new_element
	        else:
	            self.head = new_element

			def get_position(self, position):
	        """Get an element from a particular position.
	        Assume the first position is "1".
	        Return "None" if position is not in the list."""
	        if position < 1: return None
	
	        count = 1
	        point = self.head
	        while point:
	            if count == position:
	                return point
	            point = point.next
	            count += 1
	        return None

	    def insert(self, new_element, position):
	        """Insert a new node at the given position.
	        Assume the first position is "1".
	        Inserting at position 3 means between
	        the 2nd and 3rd elements."""
	        if position < 1: return
	        if position == 1:
	            new_element.next = self.head
	            self.head = new_element
	
	        point = self.head
	        count = 1
	        while point:
	            if count == position - 1:
	                new_element.next = point.next
	                point.next = new_element
	
	            count += 1
	            point = point.next
	
	    def delete(self, value):
	        """Delete the first node with a given value."""
	
	        if self.head.value == value:
	            self.head = self.head.next
	            return value
	
	        prev = self.head
	        point = prev.next
	
	        while point:
	            if point.value == value:
	                prev.next = point.next
	                return value
	
	            prev = point
	            point = point.next
	
	        return None
		# Test cases
		# Set up some Elements
		e1 = Element(1)
		e2 = Element(2)
		e3 = Element(3)
		e4 = Element(4)
		
		# Start setting up a LinkedList
		ll = LinkedList(e1)
		ll.append(e2)
		ll.append(e3)
		
		# Test get_position
		# Should print 3
		print ll.head.next.next.value
		# Should also print 3
		print ll.get_position(3).value
		
		# Test insert
		ll.insert(e4,3)
		# Should print 4 now
		print ll.get_position(3).value
		
		# Test delete
		ll.delete(1)
		# Should print 2 now
		print ll.get_position(1).value
		# Should print 4 now
		print ll.get_position(2).value
		# Should print 3 now
		print ll.get_position(3).value

**Queue作业：**

		"""
			Make a Queue class using a list!
			Hint: You can use any Python list method
			you'd like! Try to write each one in as
			few lines as possible.
			Make sure you pass the test cases too!
		"""
		
		class Queue:
		    def __init__(self, head=None):
		        self.storage = [head]
		
		    def enqueue(self, new_element):
		        if new_element is not None:
		            self.storage.append(new_element)
		        return self.storage
		
		    def peek(self):
		        if len(self.storage) > 0: return self.storage[0]
		        return None
		
		    def dequeue(self):
		        buffer = None
		        if len(self.storage) > 0:
		            buffer = self.storage[0]
		            del self.storage[0]
		        return buffer
		
		# Setup
		q = Queue(1)
		q.enqueue(2)
		q.enqueue(3)
		
		# Test peek
		# Should be 1
		print q.peek()
		
		# Test dequeue
		# Should be 1
		print q.dequeue()
		
		# Test enqueue
		q.enqueue(4)
		# Should be 2
		print q.dequeue()
		# Should be 3
		print q.dequeue()
		# Should be 4
		print q.dequeue()
		q.enqueue(5)
		# Should be 5
		print q.peek()
		
**Stack**

	"""Add a couple methods to our LinkedList class,
	and use that to implement a Stack.
	You have 4 functions below to fill in:
	insert_first, delete_first, push, and pop.
	Think about this while you're implementing:
	why is it easier to add an "insert_first"
	function than just use "append"?"""
	
	
	class Element(object):
	    def __init__(self, value):
	        self.value = value
	        self.next = None

	class LinkedList(object):
	    def __init__(self, head=None):
	        self.head = head

	    def append(self, new_element):
	        current = self.head
	        if self.head:
	            while current.next:
	                current = current.next
	            current.next = new_element
	        else:
	            self.head = new_element
	
	    def insert_first(self, new_element):
	        "Insert new element as the head of the LinkedList"
	        new_element.next = self.head
	        self.head = new_element
	
	    def delete_first(self):
	        "Delete the first (head) element in the LinkedList as return it"
	        if self.head is None: return None
	        current = self.head
	        self.head = self.head.next
	        return current

	class Stack(object):
	    def __init__(self, top=None):
	        self.ll = LinkedList(top)

	    def push(self, new_element):
	        "Push (add) a new element onto the top of the stack"
	        self.ll.insert_first(new_element)
	
	    def pop(self):
	        "Pop (remove) the first element off the top of the stack and return it"
	        return self.ll.delete_first()
	        
	# Test cases
	# Set up some Elements
	e1 = Element(1)
	e2 = Element(2)
	e3 = Element(3)
	e4 = Element(4)
	
	# Start setting up a Stack
	stack = Stack(e1)
	
	# Test stack functionality
	stack.push(e2)
	stack.push(e3)
	print stack.pop().value
	print stack.pop().value
	print stack.pop().value
	print stack.pop()
	stack.push(e4)
	print stack.pop().value