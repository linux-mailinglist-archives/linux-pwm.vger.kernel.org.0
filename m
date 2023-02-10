Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580636929A7
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Feb 2023 22:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjBJVzs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Feb 2023 16:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjBJVz3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Feb 2023 16:55:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1346136699;
        Fri, 10 Feb 2023 13:55:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso7240138wms.0;
        Fri, 10 Feb 2023 13:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFUUnGBouZuwDPNnv9L7oztS2SI4gbqXt6iIr4gzBZo=;
        b=NRHRpNOBS56puqQXyJokME1OqvkLm0/Ewe3KzQtrtvnHhFyhtIAT0EZVBXxNdcs80e
         1so6I8j8WAyTA4MH48wtM5/ozfJYxCDi3Te0F0Y0KQ9TpTF/9B3/qpRM7ra+rUIneiSW
         zVgBjwxskycvU2oXc+T2fqv5/bHh2KpCZ7nNmSVN+il80O4vS410k/3BmPhCLuV//USl
         SEc78DzZ0wIl3u78+BBNvNZqWH5B1K786N5nXcEm6QA5D+MVh/qfn0S60aTSM0XL8ONU
         nbYAoh2QfXmqRbJa/h7jQja71XX9CC23jDDwC03gqQ+Rm502IFKkrmpIcIl2SwPW/Uuz
         aIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFUUnGBouZuwDPNnv9L7oztS2SI4gbqXt6iIr4gzBZo=;
        b=eqQE4a2RyVxLGJ+NRLp3ImkLBc+aoN98sXjFC4r/UrJD13/UuoFtsJYQmFg8I86QPU
         wS3CP6qPn8nFcEk0odJEQioefL1e3GD9KFLBdDeFlDyYMATVrUP9YXspIUucP9nUea2K
         1SKLhQ0kg9/P6/nd8I8iIGPa/JGSZt5/VRvgLIbxS0hywjNQaT/UCrbrZtLedLOFLQcn
         jEmb82o3XL98fALbZNzvMXEXCr33Pd5vo/n3X/S2keYILCZrFsOHxuHboz/47c0DZQAU
         OvvVa52YgoOHzX8bkUVUuEmB/bMvVrKVEqIIw+SRY6FtkB1r4W4l1qWV9BY2rCRhiFjr
         +4qQ==
X-Gm-Message-State: AO0yUKW1uJfU+HNdEsSHn8tW4LM6mCR0sjbE28cXHrcN9JJCNU76NoOr
        3CwpXY6JLuU6oCWSvaCyLqJg2u2BtOoWfBPaYpJO2DRH
X-Google-Smtp-Source: AK7set8vdtqarZk11xbj0QLjR8KvwfsKE1CXvqktiuD+Z5oqzyilPHjhAPUCnqUeA5O6ZNSqM5hJvrkgsVq5y1bRFz0=
X-Received: by 2002:a05:600c:a39b:b0:3dc:5a75:fee5 with SMTP id
 hn27-20020a05600ca39b00b003dc5a75fee5mr584731wmb.139.1676066126414; Fri, 10
 Feb 2023 13:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com> <20201211170432.6113-2-nicola.dilieto@gmail.com>
 <20210117130434.663qpp6noujptdyt@pengutronix.de> <CACRpkdawMpuznr-XC2uvZm8PvOj-jObpnbz6iptV-Q4OFxjesw@mail.gmail.com>
In-Reply-To: <CACRpkdawMpuznr-XC2uvZm8PvOj-jObpnbz6iptV-Q4OFxjesw@mail.gmail.com>
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date:   Fri, 10 Feb 2023 22:54:49 +0100
Message-ID: <CA+TH9VnrsSQDUfvXk8c+q6Sx2Jc5TCN5XLYCRLtgv55-6voLWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nicola Di Lieto <nicola.dilieto@gmail.com>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Il giorno ven 22 gen 2021 alle ore 11:20 Linus Walleij
<linus.walleij@linaro.org> ha scritto:
>
> Hi Nicola, Uwe,
>
> thanks for looping me in on this very interesting driver!
>
> This can be really helpful, I already see that it would be possible to
> replace the hopeless idiomatic driver for the NSLU2 ixp4xx
> beeper speaker with this driver.
>
> On Sun, Jan 17, 2021 at 2:04 PM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
>
> > > +static void pwm_gpio_work(struct work_struct *work)
> > > +{
> > > +     struct pwm_gpio *pwm_gpio =3D container_of(work, struct pwm_gpi=
o, work);
> > > +
> > > +     gpiod_set_value_cansleep(pwm_gpio->desc, pwm_gpio->output);
> >
> > Usually you want to check the return value of gpiod_set_value. @Linus +
> > Bartosz: What do you think, does it need checking for an error here?
>
> We have traditionally been quite relaxed on that. But since it is
> the cansleep variant, meaning this GPIO could be on a GPIO
> expander on I2C or SPI, it would be more important.
>
> However: in this specific case for PWM I wonder if we should
> stick with gpio_set_value() without _cansleep, and then we can
> definitely skip the error check.
>
> That means GPIO PWM can happen on on-chip GPIOs that
> are just a register write. Certainly no need to check the return
> value of these. Also we know it will satisfy timing.
>
> If we allow GPIO PWM on slow buses and expanders that can
> sleep I do not think the PWM will be very good or reliable.
>
> For example on an I2C expander, with the bus speed of
> max 400 kHz, what kind of PWM can we create on that?
> Certainly now above 200 kHz (Nyquist frequency) and
> probably less. And we have to way to actually check the
> frequency of the underlying bus, so I am a bit skeptic
> here.
>
> Would gpio_set_value() work for now or do we need to
> support expanders and _cansleep?

More than a year passed from the last message, could we reopen the
discussion? I'd like to have this upstream!

Thanks!

>
> Yours,
> Linus Walleij



--=20
Profile: http://it.linkedin.com/in/compagnucciangelo
