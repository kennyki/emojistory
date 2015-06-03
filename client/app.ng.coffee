angular.module('emojistory', [
  'angular-meteor'
  'ui.router'
  'ui.bootstrap'
  'angularMoment'
  'emojistory.home'
  'emojistory.story'
])

.config ($urlRouterProvider, $locationProvider) ->
  # default
  $urlRouterProvider.otherwise '/'
  # rock 'n roll
  $locationProvider.html5Mode true

.run ($rootScope, $state) ->
  $rootScope.$on '$stateChangeError', (event, next, prev, error) ->
    # TODO: proper error pages routing: 404, 401, 500, etc
    alert error

  # default to home
  accountsUIBootstrap3.logoutCallback = ->
    $state.go 'home'