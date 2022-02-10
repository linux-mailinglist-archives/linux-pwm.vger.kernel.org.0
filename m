Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227934B0796
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Feb 2022 08:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiBJHzM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Feb 2022 02:55:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiBJHzK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Feb 2022 02:55:10 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1901BAE;
        Wed,  9 Feb 2022 23:55:11 -0800 (PST)
Message-ID: <2bf7a4c4-1661-d800-51d3-6e6287b5c6fc@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644479708;
        bh=IG7OZtMzcsqMeFE1NgxZbUGNqHISO9gfyg/RKcDEdu0=;
        h=Subject:To:References:From:In-Reply-To;
        b=YVLPlp6SZIYIQPx8e//L7oVLgVTmgo1hqvC/qPdwpK6aKuKkOSvQK5ZJ1BXaMBgK7
         sHXGnQa3jwAKH/uapRzdugQecp4U1uvymD/7NEtWlrcFvBROi+9fToDe2ngkIDWmRp
         a1B8OjFuHGQe/h+71+VtugXsoxF1i0zQXJOEiU3CyKE31xfBxU/wpsdWTg+BG82MNG
         vMaxAQ7iNKbyPhMuZd4KGClm1kFEW2X7yY19WP+4be+TOoJkS7JxdYjQQvc9cjCKgX
         zafy/KYCi9jPkdRjvPpRME7Z3qVvV9eI669Hj8j0Y6fLnxMU2NuvK6BYLsvthppzPa
         Q/M29Bmk4ck1g==
Date:   Thu, 10 Feb 2022 08:55:07 +0100
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
From:   Sven Schwermer <sven@svenschwermer.de>
In-Reply-To: <YgOGksA8kruvFLY2@ada-deb-carambola.ifak-system.com>
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

On 2/9/22 10:17, Alexander Dahl wrote:
>> +    rgb-led {
> 
> I think this should be 'led-controller'. See
> Documentation/devicetree/bindings/leds/common.yaml for reference.

Sure, I don't have a preference.

>> +        multi-led {
>> +          color = <LED_COLOR_ID_RGB>;
>> +          function = LED_FUNCTION_INDICATOR;
>> +          max-brightness = <65535>;
>> +
>> +          led-red {
>> +              pwms = <&pwm1 0 1000000>;
>> +              color = <LED_COLOR_ID_RED>;
>> +          };
>> +
>> +          led-green {
>> +              pwms = <&pwm2 0 1000000>;
>> +              color = <LED_COLOR_ID_GREEN>;
>> +          };
>> +
>> +          led-blue {
>> +              pwms = <&pwm3 0 1000000>;
>> +              color = <LED_COLOR_ID_BLUE>;
>> +          };
> 
> Not sure if those node names should be more generic like led-0, led-1
> etc.?  At least the color information is redundant here.  This would
> make it more similar to bindings of other LED drivers.

I don't see how naming them led-{0,1,2} would be better in any way, 
please elaborate.

> And how is it supposed to be named if you have multiple
> "multi-led"s, e.g. one on three PWM channels, and another one on three
> different PWM channels?

I'm not 100% sure what you mean. If you want multiple instances of these 
multi-color PWM LEDs, you'd do something like this:

indicator-led-controller {
     compatible = "pwm-leds-multicolor";
     multi-led {
       color = <LED_COLOR_ID_RGB>;
       function = LED_FUNCTION_INDICATOR;
       max-brightness = <65535>;
       led-red {
           pwms = <&pwm1 0 1000000>;
           color = <LED_COLOR_ID_RED>;
       };
       led-green {
           pwms = <&pwm2 0 1000000>;
           color = <LED_COLOR_ID_GREEN>;
       };
       led-blue {
           pwms = <&pwm3 0 1000000>;
           color = <LED_COLOR_ID_BLUE>;
       };
     };
};
status-led-controller {
     compatible = "pwm-leds-multicolor";
     multi-led {
       color = <LED_COLOR_ID_MULTI>;
       function = LED_FUNCTION_STATUS;
       max-brightness = <255>;
       led-red {
           pwms = <&pwm4 0 1000000>;
           color = <LED_COLOR_ID_RED>;
       };
       led-amber {
           pwms = <&pwm5 0 1000000>;
           color = <LED_COLOR_ID_AMBER>;
       };
     };
};
