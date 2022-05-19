Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412BB52CEEC
	for <lists+linux-pwm@lfdr.de>; Thu, 19 May 2022 11:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiESJHI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 May 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiESJHH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 May 2022 05:07:07 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810EF2E9E0;
        Thu, 19 May 2022 02:07:06 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id x7so1157009qta.6;
        Thu, 19 May 2022 02:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJsS+F/k/6P8jpC2HJqU3RUJq/XbSaz5+vmAseD4Zn8=;
        b=nBLs3zyfvlIbLbDJVkg+dYaiC3W3VkWocdKKbMVn5iubo2WKd9ob0Ylr9oVDrhiQcB
         /Bwvl0hXKt627A0cKLMw45G4kOSmowp9rqqmJ+vaeO/tiAkxMixRJlzO9ol7DfKpqGFD
         CXq+g3KER/d4aCLNX2xRgMZYMPLS1GpWHQpH7WmOd4R40F37Qli6Aft5dCSiKpC9Ncln
         A2Tdy75fVa+yob2u1PwrtNTRuCDgwH3iHj1hkomFoFAf+p37hJWx2wWyUW0+zSnS2di+
         SNg18ISDGH6/2v5JEpOmnDMORrM5qqEN/OUS1S9lNJUgEo5Q+Rwj0JVuBa3aHcYh5R3j
         9OhQ==
X-Gm-Message-State: AOAM5320YUyAgG8+wISnWyzhhTtk7KAnXjQbq0KKYOWlr6SnYtufa2UM
        pzJwIQj7QEjydpe6rjdzJz2qh0JcIGNIpg==
X-Google-Smtp-Source: ABdhPJzoI9+1XGLgOYAzsU0n/6uaathH9eyCmOL0V3WCTYpBVXe++BNttf/gkPqq8AewAZf+ghi+lg==
X-Received: by 2002:ac8:5713:0:b0:2f3:d872:2fa8 with SMTP id 19-20020ac85713000000b002f3d8722fa8mr2925892qtw.49.1652951225516;
        Thu, 19 May 2022 02:07:05 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id r74-20020a37444d000000b006a330abc56fsm766552qka.1.2022.05.19.02.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 02:07:04 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id p139so7884094ybc.11;
        Thu, 19 May 2022 02:07:02 -0700 (PDT)
X-Received: by 2002:a25:4289:0:b0:64d:746f:5311 with SMTP id
 p131-20020a254289000000b0064d746f5311mr3124109yba.89.1652951222317; Thu, 19
 May 2022 02:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510151112.16249-2-biju.das.jz@bp.renesas.com> <20220517210407.GA1635524-robh@kernel.org>
 <OS0PR01MB5922FC66FD4EF05F31B17D3386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220518181730.GH3302100-robh@kernel.org> <OS0PR01MB5922BC7AAC6154DEF7B98F0386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922BC7AAC6154DEF7B98F0386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 May 2022 11:06:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWPy4HmPrfnL8kZmFBBcHY-EoNm7Z6CoJyudhKornTS=g@mail.gmail.com>
Message-ID: <CAMuHMdWPy4HmPrfnL8kZmFBBcHY-EoNm7Z6CoJyudhKornTS=g@mail.gmail.com>
Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
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

Hi Biju,

On Wed, May 18, 2022 at 8:34 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
> > On Wed, May 18, 2022 at 05:58:00AM +0000, Biju Das wrote:
> > > > Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG
> > > > binding
> > > >
> > > > On Tue, May 10, 2022 at 04:11:05PM +0100, Biju Das wrote:
> > > > > Add device tree bindings for the RZ/G2L Port Output Enable for GPT
> > > > (POEG).
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> > > > > +examples:
> > > > > +  - |
> > > > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > +
> > > > > +    poeggd: poeg@10049400 {
> > > > > +        compatible = "renesas,r9a07g044-poeg", "renesas,rzg2l-poeg";
> > > > > +        reg = <0x10049400 0x4>;
> > > >
> > > > This looks like it is part of some larger block?
> > >
> > > There are 2 IP blocks GPT(PWM) and POEG with its own resources like
> > > (register map, clk, reset and interrupts)
> > >
> > > Larger block is GPT, which has lot of functionalities. The output from
> > > GPT block can be disabled by this IP either by external trigger,
> > > request from GPT(Deadtime error, both output low/high) or explicit
> > > software control). This IP has only a single register. Currently I am not
> > sure which framework to be used for this IP?? Or should it be merged with

Yeah, POEG is a weird beast.
Some of it fits under pin control, but not all of it.
From a quick glance, most of its configuration is intended to be
static, i.e. could be done from DT, like pin control?
I have no idea how to use the POEG interrupts, though.

> > larger block GPT by combining the resources?
> >
> > Usually, IP blocks would have some minimum address alignment (typ 4K or 64K
> > to be page aligned), but if there's no other IP in this address range as-is
> > is fine. The question is what's before or after the above address?
>
> As per the HW manual, before GPT IP block and after POE3 block(Port Output Enable 3 (POE3) for MTU).
>
> Before
> H'0_1004_8000 H'0_1004_87FF 2 Kbytes GPT
>
> After
> H'0_1004_9800 H'0_1004_9BFF 1 Kbyte POE3
>
> Please find the address map for the IP blocks near to it.
>
> H'0_1004_A000 H'0_1004_A3FF 1 Kbyte SSIF ch1
> H'0_1004_9C00 H'0_1004_9FFF 1 Kbyte SSIF ch0
> H'0_1004_9800 H'0_1004_9BFF 1 Kbyte POE3
> H'0_1004_9400 H'0_1004_97FF 1 Kbyte POEGD
> H'0_1004_9000 H'0_1004_93FF 1 Kbyte POEGC
> H'0_1004_8C00 H'0_1004_8FFF 1 Kbyte POEGB
> H'0_1004_8800 H'0_1004_8BFF 1 Kbyte POEGA
> H'0_1004_8000 H'0_1004_87FF 2 Kbytes GPT

This is actually 8 x 256 bytes, for 8 GPT instances.

> H'0_1004_7000 H'0_1004_7FFF 4 Kbytes SRC (Reg)
> H'0_1004_0000 H'0_1004_6FFF 28 Kbytes SRC (Memory)

So you can combine GPT and POEG[A-D] into a single block.
However, doing so will make life harder when reusing the driver on
an SoC with a different layout, or a different number of POEG blocks
and GPT channels.

BTW, POE3 is a similar (in spirit) block on top of the MTU
(Multi-Function Timer Pulse Unit 3, which seems to be an
 enhanced version of the already-supported MTU2 on RZ/A1?).
But the POE3 block is not located next to the MTU block, so you cannot
combine them without overlap.

Note that the minimum page size on Cortex-A seems to be 4 kiB, and
several blocks are spaced apart less, so even with a different OS
than Linux you cannot implement page-based access control.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
