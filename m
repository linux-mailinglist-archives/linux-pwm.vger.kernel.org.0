Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B493D56D8
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhGZJMi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Jul 2021 05:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhGZJMi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Jul 2021 05:12:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891B8C061757;
        Mon, 26 Jul 2021 02:53:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e21so6409062pla.5;
        Mon, 26 Jul 2021 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J11jCx264fDkYB4Ey5+F/K1O59ZJzQ0+bvigKGl9vLw=;
        b=C5VW49QstETO2+nuSLBxPYmWT5UFG2d/DKZGk6G0dcyb9Sqw4lenOzvlZ2r3hw57W9
         xiHEJuhlXYAvbBDr/48DS+PgQu3WoEdrKEkxAaKWojCGTTPQB3Z+cfG/Lsp0m7J9SIaE
         t4ByfnivIBylnuZYOWpEsiwmqjREBX+DdpcWvaP16OujRGFnVMnjGXrzq0571LSzPXHh
         XtvE0oJ8yb0nTDNYGjYRojSDcDh8+cZsO2pz0+brbSO2JMCML5/9lALcQB4Vr8Fw2EYI
         7he4EPa/V2gcoi89RG3Kh8E/TtNrrVuW8O9w2A5q6qujRae2MXBrqAQDwKt2Hw/UDERV
         Cegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J11jCx264fDkYB4Ey5+F/K1O59ZJzQ0+bvigKGl9vLw=;
        b=JSflZndkBukGECewBB1symzTn++pC5DR1L+9BPWhSrlJzN/kE9vYxh9bnT7q9XNayT
         GdN8K+cvf5VflGGY3hQt46zUyrw7jLwsZuFddeh21gBWBRiE6T+el8iakAR+kGM6N0Lq
         VhAxUeKr58nz0Lo3qcmOtBfIJwkDo6UgKZcGxOQRdObQ0HDERlLjTIbM5c25unXJ7GTY
         Zk7FroWleUxNa/MNGzedk65JX1VP8i7ANzojzPQIWjtXRchJ3dWXmkXr4BJ/H2WtkY3m
         t4eyMgZojSZCRSB/9ZghIFhST6ILvqxBHFFR/Sv/3wmv5tBNb6u8aop6/vd/vPJHNl/p
         1MpA==
X-Gm-Message-State: AOAM532mHcOakdBVA9OC+jcIBCGSHfSIRXe5BzW8sAZxb9OvQKn5mS9F
        HUdFFT0Xi8CBvD5/dXmEk0T8tKZOmgGm6iJ25wk=
X-Google-Smtp-Source: ABdhPJyrleBpLvLSD6dget3tB6MIaHE3pdYrzLelP+QIQO/diqAZwSWk0ozlkYeOVamNBz/HZ52KPSJJUEEKdjIN/b0=
X-Received: by 2002:a17:90b:1194:: with SMTP id gk20mr25831664pjb.181.1627293186051;
 Mon, 26 Jul 2021 02:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
 <20210609202123.u5rmw7al4x3rrvun@pengutronix.de> <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de> <20210722060654.nudpdtemosi64nlb@pengutronix.de>
 <YPkg0wtYIoHKpTUW@kunai> <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
 <YPlfcbkxiBmB+vw1@kunai> <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de> <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
In-Reply-To: <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 26 Jul 2021 12:52:26 +0300
Message-ID: <CAHp75VeFXJ-0ak7=a0QCtKNdFpu98W6iJ2YuR4MpNx+U4rHe2A@mail.gmail.com>
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
To:     Claudiu.Beznea@microchip.com
Cc:     u.kleine-koenig@pengutronix.de, wsa@kernel.org, sboyd@kernel.org,
        linux-rtc@vger.kernel.org, linux-pwm@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        mturquette@baylibre.com, Nicolas.Ferre@microchip.com,
        linux-spi@vger.kernel.org, o.rempel@pengutronix.de,
        Ludovic.Desroches@microchip.com, broonie@kernel.org,
        thierry.reding@gmail.com, aardelean@deviqon.com,
        kernel@pengutronix.de, Jonathan.Cameron@huawei.com,
        akpm@linux-foundation.org, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 26, 2021 at 12:18 PM <Claudiu.Beznea@microchip.com> wrote:
