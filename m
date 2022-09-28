Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509605EDE77
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 16:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiI1OJr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 28 Sep 2022 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiI1OJo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 10:09:44 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54687F589;
        Wed, 28 Sep 2022 07:09:40 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id cj27so7962930qtb.7;
        Wed, 28 Sep 2022 07:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+3FrJL7/nBcKNjydEAHAvPEykqXLPhLyMYvCllFqwQY=;
        b=SkmLla3rlsLeDihGAFQIC+/344S1zYb65kjyXjz5wN8MjlW28K/0GzsDVgA0j15ENC
         C4uf/gYPvuZI4R76MbGwsYsqoSJFnKYxv2K0G7wSKVLCwTOqgX8Zl9pqdNQBK2Q+1lF/
         LboG2ooCOcNPBF4/pKwqlUkBoHmmlEWJQOlO2fulFGTwh80hEfj1Cq8RX3T1mu84d3A1
         9Ptg8YBBPuPbuJqFuc/XrGzd1sHPihQX9kixEENPhsBY4n+hjyfT1wejYrSqdqO6bocO
         16QwJ4dDzFxBD03YAmBDN8bS2pkD9Hij09ntDnvAbK4lorZAtDKW/4OFZrYMpuq7lpqY
         BCgQ==
X-Gm-Message-State: ACrzQf0by33Gt0K13kFGBJDPGKfZAn1raUoZPFwCujpaa/UItvhUOBoV
        1CQYfzrkcVbPxl4myTkA4ZCH9QD4qa2VYQ==
X-Google-Smtp-Source: AMsMyM7GKzhLIWmU3rJboVAEy+TosoZgmfXDU8W4xtKW5wSCe8F58/z/fp0sSokX6irDobBXTiz9mw==
X-Received: by 2002:a05:622a:174b:b0:35d:1be5:c65e with SMTP id l11-20020a05622a174b00b0035d1be5c65emr23739931qtk.422.1664374178835;
        Wed, 28 Sep 2022 07:09:38 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a255000b006b98315c6fbsm3117936qko.1.2022.09.28.07.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:09:38 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3321c2a8d4cso131635047b3.5;
        Wed, 28 Sep 2022 07:09:38 -0700 (PDT)
X-Received: by 2002:a81:9c49:0:b0:34a:de:97b8 with SMTP id n9-20020a819c49000000b0034a00de97b8mr30698990ywa.384.1664374178154;
 Wed, 28 Sep 2022 07:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com> <YzRRJD/VTbgesoEI@orome>
In-Reply-To: <YzRRJD/VTbgesoEI@orome>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Sep 2022 16:09:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSVjHqcNFS=61Xfs957ANSH07DcFpeAMQPdXArXozmQw@mail.gmail.com>
Message-ID: <CAMuHMdXSVjHqcNFS=61Xfs957ANSH07DcFpeAMQPdXArXozmQw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
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

Hi Thierry,

On Wed, Sep 28, 2022 at 3:50 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Wed, Sep 21, 2022 at 03:57:41PM +0100, Biju Das wrote:
> > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
> > (GPT32E). It supports the following functions
> >  * 32 bits × 8 channels
> >  * Up-counting or down-counting (saw waves) or up/down-counting
> >    (triangle waves) for each counter.
> >  * Clock sources independently selectable for each channel
> >  * Two I/O pins per channel
> >  * Two output compare/input capture registers per channel
> >  * For the two output compare/input capture registers of each channel,
> >    four registers are provided as buffer registers and are capable of
> >    operating as comparison registers when buffering is not in use.
> >  * In output compare operation, buffer switching can be at crests or
> >    troughs, enabling the generation of laterally asymmetric PWM waveforms.
> >  * Registers for setting up frame cycles in each channel (with capability
> >    for generating interrupts at overflow or underflow)
> >  * Generation of dead times in PWM operation
> >  * Synchronous starting, stopping and clearing counters for arbitrary
> >    channels
> >  * Starting, stopping, clearing and up/down counters in response to input
> >    level comparison
> >  * Starting, clearing, stopping and up/down counters in response to a
> >    maximum of four external triggers
> >  * Output pin disable function by dead time error and detected
> >    short-circuits between output pins
> >  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
> >  * Enables the noise filter for input capture and external trigger
> >    operation
> >
> > This patch adds basic pwm support for RZ/G2L GPT driver by creating
> > separate logical channels for each IOs.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > +static int rzg2l_gpt_probe(struct platform_device *pdev)
> > +{
> > +     struct rzg2l_gpt_chip *rzg2l_gpt;
> > +     int ret;
> > +
> > +     rzg2l_gpt = devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt), GFP_KERNEL);
> > +     if (!rzg2l_gpt)
> > +             return -ENOMEM;
> > +
> > +     rzg2l_gpt->mmio = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(rzg2l_gpt->mmio))
> > +             return PTR_ERR(rzg2l_gpt->mmio);
> > +
> > +     rzg2l_gpt->rstc = devm_reset_control_get_shared(&pdev->dev, NULL);
> > +     if (IS_ERR(rzg2l_gpt->rstc))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> > +                                  "get reset failed\n");
> > +
> > +     ret = reset_control_deassert(rzg2l_gpt->rstc);
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "cannot deassert reset control\n");
> > +
> > +     pm_runtime_enable(&pdev->dev);
> > +     ret = devm_add_action_or_reset(&pdev->dev,
> > +                                    rzg2l_gpt_reset_assert_pm_disable,
> > +                                    rzg2l_gpt);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     rzg2l_gpt->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > +     if (IS_ERR(rzg2l_gpt->clk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> > +                                  "cannot get clock\n");
> > +
> > +     rzg2l_gpt->rate = clk_get_rate(rzg2l_gpt->clk);
> > +     /*
> > +      *  We need to keep the clock on, in case the bootloader has enabled the
> > +      *  PWM and is running during probe(). A variable pwm_enabled_by_
> > +      *  bootloader is set to true in that case and during first
> > +      *  pwm_disable(), it is set to false and release the clock resource.
> > +      *
> > +      *  In case the pwm is not enabled by the bootloader, devm_clk_put
> > +      *  disables the clk and holding a reference on the clk isn't needed
> > +      *  because runtime-pm handles the needed enabling.
> > +      */
>
> Where does this happen? I'm not aware of any code that would
> automatically enable clocks for runtime PM. Typically you would need to
> implement driver-specific callbacks for that to happen.
>
> > +     if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > +             rzg2l_gpt->pwm_enabled_by_bootloader = true;
> > +     else
> > +             devm_clk_put(&pdev->dev, rzg2l_gpt->clk);
>
> So in either case I would expect you to want to hold on to the clock
> pointer here and use that in the runtime PM callbacks.
>
> This whole business of keeping a separate variable to track this also
> seems a bit fishy to me because it only partially reflects in the
> software state what's really going on. So I think what you really want
> here is to call pm_runtime_set_active() before pm_runtime_enable() to
> make sure that your device is marked as such.
>
> I wonder if that alone wouldn't already solve this problem. IIRC, the
> runtime PM infrastructure will consider a device to be runtime suspended
> after ->probe() by default. And if the clock is indeed managed by
> runtime PM somehow, then that might just cause it to get disabled.
> Again, it'd be great to know how exactly runtime PM knows how to manage
> the clock if you don't tell it here. Is the clock perhaps shared between
> multiple IPs? Perhaps a parent device that managed it in runtime PM?

It's handled by the clock domain code in the PM Domain framework,
cfr. GENPD_FLAG_PM_CLK.  All members of the PM Domain have
their module clock(s) managed automatically through Runtime PM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
