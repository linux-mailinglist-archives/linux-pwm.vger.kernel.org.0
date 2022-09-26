Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231475EA7E9
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Sep 2022 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiIZOGg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Sep 2022 10:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiIZOGL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Sep 2022 10:06:11 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45EE5F113;
        Mon, 26 Sep 2022 05:17:30 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id m9so4161473qvv.7;
        Mon, 26 Sep 2022 05:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OpKZ6pIwSXsK0LhSYa9JjdvV0u7g6RN0sjGEudnzcJE=;
        b=cB6B+353ih20lmVMlwfJ+cylqv9Wm1669oPxLlBQlDPZxuLHHdLloqKKiM6rnGncYu
         FBkdGoD21TmA/BZ4oJA+a0G2yo1z8cg+5iaKe7i+gw6pfkyfbLMANXPGzDLLwL3kg6RL
         8+V9cf32UIH29A1MlVXlJGtvBOWHS+uj2Url3vUNZD9dT29zfhS41KBojs3rlEmrfZ/r
         mb7Uk5eNy4GFOJs3dmOgnMqIKydczd4e2AcqTMu6apc5az07/Ql/kH/Ima82KnKNWnif
         37c3Ix+FizEst5yNfWHTqVCE9s0DegHRvY0EUyzPaRXuOcMd87br915rumAcOUH4ORh0
         2ryA==
X-Gm-Message-State: ACrzQf0Xq3b+WqzsnIxqLB8G2md2b6b9B2RQFgTT38YuF60DRiUISsUk
        6noeUfU06qX1fJu9FAvkEFPO+MtQxPo5Zw==
X-Google-Smtp-Source: AMsMyM4ab9IRtWcoDI+LZVpBDSe19rqgcNMq7XNVLvM1hp30RHiZGN2VZtnqrdwYQK1c342yYQZjYw==
X-Received: by 2002:a0c:f5c4:0:b0:4a7:f6cb:9e39 with SMTP id q4-20020a0cf5c4000000b004a7f6cb9e39mr16559324qvm.9.1664194630011;
        Mon, 26 Sep 2022 05:17:10 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id u11-20020a05620a454b00b006ce2c3c48ebsm11726333qkp.77.2022.09.26.05.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 05:17:09 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-345528ceb87so66292787b3.11;
        Mon, 26 Sep 2022 05:17:09 -0700 (PDT)
X-Received: by 2002:a81:1691:0:b0:345:17df:4fc6 with SMTP id
 139-20020a811691000000b0034517df4fc6mr19578550yww.502.1664194629104; Mon, 26
 Sep 2022 05:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de> <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220921133542.3glfgeddnlhrebkz@pengutronix.de> <OS0PR01MB592258F2341BEDA1A5A7301C864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220922053605.qivxzwon52orbdgz@pengutronix.de> <OS0PR01MB59220ECD0B2D42DF5012B6C7864E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <TYCPR01MB59336AAF4DD1D304FA53451286509@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <20220924134233.m7uyvwyulbmo3mrv@pengutronix.de> <OS0PR01MB5922B479EE78E840DA9B8F0E86509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdU_-Y_MV=6t+ri_MicEMK+Z5JhxHHp3AsDU+4KgdMsXSQ@mail.gmail.com> <TYCPR01MB593348A5202E0E6619617AAF86529@TYCPR01MB5933.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB593348A5202E0E6619617AAF86529@TYCPR01MB5933.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 14:16:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXgtVk-f2XmdXVf19ZALfycjAZdDZVHxh-WNDGMn-OGBQ@mail.gmail.com>
Message-ID: <CAMuHMdXgtVk-f2XmdXVf19ZALfycjAZdDZVHxh-WNDGMn-OGBQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Sep 26, 2022 at 10:00 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> > On Sat, Sep 24, 2022 at 6:10 PM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > Note:
> > > I have a plan to develop another PWM driver using MTU IP on the same
> > SoC.
> > > The work is not started yet.
> >
> > That is the MTU3, which seems to be a further evolution of the MTU2 in
> > e.g. RZ/A1, which is already supported as a timer through the
> > sh_mtu2 driver?
>
> sh_mtu2 is just supports clock events. MTU2 is much powerful and we are
> not supporting more advanced features like phase counting(counter framework),
> PWM(frame wok) etc...

OK.

> > > For this IP, I planned to use MFD framework for the MTU driver and
> > > Will add counter driver, timer driver(clock source, clock event) and
> > > pwm driver as child devices.
> > >
> > > Currently the MFD driver and 16-Bit Phase Counting using counter
> > > framework is almost done.
> >
> > Do you really need an MFD? (MFDs trigger a red flag for me ;-) E.g.
>
> Similar concept is already available in mainline[1].
> See STM32 timers where there is an MFD driver supports timer, counter
> And pwm as child devices.
>
> [1] https://elixir.bootlin.com/linux/v6.0-rc5/C/ident/TIM_ARR
>
> > there are two sets of bindings for renesas,tpu: when #pwm-cells is
> > present, it is used for PWM, otherwise it is used as a timer.
>
> [2]
> Yes, we could encapsulate all in PWM. But then we need to call
> Other susbsytem from pwm (eg:- counter and timer).
>
> I am not sure, PWM subsystem people allows to call counter and
> Timer subsystem calls from pwm driver?? If yes, then that will simplifies a lot.
>
> [3]
> I almost have an RFC ready for MFD + 16-bit phase counting mode
> Using counter device with MTU3 which is tested on MTU{1,2} channels.
>
> So basically, we need to decide whether to go with approach [2]
> Or [3]??
>
> Please share your views, I can post RFC patch to get a clear picture
> if needed. Please let me know.

I see you've done your homework ;-) OK, fine for me!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
