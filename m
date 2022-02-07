Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90B94ACA63
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Feb 2022 21:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241522AbiBGU04 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Feb 2022 15:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242233AbiBGUVh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Feb 2022 15:21:37 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C8C0401E2;
        Mon,  7 Feb 2022 12:21:36 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id u13so18319729oie.5;
        Mon, 07 Feb 2022 12:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZqX3tM46b70wK/QE7E+HUwIM9ufv+nQDsFUSF1MzXvI=;
        b=OxRo/RNCAD4Dsy0I7qpqNDdg29kN9QE5B8ONzmqzvWheKx8IPBDfzgmHhyub10k5PT
         gvHZofgN3yObIeWdRD3noAp8/GnabkxxleiUysJ41fjUEOAUT6Imm8BaOT04QXpG4pZm
         Z0HKLnk+1ZhYkR3l5FBQCHvO5aUSKA+bgtko1Ji6Lj55U6V54auDkvJhryU7ptWmCE2m
         x/L7nmfzwynJ05GBQ7DJsGiaUHwQZ3SrmqKKB6oHUssHTSWvEOsA3edg3kgELvgArR/1
         9VgVJP0/H56k6UfalD5szE7fai/+Vh6a/RrVHXbyg5Bad6lHEtzhqL+Qnu2aJedBoAsG
         0N9Q==
X-Gm-Message-State: AOAM533JqDrjKzRUKTrTNfgSisDPr+mn99Tuo3eIw1DAN2KXh/s9mWXz
        G0cQZfO5bqtv6zdb5Ppllw==
X-Google-Smtp-Source: ABdhPJxBKJXoA9O+4hd/e3alRzcpx7MsRvQw+Oq2nAmMs8LfSxIzUckK+CgAG2DFHN9Te1XxjkAqbQ==
X-Received: by 2002:a05:6808:e89:: with SMTP id k9mr304553oil.263.1644265296193;
        Mon, 07 Feb 2022 12:21:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z40sm4826084oap.37.2022.02.07.12.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:21:34 -0800 (PST)
Received: (nullmailer pid 842252 invoked by uid 1000);
        Mon, 07 Feb 2022 20:21:33 -0000
Date:   Mon, 7 Feb 2022 14:21:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     sven@svenschwermer.de
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
Message-ID: <YgF/TfKCxXJNdypY@robh.at.kernel.org>
References: <20220207100326.426940-1-sven@svenschwermer.de>
 <20220207100326.426940-2-sven@svenschwermer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207100326.426940-2-sven@svenschwermer.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Feb 07, 2022 at 11:03:25AM +0100, sven@svenschwermer.de wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> This allows to group multiple PWM-connected monochrome LEDs into
> multicolor LEDs, e.g. RGB LEDs.
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
> 
> Notes:
>     Changes in v5:
>     * (no changes)
>     
>     Changes in v4:
>     * (no changes)
>     
>     Changes in v3:
>     * Remove multi-led unit name
> 
>  .../bindings/leds/leds-pwm-multicolor.yaml    | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> new file mode 100644
> index 000000000000..5a7ed5e1bb9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> @@ -0,0 +1,75 @@
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
> +  multi-led:
> +    type: object
> +    allOf:
> +      - $ref: leds-class-multicolor.yaml#

This schema says 'multi-led' here should have a child called 
"^multi-led@([0-9a-f])$". You are off a level.
> +
> +    patternProperties:
> +      "^led-[0-9a-z]+$":
> +        type: object

           $ref: common.yaml#
           additionalProperties: false


> +        properties:
> +          pwms:
> +            maxItems: 1
> +
> +          pwm-names: true
> +
> +          color:
> +            $ref: common.yaml#/properties/color

And then drop this ref.

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
> +        multi-led {

Can't this be collapsed into 1 level? I don't see "pwm-leds-multicolor" 
having other child nodes.

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
> +    };
> +
> +...
> -- 
> 2.35.1
> 
> 
