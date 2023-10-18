Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2A47CE9C9
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Oct 2023 23:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbjJRVLd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Oct 2023 17:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344764AbjJRVLQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Oct 2023 17:11:16 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA2E3862
        for <linux-pwm@vger.kernel.org>; Wed, 18 Oct 2023 14:02:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41b19dda4c6so25721cf.1
        for <linux-pwm@vger.kernel.org>; Wed, 18 Oct 2023 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697662927; x=1698267727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbO9m+81OSAJDbr8WH3dF9lXFW8TPVXH2ke44rVjrlo=;
        b=ve11l/lHQ3KlVai8DYzyfYVOHAgB1sO2Q3q/Wp4X/1K8AJ8Fax2yQvTcD5uNo6er6K
         GLBPg1FDFBK475bTU+uKrRMVnwoTU4iFNe+QnKtuAkq98L36rYyye0SVqgaLARk6WZcM
         u9SLNxLeJZagw5CHCUUhvE+t4j00zk0FnvlGR8kt7wAOGzyHDeZCbFuOgKLqw1OUqwjn
         FrJWdowRRolkC3e612sJO9QtuKNU1/vXr4eQ+XEVdMyoi5sJM938hOLb+Kmj3swnaoHN
         7op3GdhyRargl01Y2PVD+d7UZh/THlhaYaf1LO2H8XWMWlIRJqg5jQgL5rkH81TneYDB
         ueNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662927; x=1698267727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbO9m+81OSAJDbr8WH3dF9lXFW8TPVXH2ke44rVjrlo=;
        b=HOfyYFVh4I9kMcYb8+eDKVouTSftTgqgGrxxs9iUTPHAPEOR+dokR2dhGE9gg+LOGu
         XR/0GPMLb4n6hL1N+TSj3szS3CNf2GlDfXRFyiFGfOfwGuYThZ5jcb610JK9nZCgYXZh
         vIxoUmRHb6EwngypDqlE57x6SoavQci1iAYB7dRy0ZfhF54wEr2+9LwldfNwdJdIMH2E
         jyDzyIHZoR/kpjR6Bg775kAa41z4dGYvXRT9QDbAn8msEJqgJ7jJ3PtU3FNz8MU9nfPu
         uniCrOslaKzQPbPjPuv9oWmT0Z0CyvbArzs5GwqfHHsAAJr/VONoyg800cq6B0FR/ULY
         DqpQ==
X-Gm-Message-State: AOJu0YwbB6hh5BfiuxhfOL1wmSaRzroTqukL7rhv14TBXDRmy7923wXj
        DoxH+BBOXud7T8tXaKfWmc3+3FxNVFc3r5QjpLLtLg==
X-Google-Smtp-Source: AGHT+IFzy89Kjop7zge4aXi/4AoVSXx3+pu1yym3FaPV/fP5MdMQIWq0LWDNSWSPya2+Ez6//8jyCagtH+WQl8vy37w=
X-Received: by 2002:a05:622a:6dc2:b0:416:6784:bd60 with SMTP id
 ir2-20020a05622a6dc200b004166784bd60mr25706qtb.21.1697662927095; Wed, 18 Oct
 2023 14:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de> <ZLeX4UbFaY592HIa@orome>
 <20230725211004.peqxxb4y3j62gmnp@pengutronix.de> <20231010080508.7ssnroaefyaeeedd@pengutronix.de>
 <CAGETcx8CNGLnHdWrDpdm4Sx5cFcFFBT2bZKJzNZttAEknFK4Cw@mail.gmail.com>
 <20231014161721.f4iqyroddkcyoefo@pengutronix.de> <CAGETcx-T33-TWmfXxT1dqTt7gWi8E1Z+EXhjpFfdFtpa7h+pQQ@mail.gmail.com>
 <CAGETcx9Ps5gaMZZk7o6NvrdVte8P=jQeedJw-Ae1NZroo9z-NA@mail.gmail.com> <20231018111747.alk3lkw7v7gl632k@pengutronix.de>
In-Reply-To: <20231018111747.alk3lkw7v7gl632k@pengutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 18 Oct 2023 14:01:30 -0700
Message-ID: <CAGETcx9+-MkF9kKoP_LxwtLYVEmzDS8twASrMPo1=0XpHw0OxA@mail.gmail.com>
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Android Kernel Team <kernel-team@android.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 18, 2023 at 4:17=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Oct 17, 2023 at 06:42:40PM -0700, Saravana Kannan wrote:
> > On Tue, Oct 17, 2023 at 4:35=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > >
> > > On Sat, Oct 14, 2023 at 9:17=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > On Fri, Oct 13, 2023 at 02:42:20PM -0700, Saravana Kannan wrote:
> > > > > On Tue, Oct 10, 2023 at 1:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > >
> > > > > > Hello Saravana,
> > > > > >
> > > > > > you were pointed out to me as the expert for device links. I fo=
und a
> > > > > > problem with these.
> > > > > >
> > > > > > On Tue, Jul 25, 2023 at 11:10:04PM +0200, Uwe Kleine-K=C3=B6nig=
 wrote:
