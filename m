Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF77752DE0B
	for <lists+linux-pwm@lfdr.de>; Thu, 19 May 2022 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243408AbiESUEv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 May 2022 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiESUEt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 May 2022 16:04:49 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51396CA8E;
        Thu, 19 May 2022 13:04:48 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id y14-20020a9d460e000000b00605ee347da1so4249417ote.8;
        Thu, 19 May 2022 13:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GTT4wIhpDJnzKjHIGPXs5tV9PIbRQeBZZBItHT9r7RI=;
        b=N1NgxkCBumsmIDUjQw2tN+8Qkoy1K+tyadDuNCbZNonM+8ufuYR4hw6wep8LgtfCwo
         liQ3P/6jeILlg3owtswXyxP37j2b4OLAnPXzVsupbRgIoKp+nV70s/uwcoIX+gem2YVM
         +ebFlzHntdkRjDdxH3PYu7YwBUm8i1aHvbdWVqunQNeGdQOurwgFVI4Gw/tGPT7iwZRp
         eaSQyuVGBZxp9CO7EFZgxTupC/Z5ctW5DpgQCO9njkvVRvI+Aoaq2WryyUeTmRcOiVkO
         2zKpHIgiUfoz6JIxTP3N1IBds2zRfZj1RRFGBzGMq7iak527pa9oIfpxtjrt5kUvPlCu
         dVVw==
X-Gm-Message-State: AOAM530DNRu1Q+InscU0pMTO44jhWu0Abes5mfC1Khl2piKtqzxAME5I
        5Jx3lcZ47rx120ZSQ5668Q==
X-Google-Smtp-Source: ABdhPJzWfrQLCbV1u4Fzjw2rIffT+DYqX5xyF5xAzvszQwfy66OUdNdJpog58+IkZG0E2BSDXeBS8g==
X-Received: by 2002:a05:6830:4187:b0:605:4e15:de30 with SMTP id r7-20020a056830418700b006054e15de30mr2655004otu.182.1652990688134;
        Thu, 19 May 2022 13:04:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t16-20020a05683022f000b0060603221260sm113271otc.48.2022.05.19.13.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:04:47 -0700 (PDT)
Received: (nullmailer pid 2104566 invoked by uid 1000);
        Thu, 19 May 2022 20:04:46 -0000
Date:   Thu, 19 May 2022 15:04:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
Message-ID: <20220519200446.GB2071376-robh@kernel.org>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510151112.16249-2-biju.das.jz@bp.renesas.com>
 <20220517210407.GA1635524-robh@kernel.org>
 <OS0PR01MB5922FC66FD4EF05F31B17D3386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220518181730.GH3302100-robh@kernel.org>
 <OS0PR01MB5922BC7AAC6154DEF7B98F0386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWPy4HmPrfnL8kZmFBBcHY-EoNm7Z6CoJyudhKornTS=g@mail.gmail.com>
 <OS0PR01MB5922D0FFFA82AC5428F8C8D886D09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922D0FFFA82AC5428F8C8D886D09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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

