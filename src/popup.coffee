angular
.module('angular-w').directive('wPopup', ["$compile", ($compile)->
  restrict: 'E'
  scope: {}
  replace: true
  template: (tElement, tAttrs)->
    content = tElement.html()
    console.log('content', content)
    console.log('tAttrs.name', tAttrs.name)
    template = "<div ng-show='isPopupVisible'>#{content}</div>"
    console.log('template', template)
    # tElement.replaceWith(template)
    console.log('tElement', tElement)
    template
  compile: (tElement, tAttrs)->
    content = tElement.html()
    tElement.empty()
    return (scope, element)->
      console.log('scope', scope)
      console.log('i am linked', element)
      scope.isPopupVisible = false
      scope.showPopup = (attachTo)->
        scope.isPopupVisible = true
        console.log('attachTo', attachTo)
        console.log('content', content)
        childScope = scope.$new()
        # linkedContent = $compile(angular.element(content))(childScope)
        linkedContent = content
        element.html(linkedContent)
]).directive('wPopup', ['$document', ($document)->
  restrict: 'A'
  link: (scope, element, attrs)->
    element.on 'focus', ->
      console.log('popup will show')
      for el in $document.find("div")
        popup = angular.element(el)
        if popup.attr('name') == attrs.wPopup
          console.log('element', el)
          popup.isolateScope().$apply (scope)->
            scope.showPopup(element)
          break
])
