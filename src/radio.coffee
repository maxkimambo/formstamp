angular
.module("angular-w")
.directive "wRadio", ['$window', ($window) ->
    restrict: "A"
    scope:
      items: '='
      limit: '='
      inline: '='
      keyAttr: '@'
      valueAttr: '@'
    require: '?ngModel'
    replace: true
    transclude: true
    templateUrl: "/templates/radio.html"
    controller: ($scope, $element, $attrs) ->

      $scope.selection = (item)->
        $scope.selectedItem = item unless $scope.disabled

      $scope.shownItems = $scope.items

    compile: (tElement, tAttrs) ->
      tAttrs.keyAttr ||= 'id'
      tAttrs.valueAttr ||= 'label'

      # Link function
      (scope, element, attrs, ngModelCtrl, transcludeFn) ->

        if ngModelCtrl
          scope.$watch 'selectedItem', ->
            ngModelCtrl.$setViewValue(scope.selectedItem)
            scope.activeItem = scope.selectedItem

          ngModelCtrl.$render = ->
            unless scope.disabled
              scope.selectedItem = ngModelCtrl.$modelValue

        attrs.$observe 'disabled', (value) ->
          scope.disabled = value

        attrs.$observe 'required', (value) ->
          scope.required = value
]