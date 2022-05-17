Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559A952AD4C
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 23:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbiEQVEK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiEQVEK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 17:04:10 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D76532FB;
        Tue, 17 May 2022 14:04:09 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-f16a3e0529so214438fac.2;
        Tue, 17 May 2022 14:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8F3suBL/aNM3dQyouVRoR2dfCYwP1OY5NBcTIO2ADO4=;
        b=oehQIkUhB3l4K/EcpdhAza6x6nYcf1UZ8rnwTTMZWnYB/uFKoQfMiFvWA+eMABLpGT
         p5uwoyNAgBx4xbJBs1EeKv3I6JEs8iCTEMmxtMH1dKTgByMvXjIaylozZwSNuwnpWnW3
         ZmabsMmZtyRArNJfwFaIcip5X39PjEuqw7ngxVsOHlWqN5I3v9775PsbafRvRhlxZq9Z
         7BUiFTrSg0CMqnRWlWRqwttiNdTUli2Vmwi/aJsPAHWTJ4ofYheXeBWWI5nAEzXhwNI9
         Kz2CAduBTADoQsZ7QVJp6JjTPV4R1XnWMQrKqtwjOYZn4yf8WJheMWK7fxMU99OJ57t+
         6Kdw==
X-Gm-Message-State: AOAM5302/9q9GpfxmOx8o3WCVFzc6DJOiaPXLPoUPTNuk0zHP2IT6XEw
        6yfsSkBsdjwFwX6udQYDrA==
X-Google-Smtp-Source: ABdhPJzJhT+FIsAn3vilSiC+3Cvpbol50BGRh1QSZVL1IdUbT5gT8uy8Xoyym4W8MtiGpssz/VLraw==
X-Received: by 2002:a05:6870:e0d1:b0:f1:aa95:6536 with SMTP id a17-20020a056870e0d100b000f1aa956536mr6036724oab.171.1652821448732;
        Tue, 17 May 2022 14:04:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000e686d1386asm313715oao.4.2022.05.17.14.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:04:08 -0700 (PDT)
Received: (nullmailer pid 1640028 invoked by uid 1000);
        Tue, 17 May 2022 21:04:07 -0000
Date:   Tue, 17 May 2022 16:04:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
Message-ID: <20220517210407.GA1635524-robh@kernel.org>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510151112.16249-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510151112.16249-2-biju.das.jz@bp.renesas.com>
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

On Tue, May 10, 2022 at 04:11:05PM +0100, Biju Das wrote:
> Add device tree bindings for the RZ/G2L Port Output Enable for GPT (POEG).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../soc/renesas/renesas,rzg2l-poeg.yaml       | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml
> new file mode 100644
> index 000000000000..5737dbf3fa45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/renesas/renesas,rzg2l-poeg.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Renesas RZ/G2L Port Output Enable for GPT (POEG)
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +description:

'|' needed.

> +  The output pins of the general PWM timer (GPT) can be disabled by using
> +  the port output enabling function for the GPT (POEG). Specifically,
> +  either of the following ways can be used.
> +  * Input level detection of the GTETRGA to GTETRGD pins.
> +  * Output-disable request from the GPT.
> +  * Register settings.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a07g044-poeg  # RZ/G2{L,LC}
> +          - renesas,r9a07g054-poeg  # RZ/V2L
> +      - const: renesas,rzg2l-poeg
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
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
> +  - clocks
> +  - power-domains
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    poeggd: poeg@10049400 {
> +        compatible = "renesas,r9a07g044-poeg", "renesas,rzg2l-poeg";
> +        reg = <0x10049400 0x4>;

This looks like it is part of some larger block?

> +        interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&cpg CPG_MOD R9A07G044_POEG_D_CLKP>;
> +        power-domains = <&cpg>;
> +        resets = <&cpg R9A07G044_POEG_D_RST>;
> +    };
> -- 
> 2.25.1
> 
> 
