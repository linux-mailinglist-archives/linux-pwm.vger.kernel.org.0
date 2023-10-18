Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD387CD1EC
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Oct 2023 03:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjJRBnX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Oct 2023 21:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJRBnW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Oct 2023 21:43:22 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E32C4
        for <linux-pwm@vger.kernel.org>; Tue, 17 Oct 2023 18:43:19 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41b813f0a29so94731cf.0
        for <linux-pwm@vger.kernel.org>; Tue, 17 Oct 2023 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697593399; x=1698198199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3XOKxxquurGZSOnQzPoSk4C7wlMGNqbeb9vnCeu6hI=;
        b=PO0Ihj0CY53NSoplxNftSQqmtcqkft7eBAT6Q84pbz0CZDgp9//sYWOxpNHMDSQF1S
         OCI7bpXPKeR0CYAvvwkJcGn0NcJY0CRZdDejGBktcQfOrMJ8p79JHhcZfugZiJ06lQqD
         W1OOcQBhyLbz+R8WpCLdXvJ5KL2y1YSq2vUbUIe5B9CKM8z92fnWDBKUh+kYVQCe9tSY
         YwHbitxDdzzKq+L07L3QdaY1Z+Ve37n6zW7+untMieJbQG03HuTDywW3C5D5dRm1Za8E
         qR9lk25wMXUQvUVLpmHM0H+Acaziz2P/4GzCayPlqgti972YliexJHsSB592hTLiN7NW
         1L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697593399; x=1698198199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3XOKxxquurGZSOnQzPoSk4C7wlMGNqbeb9vnCeu6hI=;
        b=QUVfm57nm+MQqRrDayV/SeTAxcAurrFDyYggyz0AqgD4R8yE6kBCdd2ul55mXquKB6
         DSWBdZjy0jVFeEvO6ixHN1+SyYcOTcPLBQ6+V8HPRnDXWb2fploz79T66quC3Gk0YU3w
         P7Cp8KONVJzPGuEFaB3kiOQzqc11+MpRbY3wxt3Hu41dRFlDLRvvN4ivYsj2RZTjkqN0
         iim4pdTsfcL7t1QzDPOloC3qWqQG5OYnA52pAG3YtiGCBZjzriYY0C+G+morJSjGQbRo
         NRWwQWLam24Z8MpYXOozNdnIn+hGKwHhb+yc/sRU4pSuejTj/ezs48VomiAWfT+LGtva
         tp6Q==
X-Gm-Message-State: AOJu0Yy4P6Bc+PAUorjztak1Ypyw8AP865YrFATKmHLcoLUsH+i6eG1C
        7ME0cEPLT42DIDWzfiGg5NWYWyxpCbFl2gTUug0lEA==
X-Google-Smtp-Source: AGHT+IE3WujWozv9Yj+V1aEt2eE8euzM5o6q0XZSW2H22O/JhBEkLfP4ikTQg0aKwJ/bwupO2bI7qsdD4Pl3DnpUusc=
X-Received: by 2002:a05:622a:2c4a:b0:41b:8266:5fd0 with SMTP id
 kl10-20020a05622a2c4a00b0041b82665fd0mr148496qtb.14.1697593398885; Tue, 17
 Oct 2023 18:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de> <ZLeX4UbFaY592HIa@orome>
 <20230725211004.peqxxb4y3j62gmnp@pengutronix.de> <20231010080508.7ssnroaefyaeeedd@pengutronix.de>
 <CAGETcx8CNGLnHdWrDpdm4Sx5cFcFFBT2bZKJzNZttAEknFK4Cw@mail.gmail.com>
 <20231014161721.f4iqyroddkcyoefo@pengutronix.de> <CAGETcx-T33-TWmfXxT1dqTt7gWi8E1Z+EXhjpFfdFtpa7h+pQQ@mail.gmail.com>
In-Reply-To: <CAGETcx-T33-TWmfXxT1dqTt7gWi8E1Z+EXhjpFfdFtpa7h+pQQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 17 Oct 2023 18:42:40 -0700
Message-ID: <CAGETcx9Ps5gaMZZk7o6NvrdVte8P=jQeedJw-Ae1NZroo9z-NA@mail.gmail.com>
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
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Android Kernel Team <kernel-team@android.com>
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

