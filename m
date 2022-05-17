Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABFE52AD3F
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 23:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiEQVBb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 17:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiEQVBb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 17:01:31 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6217752E7D;
        Tue, 17 May 2022 14:01:30 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-f1d5464c48so183813fac.6;
        Tue, 17 May 2022 14:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ydx+NAThrmyhZkmIzSHvkUPadaaKDNFyyA6hZGFo99M=;
        b=4pXNKeTXp4FNfvZTjM7bQnm5dDEIagnT0GkqGGpvlq53k1lpKrfrToxhPMz82saWTE
         l12EmjTWQ8qjkdqMNLYUylyKX3BvkCR1pBl4CD4vtYDOpi/B1DSiijeNo1KeMfd4ZzRu
         YWoPN2H7hGFZ7i9AWSnxviGJz0+Dg47zeUJRsyBcNKfwd+q4JUhryvAjLxkyJ3zgBZKX
         NHkqp8+KBEEw5qdbRq116FcIwSSs/0yY9h2msAt7gsQwvD7VVOiFXnB2Pcf6UngRY3Di
         Cd+Dkcy1EK0XzCiKCwkeYJgHiUBw9SjI3nyEb3e3yUZ227Gud8m5jyFUpxP4rq3sPr+A
         8qCA==
X-Gm-Message-State: AOAM533QYAgOSoum6HPFX+0+KMnHRBr8OXmalaKhS4UUfB17S552KMCL
        YZtiWGeuak67bcGuoktjtA==
X-Google-Smtp-Source: ABdhPJyWg+9hIpwzSAoRLIjGKBx0TgtxbLs9Zq7SNwApW8Yr8HjaQD6NMQRwlYTUxw44h3VH93hEew==
X-Received: by 2002:a05:6870:6b0d:b0:ee:1253:948e with SMTP id mt13-20020a0568706b0d00b000ee1253948emr18710602oab.129.1652821289661;
        Tue, 17 May 2022 14:01:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e3-20020a05683013c300b00606a6c09a0csm185672otq.12.2022.05.17.14.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:01:29 -0700 (PDT)
Received: (nullmailer pid 1635316 invoked by uid 1000);
        Tue, 17 May 2022 21:01:28 -0000
Date:   Tue, 17 May 2022 16:01:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
Message-ID: <20220517210128.GA1630873-robh@kernel.org>
References: <20220510144259.9908-1-biju.das.jz@bp.renesas.com>
 <20220510144259.9908-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220510144259.9908-2-biju.das.jz@bp.renesas.com>
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

On Tue, May 10, 2022 at 03:42:58PM +0100, Biju Das wrote:
> Add device tree bindings for the General PWM Timer (GPT).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> RFC->v1:
>  * Added Description
>  * Removed comments from reg and clock
> ---
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> new file mode 100644
> index 000000000000..b57c1b256a86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/renesas,rzg2l-gpt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L General PWM Timer (GPT)
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +description:
> +  RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
> +  (GPT32E). It supports the following functions
> +  * 32 bits × 8 channels.

You need a '|' after 'description:' if you want formatting preserved.
 
> +  * Up-counting or down-counting (saw waves) or up/down-counting
> +    (triangle waves) for each counter.
> +  * Clock sources independently selectable for each channel.
> +  * Two I/O pins per channel.
> +  * Two output compare/input capture registers per channel.
> +  * For the two output compare/input capture registers of each channel,
> +    four registers are provided as buffer registers and are capable of
> +    operating as comparison registers when buffering is not in use.
> +  * In output compare operation, buffer switching can be at crests or
> +    troughs, enabling the generation of laterally asymmetric PWM waveforms.
> +  * Registers for setting up frame cycles in each channel (with capability
> +    for generating interrupts at overflow or underflow)
> +  * Generation of dead times in PWM operation.
> +  * Synchronous starting, stopping and clearing counters for arbitrary
> +    channels.
> +  * Starting, stopping, clearing and up/down counters in response to input
> +    level comparison.
> +  * Starting, clearing, stopping and up/down counters in response to a
> +    maximum of four external triggers.
> +  * Output pin disable function by dead time error and detected
> +    short-circuits between output pins.
> +  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
> +  * Enables the noise filter for input capture and external trigger
> +    operation.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a07g044-gpt  # RZ/G2{L,LC}
> +          - renesas,r9a07g054-gpt  # RZ/V2L
> +      - const: renesas,rzg2l-gpt
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#pwm-cells':
> +    const: 2
> +    description: |
> +      See pwm.yaml in this directory for a description of the cells format.

Drop. No need to describe common properties.

> +
> +  interrupts:
> +    items:
> +      - description: GTCCRA input capture/compare match
> +      - description: GTCCRB input capture/compare
> +      - description: GTCCRC compare match
> +      - description: GTCCRD compare match
> +      - description: GTCCRE compare match
> +      - description: GTCCRF compare match
> +      - description: GTADTRA compare match
> +      - description: GTADTRB compare match
> +      - description: GTCNT overflow/GTPR compare match
> +      - description: GTCNT underflow
> +
> +  interrupt-names:
> +    items:
> +      - const: ccmpa
> +      - const: ccmpb
> +      - const: cmpc
> +      - const: cmpd
> +      - const: cmpe
> +      - const: cmpf
> +      - const: adtrga
> +      - const: adtrgb
> +      - const: ovf
> +      - const: unf
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - power-domains
> +  - resets
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gpt4: pwm@10048400 {
> +        compatible = "renesas,r9a07g044-gpt", "renesas,rzg2l-gpt";
> +        reg = <0x10048400 0xa4>;
> +        interrupts = <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 272 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 273 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 274 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 275 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 276 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 278 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 279 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "ccmpa", "ccmpb", "cmpc", "cmpd",
> +                          "cmpe", "cmpf", "adtrga", "adtrgb",
> +                          "ovf", "unf";
> +        clocks = <&cpg CPG_MOD R9A07G044_GPT_PCLK>;
> +        power-domains = <&cpg>;
> +        resets = <&cpg R9A07G044_GPT_RST_C>;
> +        #pwm-cells = <2>;
> +    };
> -- 
> 2.25.1
> 
> 