On Thu, May 19, 2022 at 09:30:19AM +0000, Biju Das wrote:
> Hi Geert,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
> > 
> > Hi Biju,
> > 
> > On Wed, May 18, 2022 at 8:34 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > > Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG
> > > > binding On Wed, May 18, 2022 at 05:58:00AM +0000, Biju Das wrote:
> > > > > > Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L
> > > > > > POEG binding
> > > > > >
> > > > > > On Tue, May 10, 2022 at 04:11:05PM +0100, Biju Das wrote:
> > > > > > > Add device tree bindings for the RZ/G2L Port Output Enable for
> > > > > > > GPT
> > > > > > (POEG).
> > > > > > >
> > > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > 
> > > > > > > +examples:
> > > > > > > +  - |
> > > > > > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > > > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > > > +
> > > > > > > +    poeggd: poeg@10049400 {
> > > > > > > +        compatible = "renesas,r9a07g044-poeg", "renesas,rzg2l-
> > poeg";
> > > > > > > +        reg = <0x10049400 0x4>;
> > > > > >
> > > > > > This looks like it is part of some larger block?
> > > > >
> > > > > There are 2 IP blocks GPT(PWM) and POEG with its own resources
> > > > > like (register map, clk, reset and interrupts)
> > > > >
> > > > > Larger block is GPT, which has lot of functionalities. The output
> > > > > from GPT block can be disabled by this IP either by external
> > > > > trigger, request from GPT(Deadtime error, both output low/high) or
> > > > > explicit software control). This IP has only a single register.
> > > > > Currently I am not
> > > > sure which framework to be used for this IP?? Or should it be merged
> > > > with
> > 
> > Yeah, POEG is a weird beast.
> > Some of it fits under pin control, but not all of it.
> > From a quick glance, most of its configuration is intended to be static,
> > i.e. could be done from DT, like pin control?
> > I have no idea how to use the POEG interrupts, though.
> 
> If there is a GPT request(Dead time error or Both output low/high condition) output is disabled automatically and we get an 
> Interrupt. May be to clear it , we need to implement interrupt. Otherwise output will be always disabled,
> even if the outputs are out of phase after the fault condition.
> 
> I have done a quick test with interrupts previously for output disable using GPT request:- 
> 	Use both A and B in phase, output is disabled automatically and you get an interrupt in POEG block.
>       If you inverse B, it is out of phase and fault condition is no more, but still output is disabled.
>       In this condition, If we want to enable outputs, we need to clear interrupt status bits.
>             
> > 
> > > > larger block GPT by combining the resources?
> > > >
> > > > Usually, IP blocks would have some minimum address alignment (typ 4K
> > > > or 64K to be page aligned), but if there's no other IP in this
> > > > address range as-is is fine. The question is what's before or after
> > the above address?
> > >
> > > As per the HW manual, before GPT IP block and after POE3 block(Port
> > Output Enable 3 (POE3) for MTU).
> > >
> > > Before
> > > H'0_1004_8000 H'0_1004_87FF 2 Kbytes GPT
> > >
> > > After
> > > H'0_1004_9800 H'0_1004_9BFF 1 Kbyte POE3
> > >
> > > Please find the address map for the IP blocks near to it.
> > >
> > > H'0_1004_A000 H'0_1004_A3FF 1 Kbyte SSIF ch1
> > > H'0_1004_9C00 H'0_1004_9FFF 1 Kbyte SSIF ch0
> > > H'0_1004_9800 H'0_1004_9BFF 1 Kbyte POE3
> > > H'0_1004_9400 H'0_1004_97FF 1 Kbyte POEGD
> > > H'0_1004_9000 H'0_1004_93FF 1 Kbyte POEGC
> > > H'0_1004_8C00 H'0_1004_8FFF 1 Kbyte POEGB
> > > H'0_1004_8800 H'0_1004_8BFF 1 Kbyte POEGA
> > > H'0_1004_8000 H'0_1004_87FF 2 Kbytes GPT
> > 
> > This is actually 8 x 256 bytes, for 8 GPT instances.
> 
> Yes correct.
> 
> > 
> > > H'0_1004_7000 H'0_1004_7FFF 4 Kbytes SRC (Reg)
> > > H'0_1004_0000 H'0_1004_6FFF 28 Kbytes SRC (Memory)
> > 
> > So you can combine GPT and POEG[A-D] into a single block.
> > However, doing so will make life harder when reusing the driver on an SoC
> > with a different layout, or a different number of POEG blocks and GPT
> > channels.
> 
> I agree. Modelling as a different driver gives lots of flexibility.

The question is different h/w blocks or 1, not driver(s). It's 
convenient when the answer is the same (i.e. h/w node:driver is 1:1), 
but h/w is sometimes messy.

In any case, that looks like different blocks to me.

Rob
