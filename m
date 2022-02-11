Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EAD4B2DD6
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Feb 2022 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352903AbiBKTh1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Feb 2022 14:37:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343939AbiBKTh0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Feb 2022 14:37:26 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C306ECF2;
        Fri, 11 Feb 2022 11:37:23 -0800 (PST)
Message-ID: <94f9ae9d-b048-3b72-970e-9055430ca5f5@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644608241;
        bh=IRPnsyxD2CUad11a8uUxAIwhDx7MnWDkdL+tXUo5o6I=;
        h=Subject:To:References:From:In-Reply-To;
        b=RD3n5vrRh5wVheBTxyXJfin0WtCrvpa8RjtHbGeUlv9QKcnwJg5zeDFfZD3CY5wAU
         +cMKfRbadXqZyRkLVsBVtESruzJaaWTkxIxml5vWatcwMUq6CVEQu5B9hVd+Fk787R
         TfhGyj/QPIPaSasAWj2vTrluUIqbQtAjLLVmOZbbpqZCsahOGUE3qrfk0gVjUexYUQ
         jSpOrdA3quvvDWKhmo2jBpQdr/fDQWvvqdY4xArJou4JE+r0+jX7ZfIHDZefOUx45Y
         xYp/xAwO9xoMnzybetv8umEzVA5s6eIH1s2s1aaVB+wbh0/k7kws1JL2L4MPjbSUxP
         93QIX9NMxXe4A==
Date:   Fri, 11 Feb 2022 20:37:19 +0100
Mime-Version: 1.0
Subject: Re: [PATCH v6 2/3] dt-bindings: leds: Add multicolor PWM LED bindings
Content-Language: en-US
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, post@lespocky.de, andy.shevchenko@gmail.com,
        robh@kernel.org
References: <20220208191236.660172-1-sven@svenschwermer.de>
 <20220208191236.660172-2-sven@svenschwermer.de>
 <YgOGksA8kruvFLY2@ada-deb-carambola.ifak-system.com>
 <2bf7a4c4-1661-d800-51d3-6e6287b5c6fc@svenschwermer.de>
 <YgTb0sRSaO1EPsOW@ada-deb-carambola.ifak-system.com>
From:   Sven Schwermer <sven@svenschwermer.de>
In-Reply-To: <YgTb0sRSaO1EPsOW@ada-deb-carambola.ifak-system.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Alex,

On 2/10/22 10:33, Alexander Dahl wrote:
>> I don't see how naming them led-{0,1,2} would be better in any way, please
>> elaborate.
> 
> - consistency with other LED driver bindings
> - spot the number of "sub"-LEDs more easily
> - prevent all kinds of different names people will come up with, if
>    all is allowed instead of a clear scheme
> 
> The color is in the color property anyways.

Let's hear what others on this list say. I don't feel too strongly about 
this either way.

> I would have expected something like this:
> 
>    led-controller-0 {
>        compatible = "pwm-leds-multicolor";
> 
>        multi-led-0 {
>          color = <LED_COLOR_ID_RGB>;
>          function = LED_FUNCTION_INDICATOR;
>          max-brightness = <65535>;
> 
>          led-0 {
>              pwms = <&pwm1 0 1000000>;
>              color = <LED_COLOR_ID_RED>;
>          };
> 
>          led-1 {
>              pwms = <&pwm2 0 1000000>;
>              color = <LED_COLOR_ID_GREEN>;
>          };
> 
>          led-2 {
>              pwms = <&pwm3 0 1000000>;
>              color = <LED_COLOR_ID_BLUE>;
>          };
>        };
> 
>        multi-led-1 {
>          color = <LED_COLOR_ID_RGB>;
>          function = LED_FUNCTION_INDICATOR;
>          max-brightness = <65535>;
> 
>          led-0 {
>              pwms = <&pwm1 0 1000000>;
>              color = <LED_COLOR_ID_RED>;
>          };
> 
>          led-1 {
>              pwms = <&pwm2 0 1000000>;
>              color = <LED_COLOR_ID_GREEN>;
>          };
> 
>          led-2 {
>              pwms = <&pwm3 0 1000000>;
>              color = <LED_COLOR_ID_BLUE>;
>          };
>        };
>    };

That would make the driver more complex. I'm not sure that would be 
worth it. Additionally, we'd have to change the node name pattern for 
the multi LED class. Other opinions?

Best regards,
Sven