> On 23.07.2021 12:13, Uwe Kleine-K=C3=B6nig wrote:
> > From:
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Date:
> > 23.07.2021, 12:13
> > On Wed, Jun 09, 2021 at 10:21:23PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> >> given that I don't succeed in getting any feedback for my patch set, I=
'm
> >> trying with a pull request today.
> > This is for a series that is currently in v7 and didn't get any feedbac=
k
> > at all yet. The history is:
> >
> > v1: 2020-10-13, https://lore.kernel.org/linux-clk/20201013082132.661993=
-1-u.kleine-koenig@pengutronix.de
> >     no feedback at all
> >
> > v2: 2021-03-01, https://lore.kernel.org/linux-clk/20210301110821.144575=
6-1-uwe@kleine-koenig.org
> >     kernel test robot identified some issues
> >
> > v3: 2021-03-01, https://lore.kernel.org/linux-clk/20210301135053.146216=
8-1-u.kleine-koenig@pengutronix.de
> >     I added a few driver patches to show the benefit. (However in a way
> >     that the autobuilders don't understand, so there were some false
> >     positive build failure reports.)
> >
> > v4: 2021-03-30, https://lore.kernel.org/linux-clk/20210330181755.204339=
-1-u.kleine-koenig@pengutronix.de
> >     Got some feedback for the converted drivers by the respective
> >     maintainers. Some were indifferent, some found it good
> >
> > v5: 2021-04-22, https://lore.kernel.org/linux-clk/20210422065726.164674=
2-1-u.kleine-koenig@pengutronix.de
> >     Fixed a problem in one of the driver changes (i2c-imx), no feedback
> >     apart from pointing out a few typos, silence from the clk
> >     maintainers
> >
> > v6: 2021-04-26, https://lore.kernel.org/linux-clk/20210426141730.282683=
2-1-u.kleine-koenig@pengutronix.de
> >     Just the typos fixed, no feedback
> >
> > v6 resend: 2021-05-10, https://lore.kernel.org/linux-clk/20210510061724=
.940447-1-u.kleine-koenig@pengutronix.de
> >     no changes in code. Got some feedback from Jonathan Cameron
> >
> > v7: 2021-05-10, https://lore.kernel.org/linux-clk/20210510174142.986250=
-1-u.kleine-koenig@pengutronix.de
> >     Adress Jonathan's feedback, recieved some more acks from non-clk
> >     people
> >
> > pull request: 2021-07-09, https://lore.kernel.org/linux-clk/20210609202=
123.u5rmw7al4x3rrvun@pengutronix.de
> >
> > On Fri, Jul 23, 2021 at 11:26:58AM +0300, Andy Shevchenko wrote:
> >> On Thursday, July 22, 2021, Wolfram Sang <wsa@kernel.org> wrote:
> >>
> >>>>> What about adding gkh to the list explaining the situation to him?
> >>>> Greg doesn't like devm_ stuff.
> >>>>
> >>>> I already asked Arnd who doesn't want to interfere and akpm who didn=
't
> >>>> react either up to now.
> >>> Wow, okay, that is frustrating.
> >> The situation simply shows the process gap and One Maintainer nowadays=
 is
> >> far from enough to satisfy demands.
> > Technically there are two maintainers for drivers/clk, Michael Turquett=
e
> > and Stephen Boyd. It seems Michael is MIA and Stephen doesn't have the
> > capacity to address all requests.
> >
> >> What I think about is that we need to escalate this to Linus and
> >> others and elaborate the mechanisms how to squeeze a new (additional)
> >> maintainer when the original one is not responsive. Let=E2=80=99s say =
some
> >> procedural steps. Otherwise we doomed because of human factor.
> > Assuming there was some process for this, is there someone who is
> > willing to take responsibility here?
>
> Hi,
>
> In the last year I worked on AT91 clock drivers and I would be available
> for taking responsibility beyond AT91 clocks (if everyone's OK with this)=
,
> in whatever form the current maintainers and people in the audience would
> agree, if any (co-maintainer or other forms that could be useful). The id=
ea
> is to help things progress as I also have patches waiting for feedback on
> clock mailing list for almost 6 months.
>
> Let me know if I can be helpful.

I think so. Many subsystems relatively recently (in the last couple of
years or so) enforced that new drivers have to have official
maintainers. Besides that it's warmly welcome to register existing
drivers in the MAINTAINERS database. I would tell you go ahead and
become a maintainer of AT91 clocks and it will definitely reduce the
burden on Stephan's shoulders.

The idea is that you will send a PR to CCF maintainers instead of
patches, although it's expected that patches appear in the mailing
list beforehand anyway.

--=20
With Best Regards,
Andy Shevchenko
