Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703A261FFF2
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 21:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiKGU5w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Nov 2022 15:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiKGU5v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 15:57:51 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E640C2B610;
        Mon,  7 Nov 2022 12:57:48 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id n205so2424968oib.1;
        Mon, 07 Nov 2022 12:57:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CDr8yZr6hW9e3uL8vYKI/3NRYVUIB08ipYQx+5js9Q=;
        b=nofmWUpZiXrrAbczrnmual3AY3Xw9K5rlQ7PtfAeMuD5BvDPjGZo7ol4EyiDL1gTdN
         kAmosnGEgz2N/c7loU9LRJ7Ui3OGjwRha0SIVRrO5vqWg18kYy1b0Y5lzruDxjA7TrKZ
         SXGkg7VFa6T1/Bka9hW6UT5fx+VW+MzBCreL2Pu0/YfAqytw+D+wZkecIB4qlRKIoOl2
         Uph+Ny7khIqROYbnfpemr8X4f2hu6bmJwBw13ehF+iYQvEs0M6YhhnKeRO5dkungxX/+
         vr+fjLtjxVanPa3BDdpES2FMfjVhZFjFyrab68P/SdD6cFI1IoDbD/NKYzqP5sTYZvQ9
         mkdw==
X-Gm-Message-State: ACrzQf2t2ijlefGlmSjNvaJ6S1enh6zyvIxhVnQyC+8F7XrEcpt7tUlJ
        mEtmFansayQVWKaSqjJr1Q==
X-Google-Smtp-Source: AMsMyM6Y15P3ah4FNhDGYhQ+NkhX1odCbNINsFFkaKaURBfMwaqjw7RzHLttW0Ut83/Q54Q255Giow==
X-Received: by 2002:a05:6808:190f:b0:35a:6b1a:500 with SMTP id bf15-20020a056808190f00b0035a6b1a0500mr8747930oib.138.1667854668086;
        Mon, 07 Nov 2022 12:57:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u16-20020a4ad0d0000000b0049ea9654facsm2532817oor.32.2022.11.07.12.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:57:47 -0800 (PST)
Received: (nullmailer pid 1617841 invoked by uid 1000);
        Mon, 07 Nov 2022 20:57:49 -0000
Date:   Mon, 7 Nov 2022 14:57:49 -0600
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
Message-ID: <20221107205749.GB1610785-robh@kernel.org>
References: <20221104151935.1783791-1-biju.das.jz@bp.renesas.com>
 <20221104151935.1783791-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104151935.1783791-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

Also, needs a vendor prefix. The companion is the GPT, right? Perhaps 
'renesas,gpt' instead.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of a companion.
