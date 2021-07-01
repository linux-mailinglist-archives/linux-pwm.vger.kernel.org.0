Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16123B9144
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 13:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhGALoC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 1 Jul 2021 07:44:02 -0400
Received: from mail-vk1-f175.google.com ([209.85.221.175]:33753 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhGALoB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 07:44:01 -0400
Received: by mail-vk1-f175.google.com with SMTP id x125so809592vkf.0;
        Thu, 01 Jul 2021 04:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K6xPZe/HmCow3slbRUW/74J8lcie8gXG6l+vsZk3IGE=;
        b=BRT0qqYvuZpzAyAehAMQpLPmlTQGS9s6808DIjzdMN6zQ4WkKaEZLRjfM+2rVRclZT
         S2f3SlRfatRTlooDi813oCd19T00JfIsSdTexdFyUqOqwKLUMgHSR+fAug+XM651XBOU
         uOgKFfOS6Hl61ZE1eGFXfcqDJwdpvTbIRPDsopFx2Z5gXSpaHyDhd6UubPgOlRX3VeJc
         7SAANgMV1shvxIsxVDZAwHb0ISDoQprXc68e86UWfAElQMssaJYGRERXX5OtZudeOXVm
         Gxt9TrhAxm8p1sj77X7OuXGR+3XbJCXaUiZMt9wQua7+w1kKbftWfo0eyVtlqBmUip6M
         6SsA==
X-Gm-Message-State: AOAM532KN+/nDd9PKINC/SfG/WtlUaWOpNucxctaiOqtaMgTB7+x0gz3
        Qw3lVAliKtIsG7c8SRURIt4ubUCOhsekTxNO/iY=
X-Google-Smtp-Source: ABdhPJxEJnOhhZH/vF5dHyFmQZbdcGNAAoXId/x0Z+oo71nTH99l9zqwlQBszcXrE2kayKrLemprubVM8kwK5M/Twlw=
X-Received: by 2002:a1f:1a41:: with SMTP id a62mr32441403vka.5.1625139690856;
 Thu, 01 Jul 2021 04:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
 <CAMuHMdWFL42BV9m7Oigvy0m7=-i4W0hnQT8izHdNNiYG0BfiMQ@mail.gmail.com> <20210701104528.dbnhhswxp6rgzzj3@pengutronix.de>
In-Reply-To: <20210701104528.dbnhhswxp6rgzzj3@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Jul 2021 13:41:19 +0200
Message-ID: <CAMuHMdUBUG1bgfaWGt3OPhXyt+wt1XTT_uKKJemE-UcK7V8BZQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] pwm: Some improvements for legacy drivers
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

On Thu, Jul 1, 2021 at 12:45 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Jul 01, 2021 at 10:58:32AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Jul 1, 2021 at 9:29 AM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > this is the successor of my earlier patch "pwm: Ensure for legacy
> > > drivers that pwm->state stays consistent" that was applied shortly to
> > > next until Geert found a problem with it.
> > >
> > > I split the patch in three parts now: First the legacy handling is just
> > > moved to a separate function without any semantic change. Then a glitch
> > > is fixed, but without the regression I introduced initially. In the
> > > third and last patch the longstanding FIXME about breaking pwm->state if
> > > a callback fails is addressed.
> > >
> > > Uwe Kleine-König (3):
> > >   pwm: Move legacy driver handling into a dedicated function
> > >   pwm: Prevent a glitch for legacy drivers
> > >   pwm: Restore initial state if a legacy callback fails
> > >
> > >  drivers/pwm/core.c | 139 ++++++++++++++++++++++++++-------------------
> > >  1 file changed, 79 insertions(+), 60 deletions(-)
> >
> > Thanks, works fine on Armadillo 800 EVA!
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks for testing.
>
> > > base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
> >
> > That's plain v5.13-rc1, which is probably not what Thierry is targeting?
>
> his for-next branch is based on v5.13-rc1 and there are no changes in it
> touching drivers/pwm/core.c, so I expect this to be fine.

Git tends to disagree:

$ git log --oneline v5.13-rc1..pwm/for-next -- drivers/pwm/core.c
9ae241d06ef7aca8 pwm: core: Simplify some devm_*pwm*() functions
c333b936c1530e76 pwm: core: Remove unused devm_pwm_put()
e625fb70a6d21e4d pwm: core: Unify fwnode checks in the module
e5c38ba9f2813beb pwm: core: Reuse fwnode_to_pwmchip() in ACPI case
ca06616b1eed3112 pwm: core: Convert to use fwnode for matching
ad5e085c63f59391 pwm: Drop irrelevant error path from pwmchip_remove()
bcda91bf86c1ff76 pwm: Add a device-managed function to add PWM chips
9e40ee18a1dc1623 pwm: core: Support new usage_power setting in PWM state
69230cfac3d02c1b pwm: Autodetect default value for of_pwm_n_cells from
device tree
5447e7833629ee42 pwm: Drop of_pwm_simple_xlate() in favour of
of_pwm_xlate_with_flags()
cf38c978cf1d2a28 pwm: Make of_pwm_xlate_with_flags() work with #pwm-cells = <2>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
