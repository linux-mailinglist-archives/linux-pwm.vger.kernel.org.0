Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F394F4ACAA5
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Feb 2022 21:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiBGUry (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Feb 2022 15:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiBGUoh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Feb 2022 15:44:37 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4340C0401E2;
        Mon,  7 Feb 2022 12:44:36 -0800 (PST)
Message-ID: <1e4e8efe-1fdf-ca9c-7c5a-9903ef4a7fce@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644266675;
        bh=KGJH09+o9Eug54L1J6cZHqNUFBhH+gzeuOs+VQYX9Z0=;
        h=Subject:To:Cc:References:From:In-Reply-To;
        b=G06nZMACgnibUhH3P2dCm3usyocqheOBkDCZ7nVh9SQWPXQTNDI0dqaInARt9ulDe
         gX6PrJhUT7KHuIC/4YFCmNoMC9A4uioOUrYWyovJJPQTO2h8NZ4H98BWqgn5gnvGKy
         IBuQdkQ+iA+wrA23UI/shnQnLGnDenKBYodIWzhVr+PYdV1q7qXWPvHlCLDBJu8XUh
         b3MTIUNxzUwlpmnJPRUaak0jomL3hMVHRM4GBGW9oW+0AQgAiLVGQJ4Zxqvd1PbwjJ
         1UULnbnQRJqIigHgGZb/GgcmGx2uFBtj7Hu4HfOrxWkQeNNIiNnn3InM0rJHVlypQW
         Rbprr9pHpNeHA==
Date:   Mon, 7 Feb 2022 21:44:32 +0100
Mime-Version: 1.0
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, pavel@ucw.cz, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com
References: <20220207100326.426940-1-sven@svenschwermer.de>
 <20220207100326.426940-2-sven@svenschwermer.de>
 <YgF/TfKCxXJNdypY@robh.at.kernel.org>
From:   Sven Schwermer <sven@svenschwermer.de>
In-Reply-To: <YgF/TfKCxXJNdypY@robh.at.kernel.org>
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

Hi Rob,

Thanks for your comments.

On 2/7/22 21:21, Rob Herring wrote:
>> +properties:
>> +  compatible:
>> +    const: pwm-leds-multicolor
>> +
>> +  multi-led:
>> +    type: object
>> +    allOf:
>> +      - $ref: leds-class-multicolor.yaml#
> 
> This schema says 'multi-led' here should have a child called
> "^multi-led@([0-9a-f])$". You are off a level.

So it should have been?

properties:
   compatible:
     const: pwm-leds-multicolor
   allOf:
     - $ref: leds-class-multicolor.yaml#

This would imply that the multi-led node requires a unit address (reg 
property). That doesn't make sense in this case. How should we resolve this?

>> +
>> +    patternProperties:
>> +      "^led-[0-9a-z]+$":
>> +        type: object
> 
>             $ref: common.yaml#
>             additionalProperties: false

Sounds good.

>> +        properties:
>> +          pwms:
>> +            maxItems: 1
>> +
>> +          pwm-names: true
>> +
>> +          color:
>> +            $ref: common.yaml#/properties/color
> 
> And then drop this ref.

Curiosity question: why? Should I refer to an unsigned integer type instead?

>> +    rgb-led {
>> +        compatible = "pwm-leds-multicolor";
>> +
>> +        multi-led {
> 
> Can't this be collapsed into 1 level? I don't see "pwm-leds-multicolor"
> having other child nodes.

It could. The reason I added the multi-led level is because the 
leds-class-multicolor.yaml schema calls for it. Perhaps I missed the 
intention of that schema but isn't it there to create a uniform binding 
schema structure across drivers?

Best regards,
Sven
