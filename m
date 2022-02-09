Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0854AFBB5
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Feb 2022 19:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiBISsr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Feb 2022 13:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbiBISsN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Feb 2022 13:48:13 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A09C1DC2F8;
        Wed,  9 Feb 2022 10:44:51 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so3468602oor.12;
        Wed, 09 Feb 2022 10:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5iUZVsd2tC6B08DK6tleMcNCLkad2BWr1aTlffhv1yg=;
        b=vo/0pNKoWXIYoNGxZ+TQ4PS4UrJCnifArLJAaUXS1J9srTInC+Q9hT3TBK6vrjIISg
         TNxKdhW1sLVon84eF/139reUSVww0XZkicdVbSK1H3FPTDN1amTCU/MYA1jVr56gYOm3
         OyMl8vdWaWmYsbzI3u1nGNKnWVUUDSdsN/3PiXBOdKiWuf3Zyu1gB407sfL3wmsDWeB0
         IdokWek6at6dmWqFx3Z4G2Cylha9HJK9HlSM9viLtV0RfZh7V0Fln4gxvEv2O9x+ody2
         czdOEVsg771DEXWNsBuHS5c3b5027/iCh5xf8AfUCvS9jNsDN8JLkAtLU1njG7cEmcAq
         YOhw==
X-Gm-Message-State: AOAM530NVhPL+NoBDHqdopHSLzxKmeu9XyNK4gEqA9t8rBEjIuoG01NM
        Lf5SN4czacKtsvXnha9sEA==
X-Google-Smtp-Source: ABdhPJyVR93jP8FiaJyzORU4oF2UwTBNTTtG5KvHE+eQJ0R04hfJLjWLadPlVsDanj3w2ldCucS4Lw==
X-Received: by 2002:a05:6870:1842:: with SMTP id u2mr1240378oaf.162.1644432290840;
        Wed, 09 Feb 2022 10:44:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 20sm5487410oao.1.2022.02.09.10.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:44:50 -0800 (PST)
Received: (nullmailer pid 672347 invoked by uid 1000);
        Wed, 09 Feb 2022 18:44:49 -0000
Date:   Wed, 9 Feb 2022 12:44:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     sven@svenschwermer.de
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com
Subject: Re: [PATCH v6 2/3] dt-bindings: leds: Add multicolor PWM LED bindings
Message-ID: <YgQLoaKmzfZQAVSx@robh.at.kernel.org>
References: <20220208191236.660172-1-sven@svenschwermer.de>
 <20220208191236.660172-2-sven@svenschwermer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208191236.660172-2-sven@svenschwermer.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Feb 08, 2022 at 08:12:35PM +0100, sven@svenschwermer.de wrote:
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

blank line

> +  multi-led:
> +    type: object

blank line

> +    patternProperties:
> +      "^led-[0-9a-z]+$":
> +        type: object
> +        $ref: common.yaml#

blank line

> +        properties:
> +          pwms:
> +            maxItems: 1

blank line and so on. (There not a hard rule, but roughly it's 
blank lines between DT property sub-schemas, top-level keywords, and 
properties/patternProperties/required.)

> +          pwm-names: true
> +          color: true
> +        required:
> +          - pwms
> +          - color

> +        additionalProperties: false

While the top level goes at the end, I find it is easier to read putting 
the indented cases before properties/patternProperties. 

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
> +        };
> +    };
> +
> +...
> -- 
> 2.35.1
> 
> 
