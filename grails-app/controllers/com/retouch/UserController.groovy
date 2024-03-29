package com.retouch



import static org.springframework.http.HttpStatus.*

import javax.swing.GroupLayout.Spring;


import com.sun.org.apache.xerces.internal.parsers.SecurityConfiguration;

import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.SpringSecurityUtils;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

	def springSecurityService

	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def index(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		respond User.list(params), model:[userInstanceCount: User.count()]
	}

	def show(User userInstance){

		if(SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')){
			respond userInstance ,model:[userProjects: Project.findAllByClient(userInstance)]
		} else {
			respond springSecurityService.getCurrentUser() , model:[userProjects: Project.findAllByClient(springSecurityService.getCurrentUser())]
		}
	}

	def create() {
		respond new User(params)
		respond new Role(params.role)
	}

	@Transactional
	def save(User userInstance) {

		def userRole = Role.findByAuthority(params.role)

		if (userInstance == null) {
			notFound()
			return
		}

		if (userInstance.hasErrors()) {
			respond userInstance.errors, view:'create'
			return
		}
		try{
			userInstance.save flush:true
			UserRole.create userInstance, userRole, true
		}
		catch (Exception e) {
			flash.message = 'Problem Creating User.'
		}

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [
					message(code: 'user.label', default: 'User'),
					userInstance.id
				])
				redirect userInstance
			}
			'*' { respond userInstance, [status: CREATED] }
		}
	}

	def edit(User userInstance) {
		if(SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')){
			respond userInstance
		} else {
			respond springSecurityService.getCurrentUser()
		}
	}

	@Transactional
	def update(User userInstance) {

        if(SpringSecurityUtils.ifNotGranted('ROLE_ADMIN')){
            if(springSecurityService.getCurrentUser() != userInstance){
                notFound()
                return
            }
        }

		def userRole = Role.findById(params.role)

		if (userInstance == null) {
			notFound()
			return
		}

		if (userInstance.hasErrors()) {
			respond userInstance.errors, view:'edit'
			return
		}

		def deleteRole = UserRole.findByUser(userInstance)
        if(deleteRole && SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')){
            deleteRole.delete flush:true
        }

		userInstance.save flush:true

        if(SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')){
            UserRole.create userInstance, userRole, true
        }

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.updated.message', args: [
					message(code: 'User.label', default: 'User'),
					userInstance.id
				])
				redirect action:'edit',id:userInstance.id
			}
			'*'{ respond userInstance, [status: OK] }
		}
	}

	@Transactional
	def delete(User userInstance) {

		if (userInstance == null) {
			notFound()
			return
		}

		userInstance.delete flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.deleted.message', args: [
					message(code: 'User.label', default: 'User'),
					userInstance.id
				])
				redirect action:"index", method:"GET"
			}
			'*'{ render status: NO_CONTENT }
		}
	}

	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [
					message(code: 'user.label', default: 'User'),
					params.id
				])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
}
