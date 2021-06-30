Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9F3B80CC
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 12:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhF3KZE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 30 Jun 2021 06:25:04 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:44947 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbhF3KZD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Jun 2021 06:25:03 -0400
Received: by mail-vs1-f50.google.com with SMTP id y21so1351040vsm.11;
        Wed, 30 Jun 2021 03:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ksxfB8GoZkHE6cojtlCVdpvdrSWtgoILlvPB6FggsPg=;
        b=a10hOolPrFTpuVNYD29IXmfU4vJIlX+LupFU4C/5z2w7RAV51LiclmZSZx5fC7PSe6
         th0faD07mVsRpgPHxj2vyFUAqfGbnZbIPZIx0LsfDrp42mwOQR3PKh9+UYlrY54k68Kr
         p3cN9H0QySKpdpB0QiH3AhxPDEJiSlX5nCqnpIZBCzS4yAETfvjkRQugrcyAkLeBhVAT
         GyBj1Q6lje+51cfvWlfpPpiPgPKnBTcTDNZeq1eWkGkkaIpzP/Cle3vL/sILU6mxqthe
         PzZi6AZeANeg6a1LeMuh+i0cL90Z0V5uwea0njwPqcfiTuXg5tB7VZOh6WKHpf1FSAuh
         4BsA==
X-Gm-Message-State: AOAM530HlaZreRsRu4rhzSIISRxCS4I1QW7eEFojOisb0aRHT1bILHzL
        iFoXb0Cvm/UFutwDoVFhJYa2B0wflts3Sd6u6/s=
X-Google-Smtp-Source: ABdhPJwlpKjjBC5tYoOXh6f2wXLmLnEr0Tc4SqlA0tJMBKhAMsf/NCJlAUZQCoLk7HEjvzAsWjMyJF/HjkX0Pnmy+G0=
X-Received: by 2002:a67:ba0c:: with SMTP id l12mr29797150vsn.40.1625048553410;
 Wed, 30 Jun 2021 03:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210411160451.1207799-1-u.kleine-koenig@pengutronix.de>
 <20210501160943.108821-1-u.kleine-koenig@pengutronix.de> <alpine.DEB.2.22.394.2106292138100.1194476@ramsan.of.borg>
 <20210630064826.4u2p37tlbriiwtsn@pengutronix.de>
In-Reply-To: <20210630064826.4u2p37tlbriiwtsn@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Jun 2021 12:22:22 +0200
Message-ID: <CAMuHMdV0w8mxxLVT4abrD-FgqS9Kg4BLomDQbXS_csdMyqhypQ@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: Ensure for legacy drivers that pwm->state stays consistent
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, Jun 30, 2021 at 8:48 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Jun 29, 2021 at 09:44:38PM +0200, Geert Uytterhoeven wrote:
> > On Sat, 1 May 2021, Uwe Kleine-König wrote:
> > > Without this change it can happen that if changing the polarity succeeded
> > > but changing duty_cycle and period failed pwm->state contains a mixture
> > > between the old and the requested state.
> > >
> > > So remember the initial state before starting to modify the configuration
> > > and restore it when one of the required callback fails.
> > >
> > > Compared to the previous implementation .disable() (if necessary) is called
> > > earlier to prevent a glitch.
> > >
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >
> > Thanks for your patch, which is now commit d7bff84fe7ed8c3b ("pwm:
> > Ensure for legacy drivers that pwm->state stays consistent") in
> > pwm/for-next.
> >
> > This commit broke the backlight on the Atmark Techno Armadillo 800 EVA
> > board (arch/arm/boot/dts/r8a7740-armadillo800eva.dts), which now shows a
> > black screen.  Reverting the commit fixes the problem.
> >
> > Do you have an idea what is wrong, and how to fix it?
>
> I starred at the patch for some time now and couldn't find a problem.
> Looking at drivers/pwm/pwm-renesas-tpu.c I don't see something obvious.
> (The .set_polarity callback is faulty as I doesn't commit the request to
> hardware, but that shouldn't matter here.)
>
> I guess the first request the backlight driver emits is
>
>         .period = 33333,
>         .duty_cycle = 33333,
>         .enabled = true,
>         .polarity = PWM_POLARITY_INVERSED,
>
> which should result into the following driver calls (with and without
> the breaking commit):
>
>         tpu_pwm_set_polarity(chip, pwm, PWM_POLARITY_INVERSED);
>         tpu_pwm_config(chip, pwm, 33333, 33333);
>         tpu_pwm_enable(chip, pwm);
>
> Can you confirm that?

tpu_pwm_config() is no longer called:

     renesas-tpu-pwm e6600000.pwm: tpu_pwm_set_polarity:334: channel
2, polarity = 1
    -renesas-tpu-pwm e6600000.pwm: tpu_pwm_config:257: channel = 2,
duty_ns = 0, period_ns = 33333
    -renesas-tpu-pwm e6600000.pwm: tpu_pwm_config:257: channel = 2,
duty_ns = 33333, period_ns = 33333
     renesas-tpu-pwm e6600000.pwm: tpu_pwm_enable:346: channel 2

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