> > > > > > > Today I managed to trigger the problem I intend to address wi=
th this
> > > > > > > series. My machine to test this on is an stm32mp157. To be ab=
le to
> > > > > > > trigger the problem reliably I applied the following patches =
on top of
> > > > > > > v6.5-rc1:
> > > > > > >
> > > > > > >  - pwm: stm32: Don't modify HW state in .remove() callback
> > > > > > >    This is a cleanup that I already sent out.
> > > > > > >    https://lore.kernel.org/r/20230713155142.2454010-2-u.klein=
e-koenig@pengutronix.de
> > > > > > >    The purpose for reproducing the problem is to not trigger =
further
> > > > > > >    calls to the apply callback.
> > > > > > >
> > > > > > >  - The following patch:
> > > > > > >
> > > > > > > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.=
c
> > > > > > > index 687967d3265f..c7fc02b0fa3c 100644
> > > > > > > --- a/drivers/pwm/pwm-stm32.c
> > > > > > > +++ b/drivers/pwm/pwm-stm32.c
> > > > > > > @@ -451,6 +451,10 @@ static int stm32_pwm_apply(struct pwm_ch=
ip *chip, struct pwm_device *pwm,
> > > > > > >       struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> > > > > > >       int ret;
> > > > > > >
> > > > > > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > > > > > +     msleep(5000);
> > > > > > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > > > > > +
> > > > > > >       enabled =3D pwm->state.enabled;
> > > > > > >
> > > > > > >       if (enabled && !state->enabled) {
> > > > > > > @@ -650,7 +654,11 @@ static void stm32_pwm_remove(struct plat=
form_device *pdev)
> > > > > > >  {
> > > > > > >       struct stm32_pwm *priv =3D platform_get_drvdata(pdev);
> > > > > > >
> > > > > > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > > > > > >       pwmchip_remove(&priv->chip);
> > > > > > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > > > > > > +
> > > > > > > +     priv->regmap =3D NULL;
> > > > > > >  }
> > > > > > >
> > > > > > >  static int __maybe_unused stm32_pwm_suspend(struct device *d=
ev)
> > > > > > >
> > > > > > > The first hunk is only there to widen the race window. The se=
cond is to
> > > > > > > give some diagnostics and make stm32_pwm_apply() crash if it =
continues
> > > > > > > to run after the msleep. (Without it it didn't crash reproduc=
ibly, don't
> > > > > > > understand why. *shrug*)
> > > > > > >
> > > > > > > The device tree contains a pwm-fan device making use of one o=
f the PWMs.
> > > > > > >
> > > > > > > Now I do the following:
> > > > > > >
> > > > > > >       echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & s=
leep 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbin=
d
> > > > > > >
> > > > > > > Unbinding the fan device has two effects:
> > > > > > >
> > > > > > >  - The device link between fan and pwm looses its property to=
 unbind fan
> > > > > > >    when pwm gets unbound.
> > > > > > >    (Its .status changes from DL_STATE_ACTIVE to DL_STATE_AVAI=
LABLE)
> > > > > > >  - It calls pwm_fan_cleanup() which triggers a call to
> > > > > > >    pwm_apply_state().
> > > > > > >
> > > > > > > So when the pwm device gets unbound the first thread is sleep=
ing in
> > > > > > > stm32_pwm_apply(). The driver calls pwmchip_remove() and sets
> > > > > > > priv->regmap to NULL. Then a few seconds later the first thre=
ad wakes up
> > > > > > > in stm32_pwm_apply() with the chip freed and priv->regmap =3D=
 NULL. Bang!
> > > > > > >
> > > > > > > This looks as follows:
> > > > > > >
> > > > > > > root@crown:~# echo fan > /sys/bus/platform/drivers/pwm-fan/un=
bind & sleep 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-p=
wm/unbind
> > > > > > > [  187.182113] stm32-pwm 40007000.timer:pwm: stm32_pwm_apply:=
454
> > > > > > > [  188.164769] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove=
:657
> > > > > > > [  188.184555] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove=
:659
> > > > > > > root@crown:~# [  192.236423] platform 40007000.timer:pwm: stm=
32_pwm_apply:456
> > > > > > > [  192.240727] 8<--- cut here ---
> > > > > > > [  192.243759] Unable to handle kernel NULL pointer dereferen=
ce at virtual address 0000001c when read
> > > > > > > ...
> > > > > > >
> > > > > > > Even without the crash you can see that stm32_pwm_apply() is =
still
> > > > > > > running after pwmchip_remove() completed.
> > > > > > >
> > > > > > > I'm unsure if the device link could be improved here to ensur=
e that the
> > > > > > > fan is completely unbound even if it started unbinding alread=
y before
> > > > > > > the pwm device gets unbound. (And if it could, would this fit=
 the device
> > > > > > > links purpose and so be a sensible improvement?)
> > > > > >
> > > > > > While I think that there is something to be done in the pwm cor=
e that
> > > > > > this doesn't explode (i.e. do proper lifetime tracking such tha=
t a
> > > > > > pwm_chip doesn't disappear while still being used---and I'm wor=
king on
> > > > > > that) I expected that the device links between pwm consumer and=
 provider
> > > > > > would prevent the above described oops, too. But somehow the fa=
n already
> > > > > > going away (but still using the PWM) when the PWM is unbound, r=
esults in
> > > > > > the PWM disappearing before the fan is completely gone.
> > > > > >
> > > > > > Is this expected, or a problem that can (and should?) be fixed?
> > > > >
> > > > > I didn't read your full series, but I read this email. With what'=
s in
> > > > > this email, the problem seems to be in the driver or the pwm
> > > > > framework. The pwm driver/framework can't tell the driver core th=
at
> > > > > you successfully unbound (returning from .remove()) before you ha=
ve
> > > > > finish all your ongoing transactions with the device. If your
> > > > > "apply()" is still running, you need to make sure it's complete b=
efore
> > > > > .remove() does any resource releasing/clean up.
> > > > >
> > > > > Also, how is the consumer driver's .remove() succeeding if it has=
 an
> > > > > ongoing pwm call()?
> > > >
> > > > The thing that works fine and as expected is:
> > > >
> > > >  - trigger unbind of PWM device via sysfs
> > > >
> > > > Because there is a device link PWM provider -> pwm consumer (fan), =
the
> > > > fan is removed and once its gone (and not earlier), the PWM gets un=
bound.
> > > >
> > > > The failing sequence is:
> > > >
> > > >  - trigger unbind of fan device in userspace thread A via sysfs. Th=
e
> > > >    fan's remove callback blocks for 5s in pwm_apply_state() and so
> > > >    .remove() doesn't complete yet.
> > > >
> > > >  - a second later: trigger unbind of PWM device via sysfs in thread=
 B.
> > > >    As before I'd expect that the device link results in waiting for=
 the
> > > >    fan to be removed completely, but the PWM is removed immediately=
.
> > > >
> > > >  - pwm_apply_state's sleep completes (in thread B) and operates on =
freed
> > > >    resources =3D> bang!
> > > >
> > > > > This all sounds like insufficient locking and
> > > > > critical region protection in both the consumer and supplier.
> > > >
> > > > My (and I think also Thierry's) expectation was, that the device li=
nk
> > > > provides the needed synchronisation. But it doesn't as it doesn't b=
lock
> > > > the PWM provider going away until the fan is completely gone.
> > > >
> > > > > Device links can't do anything here because you are giving it wro=
ng
> > > > > info -- that the unbind was successful before it actually is.
> > > >
> > > > The fan's unbind is ongoing, but not complete yet and I'd expect th=
at
> > > > the device link blocks unbinding the PWM until the fan is completel=
y
> > > > gone. So I think there is no wrong information.
> > > >
> > > > > Device links will and can make sure that the consumer is unbound
> > > > > successfully before the unbind is called on the supplier. And it =
looks
> > > > > like that's still true here.
> > > >
> > > > I hope you understood the situation better now and see the problem =
we
> > > > have.
> > > >
> > > > The problem is fixable in the pwm framework (and I'm working on tha=
t),
> > > > but I think there is also something to improve around devicelink
> > > > handling.
> > >
> > > Thanks for a better explanation of the issue. I agree, this seems lik=
e
> > > something device links should be able to take care of.
> > >
> > > I'll take a look into this.
> >
> > Took me a while to debug this because I couldn't find the .remove()
> > function and I was very confused about what's going on.
> > I'm guessing you started hitting this issue only after moving to the
> > devm_ variant of the pwm APIs.
>
> Ah I see. That problem wouldn't happen if the fan called a pwm API
> function in its remove callback but that happens in a devm cleanup call
> (registered by devm_add_action_or_reset(dev, pwm_fan_cleanup, ctx) in
> pwm_fan_probe()). I first thought you talked about
> 8c89fd866ad221af037ef0ec3d60b83d0b859c65.

Am I not talking about that commit?

Btw, I'm still a bit confused by this thread. In your earlier emails
to me, you said:

>  - trigger unbind of fan device in userspace thread A via sysfs. The
>  fan's remove callback blocks for 5s in pwm_apply_state() and so
>  .remove() doesn't complete yet.

But the latest tree (Tot) didn't have any .remove() function at all.
So I just decided to see if there's any issue in Tot and just fix
that. I'm glad my fix helps fixed the issue with the used of devm_*()
APIs.

However, are you really seeing the issue (supplier freed before
consumer) if you do the clean up in the .remove() function? If so,
there might still be another issue that needs to be fixed.

Thanks,
Saravana
