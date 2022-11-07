Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983BE61F12E
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 11:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiKGKu3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 7 Nov 2022 05:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiKGKu3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 05:50:29 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFE55FF1;
        Mon,  7 Nov 2022 02:50:27 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id w10so7809464qvr.3;
        Mon, 07 Nov 2022 02:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtzJH7j4f+O6x2qizE8T24aAva54b8aUBsTx0+qwrlc=;
        b=NBDS/xX7skJUWxdeyh0PEalNH60V4Z4+dA7z3mV2HoBT2MzFFDEjHJYs98SKCVeIa7
         jlMuDb9OMTCZHEW9v2fbtwLT9Zq7KQCIDAIMHZQ8nmgJKYQK4GUEeVX6BmCYn11285rA
         Vh1u3bYDMIwlTbFtJCHX68JhLjV4up4u8MvdcHwpD6bn0bXdD4p+as0WbrIxRnCFMyOk
         nn81MkC3pV5cF5m0XVLFVKOkl+I2IwH31gfuE7Xx11N6mVlKSL8v+HbVgvnykjtnKvvB
         zIqpbOUbIZcLFmD2ZbCUrW7+FSMw8KUVP+hC8EM/1CUi9QLFruoNQOtyHhugbLSHHOZq
         wxng==
X-Gm-Message-State: ACrzQf0Z+GwrHPqiVMU4OT6a2ekuIKRpnWItBsa6VbuRlgnqWc3P78tH
        Bxckj7HcXWPNTkvI7UfeN30JOip61bXiC9rb
X-Google-Smtp-Source: AMsMyM7JWtVPK9qOOSHBw287YuSJrIw9uKAmmUCs1l9XsLt1F70NUu/5iiK//flYsJblqvBRWl7b6g==
X-Received: by 2002:a05:6214:226d:b0:4bb:d13a:78c6 with SMTP id gs13-20020a056214226d00b004bbd13a78c6mr41614432qvb.43.1667818226228;
        Mon, 07 Nov 2022 02:50:26 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id ga23-20020a05622a591700b00399ad646794sm5850047qtb.41.2022.11.07.02.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:50:25 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id g127so13089367ybg.8;
        Mon, 07 Nov 2022 02:50:25 -0800 (PST)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr36174596ybc.89.1667818225481; Mon, 07
 Nov 2022 02:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20221028104231.220426-1-biju.das.jz@bp.renesas.com>
 <20221028104231.220426-3-biju.das.jz@bp.renesas.com> <CAMuHMdXZFtT9hjTMq3_xbbXX6_SNVSt3byGnDAko24_0XG7bcQ@mail.gmail.com>
 <OS0PR01MB5922DE47BABC3C271C5FFECD863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922DE47BABC3C271C5FFECD863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 11:50:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXoYN=_JfZT+XVf6XoGAT4HaaHT_R3QLK85uSrtrup+qA@mail.gmail.com>
Message-ID: <CAMuHMdXoYN=_JfZT+XVf6XoGAT4HaaHT_R3QLK85uSrtrup+qA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Biju,

CC linux-pm