On Tue, Oct 17, 2023 at 4:35=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Sat, Oct 14, 2023 at 9:17=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Fri, Oct 13, 2023 at 02:42:20PM -0700, Saravana Kannan wrote:
> > > On Tue, Oct 10, 2023 at 1:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > Hello Saravana,
> > > >
> > > > you were pointed out to me as the expert for device links. I found =
a
> > > > problem with these.
> > > >
> > > > On Tue, Jul 25, 2023 at 11:10:04PM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > Today I managed to trigger the problem I intend to address with t=
his
> > > > > series. My machine to test this on is an stm32mp157. To be able t=
o
> > > > > trigger the problem reliably I applied the following patches on t=
op of
> > > > > v6.5-rc1:
> > > > >
> > > > >  - pwm: stm32: Don't modify HW state in .remove() callback
> > > > >    This is a cleanup that I already sent out.
> > > > >    https://lore.kernel.org/r/20230713155142.2454010-2-u.kleine-ko=
enig@pengutronix.de
> > > > >    The purpose for reproducing the problem is to not trigger furt=
her
> > > > >    calls to the apply callback.
> > > > >
> > > > >  - The following patch:
> > > > >
> > > > > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > > > > index 687967d3265f..c7fc02b0fa3c 100644
> > > > > --- a/drivers/pwm/pwm-stm32.c
> > > > > +++ b/drivers/pwm/pwm-stm32.c
> > > > > @@ -451,6 +451,10 @@ static int stm32_pwm_apply(struct pwm_chip *=
chip, struct pwm_device *pwm,
> > > > >       struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> > > > >       int ret;
> > > > >
> > > > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > > > +     msleep(5000);
> > > > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > > > +
> > > > >       enabled =3D pwm->state.enabled;
> > > > >
> > > > >       if (enabled && !state->enabled) {
> > > > > @@ -650,7 +654,11 @@ static void stm32_pwm_remove(struct platform=
_device *pdev)
> > > > >  {
> > > > >       struct stm32_pwm *priv =3D platform_get_drvdata(pdev);
> > > > >
> > > > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > > > >       pwmchip_remove(&priv->chip);
> > > > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > > > > +
> > > > > +     priv->regmap =3D NULL;
> > > > >  }
> > > > >
> > > > >  static int __maybe_unused stm32_pwm_suspend(struct device *dev)
> > > > >
> > > > > The first hunk is only there to widen the race window. The second=
 is to
> > > > > give some diagnostics and make stm32_pwm_apply() crash if it cont=
inues
> > > > > to run after the msleep. (Without it it didn't crash reproducibly=
, don't
> > > > > understand why. *shrug*)
> > > > >
> > > > > The device tree contains a pwm-fan device making use of one of th=
e PWMs.
> > > > >
> > > > > Now I do the following:
> > > > >
> > > > >       echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & sleep=
 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbind
> > > > >
> > > > > Unbinding the fan device has two effects:
> > > > >
> > > > >  - The device link between fan and pwm looses its property to unb=
ind fan
> > > > >    when pwm gets unbound.
> > > > >    (Its .status changes from DL_STATE_ACTIVE to DL_STATE_AVAILABL=
E)
> > > > >  - It calls pwm_fan_cleanup() which triggers a call to
> > > > >    pwm_apply_state().
> > > > >
> > > > > So when the pwm device gets unbound the first thread is sleeping =
in
> > > > > stm32_pwm_apply(). The driver calls pwmchip_remove() and sets
> > > > > priv->regmap to NULL. Then a few seconds later the first thread w=
akes up
> > > > > in stm32_pwm_apply() with the chip freed and priv->regmap =3D NUL=
L. Bang!
> > > > >
> > > > > This looks as follows:
> > > > >
> > > > > root@crown:~# echo fan > /sys/bus/platform/drivers/pwm-fan/unbind=
 & sleep 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/u=
nbind
> > > > > [  187.182113] stm32-pwm 40007000.timer:pwm: stm32_pwm_apply:454
> > > > > [  188.164769] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:657
> > > > > [  188.184555] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:659
> > > > > root@crown:~# [  192.236423] platform 40007000.timer:pwm: stm32_p=
wm_apply:456
> > > > > [  192.240727] 8<--- cut here ---
> > > > > [  192.243759] Unable to handle kernel NULL pointer dereference a=
t virtual address 0000001c when read
> > > > > ...
> > > > >
> > > > > Even without the crash you can see that stm32_pwm_apply() is stil=
l
> > > > > running after pwmchip_remove() completed.
> > > > >
> > > > > I'm unsure if the device link could be improved here to ensure th=
at the
> > > > > fan is completely unbound even if it started unbinding already be=
fore
> > > > > the pwm device gets unbound. (And if it could, would this fit the=
 device
> > > > > links purpose and so be a sensible improvement?)
> > > >
> > > > While I think that there is something to be done in the pwm core th=
at
> > > > this doesn't explode (i.e. do proper lifetime tracking such that a
> > > > pwm_chip doesn't disappear while still being used---and I'm working=
 on
> > > > that) I expected that the device links between pwm consumer and pro=
vider
> > > > would prevent the above described oops, too. But somehow the fan al=
ready
> > > > going away (but still using the PWM) when the PWM is unbound, resul=
ts in
> > > > the PWM disappearing before the fan is completely gone.
> > > >
> > > > Is this expected, or a problem that can (and should?) be fixed?
> > >
> > > I didn't read your full series, but I read this email. With what's in
> > > this email, the problem seems to be in the driver or the pwm
> > > framework. The pwm driver/framework can't tell the driver core that
> > > you successfully unbound (returning from .remove()) before you have
> > > finish all your ongoing transactions with the device. If your
> > > "apply()" is still running, you need to make sure it's complete befor=
e
> > > .remove() does any resource releasing/clean up.
> > >
> > > Also, how is the consumer driver's .remove() succeeding if it has an
> > > ongoing pwm call()?
> >
> > The thing that works fine and as expected is:
> >
> >  - trigger unbind of PWM device via sysfs
> >
> > Because there is a device link PWM provider -> pwm consumer (fan), the
> > fan is removed and once its gone (and not earlier), the PWM gets unboun=
d.
> >
> > The failing sequence is:
> >
> >  - trigger unbind of fan device in userspace thread A via sysfs. The
> >    fan's remove callback blocks for 5s in pwm_apply_state() and so
> >    .remove() doesn't complete yet.
> >
> >  - a second later: trigger unbind of PWM device via sysfs in thread B.
> >    As before I'd expect that the device link results in waiting for the
> >    fan to be removed completely, but the PWM is removed immediately.
> >
> >  - pwm_apply_state's sleep completes (in thread B) and operates on free=
d
> >    resources =3D> bang!
> >
> > > This all sounds like insufficient locking and
> > > critical region protection in both the consumer and supplier.
> >
> > My (and I think also Thierry's) expectation was, that the device link
> > provides the needed synchronisation. But it doesn't as it doesn't block
> > the PWM provider going away until the fan is completely gone.
> >
> > > Device links can't do anything here because you are giving it wrong
> > > info -- that the unbind was successful before it actually is.
> >
> > The fan's unbind is ongoing, but not complete yet and I'd expect that
> > the device link blocks unbinding the PWM until the fan is completely
> > gone. So I think there is no wrong information.
> >
> > > Device links will and can make sure that the consumer is unbound
> > > successfully before the unbind is called on the supplier. And it look=
s
> > > like that's still true here.
> >
> > I hope you understood the situation better now and see the problem we
> > have.
> >
> > The problem is fixable in the pwm framework (and I'm working on that),
> > but I think there is also something to improve around devicelink
> > handling.
>
> Thanks for a better explanation of the issue. I agree, this seems like
> something device links should be able to take care of.
>
> I'll take a look into this.

Took me a while to debug this because I couldn't find the .remove()
function and I was very confused about what's going on.
I'm guessing you started hitting this issue only after moving to the
devm_ variant of the pwm APIs.

I think I have a fix.
https://lore.kernel.org/lkml/20231018013851.3303928-1-saravanak@google.com/=
T/#u

I didn't even compile test it, but it's a trivial change. Can you
please test it out and give your "tested-by" if it fixes your issue?

Thanks,
Saravana
