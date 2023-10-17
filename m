Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2CE7CD0DF
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Oct 2023 01:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbjJQXgR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Oct 2023 19:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbjJQXgB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Oct 2023 19:36:01 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E03A100
        for <linux-pwm@vger.kernel.org>; Tue, 17 Oct 2023 16:35:56 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-419b53acc11so71591cf.0
        for <linux-pwm@vger.kernel.org>; Tue, 17 Oct 2023 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697585755; x=1698190555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6XvEbt2MnxqD71HOE9SNfh2ltnCZaXynJwAqTCW6QE=;
        b=Dd/DQR847jTjFQC4yHsZqDGql3b5IprBHHZjnt5gciBy0xMVqaEMOqIT1fUFYx3Lbc
         eGVpIKIVgCcyu6pKiIiCS8dJV0j7OhUAmPQNXvg1hYu2lHlXSAFlk7ip0f51V8w5TQqx
         h1huSrwqGprVUDbEKMwc7FCrQvLGYFa0WY8J6cYw1k5/+y3aIGgZm0IIbwNVh9yA+mBx
         2U83VTTm59q0xIHa1QhC2XpPuT5ihy3qM6A7jqgOY7YLRxFTjWHVQDWRjmVxg3c7Ai/K
         uJVxOf/TImj8UXcIcJrgROadyp7o7WQxBatHZ/jJbruGMejdCct3AjkCjB6NroLbNOVb
         u4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697585755; x=1698190555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6XvEbt2MnxqD71HOE9SNfh2ltnCZaXynJwAqTCW6QE=;
        b=dei8EaLD/vrL5TWtVKau8R6IkQUTlVg+7wIKx3arVncUlehuhy5bR3/RiAXSGnbG1A
         AY8NdslD7syoEfrVjvpoZm3/uKfxjjaKRWv7GnM1qnQXf0QIgBRmMzhabJD+mb8fglPW
         xHVdJ1+rh9XMriCII4kR2Yph8SlzSRjx/vzQ32+YGh3C3EPFqbBk1Z6ORj5f1ArEpCo2
         BD5FCoX9TLe3BngdKe6trAy/ZpOYlVjBNVowphYC4fxXHc5zoiUDhw+YiQfYa9Lztdik
         0+1uhSt8h1040uuIHdQgAjUZsiSgIkCl4X82DjhCyKEsNDnvl8pzf/obJVtOyek4uMct
         vGCA==
X-Gm-Message-State: AOJu0YwdHPgiH7DE0/SMvi8u4SocYfx+PYGEcSGFdHC/70IlWYLvQ/7C
        TYqVORUfc5fGm8GJETN8bTM3YvVBNBBFai1BeyEiC+FD0ivroNUe6fU=
X-Google-Smtp-Source: AGHT+IGjEULsLcMtZpPpeeKXIF2cfllG/iLgplkyMye827sFFSSMtphxLGDQI8VHjatBToqy8UnrF//bLx41QsTIoP4=
X-Received: by 2002:ac8:4e3c:0:b0:41c:b7bf:c855 with SMTP id
 d28-20020ac84e3c000000b0041cb7bfc855mr115512qtw.24.1697585754818; Tue, 17 Oct
 2023 16:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de> <ZLeX4UbFaY592HIa@orome>
 <20230725211004.peqxxb4y3j62gmnp@pengutronix.de> <20231010080508.7ssnroaefyaeeedd@pengutronix.de>
 <CAGETcx8CNGLnHdWrDpdm4Sx5cFcFFBT2bZKJzNZttAEknFK4Cw@mail.gmail.com> <20231014161721.f4iqyroddkcyoefo@pengutronix.de>
In-Reply-To: <20231014161721.f4iqyroddkcyoefo@pengutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 17 Oct 2023 16:35:17 -0700
Message-ID: <CAGETcx-T33-TWmfXxT1dqTt7gWi8E1Z+EXhjpFfdFtpa7h+pQQ@mail.gmail.com>
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wolfram Sang <wsa@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Oct 14, 2023 at 9:17=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Fri, Oct 13, 2023 at 02:42:20PM -0700, Saravana Kannan wrote:
> > On Tue, Oct 10, 2023 at 1:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > Hello Saravana,
> > >
> > > you were pointed out to me as the expert for device links. I found a
> > > problem with these.
> > >
> > > On Tue, Jul 25, 2023 at 11:10:04PM +0200, Uwe Kleine-K=C3=B6nig wrote=
:
> > > > Today I managed to trigger the problem I intend to address with thi=
s
> > > > series. My machine to test this on is an stm32mp157. To be able to
> > > > trigger the problem reliably I applied the following patches on top=
 of
