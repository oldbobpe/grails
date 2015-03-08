package com.retouch

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ProjectController {
	def myImageService
	def springSecurityService
	def taskService

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def index(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		respond Project.list(params), model: [projectInstanceCount: Project.count()]
	}

	//Main upload page
	def upload(){
		def projectId = Project.generateProjectId()
		def projectInstance = new Project(projectId:projectId )
		[projectInstance:projectInstance]
	}

	def instructions(String id){
		def projectInstance = Project.findByProjectId(id)
		if(!projectInstance){
			println "NO Project" + id
			flash.message = "This project does not exist."
			redirect(action: "upload")
			return
		}
		def imageTagsJson = taskService.getImageTagJSON(projectInstance.task)
		def techniques = Technique.list() //.executeQuery("select from Technique group by groep")
		println techniques
		println "image tage" + imageTagsJson
		[projectInstance:projectInstance,imageTagsJson:imageTagsJson,techniques:techniques]

	}

	def technique(String id){
		def projectInstance = Project.findByProjectId(id)
		if(!projectInstance){
			println "NO Project" + id
			flash.message = "This project does not exist."
			redirect(action: "upload")
			return
		}
		def imageTagsJson = taskService.getImageTagJSON(projectInstance.task)
		def techniques = Technique.list() 
		def uniqueTechniques = Technique.executeQuery("select distinct a.groep from Technique a")
		[projectInstance:projectInstance,imageTagsJson:imageTagsJson,techniques:techniques, uniqueTechniques:uniqueTechniques]
	}

	@Transactional
	def addInstructions(String id){
		def projectInstance = Project.findByProjectId(id)
		println "*************"+id

		if(!projectInstance || projectInstance?.client!=springSecurityService.getCurrentUser()){
			flash.message = "This project does not exist."
			redirect(action: "upload")
			return
		}
		projectInstance.properties = params

		if(!projectInstance.save(flush:true)){
			flash.message = message(code: 'default.updated.message', args: [
				message(code: 'Project.label', default: 'Project'),
				projectInstance.id
			])
			println projectInstance.errors
			// redirect(action: "instructions", id:projectInstance.projectId)
		}else{
			println "SERV"
			redirect(action: "service", id:projectInstance.projectId )
		}
	}

	def service(String id){
		def projectInstance = Project.findByProjectId(id)
		println "Service"
		if(!projectInstance){
			flash.message = "The project does not exist."
			redirect(action: "upload")
			return
		}
		if(!projectInstance.note){
			redirect(action: "instructions", id:projectInstance.projectId )
		}

		[projectInstance:projectInstance]

	}

	def projects(Integer max){
		params.max = Math.min(max ?: 10, 100)
		if(!params.sort){
			params.sort = "id"
			params.order = "desc"
		}
		respond Project.findAllByClient(springSecurityService.getCurrentUser(),params), model: [projectInstanceCount: Project.countByClient(springSecurityService.getCurrentUser())]
	}

	@Transactional
	def addTask(){
		def project
		println params.id
		if(params.id){
			project  = Project.findByProjectId(params.id)
			if(!project){
				project = new Project(client:springSecurityService.getCurrentUser(),projectId:params.id ,createdDate:new Date() )
			}
		}else{
			redirect(action: "upload")
			return
		}

		def imageFile
		if(params.reimage){
			imageFile = request.getFile('reimage')
		}

		if(imageFile && !imageFile.empty) {
			def fileName = myImageService.saveImagePackage( imageFile )
			def image = new ReImage(imagePath: fileName)
			def task = new Task(originalImage: image)
			project?.task = task
			// image.save(flush:true)
			if(!project.save(flush:true)){
				// myImageService.deleteImagePackage(image)
				println project.errors
				flash.message = "Action Failed!!! Please try again"
				redirect(action: "upload")
			}else{
				redirect(action: "instructions", id:project.projectId )
			}
		}else{
			flash.message = "Please select an image"
			redirect(action: "upload")
		}
	}

	def show(Project projectInstance) {
		respond projectInstance
	}

	def create() {
		respond new Project(params)
	}

	@Transactional
	def save(Project projectInstance) {
		if (projectInstance == null) {
			notFound()
			return
		}

		if (projectInstance.hasErrors()) {
			respond projectInstance.errors, view: 'create'
			return
		}

		projectInstance.save flush: true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [
					message(code: 'project.label', default: 'Project'),
					projectInstance.id
				])
				redirect projectInstance
			}
			'*' { respond projectInstance, [status: CREATED] }
		}
	}

	def edit(Project projectInstance) {
		respond projectInstance
	}

	@Transactional
	def update(Project projectInstance) {
		if (projectInstance == null) {
			notFound()
			return
		}

		if (projectInstance.hasErrors()) {
			respond projectInstance.errors, view: 'edit'
			return
		}

		projectInstance.save flush: true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [
					message(code: 'Project.label', default: 'Project'),
					projectInstance.id
				])
				redirect projectInstance
			}
			'*' { respond projectInstance, [status: OK] }
		}
	}

	@Transactional
	def delete(Project projectInstance) {

		if (projectInstance == null) {
			notFound()
			return
		}

		projectInstance.delete flush: true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.deleted.message', args: [
					message(code: 'Project.label', default: 'Project'),
					projectInstance.id
				])
				redirect action: "index", method: "GET"
			}
			'*' { render status: NO_CONTENT }
		}
	}

	@Transactional
	def addImageNote(Task task) {

		if(!task || task.project.client!=springSecurityService.getCurrentUser()){
			render false
		}else{
			println "TESTTTT" +params
			println "TESTTTT" +task

			params.note=params.note?.encodeAsHTML()
			def imgTg = new ImageTag(params)
			task.addToTags(imgTg)
			if(task.save(flush:true)){
				def noteJ = [x1:params.posX,y1:params.posY,height:params.height,width:params.width,note:params.note,note_id:imgTg.id ]
				render noteJ as JSON
			}else{
				task.errors.each{ println it }
				render false
			}
		}
	}
	@Transactional
	def removeImageNote(ImageTag imageTag){
		if(!imageTag || imageTag?.task?.project?.client!=springSecurityService.getCurrentUser()){
			render false
		}else{
			try{
				imageTag.delete(failOnError:true)
				render true
			}
			catch(e) {
				render false
			}
		}
	}

	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [
					message(code: 'project.label', default: 'Project'),
					params.id
				])
				redirect action: "index", method: "GET"
			}
			'*' { render status: NOT_FOUND }
		}
	}
}
