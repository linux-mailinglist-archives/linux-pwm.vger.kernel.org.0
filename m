Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C37B681764
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jan 2023 18:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbjA3RQX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Jan 2023 12:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbjA3RQX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2023 12:16:23 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0240BDD;
        Mon, 30 Jan 2023 09:16:21 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-142b72a728fso15857811fac.9;
        Mon, 30 Jan 2023 09:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFbZYokXDaufN+nrw5U+tk54eaumBdk6Eaj/TYXiSlc=;
        b=C7NxRfBBIzF2QTuzUsl5Ml3G9eXetQekWk/fNOfNDMKwn0zXOQppST41er9C/lLHKK
         LseNVaohiulA8/prqVQOc9zCA8sRx/rIidCyLwUxaxz/rw20CaXhvdKhIR6l+C2ZeI8g
         Nv7Noyv8ZcgVNeh1sXrAoj+i88ek189tiGSaqp6axrd+10+OmKN6HEhB8p2Xi3mhIh0e
         ObqgF9nUyMXStOJSpcgS/i2RlSrwwUB2y/tmtVCRzZ7aBI13ZPsRF6Ck4LotZDlcqWWV
         4loffJXUPH/Cbq6yG7OY7e/N8yEtorekybfVLaB2urfOSw5EwBSQNS9yH3PRvtWc01q1
         MVGg==
X-Gm-Message-State: AO0yUKWIDCI0cUn+trv5/CmrAfVm9TiyezYcGMpO87znyVgtcOR6KcXX
        WjhOKOuhh8lQ1pjhOqjWyw==
X-Google-Smtp-Source: AK7set9D9gvZqo/95yXNlorY/OCGBOTG2wadwkpOFSNQvhHBMxofZPVeWjr0GxvAfHf2ukHGXSr36Q==
X-Received: by 2002:a05:6870:42d2:b0:163:290f:9ef4 with SMTP id z18-20020a05687042d200b00163290f9ef4mr12449174oah.6.1675098980670;
        Mon, 30 Jan 2023 09:16:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id et10-20020a0568705cca00b00163263f84dasm5335195oab.12.2023.01.30.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:16:20 -0800 (PST)
Received: (nullmailer pid 2929331 invoked by uid 1000);
        Mon, 30 Jan 2023 17:16:19 -0000
Date:   Mon, 30 Jan 2023 11:16:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert Amlogic Meson PWM binding
Message-ID: <20230130171619.GA2851045-robh@kernel.org>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <d37fb6a3-f94e-224a-8829-80cf47412fce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d37fb6a3-f94e-224a-8829-80cf47412fce@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 25, 2023 at 11:28:17PM +0100, Heiner Kallweit wrote:
> Convert Amlogic Meson PWM binding to yaml.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - fix clocks and clock-names
> - consider that more than one compatible may be set
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 73 +++++++++++++++++++
>  .../devicetree/bindings/pwm/pwm-meson.txt     | 29 --------
>  2 files changed, 73 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> new file mode 100644
> index 000000000..871b24bc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -0,0 +1,73 @@
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
> +    minItems: 1
> +    maxItems: 2

A fallback compatible shouldn't be optional. This makes 
'amlogic,meson-gx-pwm' alone valid, for example.

Though probably the dtschema processing will add minItems/maxItems on 
each oneOf entry to prevent that anyways. So just drop the 
minItems/maxItems here.

> +    oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,meson8b-pwm
> +              - amlogic,meson-gxbb-pwm
> +              - amlogic,meson-gxbb-ao-pwm
> +              - amlogic,meson-axg-ee-pwm
> +              - amlogic,meson-axg-ao-pwm
> +              - amlogic,meson-g12a-ee-pwm
> +              - amlogic,meson-g12a-ao-pwm-ab
> +              - amlogic,meson-g12a-ao-pwm-cd
> +              - amlogic,meson-s4-pwm
> +      - items:
> +          - const: amlogic,meson-gx-pwm
> +          - const: amlogic,meson-gxbb-pwm
> +      - items:
> +          - const: amlogic,meson-gx-ao-pwm
> +          - const: amlogic,meson-gxbb-ao-pwm
> +      - items:
> +          - const: amlogic,meson8-pwm
> +          - const: amlogic,meson8b-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - enum: [clkin0, clkin1]
> +      - items:
> +          - const: clkin0
> +          - const: clkin1
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
> +    pwm@8550 {
> +      compatible = "amlogic,meson-gxbb-pwm";
> +      reg = <0x08550 0x10>;
> +      clocks = <&xtal>, <&xtal>;
> +      clock-names = "clkin0", "clkin1";
> +      #pwm-cells = <3>;
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
