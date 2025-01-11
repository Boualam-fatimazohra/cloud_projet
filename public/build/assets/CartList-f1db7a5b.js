import{z as m,J as C,o as r,c as A,w as V,K as u,e as t,b as a,q,t as g,g as b,n as z,s as d,v as i,F as U,O as x}from"./app-286e29ed.js";import S from"./UserLayouts-16a92e64.js";import"./index-419f3630.js";import"./Header-18568074.js";import"./Footer-fa580ed6.js";import"./_plugin-vue_export-helper-c27b6911.js";/* empty css                                                             */const $={class:"text-gray-600 body-font relative"},B={class:"container px-5 py-24 mx-auto flex sm:flex-nowrap flex-wrap"},j={class:"lg:w-2/3 md:w-1/2 rounded-lg sm:mr-10 p-10"},I={class:"w-full text-sm text-left text-gray-500 dark:text-gray-400"},M=t("thead",{class:"text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400"},[t("tr",null,[t("th",{scope:"col",class:"px-6 py-3"},[t("span",{class:"sr-only"},"Image")]),t("th",{scope:"col",class:"px-6 py-3"}," Product "),t("th",{scope:"col",class:"px-6 py-3"}," Qty "),t("th",{scope:"col",class:"px-6 py-3"}," Price "),t("th",{scope:"col",class:"px-6 py-3"}," Action ")])],-1),P={class:"w-32 p-4"},F=["src"],N={key:1,src:"https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png",alt:"Apple Watch"},O={class:"px-6 py-4 font-semibold text-gray-900 dark:text-white"},Q={class:"px-6 py-4"},D={class:"flex items-center space-x-3"},L=["onClick","disabled"],T=t("span",{class:"sr-only"},"Quantity button",-1),W=t("svg",{class:"w-3 h-3","aria-hidden":"true",xmlns:"http://www.w3.org/2000/svg",fill:"none",viewBox:"0 0 18 2"},[t("path",{stroke:"currentColor","stroke-linecap":"round","stroke-linejoin":"round","stroke-width":"2",d:"M1 1h16"})],-1),E=[T,W],J=["onUpdate:modelValue"],K=["onClick"],R=t("span",{class:"sr-only"},"Quantity button",-1),Z=t("svg",{class:"w-3 h-3","aria-hidden":"true",xmlns:"http://www.w3.org/2000/svg",fill:"none",viewBox:"0 0 18 18"},[t("path",{stroke:"currentColor","stroke-linecap":"round","stroke-linejoin":"round","stroke-width":"2",d:"M9 1v16M1 9h16"})],-1),G=[R,Z],H={class:"px-6 py-4 font-semibold text-gray-900 dark:text-white"},X={class:"px-6 py-4"},Y=["onClick"],tt={class:"lg:w-1/3 md:w-1/2 bg-white flex flex-col md:ml-auto w-full md:py-8 mt-8 md:mt-0"},et=t("h2",{class:"text-gray-900 text-lg mb-1 font-medium title-font"},"Summary",-1),ot={class:"leading-relaxed mb-5 text-gray-600"},st={key:0},rt=t("h2",{class:"text-gray-900 text-lg mb-1 font-medium title-font"},"Shipping Address",-1),at={class:"leading-relaxed mb-5 text-gray-600"},nt=t("p",{class:"leading-relaxed mb-5 text-gray-600"},"or you can add new below",-1),dt={key:1},it=t("p",{class:"leading-relaxed mb-5 text-gray-600"}," Add shipping address to continue",-1),lt=[it],ct=["onSubmit"],ut={class:"relative mb-4"},gt=t("label",{for:"name",class:"leading-7 text-sm text-gray-600"},"Address 1",-1),pt={class:"relative mb-4"},yt=t("label",{for:"email",class:"leading-7 text-sm text-gray-600"},"City",-1),mt={class:"relative mb-4"},bt=t("label",{for:"email",class:"leading-7 text-sm text-gray-600"},"State",-1),xt={class:"relative mb-4"},ht=t("label",{for:"email",class:"leading-7 text-sm text-gray-600"},"Zipcode",-1),_t={class:"relative mb-4"},ft=t("label",{for:"email",class:"leading-7 text-sm text-gray-600"},"Country Code",-1),vt={class:"relative mb-4"},kt=t("label",{for:"email",class:"leading-7 text-sm text-gray-600"},"Address type",-1),wt={key:0,type:"submit",class:"text-white bg-indigo-500 border-0 py-2 px-6 focus:outline-none hover:bg-indigo-600 rounded text-lg"},Ct={key:1,type:"submit",class:"text-white bg-gray-500 border-0 py-2 px-6 focus:outline-none hover:bg-gray-600 rounded text-lg"},At=t("p",{class:"text-xs text-gray-500 mt-3"},"Continue Shopping ",-1),jt={__name:"CartList",props:{userAddress:Object},setup(p){const n=m(()=>u().props.cart.data.items),_=m(()=>u().props.cart.data.products),f=m(()=>u().props.cart.data.total),l=c=>n.value.findIndex(s=>s.product_id===c),o=C({address1:null,state:null,city:null,zipcode:null,country_code:null,type:null}),v=m(()=>o.address1!==null&&o.state!==null&&o.city!==null&&o.zipcode!==null&&o.country_code!==null&&o.type!==null),h=(c,s)=>x.patch(route("cart.update",c),{quantity:s}),k=c=>x.delete(route("cart.delete",c));function w(){x.visit(route("checkout.store"),{method:"post",data:{carts:u().props.cart.data.items,products:u().props.cart.data.products,total:u().props.cart.data.total,address:o}})}return(c,s)=>(r(),A(S,null,{default:V(()=>[t("section",$,[t("div",B,[t("div",j,[t("table",I,[M,t("tbody",null,[(r(!0),a(U,null,q(_.value,e=>(r(),a("tr",{key:e.id,class:"bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600"},[t("td",P,[e.product_images.length>0?(r(),a("img",{key:0,src:`/${e.product_images[0].image}`,alt:"Apple Watch"},null,8,F)):(r(),a("img",N))]),t("td",O,g(e.title),1),t("td",Q,[t("div",D,[t("button",{onClick:b(y=>h(e,n.value[l(e.id)].quantity-1),["prevent"]),disabled:n.value[l(e.id)].quantity<=1,class:z([n.value[l(e.id)].quantity>1?"cursor-pointer text-purple-600":"cursor-not-allowed text-gray-300 dark:text-gray-500","inline-flex items-center justify-center p-1 text-sm font-medium h-6 w-6 text-gray-500 bg-white border border-gray-300 rounded-full focus:outline-none hover:bg-gray-100 focus:ring-4 focus:ring-gray-200 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700"]),type:"button"},E,10,L),t("div",null,[d(t("input",{type:"number",id:"first_product","onUpdate:modelValue":y=>n.value[l(e.id)].quantity=y,class:"bg-gray-50 w-14 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block px-2.5 py-1 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500",placeholder:"1",required:""},null,8,J),[[i,n.value[l(e.id)].quantity]])]),t("button",{onClick:b(y=>h(e,n.value[l(e.id)].quantity+1),["prevent"]),class:"inline-flex items-center justify-center h-6 w-6 p-1 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-full focus:outline-none hover:bg-gray-100 focus:ring-4 focus:ring-gray-200 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700",type:"button"},G,8,K)])]),t("td",H," $"+g(e.price),1),t("td",X,[t("a",{onClick:y=>k(e),class:"font-medium text-red-600 dark:text-red-500 hover:underline"},"Remove",8,Y)])]))),128))])])]),t("div",tt,[et,t("p",ot,"Total : $ "+g(f.value),1),p.userAddress?(r(),a("div",st,[rt,t("p",at,g(p.userAddress.address1)+" , "+g(p.userAddress.city)+", "+g(p.userAddress.zipcode),1),nt])):(r(),a("div",dt,lt)),t("form",{onSubmit:b(w,["prevent"])},[t("div",ut,[gt,d(t("input",{type:"text",id:"name",name:"address1","onUpdate:modelValue":s[0]||(s[0]=e=>o.address1=e),class:"w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"},null,512),[[i,o.address1]])]),t("div",pt,[yt,d(t("input",{type:"text",id:"email",name:"city","onUpdate:modelValue":s[1]||(s[1]=e=>o.city=e),class:"w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"},null,512),[[i,o.city]])]),t("div",mt,[bt,d(t("input",{type:"text",id:"email",name:"state","onUpdate:modelValue":s[2]||(s[2]=e=>o.state=e),class:"w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"},null,512),[[i,o.state]])]),t("div",xt,[ht,d(t("input",{type:"text",id:"email",name:"zipcode","onUpdate:modelValue":s[3]||(s[3]=e=>o.zipcode=e),class:"w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"},null,512),[[i,o.zipcode]])]),t("div",_t,[ft,d(t("input",{type:"text",id:"email",name:"countrycode","onUpdate:modelValue":s[4]||(s[4]=e=>o.country_code=e),class:"w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"},null,512),[[i,o.country_code]])]),t("div",vt,[kt,d(t("input",{type:"text",id:"email",name:"type","onUpdate:modelValue":s[5]||(s[5]=e=>o.type=e),class:"w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"},null,512),[[i,o.type]])]),v.value||p.userAddress?(r(),a("button",wt,"Checkout")):(r(),a("button",Ct,"Add Address to continue"))],40,ct),At])])])]),_:1}))}};export{jt as default};