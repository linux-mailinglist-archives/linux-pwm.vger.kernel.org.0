Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17067BAA9
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jan 2023 20:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbjAYTWS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Jan 2023 14:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbjAYTWN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Jan 2023 14:22:13 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC825C0CE;
        Wed, 25 Jan 2023 11:22:10 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id r9so17123612oig.12;
        Wed, 25 Jan 2023 11:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PVEqBCzfLUzY4IompNf+WDKcAK9eA2hdVNa/dgEZEM=;
        b=64XRWRO7jNWT3ritowQPdT/UV/FlGGUIIVFkoG7vqIJ2eZ4oBoD5ZrrGdPqODKP2Hr
         +ODSepk4lqprdLyuNN3xUKmEcTOkAHd3HM4W+unQ+SbM1dNB3XZxG9mups+nbHvXK6uo
         uzfzTa7duHbnKpQZLMrgSPz4Z6q6DCl6XzhP82GURxUIlM3spDwKfGq5hca9BxaYIwW+
         zBu6LI/uxfz0TQ/iRgagA5//oS5gNyVz1B9EmBBbaDvVvUZpo+o47yyCnQbi8fqp5IeD
         7Mwjm60Te0B2UiOJBenMuo9A40ZjV4czhLgTC8X12hJKpRMG8JWaU6Vg+tMw/4kH+Ume
         2fyw==
X-Gm-Message-State: AFqh2kqAwjeNY1a+JRUT1Vhn6HrO3qUGOkdZNHdKSqcY7vUZgbBIqo9F
        yGtNFnoqMgfK7ESkU46xGg==
X-Google-Smtp-Source: AMrXdXtSGTGKDZXApqdn1BokhZuqhAW4CWOl6Q8yAt6sCWvdBefTWfX8VBhMIBueSOmJDZQTrHxWyA==
X-Received: by 2002:a05:6808:2015:b0:36c:e058:9cc with SMTP id q21-20020a056808201500b0036ce05809ccmr16173734oiw.7.1674674529265;
        Wed, 25 Jan 2023 11:22:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m24-20020a05680806d800b0035ec1384c9esm2396349oih.23.2023.01.25.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:22:08 -0800 (PST)
Received: (nullmailer pid 2716000 invoked by uid 1000);
        Wed, 25 Jan 2023 19:22:08 -0000
Date:   Wed, 25 Jan 2023 13:22:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 6/8] dt-bindings: pwm: Add Amlogic Meson PWM binding
Message-ID: <20230125192208.GA2713777-robh@kernel.org>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <0d492f0e-abb3-33f6-3ee9-09e1440a9015@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d492f0e-abb3-33f6-3ee9-09e1440a9015@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jan 23, 2023 at 10:29:27PM +0100, Heiner Kallweit wrote:
> Add Amlogic Meson PWM binding.
> Tested with make targets dt_binding_check and dtbs_check.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 61 +++++++++++++++++++
>  .../devicetree/bindings/pwm/pwm-meson.txt     | 29 ---------
>  2 files changed, 61 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> new file mode 100644
> index 000000000..443ff4e5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-amlogic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic PWM
> +
> +maintainers:
> +  - Heiner Kallweit <hkallweit1@gmail.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson8b-pwm
> +      - amlogic,meson-gxbb-pwm
> +      - amlogic,meson-gxbb-ao-pwm
> +      - amlogic,meson-axg-ee-pwm
> +      - amlogic,meson-axg-ao-pwm
> +      - amlogic,meson-g12a-ee-pwm
> +      - amlogic,meson-g12a-ao-pwm-ab
> +      - amlogic,meson-g12a-ao-pwm-cd
> +      - amlogic,meson-s4-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

No need for a type, 'clocks' already has one. You need how many and what 
each one is when more than 1.

> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2

Need the exact names here.

> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    apb@fe000000 {
> +      reg = <0x0 0xfe000000 0x0 0x480000>;
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pwm@8550 {
> +        compatible = "amlogic,meson-gxbb-pwm";
> +        reg = <0x0 0x08550 0x0 0x10>;
> +        clocks = <&xtal>, <&xtal>;
> +        clock-names = "clkin0", "clkin1";
> +        #pwm-cells = <3>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
> deleted file mode 100644
> index bd02b0a14..000000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Amlogic Meson PWM Controller
> -============================
> -
> -Required properties:
> -- compatible: Shall contain "amlogic,meson8b-pwm"
> -                         or "amlogic,meson-gxbb-pwm"
> -                         or "amlogic,meson-gxbb-ao-pwm"
> -                         or "amlogic,meson-axg-ee-pwm"
> -                         or "amlogic,meson-axg-ao-pwm"
> -                         or "amlogic,meson-g12a-ee-pwm"
> -                         or "amlogic,meson-g12a-ao-pwm-ab"
> -                         or "amlogic,meson-g12a-ao-pwm-cd"
> -- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
> -  the cells format.
> -
> -Optional properties:
> -- clocks: Could contain one or two parents clocks phandle for each of the two
> -  PWM channels.
> -- clock-names: Could contain at least the "clkin0" and/or "clkin1" names.
> -
> -Example:
> -
> -	pwm_ab: pwm@8550 {
> -		compatible = "amlogic,meson-gxbb-pwm";
> -		reg = <0x0 0x08550 0x0 0x10>;
> -		#pwm-cells = <3>;
> -		clocks = <&xtal>, <&xtal>;
> -		clock-names = "clkin0", "clkin1";
> -	}
> -- 
> 2.39.1
> 
> 
