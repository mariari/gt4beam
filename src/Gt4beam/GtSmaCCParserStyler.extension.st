Extension { #name : #GtSmaCCParserStyler }

{ #category : #'*Gt4beam' }
GtSmaCCParserStyler class >> elixirStyler: aParserClass [
	<smaccStyler: #ElixirParser priority: 50>
	^ (self forParser: aParserClass)
		stylerRules: {GtSmaCCKeywordTokensStylerRule
					styleBlock: [ :styler | 
						styler
							bold;
							foreground: Color purple ].
				GtSmaCCCommentStylerRule
					styleBlock: [ :styler | styler foreground: Color lightGray ].
				GtSmaCCNodeStylerRule
					nodeClassName: #ElixirNumberNode
					styleBlock: [ :styler | styler foreground: Color blue ].
				GtSmaCCNodeStylerRule
					nodeClassName: #ElixirBinStringNode
					styleBlock: [ :styler | styler foreground: Color blue ].
				GtSmaCCNodeStylerRule
					nodeClassName: #ElixirListNode
					styleBlock: [ :styler :node :text | 
						CarpStylerUtilities
							colorAndHighlightParenthesesLeft: node startPosition
							right: node stopPosition
							atNestingLevel: node listDepth
							inText: text ].
				GtSmaCCNodeStylerRule
					nodeClassName: #ElixirMapNode
					styleBlock: [ :styler :node :text | 
						CarpStylerUtilities
							colorAndHighlightParenthesesLeft: node startPosition
							right: node stopPosition
							atNestingLevel: node listDepth
							inText: text ].
				GtSmaCCNodeStylerRule
					nodeClassName: #ElixirAtomNode
					styleBlock: [ :styler | styler italic ].
				GtSmaCCNodeStylerRule
					nodeClassName: #ElixirDoNode
					styleBlock: [ :styler :node :text | 
						(text from: node module startPosition to: node module stopPosition)
							foreground: Color orange ].
				GtSmaCCNodeStylerRule
					nodeClassName: #ElixirTrueNode
					styleBlock: [ :styler :node :text | 
						(text from: node module startPosition to: node module stopPosition)
							foreground: Color orange ].
				GtSmaCCNodeStylerRule
					nodeClassName: #ElixirFalseNode
					styleBlock: [ :styler :node :text | 
						(text from: node module startPosition to: node module stopPosition)
							foreground: Color orange ].
				GtSmaCCNodeVariableStylerRule
					nodeClassName: #SmaCCErrorNode
					variableNames: #(dismissedTokens errorToken)
					styleBlock: [ :styler | styler foreground: Color red ]}
]