On Mon, Nov 7, 2022 at 11:35 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 07 November 2022 10:28
> > On Fri, Oct 28, 2022 at 12:42 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > > timer (GPT32E). It supports the following functions
> > >  * 32 bits × 8 channels
> > >  * Up-counting or down-counting (saw waves) or up/down-counting
> > >    (triangle waves) for each counter.
> > >  * Clock sources independently selectable for each channel
> > >  * Two I/O pins per channel
> > >  * Two output compare/input capture registers per channel
> > >  * For the two output compare/input capture registers of each channel,
> > >    four registers are provided as buffer registers and are capable of
> > >    operating as comparison registers when buffering is not in use.
> > >  * In output compare operation, buffer switching can be at crests or
> > >    troughs, enabling the generation of laterally asymmetric PWM waveforms.
> > >  * Registers for setting up frame cycles in each channel (with capability
> > >    for generating interrupts at overflow or underflow)
> > >  * Generation of dead times in PWM operation
> > >  * Synchronous starting, stopping and clearing counters for arbitrary
> > >    channels
> > >  * Starting, stopping, clearing and up/down counters in response to input
> > >    level comparison
> > >  * Starting, clearing, stopping and up/down counters in response to a
> > >    maximum of four external triggers
> > >  * Output pin disable function by dead time error and detected
> > >    short-circuits between output pins
> > >  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
> > >  * Enables the noise filter for input capture and external trigger
> > >    operation
> > >
> > > This patch adds basic pwm support for RZ/G2L GPT driver by creating
> > > separate logical channels for each IOs.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v8->v9:
> > >  * deassert after devm_clk_get() to avoid reset stays deasserted,in case
> > >    clk_get() fails.
> > >  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
> > >  * Removed clk_disable_unprepare() from probe as it is giving
> > >    gpt_pclk already disabled warning in the error path.
> > >         [    0.915664]  clk_core_disable+0x25c/0x274
> > >         [    0.915754]  clk_disable+0x2c/0x44
> > >         [    0.915833]  rzg2l_gpt_pm_runtime_suspend+0x1c/0x34
> > >         [    0.915938]  pm_generic_runtime_suspend+0x28/0x40
> > >         [    0.916042]  genpd_runtime_suspend+0xa8/0x2b0
> > >         [    0.916136]  __rpm_callback+0x44/0x13c
> > >         [    0.916218]  rpm_callback+0x64/0x70
> > >         [    0.916296]  rpm_suspend+0x104/0x630
> > >         [    0.916374]  pm_runtime_work+0xb4/0xbc
> > >         [    0.916456]  process_one_work+0x288/0x6a
> >
> > Thanks for the update!
> >
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> >
> > > +static int __maybe_unused rzg2l_gpt_pm_runtime_suspend(struct device
> > > +*dev) {
> > > +       struct rzg2l_gpt_chip *rzg2l_gpt = dev_get_drvdata(dev);
> > > +
> > > +       clk_disable_unprepare(rzg2l_gpt->clk);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int __maybe_unused rzg2l_gpt_pm_runtime_resume(struct device
> > > +*dev) {
> > > +       struct rzg2l_gpt_chip *rzg2l_gpt = dev_get_drvdata(dev);
> > > +
> > > +       clk_prepare_enable(rzg2l_gpt->clk);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct dev_pm_ops rzg2l_gpt_pm_ops = {
> > > +       SET_RUNTIME_PM_OPS(rzg2l_gpt_pm_runtime_suspend,
> > > +rzg2l_gpt_pm_runtime_resume, NULL) };
> > > +
> > > +static void rzg2l_gpt_reset_assert_pm_disable(void *data) {
> > > +       struct rzg2l_gpt_chip *rzg2l_gpt = data;
> > > +
> > > +       pm_runtime_disable(rzg2l_gpt->chip.dev);
> > > +       pm_runtime_set_suspended(rzg2l_gpt->chip.dev);
> > > +       reset_control_assert(rzg2l_gpt->rstc);
> > > +}
> > > +
> > > +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> > > +       bool ch_en[RZG2L_MAX_PWM_CHANNELS];
> > > +       struct rzg2l_gpt_chip *rzg2l_gpt;
> > > +       int ret;
> > > +       u32 i;
> > > +
> > > +       rzg2l_gpt = devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt), GFP_KERNEL);
> > > +       if (!rzg2l_gpt)
> > > +               return -ENOMEM;
> > > +
> > > +       rzg2l_gpt->mmio = devm_platform_ioremap_resource(pdev, 0);
> > > +       if (IS_ERR(rzg2l_gpt->mmio))
> > > +               return PTR_ERR(rzg2l_gpt->mmio);
> > > +
> > > +       rzg2l_gpt->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > > +       if (IS_ERR(rzg2l_gpt->rstc))
> > > +               return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> > > +                                    "get reset failed\n");
> > > +
> > > +       rzg2l_gpt->clk = devm_clk_get(&pdev->dev, NULL);
> > > +       if (IS_ERR(rzg2l_gpt->clk))
> > > +               return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> > > +                                    "cannot get clock\n");
> > > +
> > > +       ret = reset_control_deassert(rzg2l_gpt->rstc);
> > > +       if (ret)
> > > +               return dev_err_probe(&pdev->dev, ret,
> > > +                                    "cannot deassert reset control\n");
> > > +
> > > +       rzg2l_gpt->rate = clk_get_rate(rzg2l_gpt->clk);
> > > +
> > > +       clk_prepare_enable(rzg2l_gpt->clk);
> >
> > So you enable the clock in .probe()...
>
> Yes, But the PM handler context disable the clock once we return from probe.
> Please see the context for clk_disable.
>
>  [    0.915754]  clk_disable+0x2c/0x44
>  [    0.915833]  rzg2l_gpt_pm_runtime_suspend+0x1c/0x34
>  [    0.915938]  pm_generic_runtime_suspend+0x28/0x40
>  [    0.916042]  genpd_runtime_suspend+0xa8/0x2b0
>  [    0.916136]  __rpm_callback+0x44/0x13c
>  [    0.916218]  rpm_callback+0x64/0x70
>  [    0.916296]  rpm_suspend+0x104/0x630
>  [    0.916374]  pm_runtime_work+0xb4/0xbc
>
> >
> > > +       pm_runtime_set_active(&pdev->dev);
> > > +       pm_runtime_enable(&pdev->dev);
> > > +       ret = devm_add_action_or_reset(&pdev->dev,
> > > +
> > > + rzg2l_gpt_reset_assert_pm_disable,
> >
> > ... and rely on Runtime PM to disable the clock on error/remove?
> > Does that actually work?
>
> See above.

According to that backtrace, there must be an asymmetry in the behavior
of the following two pairs of Runtime PM calls:

    pm_runtime_set_active(&pdev->dev);
    pm_runtime_enable(&pdev->dev);

        => does not call rzg2l_gpt_pm_runtime_resume()
          (and thus does not call clk_prepare_enable())


    pm_runtime_disable(rzg2l_gpt->chip.dev);
    pm_runtime_set_suspended(rzg2l_gpt->chip.dev);

        => does call rzg2l_gpt_pm_runtime_suspend()
           (and thus does call clk_disable_unprepare())

That sounds like an issue in Runtime PM?

> > > +                                      rzg2l_gpt);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       mutex_init(&rzg2l_gpt->lock);
> > > +       platform_set_drvdata(pdev, rzg2l_gpt);
> > > +
> > > +       /*
> > > +        *  We need to keep the clock on, in case the bootloader has enabled the
> > > +        *  PWM and is running during probe().
> > > +        */
> > > +       for (i = 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> > > +               ch_en[i] = rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i);
> > > +               if (ch_en[i])

ch_en[] could be a bitmask instead of an array...

> > > +                       pm_runtime_get_sync(&pdev->dev);

Does that work across driver remove/unbind?

> > > +       }
> > > +
> > > +       rzg2l_gpt->chip.dev = &pdev->dev;
> > > +       rzg2l_gpt->chip.ops = &rzg2l_gpt_ops;
> > > +       rzg2l_gpt->chip.npwm = RZG2L_MAX_PWM_CHANNELS;
> > > +
> > > +       ret = devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
> > > +       if (ret) {
> > > +               for (i = 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> > > +                       if (ch_en[i])
> > > +                               pm_runtime_put(&pdev->dev);
> > > +               }
> > > +
> > > +               dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > > +       }
> > > +
> > > +       return ret;
> > > +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
