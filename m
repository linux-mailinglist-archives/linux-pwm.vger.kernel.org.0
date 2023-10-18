Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F487CEB20
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Oct 2023 00:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjJRW0B (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Oct 2023 18:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRWZ7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Oct 2023 18:25:59 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590C5D44
        for <linux-pwm@vger.kernel.org>; Wed, 18 Oct 2023 15:25:56 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41b19dda4c6so46891cf.1
        for <linux-pwm@vger.kernel.org>; Wed, 18 Oct 2023 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697667955; x=1698272755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+/KR19rIuPvaDSW1/4YJbqKG2O1JJ+lf2SeOzgYQ78=;
        b=tLDWhri4hNQ+ub8X+UQQbVkvVL8DsEsLROcggVScYaCaYiEurZZtoGtxIy5sKnR/8i
         a9kMF+tc/ljmYvMvH5TE0ktuADmfiieNkbQt/xulB1N0TiPnYQjlhaCdSqla0QZTeNju
         xQlO4aayv+h3MASdSxyimb6hN7lQ+7iy+cTbqWUaIlGmdF2TefPoQh2qZHNpzJwIcX48
         35oRZ/MQiaLi213WiSv4yaSjDQvJ06JvGXRL+LT7PA0UwQY6ewpPMGE98R2LrceqAWcP
         xycfs0OqtCpgwWwNZrUqtuRzx2iEU54pc2XRkyAJhV4V5M+UG4wZllFDLkiKIhhboRdB
         Be7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667955; x=1698272755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+/KR19rIuPvaDSW1/4YJbqKG2O1JJ+lf2SeOzgYQ78=;
        b=MU/YpKYLFrjSqEacULLoLs2tLYcsZFmXVjz9f7E3AlIJC7n+Fi7LCgugZ/ImR0Ukp9
         PPWvkDHfCLZ+zN4TC8OrIuz1aoBWjHAEiErq5hgvpsEz7uXE/s1N/ig3va3UkptoV8an
         CF+4u0ShhWuRb3Swiw6WqQAp++x0+O+zLzxdHkrGq93vEkfPT/zVpaYGOlSGeAJ7wVx5
         ceMQbwSjC62rC2ujtRGlbK3V+/RLqdARTzDTZcu41YbQ/+lfWUBraL1IgtaXoZF6am/o
         OnHyDoPczFDcEYqyMadgvQNMxcoLMamRInGM1GWQhOR8UUZNSJFNjFIgdOGfuRQUZQv3
         GdIA==
X-Gm-Message-State: AOJu0Yy0zLlW0UMJ2Kf+UGBlBwCnfLXIAtNzI1N2oUl3FdR8pDlZZWma
        VY3Ro6/L28DS+VKXBKdsGb2nS+J0FDe8g0QuYq4imQ==
X-Google-Smtp-Source: AGHT+IHMNOvFgZ3W8YJi5w9LnOTVtmHtCY5RXuMJEIdz+KTZ25YaSr+twHLtH8f8mf0DEjKEO03nNXBAA8RPVr0JEEE=
X-Received: by 2002:ac8:4e37:0:b0:419:77b7:da5f with SMTP id
 d23-20020ac84e37000000b0041977b7da5fmr55233qtw.11.1697667954961; Wed, 18 Oct
 2023 15:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
 <ZLeX4UbFaY592HIa@orome> <20230725211004.peqxxb4y3j62gmnp@pengutronix.de>
 <20231010080508.7ssnroaefyaeeedd@pengutronix.de> <CAGETcx8CNGLnHdWrDpdm4Sx5cFcFFBT2bZKJzNZttAEknFK4Cw@mail.gmail.com>
 <20231014161721.f4iqyroddkcyoefo@pengutronix.de> <CAGETcx-T33-TWmfXxT1dqTt7gWi8E1Z+EXhjpFfdFtpa7h+pQQ@mail.gmail.com>
 <CAGETcx9Ps5gaMZZk7o6NvrdVte8P=jQeedJw-Ae1NZroo9z-NA@mail.gmail.com>
 <20231018111747.alk3lkw7v7gl632k@pengutronix.de> <CAGETcx9+-MkF9kKoP_LxwtLYVEmzDS8twASrMPo1=0XpHw0OxA@mail.gmail.com>
 <20231018212054.cjwhjx4fevip2kjt@pengutronix.de>
In-Reply-To: <20231018212054.cjwhjx4fevip2kjt@pengutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 18 Oct 2023 15:25:19 -0700
Message-ID: <CAGETcx9m4GFaybcvD5JqFS8m2CKYJHAsBcCOTCi5NeP81U7e1g@mail.gmail.com>
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 18, 2023 at 2:21=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Wed, Oct 18, 2023 at 02:01:30PM -0700, Saravana Kannan wrote:
> > On Wed, Oct 18, 2023 at 4:17=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Tue, Oct 17, 2023 at 06:42:40PM -0700, Saravana Kannan wrote:
> > > > On Tue, Oct 17, 2023 at 4:35=E2=80=AFPM Saravana Kannan <saravanak@=
google.com> wrote:
> > > > >
> > > > > On Sat, Oct 14, 2023 at 9:17=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > >
> > > > > > On Fri, Oct 13, 2023 at 02:42:20PM -0700, Saravana Kannan wrote=
:
> > > > > > > On Tue, Oct 10, 2023 at 1:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > > >
> > > > > > > > Hello Saravana,
> > > > > > > >
> > > > > > > > you were pointed out to me as the expert for device links. =
I found a
> > > > > > > > problem with these.
> > > > > > > >
> > > > > > > > On Tue, Jul 25, 2023 at 11:10:04PM +0200, Uwe Kleine-K=C3=
=B6nig wrote:
> > > > > > > > > Today I managed to trigger the problem I intend to addres=
s with this
> > > > > > > > > series. My machine to test this on is an stm32mp157. To b=
e able to
> > > > > > > > > trigger the problem reliably I applied the following patc=
hes on top of
> > > > > > > > > v6.5-rc1:
> > > > > > > > >
> > > > > > > > >  - pwm: stm32: Don't modify HW state in .remove() callbac=
k
> > > > > > > > >    This is a cleanup that I already sent out.
> > > > > > > > >    https://lore.kernel.org/r/20230713155142.2454010-2-u.k=
leine-koenig@pengutronix.de
> > > > > > > > >    The purpose for reproducing the problem is to not trig=
ger further
> > > > > > > > >    calls to the apply callback.
> > > > > > > > >
> > > > > > > > >  - The following patch:
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-st=
m32.c
> > > > > > > > > index 687967d3265f..c7fc02b0fa3c 100644
> > > > > > > > > --- a/drivers/pwm/pwm-stm32.c
> > > > > > > > > +++ b/drivers/pwm/pwm-stm32.c
> > > > > > > > > @@ -451,6 +451,10 @@ static int stm32_pwm_apply(struct pw=
m_chip *chip, struct pwm_device *pwm,
> > > > > > > > >       struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> > > > > > > > >       int ret;
> > > > > > > > >
> > > > > > > > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > > > > > > > +     msleep(5000);
> > > > > > > > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > > > > > > > +
> > > > > > > > >       enabled =3D pwm->state.enabled;
> > > > > > > > >
> > > > > > > > >       if (enabled && !state->enabled) {
> > > > > > > > > @@ -650,7 +654,11 @@ static void stm32_pwm_remove(struct =
platform_device *pdev)
> > > > > > > > >  {
> > > > > > > > >       struct stm32_pwm *priv =3D platform_get_drvdata(pde=
v);
> > > > > > > > >
> > > > > > > > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__)=
;
> > > > > > > > >       pwmchip_remove(&priv->chip);
> > > > > > > > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__)=
;
> > > > > > > > > +
> > > > > > > > > +     priv->regmap =3D NULL;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static int __maybe_unused stm32_pwm_suspend(struct devic=
e *dev)
> > > > > > > > >
> > > > > > > > > The first hunk is only there to widen the race window. Th=
e second is to
> > > > > > > > > give some diagnostics and make stm32_pwm_apply() crash if=
 it continues
> > > > > > > > > to run after the msleep. (Without it it didn't crash repr=
oducibly, don't
> > > > > > > > > understand why. *shrug*)
> > > > > > > > >
> > > > > > > > > The device tree contains a pwm-fan device making use of o=
ne of the PWMs.
> > > > > > > > >
> > > > > > > > > Now I do the following:
> > > > > > > > >
> > > > > > > > >       echo fan > /sys/bus/platform/drivers/pwm-fan/unbind=
 & sleep 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/u=
nbind
> > > > > > > > >
> > > > > > > > > Unbinding the fan device has two effects:
> > > > > > > > >
> > > > > > > > >  - The device link between fan and pwm looses its propert=
y to unbind fan
> > > > > > > > >    when pwm gets unbound.
> > > > > > > > >    (Its .status changes from DL_STATE_ACTIVE to DL_STATE_=
AVAILABLE)
> > > > > > > > >  - It calls pwm_fan_cleanup() which triggers a call to
> > > > > > > > >    pwm_apply_state().
> > > > > > > > >
> > > > > > > > > So when the pwm device gets unbound the first thread is s=
leeping in
> > > > > > > > > stm32_pwm_apply(). The driver calls pwmchip_remove() and =
sets
> > > > > > > > > priv->regmap to NULL. Then a few seconds later the first =
thread wakes up
> > > > > > > > > in stm32_pwm_apply() with the chip freed and priv->regmap=
 =3D NULL. Bang!
> > > > > > > > >
> > > > > > > > > This looks as follows:
> > > > > > > > >
> > > > > > > > > root@crown:~# echo fan > /sys/bus/platform/drivers/pwm-fa=
n/unbind & sleep 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm=
32-pwm/unbind
> > > > > > > > > [  187.182113] stm32-pwm 40007000.timer:pwm: stm32_pwm_ap=
ply:454
> > > > > > > > > [  188.164769] stm32-pwm 40007000.timer:pwm: stm32_pwm_re=
move:657
> > > > > > > > > [  188.184555] stm32-pwm 40007000.timer:pwm: stm32_pwm_re=
move:659
> > > > > > > > > root@crown:~# [  192.236423] platform 40007000.timer:pwm:=
 stm32_pwm_apply:456
> > > > > > > > > [  192.240727] 8<--- cut here ---
> > > > > > > > > [  192.243759] Unable to handle kernel NULL pointer deref=
erence at virtual address 0000001c when read
> > > > > > > > > ...
> > > > > > > > >
> > > > > > > > > Even without the crash you can see that stm32_pwm_apply()=
 is still
> > > > > > > > > running after pwmchip_remove() completed.
> > > > > > > > >
> > > > > > > > > I'm unsure if the device link could be improved here to e=
nsure that the
> > > > > > > > > fan is completely unbound even if it started unbinding al=
ready before
> > > > > > > > > the pwm device gets unbound. (And if it could, would this=
 fit the device
> > > > > > > > > links purpose and so be a sensible improvement?)
> > > > > > > >
> > > > > > > > While I think that there is something to be done in the pwm=
 core that
> > > > > > > > this doesn't explode (i.e. do proper lifetime tracking such=
 that a
> > > > > > > > pwm_chip doesn't disappear while still being used---and I'm=
 working on
> > > > > > > > that) I expected that the device links between pwm consumer=
 and provider
> > > > > > > > would prevent the above described oops, too. But somehow th=
e fan already
> > > > > > > > going away (but still using the PWM) when the PWM is unboun=
d, results in
> > > > > > > > the PWM disappearing before the fan is completely gone.
> > > > > > > >
> > > > > > > > Is this expected, or a problem that can (and should?) be fi=
xed?
> > > > > > >
> > > > > > > I didn't read your full series, but I read this email. With w=
hat's in
> > > > > > > this email, the problem seems to be in the driver or the pwm
> > > > > > > framework. The pwm driver/framework can't tell the driver cor=
e that
> > > > > > > you successfully unbound (returning from .remove()) before yo=
u have
> > > > > > > finish all your ongoing transactions with the device. If your
> > > > > > > "apply()" is still running, you need to make sure it's comple=
te before
> > > > > > > .remove() does any resource releasing/clean up.
> > > > > > >
> > > > > > > Also, how is the consumer driver's .remove() succeeding if it=
 has an
> > > > > > > ongoing pwm call()?
> > > > > >
> > > > > > The thing that works fine and as expected is:
> > > > > >
> > > > > >  - trigger unbind of PWM device via sysfs
> > > > > >
> > > > > > Because there is a device link PWM provider -> pwm consumer (fa=
n), the
> > > > > > fan is removed and once its gone (and not earlier), the PWM get=
s unbound.
> > > > > >
> > > > > > The failing sequence is:
> > > > > >
> > > > > >  - trigger unbind of fan device in userspace thread A via sysfs=
. The
> > > > > >    fan's remove callback blocks for 5s in pwm_apply_state() and=
 so
> > > > > >    .remove() doesn't complete yet.
> > > > > >
> > > > > >  - a second later: trigger unbind of PWM device via sysfs in th=
read B.
> > > > > >    As before I'd expect that the device link results in waiting=
 for the
> > > > > >    fan to be removed completely, but the PWM is removed immedia=
tely.
> > > > > >
> > > > > >  - pwm_apply_state's sleep completes (in thread B) and operates=
 on freed
> > > > > >    resources =3D> bang!
> > > > > >
> > > > > > > This all sounds like insufficient locking and
> > > > > > > critical region protection in both the consumer and supplier.
> > > > > >
> > > > > > My (and I think also Thierry's) expectation was, that the devic=
e link
> > > > > > provides the needed synchronisation. But it doesn't as it doesn=
't block
> > > > > > the PWM provider going away until the fan is completely gone.
> > > > > >
> > > > > > > Device links can't do anything here because you are giving it=
 wrong
> > > > > > > info -- that the unbind was successful before it actually is.
> > > > > >
> > > > > > The fan's unbind is ongoing, but not complete yet and I'd expec=
t that
> > > > > > the device link blocks unbinding the PWM until the fan is compl=
etely
> > > > > > gone. So I think there is no wrong information.
> > > > > >
> > > > > > > Device links will and can make sure that the consumer is unbo=
und
> > > > > > > successfully before the unbind is called on the supplier. And=
 it looks
> > > > > > > like that's still true here.
> > > > > >
> > > > > > I hope you understood the situation better now and see the prob=
lem we
> > > > > > have.
> > > > > >
> > > > > > The problem is fixable in the pwm framework (and I'm working on=
 that),
> > > > > > but I think there is also something to improve around devicelin=
k
> > > > > > handling.
> > > > >
> > > > > Thanks for a better explanation of the issue. I agree, this seems=
 like
> > > > > something device links should be able to take care of.
> > > > >
> > > > > I'll take a look into this.
> > > >
> > > > Took me a while to debug this because I couldn't find the .remove()
> > > > function and I was very confused about what's going on.
> > > > I'm guessing you started hitting this issue only after moving to th=
e
> > > > devm_ variant of the pwm APIs.
> > >
> > > Ah I see. That problem wouldn't happen if the fan called a pwm API
> > > function in its remove callback but that happens in a devm cleanup ca=
ll
> > > (registered by devm_add_action_or_reset(dev, pwm_fan_cleanup, ctx) in
> > > pwm_fan_probe()). I first thought you talked about
> > > 8c89fd866ad221af037ef0ec3d60b83d0b859c65.
> >
> > Am I not talking about that commit?
>
> The relevant thing is that the fan (i.e. the consumer) uses
> pwm_apply_state() in a devm cleanup. If the pwm provider uses
> devm_pwmchip_add or plain pwmchip_add + pwmchip_remove in .remove()
> doesn't matter.

Duh! For whatever reason I had forgotten that stm32 was the supplier
and was confusing myself.

>
> > Btw, I'm still a bit confused by this thread. In your earlier emails
> > to me, you said:
> >
> > >  - trigger unbind of fan device in userspace thread A via sysfs. The
> > >  fan's remove callback blocks for 5s in pwm_apply_state() and so
> > >  .remove() doesn't complete yet.
> >
> > But the latest tree (Tot) didn't have any .remove() function at all.
> > So I just decided to see if there's any issue in Tot and just fix
> > that. I'm glad my fix helps fixed the issue with the used of devm_*()
> > APIs.
>
> I was sloppy here and called it "remove callback" when it was really a
> devm cleanup call. Sorry if that confused you. I didn't expect this to
> make a difference (and I'm not even sure I was aware this is a devm
> cleanup and not directly .remove() when I wrote that).
>
> > However, are you really seeing the issue (supplier freed before
> > consumer) if you do the clean up in the .remove() function? If so,
> > there might still be another issue that needs to be fixed.
>
> I didn't test that and now having understood the issue you fixed and
> seeing the effect, I confidently claim there is nothing to fix for
> drivers that use pwm_apply_state in .remove().

Yeah, I'm convinced now too!

-Saravana
