;function enumerate(item){var arr,iter,i;arr=[];iter=ՐՏ_Iterable(item);for(i=0;i<iter.length;i++){arr[arr.length]=[i,item[i]]}return arr}function ՐՏ_Iterable(iterable){var tmp;if(iterable.constructor===[].constructor||iterable.constructor==="".constructor||(tmp=Array.prototype.slice.call(iterable)).length){return tmp||iterable}return Object.keys(iterable)}function range(start,stop,step){var length,idx,range;if(arguments.length<=1){stop=start||0;start=0}step=arguments[2]||1;length=Math.max(Math.ceil((stop-start)/step),0);idx=0;range=new Array(length);while(idx<length){range[idx++]=start;start+=step}return range}var __name__="__main__";var points;points=[];function setup(){var x;createCanvas(windowWidth,windowHeight);points=(function(){var ՐՏidx1,ՐՏitr1=ՐՏ_Iterable(range(10,windowWidth-10,20)),ՐՏres=[],x;for(ՐՏidx1=0;ՐՏidx1<ՐՏitr1.length;ՐՏidx1++){x=ՐՏitr1[ՐՏidx1];ՐՏres.push([x,windowHeight/2])}return ՐՏres})();stroke(100,200,100,100);background(51)}function draw(){;var ՐՏitr2,ՐՏidx2;var i,point;background(51);noFill();beginShape();ՐՏitr2=ՐՏ_Iterable(enumerate(points.slice(1,-2)));for(ՐՏidx2=0;ՐՏidx2<ՐՏitr2.length;ՐՏidx2++){[i,point]=ՐՏitr2[ՐՏidx2];curveVertex(point[0],point[1]);point[1]=point[1]+random(-2,2)}endShape()}window.setup=setup;window.draw=draw