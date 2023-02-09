let shoppingCart = {};
const moneySymbol = "$";

// Pls customer, don't touch on below code if you really don't know what you're doing!!!!
$(function () {
    window.addEventListener('message', function (event) {
        const data = event.data;
        if (data.action == 'open') {
            $("#shoppingCart_list").empty();
            shoppingCart = {};

            $('.cart_item_box .total_price').text(`${moneySymbol}0.0`);

            $('body').show()

        } else if (data.action == 'add') {
            $(".product_box").append(`
                <div class="product_item filter ${data.category}" data-item="${data.item}" data-display="${data.display}" data-price="${data.price}">
                    <div class="product_content">
                        <h4>${data.display}</h4>
                        <p>${data.description}</p>
                        <button class="addToCartBtn">${moneySymbol}${data.price}</button>
                    </div>
                    <div class="product_img">
                        <img src="img/${data.item}.png" alt="image not found" />
                    </div>
                </div>
            `);

        } else if (data.action == 'clear') {
            $(".product_box").empty();
            $('.clear_btn').click();

        } else if (data.action == 'close') {
            $('.clear_btn').click();
            $('body').hide()
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $('body').hide();
            $.post('https://if-shopv1/escape', '{}');
        }
    };    

    $('.clear_btn').click(function () {
        $("#shoppingCart_list").empty();
        shoppingCart = {};

        $('.cart_item_box .total_price').attr('data-totalPrice', 0.0);
        $('.cart_item_box .total_price').text(`${moneySymbol}0.0`);
    });
    $('.pay_btn').click(async function() {
        await $.post('https://if-shopv1/buy', JSON.stringify({shoppingCart}), function(success) {
            if (success) {
                $('.clear_btn').click();
                $('body').hide();

            } else {
                $('body').hide();
                setTimeout(() => {
                    $('body').show();
                }, 2500);
            };
        });
    });

    $('.product_box').on('click', '.addToCartBtn', function() {
        const productBox = $(this).parent().parent();
        const productItem = $(productBox).attr('data-item');
        const productDisplay = $(productBox).attr('data-display');
        const productUnityPrice = parseFloat($(productBox).attr('data-price'));
        let productAmount = 1;

        if (!shoppingCart[productItem]) {
            shoppingCart[productItem] = { display: productDisplay, price: productUnityPrice, amount: productAmount };
            $("#shoppingCart_list").append(`
                <li data-productItem="${productItem}">
                    <div class="cart_items">
                        <span class="cart_title">${productDisplay}</span><span class="cart_price">${productUnityPrice}$</span>
                    </div>
                    <div class="cart_items_number">
                        <div class="cart_minus"><button>&minus;</button></div>
                        <div class="cart_text"><span class="title_cart">${productDisplay}</span> <span>x 1</span></div>
                        <div class="cart_plus"><button>+</button></div>
                  </div>
                </li>
            `);
            $("#shoppingCart_list").find(`li[data-productItem="${productItem}"] .cart_plus`).on('click', cartPlus_addProduct);
            $("#shoppingCart_list").find(`li[data-productItem="${productItem}"] .cart_minus`).on('click', cartMinus_removeProduct);
        } else {
            shoppingCart[productItem].amount++;
            shoppingCart[productItem].price+=productUnityPrice;
            productAmount = parseFloat(shoppingCart[productItem].amount);
            $("#shoppingCart_list").find(`li[data-productItem="${productItem}"] .cart_price`).text(`${productAmount}x - ${moneySymbol}${productUnityPrice}`);
            $("#shoppingCart_list").find(`li[data-productItem="${productItem}"] .cart_text`).html(`${productDisplay}</span> <span>x ${productAmount}</span>`);
        };

        const currentTotalPrice = parseFloat($('.cart_item_box .total_price').attr('data-totalPrice'));
        const newTotalPrice = parseFloat(currentTotalPrice + productUnityPrice);
        $('.cart_item_box .total_price').attr('data-totalPrice', newTotalPrice);
        $('.cart_item_box .total_price').text(`${moneySymbol}${newTotalPrice}`);
    });

    function cartPlus_addProduct() {
        const productItem = $(this).parent().parent().attr('data-productItem');
        const inCartProduct = shoppingCart[productItem];
        const productCurrentAmount = parseFloat(inCartProduct.amount);
        const productUnityPrice = parseFloat(parseFloat(inCartProduct.price)/productCurrentAmount);

        shoppingCart[productItem].amount++;
        shoppingCart[productItem].price += productUnityPrice;

        $("#shoppingCart_list").find(`li[data-productItem="${productItem}"] .cart_price`).text(`${shoppingCart[productItem].amount}x - ${moneySymbol}${shoppingCart[productItem].price}`);
        $("#shoppingCart_list").find(`li[data-productItem="${productItem}"] .cart_text`).html(`${inCartProduct.display}</span> <span>x ${shoppingCart[productItem].amount}</span>`);

        const currentTotalPrice = parseFloat($('.cart_item_box .total_price').attr('data-totalPrice'));
        const newTotalPrice = parseFloat(currentTotalPrice + productUnityPrice);
        $('.cart_item_box .total_price').attr('data-totalPrice', newTotalPrice);
        $('.cart_item_box .total_price').text(`${moneySymbol}${newTotalPrice}`);
    };
    function cartMinus_removeProduct() {
        const productItem = $(this).parent().parent().attr('data-productItem');
        const inCartProduct = shoppingCart[productItem];
        const productCurrentAmount = parseFloat(inCartProduct.amount);
        const productUnityPrice = parseFloat(parseFloat(inCartProduct.price)/productCurrentAmount);

        if (productCurrentAmount <= 1) {
            delete shoppingCart[productItem];
            $("#shoppingCart_list").find(`li[data-productItem="${productItem}"]`).remove();

        } else {
            shoppingCart[productItem].amount--;
            shoppingCart[productItem].price -= productUnityPrice;

            $("#shoppingCart_list").find(`li[data-productItem="${productItem}"] .cart_price`).text(`${shoppingCart[productItem].amount}x - ${moneySymbol}${shoppingCart[productItem].price}`);
            $("#shoppingCart_list").find(`li[data-productItem="${productItem}"] .cart_text`).html(`${inCartProduct.display}</span> <span>x ${shoppingCart[productItem].amount}</span>`);
        };

        const currentTotalPrice = parseFloat($('.cart_item_box .total_price').attr('data-totalPrice'));
        const newTotalPrice = parseFloat(currentTotalPrice - productUnityPrice);
        $('.cart_item_box .total_price').attr('data-totalPrice', newTotalPrice);
        $('.cart_item_box .total_price').text(`${moneySymbol}${newTotalPrice}`);
    };

    $(".filter-button").click(function () {
        const value = $(this).attr("data-filter");

        if (value == "all") {
            $(".filter").show("2000");
        } else {
            $(".filter")
                .not("." + value)
                .hide("2000");
            $(".filter")
                .filter("." + value)
                .show("2000");
        }
    });
    if ($(".filter-button").removeClass("active")) {
        $(this).removeClass("active");
    };
    $(this).addClass("active");
});