Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED507C8F7B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 23:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJMVnB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 17:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMVnA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 17:43:00 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F82BF
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 14:42:57 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-419b53acc11so38611cf.0
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697233376; x=1697838176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pb/tKoEHgiUjsUV3nygbaOQxumkmAbOvHQiwTQ1o3U=;
        b=LQ7EalUzEghkyaGycoCOcAZV5iyaeQoxT8vvjbYRe/w5CFjQsM8KIFAQHz7mkn6a4T
         k+Zda99IbvyfnlJcIawJIM0CxYQF52Np+NGSDHcWWjUslarXkN4hnp4P9Co0mCBL/kLI
         7NmYuXEbi8JA+/6HZPIKbcVQEVZBH1U3DblKcjBBiWrZoFfrFcuYGMj5nldfeTbFHYta
         1psCDgKm1njJzIcg1wFtrj6oHWELUUKkixeziNSY3bOS4ZpxWS3A73KvOWIFlRvPSJY7
         +TGK2mjVst4x5imzE0PdMXDAbx/fUNb0Eyf2sWDC/rhGQkp/qMM7csyBRgKt9FGP4520
         NUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233376; x=1697838176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pb/tKoEHgiUjsUV3nygbaOQxumkmAbOvHQiwTQ1o3U=;
        b=Mkt1tPe3owEjjzTVM5AkB4R1mb/IzeFXlQ/wG0znofj0nXI9gVNjCBiSaP0yWbq8hS
         6nCIbuhHPv5+3b05oOCxTsUSWqQ27USbeYV6wcqtYG3JNmirAZ1OZPP6oE9rQGUC1Bl2
         2u17SurJ0H7Br3nit2EJT2M6W/ChjdPG7z5JrGdcX2EHFiAh9m7KXwLoIiUEoE4PqfJl
         RjH6ck5Dn03d4PtsNxPzQKNXalKoqVKgquf0lzP6fjNTJDEEqNAhAghjfH1hAkLPlibb
         RcPmRUPXPNqzLDkgjXUwzhePNUmEubudR0n/x2gPkjBJW1jlOtQnoPeg3E/F3B/WYl/w
         KQZA==
X-Gm-Message-State: AOJu0Yy4+6BDlZdpn1eQf/7jp5htqLhhQGpf6KhPBUmh3c6x+qnv7vtH
        OPvXr7XXAiURzphGMcWwCRipQZvDhaY1oIQJL3EPb4BcgxQkWONEef4=
X-Google-Smtp-Source: AGHT+IH3PIRKETHDC8vsQwErx5fbzZJlbuRmauTNCGrZxwbropga1Rop4p/jWXxvwlV+7zQvZtAS5x/TfnSq2debgAY=
X-Received: by 2002:a05:622a:2899:b0:410:88a5:92f with SMTP id
 ke25-20020a05622a289900b0041088a5092fmr62905qtb.0.1697233375989; Fri, 13 Oct
 2023 14:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de> <ZLeX4UbFaY592HIa@orome>
 <20230725211004.peqxxb4y3j62gmnp@pengutronix.de> <20231010080508.7ssnroaefyaeeedd@pengutronix.de>
