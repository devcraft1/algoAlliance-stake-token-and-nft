// // const arr = []

// // try {
// //     arr.push('try')
// //     throw new Error()

// // } catch {
// //     arr.push('catch')
// // } finally {
// //     arr.push('finally')
// // }

// // console.log(arr)


// const myQueue = Queue()

// myQueue.enqueue(1)
// myQueue.enqueue(2)


// const r1 = myQueue.dequeue() === 1
// const r2 = myQueue.dequeue() === 2

// console.log(r1 && r2)



async function apicall() {
    return new Promise(resolve => {
        setTimeout(() => {
            resolve('b')
        }, 50)
    })
}

async function logger() {
    setTimeout(() => console.log('a', 10));
    console.log(await apicall())
    console.log('c')
}

logger()