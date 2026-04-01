/** @import { KnownUniqueStringTypes } from "./types.d.js" */
// Eg:
// /**
//  * @typedef {{A: UniqueString<'a','A'>}} KnownUniqueStringTypes
//  */

/**
 * @template {string} options
 * @template {string} id
 * @typedef {string & { options: options, id: id }} UniqueString<options,id>
 */
/**
 * @template {UniqueString<*, *>} U
 * @template {string} T
 * @typedef {UniqueString<U extends UniqueString<infer S, *> ? S : never, `${U extends UniqueString<*, infer N> ? N : never}${T}`>} ChainedUniqueString<U,T>
 */

/**
 * @template {string} str
 * @template {string} id
 * @param {str} str
 * @param {id} _id
 * @returns {(KnownUniqueStringTypes & { [key: string] : false })[id] extends UniqueString<infer options, id> ? str extends options ? UniqueString<str, id> : never : UniqueString<str, id>}
 */ // @ts-expect-error
export const asUniqueStr = (str, _id) => str

/**
 * @template {string | UniqueString<*, *>} T
 * @param {T} str
 * @returns {T extends UniqueString<infer S, infer id> ? (KnownUniqueStringTypes & { [key: string] : false })[id] extends UniqueString<infer options, id> ? options : S : T}
 */ // @ts-expect-error
export const asStr = str => str
