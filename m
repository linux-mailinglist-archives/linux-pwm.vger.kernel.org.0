Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F400C61FFE2
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 21:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiKGU4R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Nov 2022 15:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiKGU4Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 15:56:16 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08FD2B620;
        Mon,  7 Nov 2022 12:56:13 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13bef14ea06so14116268fac.3;
        Mon, 07 Nov 2022 12:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mqygz+AwBgs9VWg0nK3QIhzMHWxsGM/+YbQMo/qaLoA=;
        b=bVNVGFdQcfkywkZjtQKe0WhBTbF4CwCN6139R5ir0V7fU5bUbirCJ6RhsZ9ZIZWOS8
         WxoHiOsD0L0MEaSDB/5beNOWsVa3uZXU380DgbQh0LdpztlB81qCpwLQv6xv9t1PzDOC
         pICbVUiMAUGn0AEyJ6IQfV7mdK1aUsZbwmU+dgD2Y3DTbU5SfboJ/Qv6gddylqYuMhd7
         HY6Iw5xekZ47XEX8WiXMBxwLYpjZHmNwyR117Ev7ozBdL6cHCyY2ybu5S8THJ6slx0Or
         Zh0lM2NVmDNLzI9oLkTfXt08BCO7lAFomCh++zPvpNyYON55dd3vme3gU4wRWCvXB6tZ
         WhFg==
X-Gm-Message-State: ACrzQf0EDFthut3EpMOjFlNZO+OtnbU7Ma8EiWFngL4X+UPbq3KKBqIT
        lrnOyXSW478gTtT45Md8ng==
X-Google-Smtp-Source: AMsMyM6Gf5fZli0JXcxXW8pOeQLSyMdps/r8/dfQGZCF/gd4+Wo2STtJmjGH93cwS+qXBw2JrWmnvw==
X-Received: by 2002:a05:6870:f70f:b0:13d:843c:c818 with SMTP id ej15-20020a056870f70f00b0013d843cc818mr16611266oab.17.1667854572973;
        Mon, 07 Nov 2022 12:56:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a4ade49000000b0049ef7712ee5sm872782oot.11.2022.11.07.12.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:56:12 -0800 (PST)
Received: (nullmailer pid 1616165 invoked by uid 1000);
        Mon, 07 Nov 2022 20:56:14 -0000
Date:   Mon, 7 Nov 2022 14:56:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: renesas: Add RZ/G2L POEG
 binding
Message-ID: <20221107205614.GA1610785-robh@kernel.org>
References: <20221104151935.1783791-1-biju.das.jz@bp.renesas.com>
 <20221104151935.1783791-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104151935.1783791-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Nov 04, 2022 at 03:19:34PM +0000, Biju Das wrote:
> Add device tree bindings for the RZ/G2L Port Output Enable for GPT (POEG).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Removed Rb tag from Rob as there are some changes introduced.
>  * Added companion property, so that poeg can link with gpt device
>  * Documented renesas,id, as identifier for POEGG{A,B,C,D}.
>  * Updated the example.
> v1->v2:
>  * Updated the description.
> REF->v1:
>  * Modelled as pincontrol as most of its configuration is intended to be
>    static.
>  * Updated reg size in example.
> ---
>  .../bindings/pinctrl/renesas,rzg2l-poeg.yaml  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
> new file mode 100644
> index 000000000000..8adf01682de5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/renesas,rzg2l-poeg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L Port Output Enable for GPT (POEG)
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +description: |
> +  The output pins(GTIOCxA and GTIOCxB) of the general PWM timer (GPT) can be
> +  disabled by using the port output enabling function for the GPT (POEG).
> +  Specifically, either of the following ways can be used.
> +  * Input level detection of the GTETRGA to GTETRGD pins.
> +  * Output-disable request from the GPT.
> +  * SSF bit setting(ie, by setting POEGGn.SSF to 1)
> +
> +  The state of the GTIOCxA and the GTIOCxB pins when the output is disabled,
> +  are controlled by the GPT module.
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
> +  companion:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of a companion.
> +
> +  renesas,id:

Perhaps 'poeg' in the name.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2, 3 ]
> +    description: |
> +      POEG group index. Valid values are:
> +        <0> : POEG group A (default)

default: 0

Though a default for a required property doesn't make much sense...

> +        <1> : POEG group B
> +        <2> : POEG group C
> +        <3> : POEG group D
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - power-domains
> +  - resets
> +  - renesas,id
> +  - companion
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
> +        reg = <0x10049400 0x400>;
> +        interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&cpg CPG_MOD R9A07G044_POEG_D_CLKP>;
> +        power-domains = <&cpg>;
> +        resets = <&cpg R9A07G044_POEG_D_RST>;
> +        renesas,id = <3>;
> +        companion = <&gpt>;
> +    };
> -- 
> 2.25.1
> 
> 
