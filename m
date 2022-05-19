Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0016C52CF46
	for <lists+linux-pwm@lfdr.de>; Thu, 19 May 2022 11:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiESJXS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 May 2022 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiESJXR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 May 2022 05:23:17 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEE5EDE9;
        Thu, 19 May 2022 02:23:15 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id i68so3057112qke.11;
        Thu, 19 May 2022 02:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD9CMG2eKRR20RkYXvJiV6droyXWcEn+XuexIGjtZCU=;
        b=hrdzWilHRb4R1ZPncBkvS14tv86rlLLOxKP1oDLgzD+9DNuh9LzBICvnSdxh0uBiBr
         swD0dajYOaZ9pgbDoeuW0xaxJVzPzENN3PF2ZlCU6yY1OK08gDqfKr4bnUXFjDYzvIm9
         TrZ+SJrrsIOlyv3Fanp2qd/jSv5cIPwx2x41wX0HB9qhY34yJNd9q3oacGkGWB6mcqry
         sz82Mvu9Sy/gBmw7FEWRrwYidCCrkba35LxFE40e2o3ht5AyVDV4tnouDScs/nS/fETi
         jhmdbGil0YfPMNcfAvXAikVJ4svVin97tgPd07g/Jwb2SLyCHo2vPfZ/Nv+aLbzqx+z0
         i1AQ==
X-Gm-Message-State: AOAM532nSTjkEK8QlAKG0aZno+SoNMUKZz+Op7rpk+o0Qa5ar6Ca+R1F
        CF7lE9NhvqNU5ZxYmEyy/M4N0VR/PaRlfw==
X-Google-Smtp-Source: ABdhPJxbqwGpQaHuhbEQA39zbzCTkBH7KNSE5vE3DK3gH0QhhvNWiFM2SYKGnqX7fnCxCiMxM7RS2w==
X-Received: by 2002:a05:620a:4ea:b0:6a3:28ec:8a3d with SMTP id b10-20020a05620a04ea00b006a328ec8a3dmr2361238qkh.550.1652952194125;
        Thu, 19 May 2022 02:23:14 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id r6-20020ac87946000000b002f39b99f671sm1028310qtt.11.2022.05.19.02.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 02:23:13 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2fefb051547so50634167b3.5;
        Thu, 19 May 2022 02:23:12 -0700 (PDT)
X-Received: by 2002:a81:6588:0:b0:2f8:b75e:1e1a with SMTP id
 z130-20020a816588000000b002f8b75e1e1amr3788287ywb.358.1652952192342; Thu, 19
 May 2022 02:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220510144259.9908-1-biju.das.jz@bp.renesas.com>
 <20220510144259.9908-2-biju.das.jz@bp.renesas.com> <CAMuHMdXUQ9FeaSO97-HhbL4fcxCKt1qb_d1R_L=-BxGH7x23yg@mail.gmail.com>
In-Reply-To: <CAMuHMdXUQ9FeaSO97-HhbL4fcxCKt1qb_d1R_L=-BxGH7x23yg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 May 2022 11:23:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOQfqZM0-Kyo_BjWOQrYTEkbE8i_hg+Lx9A7WXH73JzQ@mail.gmail.com>
Message-ID: <CAMuHMdWOQfqZM0-Kyo_BjWOQrYTEkbE8i_hg+Lx9A7WXH73JzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, May 19, 2022 at 11:22 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, May 10, 2022 at 4:43 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Add device tree bindings for the General PWM Timer (GPT).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
>
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    gpt4: pwm@10048400 {
> > +        compatible = "renesas,r9a07g044-gpt", "renesas,rzg2l-gpt";
> > +        reg = <0x10048400 0xa4>;
>
> 0x100

That applies to
[RFC 3/5] arm64: dts: renesas: r9a07g044: Add GPT support
[RFC 4/5] arm64: dts: renesas: r9a07g054: Add GPT support
too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
