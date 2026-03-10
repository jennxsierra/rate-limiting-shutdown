package main

import (
	"net/http"

	"github.com/julienschmidt/httprouter"
)

func (a *applicationDependencies) routes() http.Handler {

	// setup a new router
	router := httprouter.New()

	// handle 404
	router.NotFound = http.HandlerFunc(a.notFoundResponse)

	// handle 405
	router.MethodNotAllowed = http.HandlerFunc(a.methodNotAllowedResponse)

	// setup routes
	router.HandlerFunc(http.MethodGet, "/v1/healthcheck", a.healthcheckHandler)

	// Patient routes
	router.HandlerFunc(http.MethodGet, "/v1/patients", a.listPatientsHandler)
	router.HandlerFunc(http.MethodGet, "/v1/patients/:patient_no", a.showPatientHandler)
	router.HandlerFunc(http.MethodPost, "/v1/patients", a.createPatientHandler)
	router.HandlerFunc(http.MethodPut, "/v1/patients/:patient_no", a.updatePatientHandler)
	router.HandlerFunc(http.MethodPatch, "/v1/patients/:patient_no", a.updatePatientHandler)
	router.HandlerFunc(http.MethodDelete, "/v1/patients/:patient_no", a.deletePatientHandler)

	// Request sent first to recoverPanic() then sent to rateLimit()
	// finally it is sent to the router
	return a.recoverPanic(a.rateLimit(router))
}
