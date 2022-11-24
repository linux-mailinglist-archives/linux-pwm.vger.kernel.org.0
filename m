Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1E637443
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Nov 2022 09:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKXInT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Nov 2022 03:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKXInS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Nov 2022 03:43:18 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDCE8EB7D;
        Thu, 24 Nov 2022 00:43:17 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id c15so694216qtw.8;
        Thu, 24 Nov 2022 00:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeX5JiNwOtG5KDFqFaTJsCq21klhOXLTy4lehVodWKI=;
        b=8FmM/IxbtIrWu0uQFR09psEBh19P4+O7tJtmw3qhK17JH6VYR1oaoZm2iramHsAZdF
         MFPqcYJ1NG06bHzEPfFMHuTzLv5pJ0tVPVLQRYV958ZPJlh+5RLtKPidMKdFjApJbqsN
         6JAWfmukIBX9uryjIWzkh81122PFSiRQ3EMYVPdxIMVtypBWfz808qHHAql0L25jGtK/
         UN466jO2dphYoT8PBQIIgzDaRrlVjTGMjvAfFeEQ+JmLlb7srn6JFq3L+gUebETNsCV8
         54sGV8rhfSj6K9EmcnMhMbzm9YhMB5HeIQ6h3Oau2sx+MKia9pKGuzOIe0yWCVPNNhrP
         ElCQ==
X-Gm-Message-State: ANoB5plf9uwFLBWT9CDPMtxCzdQGDL7JynMH75ViVXQd+CEeN2kbzbIS
        QjtjGxim+AYwj8jGkU+R3R2J72t9dun3WQ==
X-Google-Smtp-Source: AA0mqf4OCwUeGg3dFPJKH16DU4sxkW0jA6DeTaFV77RKy7ikk6CDKDn0EiiHpPyMPSn8dj8ewsLgow==
X-Received: by 2002:ac8:44cb:0:b0:3a5:259f:bacb with SMTP id b11-20020ac844cb000000b003a5259fbacbmr29725212qto.569.1669279396526;
        Thu, 24 Nov 2022 00:43:16 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id r25-20020ac85219000000b003a5172220dbsm310092qtn.8.2022.11.24.00.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 00:43:15 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3b56782b3f6so8782517b3.13;
        Thu, 24 Nov 2022 00:43:14 -0800 (PST)
X-Received: by 2002:a0d:fec2:0:b0:36b:56d3:71b8 with SMTP id
 o185-20020a0dfec2000000b0036b56d371b8mr29937985ywf.384.1669279394668; Thu, 24
 Nov 2022 00:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20221118131641.469238-1-biju.das.jz@bp.renesas.com> <20221118131641.469238-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221118131641.469238-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Nov 2022 09:43:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXtKTgUEZWHuS3=KB9w-uCrbWgeRW27yQNw6u_1sq1dzA@mail.gmail.com>
Message-ID: <CAMuHMdXtKTgUEZWHuS3=KB9w-uCrbWgeRW27yQNw6u_1sq1dzA@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: pwm: Add RZ/V2M PWM binding
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Biju,

On Fri, Nov 18, 2022 at 2:16 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add device tree bindings for the RZ/V2{M, MA} PWM Timer (PWM).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/renesas,rzv2m-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/V2{M, MA} PWM Timer (PWM)
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +description: |
> +  The RZ/V2{M, MA} PWM Timer (PWM) composed of 16 channels. It supports the
> +  following functions
> +  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
> +  * The frequency division ratio for internal counter operation is selectable
> +    as PWM_CLK divided by 1, 16, 256, or 2048.
> +  * The period as well as the duty cycle is adjustable.
> +  * The low-level and high-level order of the PWM signals can be inverted.
> +  * The duty cycle of the PWM signal is selectable in the range from 0 to 100%.
> +  * The minimum resolution is 20.83 ns.
> +  * Three interrupt sources: Rising and falling edges of the PWM signal and
> +    clearing of the counter
> +  * Counter operation and the bus interface are asynchronous and both can
> +    operate independently of the magnitude relationship of the respective
> +    clock periods.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a09g011-pwm  # RZ/V2M
> +          - renesas,r9a09g055-pwm  # RZ/V2MA
> +      - const: renesas,rzv2m-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#pwm-cells':
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: CPU Peripheral Group F APB clock

"APB clock"

PWM0-7] are part of Peripheral Group E, and the block might be
reused on SoCs not using CPU Peripheral Group clock signals.

> +      - description: PWM clock
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: pwm
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
> +  - clock-names
> +  - power-domains
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - renesas,r9a09g055-pwm
> +then:
> +  required:
> +    - resets

I think you should make the resets property required unconditionally.
DT describes hardware, not software policy.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
