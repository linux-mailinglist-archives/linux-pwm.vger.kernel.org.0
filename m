Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33049BD17
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 21:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiAYU1s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 15:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiAYU1j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jan 2022 15:27:39 -0500
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jan 2022 12:27:38 PST
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E93C06173B;
        Tue, 25 Jan 2022 12:27:38 -0800 (PST)
Received: from thinkpad (unknown [172.20.6.87])
        by mail.nic.cz (Postfix) with ESMTPSA id 415D61409A4;
        Tue, 25 Jan 2022 21:27:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1643142457; bh=A57kRWvGiyKtaG/Yvtu0y04xlTtadwcYoeG0S5PBK+4=;
        h=Date:From:To;
        b=obndSyKu5DuWOkOOM01HZlYynzSPNjomKD+VcgJEfX3+UXxi/VTyFW07ImOzb2pBW
         vrbSu3+PXtMt+hgSa6IFyC+jd5gY0XTh25lo4a6R2jbXuUcs9giiv/qLN5piQHMYKW
         tzkyb2tJH9enEDwrdspG2vYuxl4IDF9547BvLEoA=
Date:   Tue, 25 Jan 2022 21:27:36 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To:     sven@svenschwermer.de
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, post@lespocky.de
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: leds: Add multicolor PWM LED
 bindings
Message-ID: <20220125212736.5ffafe2b@thinkpad>
In-Reply-To: <20220125151226.31049-2-sven@svenschwermer.de>
References: <20220125151226.31049-1-sven@svenschwermer.de>
        <20220125151226.31049-2-sven@svenschwermer.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.4 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 25 Jan 2022 16:12:25 +0100
sven@svenschwermer.de wrote:

> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> This allows to group multiple PWM-connected monochrome LEDs into
> multicolor LEDs, e.g. RGB LEDs.
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
>  .../bindings/leds/leds-pwm-multicolor.yaml    | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> new file mode 100644
> index 000000000000..b82b26f2e140
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> @@ -0,0 +1,76 @@
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
> +
> +patternProperties:
> +  '^multi-led@[0-9a-f]$':
> +    type: object
> +    allOf:
> +      - $ref: leds-class-multicolor.yaml#
> +
> +    patternProperties:
> +      "^led-[0-9a-z]+$":
> +        type: object
> +        properties:
> +          pwms:
> +            maxItems: 1
> +
> +          pwm-names: true
> +
> +          color:
> +            $ref: common.yaml#/properties/color
> +
> +        required:
> +          - pwms
> +          - color
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    rgb-led {
> +        compatible = "pwm-leds-multicolor";
> +
> +        multi-led@0 {
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
> +        };

what about

	multi-led@0 {
		color = <LED_COLOR_ID_RGB>;
		function = LED_FUNCTION_INDICATOR;
		pwms = <&pwm1 0 1000000>,
		       <&pwm2 0 1000000>,
		       <&pwm3 0 1000000>;
		channels = <LED_COLOR_ID_RED>,
			   <LED_COLOR_ID_GREEN>,
			   <LED_COLOR_ID_BLUE>;
	};

I am not saying that it is necessarily better, just comenting that
maybe it is, since it saves some space. `pwms` is phandle-array, so it
can contain references to multiple pwms, and we have functions which
make getting these pwms in driver code easy...

Also this example won't compile with
   make dt_bindings_check
because you don't have pwm1, pwm2
and pwm3 defined...

Marek
