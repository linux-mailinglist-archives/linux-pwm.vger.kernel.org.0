Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0137351B098
	for <lists+linux-pwm@lfdr.de>; Wed,  4 May 2022 23:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbiEDVdj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 May 2022 17:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiEDVdi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 May 2022 17:33:38 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D254050E0B;
        Wed,  4 May 2022 14:30:01 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id m6-20020a05683023a600b0060612720715so1734262ots.10;
        Wed, 04 May 2022 14:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E78NrbeUTgGh2vOcV3Q1Dtc9mx50Pf/T4zDEn6fxndY=;
        b=3XgNd8xtoOX5LH0gm5W0mw8bfKZ/3gz6I5OTaH/IJHClRrcO1fOPxNCU1cb/cLXjlC
         BrfFLhBT/jMk3Lw3jYt1qlx1Ma0ju84tvIo99PRL6ZY7BcwVFQGYP6JURWsWbUMMYz3S
         zjg7Z7goD0GgzX9ohEhmPrYkGYI5oHDmlEb2m8Ocq1tFazzy+aLDBxEN8P+CvLraz8Kx
         X905DNjY7ag5vmq16hmsScI/D29YkbQRaz9g7+9K3BemhJmF4KTGVgrMowjCugzyy1uc
         0rsJyA9qicJgad6un+F7jlHjKcSteIhw60VPx4iCHqFM6G0IKg6oSvOMK9RqtUOB4tax
         beIA==
X-Gm-Message-State: AOAM530Hcl+8U/dNpRh/c6rkUKc8DuaEjazT1zINlv550348Wh/bh4V7
        C1aHEM0qeWP1BPy3y67eNA==
X-Google-Smtp-Source: ABdhPJwZTxM84Iciu8kije3sWl+ozUXbsX/XNrhwefT2QJBTeyOXErcP4NsrKcKqmheLI8ilRMwH1w==
X-Received: by 2002:a9d:65cb:0:b0:605:f090:7d5f with SMTP id z11-20020a9d65cb000000b00605f0907d5fmr8058407oth.273.1651699801138;
        Wed, 04 May 2022 14:30:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a11-20020a05680802cb00b00325cda1ff93sm18331oid.18.2022.05.04.14.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 14:30:00 -0700 (PDT)
Received: (nullmailer pid 2258214 invoked by uid 1000);
        Wed, 04 May 2022 21:29:59 -0000
Date:   Wed, 4 May 2022 16:29:59 -0500
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
Subject: Re: [RFC 1/5] dt-bindings: pwm: Add RZ/G2L GPT binding
Message-ID: <YnLwV8cF+t2SLCWF@robh.at.kernel.org>
References: <20220430075915.5036-1-biju.das.jz@bp.renesas.com>
 <20220430075915.5036-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430075915.5036-2-biju.das.jz@bp.renesas.com>
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

On Sat, Apr 30, 2022 at 08:59:11AM +0100, Biju Das wrote:
> Add device tree bindings for the RZ/G2L General PWM Timer (GPT).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> new file mode 100644
> index 000000000000..0e44c0fbe04a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> @@ -0,0 +1,104 @@
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
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a07g044-gpt  # RZ/G2{L,LC}
> +          - renesas,r9a07g054-gpt  # RZ/V2L
> +      - const: renesas,rzg2l-gpt
> +
> +  reg:
> +    # base address and length of the registers block for the PWM.

Yes, that's all 'reg', drop.

> +    maxItems: 1
> +
> +  '#pwm-cells':
> +    # should be 2. See pwm.yaml in this directory for a description of
> +    # the cells format.

2 cells the schema says already. The reference for the format is okay, 
but move it to a 'description' entry.

> +    const: 2
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
> +    # clock phandle and specifier pair.

That's all 'clocks', drop.

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
> +        resets = <&cpg 523 R9A07G044_GPT_RST_C>;
> +        #pwm-cells = <2>;
> +    };
> -- 
> 2.25.1
> 
> 