In-Reply-To: <20231010080508.7ssnroaefyaeeedd@pengutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 13 Oct 2023 14:42:20 -0700
Message-ID: <CAGETcx8CNGLnHdWrDpdm4Sx5cFcFFBT2bZKJzNZttAEknFK4Cw@mail.gmail.com>
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 10, 2023 at 1:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Saravana,
>
> you were pointed out to me as the expert for device links. I found a
> problem with these.
>
> On Tue, Jul 25, 2023 at 11:10:04PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Today I managed to trigger the problem I intend to address with this
> > series. My machine to test this on is an stm32mp157. To be able to
> > trigger the problem reliably I applied the following patches on top of
> > v6.5-rc1:
> >
> >  - pwm: stm32: Don't modify HW state in .remove() callback
> >    This is a cleanup that I already sent out.
> >    https://lore.kernel.org/r/20230713155142.2454010-2-u.kleine-koenig@p=
engutronix.de
> >    The purpose for reproducing the problem is to not trigger further
> >    calls to the apply callback.
> >
> >  - The following patch:
> >
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index 687967d3265f..c7fc02b0fa3c 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -451,6 +451,10 @@ static int stm32_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >       struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> >       int ret;
> >
> > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > +     msleep(5000);
> > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > +
> >       enabled =3D pwm->state.enabled;
> >
> >       if (enabled && !state->enabled) {
> > @@ -650,7 +654,11 @@ static void stm32_pwm_remove(struct platform_devic=
e *pdev)
> >  {
> >       struct stm32_pwm *priv =3D platform_get_drvdata(pdev);
> >
> > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> >       pwmchip_remove(&priv->chip);
> > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > +
> > +     priv->regmap =3D NULL;
> >  }
> >
> >  static int __maybe_unused stm32_pwm_suspend(struct device *dev)
> >
> > The first hunk is only there to widen the race window. The second is to
> > give some diagnostics and make stm32_pwm_apply() crash if it continues
> > to run after the msleep. (Without it it didn't crash reproducibly, don'=
t
> > understand why. *shrug*)
> >
> > The device tree contains a pwm-fan device making use of one of the PWMs=
.
> >
> > Now I do the following:
> >
> >       echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & sleep 1; ec=
ho 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbind
> >
> > Unbinding the fan device has two effects:
> >
> >  - The device link between fan and pwm looses its property to unbind fa=
n
> >    when pwm gets unbound.
> >    (Its .status changes from DL_STATE_ACTIVE to DL_STATE_AVAILABLE)
> >  - It calls pwm_fan_cleanup() which triggers a call to
> >    pwm_apply_state().
> >
> > So when the pwm device gets unbound the first thread is sleeping in
> > stm32_pwm_apply(). The driver calls pwmchip_remove() and sets
> > priv->regmap to NULL. Then a few seconds later the first thread wakes u=
p
> > in stm32_pwm_apply() with the chip freed and priv->regmap =3D NULL. Ban=
g!
> >
> > This looks as follows:
> >
> > root@crown:~# echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & sle=
ep 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbind
> > [  187.182113] stm32-pwm 40007000.timer:pwm: stm32_pwm_apply:454
> > [  188.164769] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:657
> > [  188.184555] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:659
> > root@crown:~# [  192.236423] platform 40007000.timer:pwm: stm32_pwm_app=
ly:456
> > [  192.240727] 8<--- cut here ---
> > [  192.243759] Unable to handle kernel NULL pointer dereference at virt=
ual address 0000001c when read
> > ...
> >
> > Even without the crash you can see that stm32_pwm_apply() is still
> > running after pwmchip_remove() completed.
> >
> > I'm unsure if the device link could be improved here to ensure that the
> > fan is completely unbound even if it started unbinding already before
> > the pwm device gets unbound. (And if it could, would this fit the devic=
e
> > links purpose and so be a sensible improvement?)
>
> While I think that there is something to be done in the pwm core that
> this doesn't explode (i.e. do proper lifetime tracking such that a
> pwm_chip doesn't disappear while still being used---and I'm working on
> that) I expected that the device links between pwm consumer and provider
> would prevent the above described oops, too. But somehow the fan already
> going away (but still using the PWM) when the PWM is unbound, results in
> the PWM disappearing before the fan is completely gone.
>
> Is this expected, or a problem that can (and should?) be fixed?

I didn't read your full series, but I read this email. With what's in
this email, the problem seems to be in the driver or the pwm
framework. The pwm driver/framework can't tell the driver core that
you successfully unbound (returning from .remove()) before you have
finish all your ongoing transactions with the device. If your
"apply()" is still running, you need to make sure it's complete before
.remove() does any resource releasing/clean up.

Also, how is the consumer driver's .remove() succeeding if it has an
ongoing pwm call()? This all sounds like insufficient locking and
critical region protection in both the consumer and supplier.

Device links can't do anything here because you are giving it wrong
info -- that the unbind was successful before it actually is.

Device links will and can make sure that the consumer is unbound
successfully before the unbind is called on the supplier. And it looks
like that's still true here.

-Saravana

>
> If you need more context or a tester, don't hesitate to ask.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
