/**
 * assertions.ks
 * Version 0.0.0
 * October 10th, 2019
 *
 * Copyright (c) 2019 Baptiste Augrain
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 **/
require|import 'chai' for assert, Assertion, config, expect, should, Should, use

import 'deep-eql'

func comparator(a?, b?) { # {{{
	if Type.isEnumInstance(a) {
		if Type.isEnumInstance(b) {
			return a.value == b.value && a.__ks_enum == b.__ks_enum
		}
		else if b is Number {
			return a.value == b
		}
		else {
			return false
		}
	}
	else if Type.isEnumInstance(b) {
		if Type.isEnumInstance(a) {
			return a.value == b.value && a.__ks_enum == b.__ks_enum
		}
		else if a is Number {
			return a == b.value
		}
		else {
			return false
		}
	}
	else {
		return null
	}
} # }}}

func assertEql(this, flag, obj, msg? = null) { # {{{
	if msg != null {
		flag(this, 'message', msg)
		// echo(msg)
	}

	this.assert(
		deepEql(obj, this._obj, {
			comparator
		})
		'expected #{this} to deeply equal #{exp}'
		'expected #{this} to not deeply equal #{exp}'
		obj
		this._obj
		true
	)
} # }}}

use(func({Assertion}, {flag}) {
	var fn = assertEql^^(flag, ...)

	Assertion.addMethod('eql', fn)
	Assertion.addMethod('eqls', fn)
})

export assert, Assertion, config, expect, should, Should, use
