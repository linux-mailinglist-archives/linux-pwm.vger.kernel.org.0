Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A984AF24A
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Feb 2022 14:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiBINEq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Feb 2022 08:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiBINEp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Feb 2022 08:04:45 -0500
X-Greylist: delayed 4200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 05:04:49 PST
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB8C05CB9A
        for <linux-pwm@vger.kernel.org>; Wed,  9 Feb 2022 05:04:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 42B5A1A7A;
        Wed,  9 Feb 2022 10:17:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TcYIS0UTs6_D; Wed,  9 Feb 2022 10:17:25 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 4830C3578; Wed,  9 Feb 2022 10:17:23 +0100 (CET)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
Date:   Wed, 9 Feb 2022 10:17:06 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     sven@svenschwermer.de
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: leds: Add multicolor PWM LED bindings
Message-ID: <YgOGksA8kruvFLY2@ada-deb-carambola.ifak-system.com>
Mail-Followup-To: sven@svenschwermer.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
References: <20220208191236.660172-1-sven@svenschwermer.de>
 <20220208191236.660172-2-sven@svenschwermer.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208191236.660172-2-sven@svenschwermer.de>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Sven,

Am Tue, Feb 08, 2022 at 08:12:35PM +0100 schrieb sven@svenschwermer.de:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> This allows to group multiple PWM-connected monochrome LEDs into
> multicolor LEDs, e.g. RGB LEDs.
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
> 
> Notes:
>     Changes in v6:
>     * Fix device tree binding schema
>     
>     Changes in v5:
>     * (no changes)
>     
>     Changes in v4:
>     * (no changes)
>     
>     Changes in v3:
>     * Remove multi-led unit name
> 
>  .../bindings/leds/leds-pwm-multicolor.yaml    | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> new file mode 100644
> index 000000000000..f7ce29c8ae63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-pwm-multicolor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Multi-color LEDs connected to PWM
> +
> +maintainers:
> +  - Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> +
> +description: |
> +  This driver combines several monochrome PWM LEDs into one multi-color
> +  LED using the multicolor LED class.
> +
> +properties:
> +  compatible:
> +    const: pwm-leds-multicolor
> +  multi-led:
> +    type: object
> +    patternProperties:
> +      "^led-[0-9a-z]+$":
> +        type: object
> +        $ref: common.yaml#
> +        properties:
> +          pwms:
> +            maxItems: 1
> +          pwm-names: true
> +          color: true
> +        required:
> +          - pwms
> +          - color
> +        additionalProperties: false
> +required:
> +  - compatible
> +allOf:
> +  - $ref: leds-class-multicolor.yaml#
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    rgb-led {

I think this should be 'led-controller'. See
Documentation/devicetree/bindings/leds/common.yaml for reference.

> +        compatible = "pwm-leds-multicolor";
> +
> +        multi-led {
> +          color = <LED_COLOR_ID_RGB>;
> +          function = LED_FUNCTION_INDICATOR;
> +          max-brightness = <65535>;
> +
> +          led-red {
> +              pwms = <&pwm1 0 1000000>;
> +              color = <LED_COLOR_ID_RED>;
> +          };
> +
> +          led-green {
> +              pwms = <&pwm2 0 1000000>;
> +              color = <LED_COLOR_ID_GREEN>;
> +          };
> +
> +          led-blue {
> +              pwms = <&pwm3 0 1000000>;
> +              color = <LED_COLOR_ID_BLUE>;
> +          };

Not sure if those node names should be more generic like led-0, led-1
etc.?  At least the color information is redundant here.  This would
make it more similar to bindings of other LED drivers.

And how is it supposed to be named if you have multiple
"multi-led"s, e.g. one on three PWM channels, and another one on three
different PWM channels?

Greets
Alex

> +        };
> +    };
> +
> +...
> -- 
> 2.35.1
> 
