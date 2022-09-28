Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFEA5EE3E3
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 20:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiI1SHl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 28 Sep 2022 14:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiI1SHk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 14:07:40 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3FA102501;
        Wed, 28 Sep 2022 11:07:39 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id 3so8375810qka.5;
        Wed, 28 Sep 2022 11:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gyVP7KS9Iqc8V/m+UNn2eX6nCoMfcYCz2r0GaTTSlp4=;
        b=4lFxDLJj0jAVG09dRkS/SRyunXAb1Dcancocwpy1z6H7/QjNuLyPjAwfEtQLdlbPZ2
         fZQ+Kwc3Lg9RgvNONTnZ/K27ROR0lbzse7xQ+8ymm+CRi/9eHn52Ol4wX1LKGVTAFKw3
         9CynSqzTxAUn5Ri5fhzdeJ+GQGLIPtjbDzgRvTmtWthodDlR+t5P4XSzkf7IdBQFdeEp
         ksgTr3qJOmTIF2fmkrg07h5b+JYrtKRh7DKq/d33bWmnufyESwKJqyG7hV1o65DkTx0L
         7vh9RNd4XPorys+y9j/Igxu3A+5t83mWL3/zfq7wQKfKI/ynj/j2oG0z8g9FwiUQRclR
         MfaQ==
X-Gm-Message-State: ACrzQf2zy6rThL1KPBa5qAUcbocjvbANQ4LZeHa2zgYSDDNLPavLkPGW
        gU/O7GwoG5L4EHWBGx7gAe0ebkG2cXVogQ==
X-Google-Smtp-Source: AMsMyM7AVs3mRAHqG8RgD0/ziUgvjI9JzS/12GY4pYwg4TdVhtpAEU6GvFQ/wP9FlfCuxiIYUPWtDw==
X-Received: by 2002:a05:620a:905:b0:6ce:604c:3187 with SMTP id v5-20020a05620a090500b006ce604c3187mr22720080qkv.523.1664388458126;
        Wed, 28 Sep 2022 11:07:38 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id d22-20020a05620a205600b006b9c6d590fasm3286128qka.61.2022.09.28.11.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:07:37 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3529c491327so43232427b3.13;
        Wed, 28 Sep 2022 11:07:37 -0700 (PDT)
X-Received: by 2002:a81:4ed0:0:b0:353:cef1:aab2 with SMTP id
 c199-20020a814ed0000000b00353cef1aab2mr2782208ywb.502.1664388457173; Wed, 28
 Sep 2022 11:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com> <YzRRJD/VTbgesoEI@orome> <OS0PR01MB5922D60C59A5BACC580030A986549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922D60C59A5BACC580030A986549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Sep 2022 20:07:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWaNULmoUvgeboDrxT92w=iCPY0ucDuU19O1E0buqXgbQ@mail.gmail.com>
Message-ID: <CAMuHMdWaNULmoUvgeboDrxT92w=iCPY0ucDuU19O1E0buqXgbQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
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

On Wed, Sep 28, 2022 at 7:34 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > On Wed, Sep 21, 2022 at 03:57:41PM +0100, Biju Das wrote:
> > > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > > timer (GPT32E). It supports the following functions
> > >  * 32 bits × 8 channels
> > >  * Up-counting or down-counting (saw waves) or up/down-counting
> > >    (triangle waves) for each counter.
> > >  * Clock sources independently selectable for each channel
> > >  * Two I/O pins per channel
> > >  * Two output compare/input capture registers per channel
> > >  * For the two output compare/input capture registers of each
> > channel,
> > >    four registers are provided as buffer registers and are capable
> > of
> > >    operating as comparison registers when buffering is not in use.
> > >  * In output compare operation, buffer switching can be at crests or
> > >    troughs, enabling the generation of laterally asymmetric PWM
> > waveforms.
> > >  * Registers for setting up frame cycles in each channel (with
> > capability
> > >    for generating interrupts at overflow or underflow)
> > >  * Generation of dead times in PWM operation
> > >  * Synchronous starting, stopping and clearing counters for
> > arbitrary
> > >    channels
> > >  * Starting, stopping, clearing and up/down counters in response to
> > input
> > >    level comparison
> > >  * Starting, clearing, stopping and up/down counters in response to
> > a
> > >    maximum of four external triggers
> > >  * Output pin disable function by dead time error and detected
> > >    short-circuits between output pins
> > >  * A/D converter start triggers can be generated (GPT32E0 to
> > GPT32E3)
> > >  * Enables the noise filter for input capture and external trigger
> > >    operation
> > >
> > > This patch adds basic pwm support for RZ/G2L GPT driver by creating
> > > separate logical channels for each IOs.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > > +   if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > > +           rzg2l_gpt->pwm_enabled_by_bootloader = true;
> > > +   else
> > > +           devm_clk_put(&pdev->dev, rzg2l_gpt->clk);
> >
> > So in either case I would expect you to want to hold on to the clock
> > pointer here and use that in the runtime PM callbacks.
>
> But the api used here is "devm_clk_get_enabled".
> This will enable the clocks and holds the reference
> (for pwm enabled by bootloader case) as it avoids turning "off"
> the clock during later part of the boot process
> (it prevents clock off by clk_disable_unused())

The clock will still be stopped if the driver is unloaded, or if the device
is unbound manually, right? Or am I missing something?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
