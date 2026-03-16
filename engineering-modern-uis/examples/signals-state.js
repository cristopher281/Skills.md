/**
 * signals-state.js
 * ────────────────────────────────────────────────────────────────
 * Signals-based reactive state primitives for the 2026 Frontend
 * Architecture. Zero virtual-DOM overhead — direct dependency
 * tracking with surgical DOM updates.
 *
 * Exports:
 *   createSignal(value)   → [getter, setter]
 *   computed(fn)           → getter
 *   effect(fn)             → disposer
 *   batch(fn)              → void
 * ────────────────────────────────────────────────────────────────
 */

// ── Internals ──────────────────────────────────────────────────

let _currentEffect = null;
let _batchDepth = 0;
const _pendingEffects = new Set();

// ── createSignal ───────────────────────────────────────────────
/**
 * Creates a reactive signal.
 *
 * @template T
 * @param {T} initialValue - The initial value of the signal.
 * @returns {[() => T, (value: T | ((prev: T) => T)) => void]}
 *
 * @example
 *   const [count, setCount] = createSignal(0);
 *   console.log(count());  // 0
 *   setCount(5);
 *   console.log(count());  // 5
 *   setCount(prev => prev + 1);
 *   console.log(count());  // 6
 */
export function createSignal(initialValue) {
    let value = initialValue;
    const subscribers = new Set();

    function get() {
        if (_currentEffect) {
            subscribers.add(_currentEffect);
        }
        return value;
    }

    function set(nextValue) {
        const newValue = typeof nextValue === 'function'
            ? nextValue(value)
            : nextValue;

        if (Object.is(newValue, value)) return;

        value = newValue;

        if (_batchDepth > 0) {
            for (const fn of subscribers) {
                _pendingEffects.add(fn);
            }
        } else {
            for (const fn of subscribers) {
                fn();
            }
        }
    }

    return [get, set];
}

// ── computed ───────────────────────────────────────────────────
/**
 * Creates a derived signal that auto-tracks its dependencies.
 *
 * @template T
 * @param {() => T} fn - A function that reads other signals.
 * @returns {() => T} A getter for the computed value.
 *
 * @example
 *   const [price, setPrice] = createSignal(100);
 *   const [qty, setQty] = createSignal(3);
 *   const total = computed(() => price() * qty());
 *   console.log(total());  // 300
 */
export function computed(fn) {
    const [get, set] = createSignal(undefined);

    effect(() => {
        set(fn());
    });

    return get;
}

// ── effect ─────────────────────────────────────────────────────
/**
 * Creates a reactive effect that re-runs when its signal
 * dependencies change.
 *
 * @param {() => void} fn - The effect function.
 * @returns {() => void} A dispose function to stop the effect.
 *
 * @example
 *   const [name, setName] = createSignal('World');
 *   const dispose = effect(() => {
 *     console.log(`Hello, ${name()}!`);
 *   });
 *   // Logs: "Hello, World!"
 *   setName('2026');
 *   // Logs: "Hello, 2026!"
 *   dispose();
 */
export function effect(fn) {
    let disposed = false;

    function execute() {
        if (disposed) return;
        const prev = _currentEffect;
        _currentEffect = execute;
        try {
            fn();
        } finally {
            _currentEffect = prev;
        }
    }

    execute();

    return function dispose() {
        disposed = true;
    };
}

// ── batch ──────────────────────────────────────────────────────
/**
 * Batches multiple signal updates into a single effect flush.
 * Prevents intermediate re-renders for performance.
 *
 * @param {() => void} fn - A function containing multiple signal updates.
 *
 * @example
 *   const [a, setA] = createSignal(1);
 *   const [b, setB] = createSignal(2);
 *
 *   effect(() => console.log(a() + b()));
 *   // Logs: 3
 *
 *   batch(() => {
 *     setA(10);
 *     setB(20);
 *   });
 *   // Logs: 30 (single flush, not 12 then 30)
 */
export function batch(fn) {
    _batchDepth++;
    try {
        fn();
    } finally {
        _batchDepth--;
        if (_batchDepth === 0) {
            for (const effect of _pendingEffects) {
                effect();
            }
            _pendingEffects.clear();
        }
    }
}
