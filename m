Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4EB61F3F9
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 14:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiKGNHS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 7 Nov 2022 08:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKGNHS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 08:07:18 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B8D1C123;
        Mon,  7 Nov 2022 05:07:16 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id hh9so6755023qtb.13;
        Mon, 07 Nov 2022 05:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wyr2OIYB/cnWtBGSIWDqBzyM+MbJyfUX2/M0rNUV5BI=;
        b=gRh/lO4sBGjaK05R7lETX3z+5Xy82kjmpfxwoikwxTnlkhG0CgzD5Yp1s7EKHNfaqA
         NKkcKiQiDhp9iD0y1PYpEEdJ8qxDdlakn2CkEuFpIY8fUJ4Hgt+YOX6XGi96SGtAit7I
         W64A3BivlmMOFaN42WUtA2UD8XT2skzWPf0D9BRZ5UYoLwLM3jEE/Fr3XKWFn6wya1lC
         BhQL+TTWFVcvgzzYxvR2BaIzG5WWnjNRLLw/GkB9TPpcVYt7XevMmpYlgbiCYA3E04aG
         JjH5UknlZogXt7TWYf7KvmA1rpYGBMd+HGdgOcsItsoq7ShWQVsx3giCsIAlvH8Qe8Qk
         UMaQ==
X-Gm-Message-State: ACrzQf1XiVJuZ4TjaWsCFw0R5p1jbbf87s4r0j4CPGvWK3FNi3HZY3ir
        Wu8YT41hnvvdIFivTrLttXPhCB3anIi9Ow==
X-Google-Smtp-Source: AMsMyM5zz7JYJxGLtm1PYow/5wJ6wyLkeK7oVkx07JVReUNc13i6Rig/j7tO4mXYm2LPtyVxi/9HfQ==
X-Received: by 2002:ac8:53d1:0:b0:3a5:13b0:e040 with SMTP id c17-20020ac853d1000000b003a513b0e040mr726052qtq.625.1667826435202;
        Mon, 07 Nov 2022 05:07:15 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id j129-20020a37b987000000b006cdd0939ffbsm6671436qkf.86.2022.11.07.05.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:07:14 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 129so13465290ybb.12;
        Mon, 07 Nov 2022 05:07:14 -0800 (PST)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr36739701ybc.89.1667826434413; Mon, 07
 Nov 2022 05:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20221028104231.220426-1-biju.das.jz@bp.renesas.com>
 <20221028104231.220426-3-biju.das.jz@bp.renesas.com> <CAMuHMdXZFtT9hjTMq3_xbbXX6_SNVSt3byGnDAko24_0XG7bcQ@mail.gmail.com>
 <OS0PR01MB5922DE47BABC3C271C5FFECD863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXoYN=_JfZT+XVf6XoGAT4HaaHT_R3QLK85uSrtrup+qA@mail.gmail.com> <OS0PR01MB59222558EA83F0C500E2B06C863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59222558EA83F0C500E2B06C863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 14:07:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXcMpibSm=vGwtujGtrFo575WdM-nVjFp_Mgt6dbEJmAQ@mail.gmail.com>
Message-ID: <CAMuHMdXcMpibSm=vGwtujGtrFo575WdM-nVjFp_Mgt6dbEJmAQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] pwm: Add support for RZ/G2L GPT
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

On Mon, Nov 7, 2022 at 12:39 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > On Mon, Nov 7, 2022 at 11:35 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > -----Original Message-----
> > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Sent: 07 November 2022 10:28
> > > > On Fri, Oct 28, 2022 at 12:42 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > > > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > > > > timer (GPT32E). It supports the following functions
> > > > >  * 32 bits × 8 channels
> > > > >  * Up-counting or down-counting (saw waves) or up/down-counting
> > > > >    (triangle waves) for each counter.
> > > > >  * Clock sources independently selectable for each channel
> > > > >  * Two I/O pins per channel
> > > > >  * Two output compare/input capture registers per channel
> > > > >  * For the two output compare/input capture registers of each channel,
> > > > >    four registers are provided as buffer registers and are capable of
> > > > >    operating as comparison registers when buffering is not in use.
> > > > >  * In output compare operation, buffer switching can be at crests or
> > > > >    troughs, enabling the generation of laterally asymmetric PWM
> > waveforms.
> > > > >  * Registers for setting up frame cycles in each channel (with
> > capability
> > > > >    for generating interrupts at overflow or underflow)
> > > > >  * Generation of dead times in PWM operation
> > > > >  * Synchronous starting, stopping and clearing counters for arbitrary
> > > > >    channels
> > > > >  * Starting, stopping, clearing and up/down counters in response to
> > input
> > > > >    level comparison
> > > > >  * Starting, clearing, stopping and up/down counters in response to a
> > > > >    maximum of four external triggers
> > > > >  * Output pin disable function by dead time error and detected
> > > > >    short-circuits between output pins
> > > > >  * A/D converter start triggers can be generated (GPT32E0 to
> > > > > GPT32E3)
> > > > >  * Enables the noise filter for input capture and external trigger
> > > > >    operation
> > > > >
> > > > > This patch adds basic pwm support for RZ/G2L GPT driver by
> > > > > creating separate logical channels for each IOs.
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > ---
> > > > > v8->v9:
> > > > >  * deassert after devm_clk_get() to avoid reset stays deasserted,in
> > case
> > > > >    clk_get() fails.
> > > > >  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
> > > > >  * Removed clk_disable_unprepare() from probe as it is giving
> > > > >    gpt_pclk already disabled warning in the error path.
> > > > >         [    0.915664]  clk_core_disable+0x25c/0x274
> > > > >         [    0.915754]  clk_disable+0x2c/0x44
> > > > >         [    0.915833]  rzg2l_gpt_pm_runtime_suspend+0x1c/0x34
> > > > >         [    0.915938]  pm_generic_runtime_suspend+0x28/0x40
> > > > >         [    0.916042]  genpd_runtime_suspend+0xa8/0x2b0
> > > > >         [    0.916136]  __rpm_callback+0x44/0x13c
> > > > >         [    0.916218]  rpm_callback+0x64/0x70
> > > > >         [    0.916296]  rpm_suspend+0x104/0x630
> > > > >         [    0.916374]  pm_runtime_work+0xb4/0xbc
> > > > >         [    0.916456]  process_one_work+0x288/0x6a
> > > >
> > > > Thanks for the update!
> > > >
> > > > > --- /dev/null
> > > > > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > > > > +       /*
> > > > > +        *  We need to keep the clock on, in case the bootloader has
> > enabled the
> > > > > +        *  PWM and is running during probe().
> > > > > +        */
> > > > > +       for (i = 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> > > > > +               ch_en[i] = rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i);
> > > > > +               if (ch_en[i])
> >
> > ch_en[] could be a bitmask instead of an array...
>
> It is a local array. Maybe we need to initialize a u8
> variable to 0 initially for bitmask operation??

Yes, regardless of using an array or a bitmask, it must be initialized
to (all) zero(es).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