> > > > v6.5-rc1:
> > > >
> > > >  - pwm: stm32: Don't modify HW state in .remove() callback
> > > >    This is a cleanup that I already sent out.
> > > >    https://lore.kernel.org/r/20230713155142.2454010-2-u.kleine-koen=
ig@pengutronix.de
> > > >    The purpose for reproducing the problem is to not trigger furthe=
r
> > > >    calls to the apply callback.
> > > >
> > > >  - The following patch:
> > > >
> > > > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > > > index 687967d3265f..c7fc02b0fa3c 100644
> > > > --- a/drivers/pwm/pwm-stm32.c
> > > > +++ b/drivers/pwm/pwm-stm32.c
> > > > @@ -451,6 +451,10 @@ static int stm32_pwm_apply(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > > >       struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> > > >       int ret;
> > > >
> > > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > > +     msleep(5000);
> > > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > > +
> > > >       enabled =3D pwm->state.enabled;
> > > >
> > > >       if (enabled && !state->enabled) {
> > > > @@ -650,7 +654,11 @@ static void stm32_pwm_remove(struct platform_d=
evice *pdev)
> > > >  {
> > > >       struct stm32_pwm *priv =3D platform_get_drvdata(pdev);
> > > >
> > > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > > >       pwmchip_remove(&priv->chip);
> > > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > > > +
> > > > +     priv->regmap =3D NULL;
> > > >  }
> > > >
> > > >  static int __maybe_unused stm32_pwm_suspend(struct device *dev)
> > > >
> > > > The first hunk is only there to widen the race window. The second i=
s to
> > > > give some diagnostics and make stm32_pwm_apply() crash if it contin=
ues
> > > > to run after the msleep. (Without it it didn't crash reproducibly, =
don't
> > > > understand why. *shrug*)
> > > >
> > > > The device tree contains a pwm-fan device making use of one of the =
PWMs.
> > > >
> > > > Now I do the following:
> > > >
> > > >       echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & sleep 1=
; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbind
> > > >
> > > > Unbinding the fan device has two effects:
> > > >
> > > >  - The device link between fan and pwm looses its property to unbin=
d fan
> > > >    when pwm gets unbound.
> > > >    (Its .status changes from DL_STATE_ACTIVE to DL_STATE_AVAILABLE)
> > > >  - It calls pwm_fan_cleanup() which triggers a call to
> > > >    pwm_apply_state().
> > > >
> > > > So when the pwm device gets unbound the first thread is sleeping in
> > > > stm32_pwm_apply(). The driver calls pwmchip_remove() and sets
> > > > priv->regmap to NULL. Then a few seconds later the first thread wak=
es up
> > > > in stm32_pwm_apply() with the chip freed and priv->regmap =3D NULL.=
 Bang!
> > > >
> > > > This looks as follows:
> > > >
> > > > root@crown:~# echo fan > /sys/bus/platform/drivers/pwm-fan/unbind &=
 sleep 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unb=
ind
> > > > [  187.182113] stm32-pwm 40007000.timer:pwm: stm32_pwm_apply:454
> > > > [  188.164769] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:657
> > > > [  188.184555] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:659
> > > > root@crown:~# [  192.236423] platform 40007000.timer:pwm: stm32_pwm=
_apply:456
> > > > [  192.240727] 8<--- cut here ---
> > > > [  192.243759] Unable to handle kernel NULL pointer dereference at =
virtual address 0000001c when read
> > > > ...
> > > >
> > > > Even without the crash you can see that stm32_pwm_apply() is still
> > > > running after pwmchip_remove() completed.
> > > >
> > > > I'm unsure if the device link could be improved here to ensure that=
 the
> > > > fan is completely unbound even if it started unbinding already befo=
re
> > > > the pwm device gets unbound. (And if it could, would this fit the d=
evice
> > > > links purpose and so be a sensible improvement?)
> > >
> > > While I think that there is something to be done in the pwm core that
> > > this doesn't explode (i.e. do proper lifetime tracking such that a
> > > pwm_chip doesn't disappear while still being used---and I'm working o=
n
> > > that) I expected that the device links between pwm consumer and provi=
der
> > > would prevent the above described oops, too. But somehow the fan alre=
ady
> > > going away (but still using the PWM) when the PWM is unbound, results=
 in
> > > the PWM disappearing before the fan is completely gone.
> > >
> > > Is this expected, or a problem that can (and should?) be fixed?
> >
> > I didn't read your full series, but I read this email. With what's in
> > this email, the problem seems to be in the driver or the pwm
> > framework. The pwm driver/framework can't tell the driver core that
> > you successfully unbound (returning from .remove()) before you have
> > finish all your ongoing transactions with the device. If your
> > "apply()" is still running, you need to make sure it's complete before
> > .remove() does any resource releasing/clean up.
> >
> > Also, how is the consumer driver's .remove() succeeding if it has an
> > ongoing pwm call()?
>
> The thing that works fine and as expected is:
>
>  - trigger unbind of PWM device via sysfs
>
> Because there is a device link PWM provider -> pwm consumer (fan), the
> fan is removed and once its gone (and not earlier), the PWM gets unbound.
>
> The failing sequence is:
>
>  - trigger unbind of fan device in userspace thread A via sysfs. The
>    fan's remove callback blocks for 5s in pwm_apply_state() and so
>    .remove() doesn't complete yet.
>
>  - a second later: trigger unbind of PWM device via sysfs in thread B.
>    As before I'd expect that the device link results in waiting for the
>    fan to be removed completely, but the PWM is removed immediately.
>
>  - pwm_apply_state's sleep completes (in thread B) and operates on freed
>    resources =3D> bang!
>
> > This all sounds like insufficient locking and
> > critical region protection in both the consumer and supplier.
>
> My (and I think also Thierry's) expectation was, that the device link
> provides the needed synchronisation. But it doesn't as it doesn't block
> the PWM provider going away until the fan is completely gone.
>
> > Device links can't do anything here because you are giving it wrong
> > info -- that the unbind was successful before it actually is.
>
> The fan's unbind is ongoing, but not complete yet and I'd expect that
> the device link blocks unbinding the PWM until the fan is completely
> gone. So I think there is no wrong information.
>
> > Device links will and can make sure that the consumer is unbound
> > successfully before the unbind is called on the supplier. And it looks
> > like that's still true here.
>
> I hope you understood the situation better now and see the problem we
> have.
>
> The problem is fixable in the pwm framework (and I'm working on that),
> but I think there is also something to improve around devicelink
> handling.

Thanks for a better explanation of the issue. I agree, this seems like
something device links should be able to take care of.

I'll take a look into this.

-Saravana
