Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A38C18E994
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2019 13:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfHOLGH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Aug 2019 07:06:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45654 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOLGH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Aug 2019 07:06:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id m24so4907985otp.12
        for <linux-pwm@vger.kernel.org>; Thu, 15 Aug 2019 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XTtM2IKBiBw7u5W/pJGh0ladnUVrx5mRQB0sY1wPIks=;
        b=tn0g8NmJP1BGzEBCyi3AivIBNiNL/5tLWT3S22t+OLqRJAppPCU+KjZrWzvdJBwM4A
         6/qEM8zdcqZRUE7Lv9aPq1Es63/kfaNicpuW1hilOYDzH7OZ+8LnKsFTRR8XJRG0Fz04
         ZHGkW2F8SSt5fOLD7pQtj5z/Ydsr+S9g/x2EPeYByHZFY0iuAS/4GJdRUN48UKW6flZM
         /uSh6DjA3jlJSjlxoVC2Zyz5NFSJNzuLimGbwmeNvMULLf06ZS5U2ox5J7YRVs42/bSG
         gRZvJYmpUTMaMqfPjreqdev+IfPs5UPGXQuTnic6Csfj+9Z3txVK2J7XKiFbaw6WIOwE
         84Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTtM2IKBiBw7u5W/pJGh0ladnUVrx5mRQB0sY1wPIks=;
        b=Z1PDE4Q5Qhc2/Ffh6YBJr4RVFLrZ6BXO0r2IrCUPJL+zsn4/V8y5AgKQG63NeXcIX2
         /l62nHwxCtgeyDwwagffr3miWUKCfBUTtEQYC/zk3HtN4U13JGtQmm0tj+Z7FSWGHBoo
         Zw1uU6VA1xjpnJYECxHWB8e8jxYqh7Weiean8fNqxORcugH/ihIW5JftmnhwfZqyPkZ7
         6dw4o6IAgdy9vF2wHiDyc7lBE9AHj6iNTGV6KRcIMhech3m2x5RkmM9vAX61XHoxsal7
         BEHibhBVWogWOw0CP0FdGs75wFHSgZPFR7xRyn+oKWGNvp28Sr7desTjYejoFja9mkzX
         9Emg==
X-Gm-Message-State: APjAAAXpSlEwr6o06ZjguuFNMwkkS9H/owHuztBRUups83sgQPvyw9de
        3395u6PEuFzGgcI5YCc0efm8DOodCaqfEGLgO11/TQ==
X-Google-Smtp-Source: APXvYqzVjAyz7lrBUitI+br7jmLnCJvIHFhQNR0FULILz2Y8YewsVFYoqRJSLGGL6k0KJ3PhFxGSVCLFjpgJxgMLEHA=
X-Received: by 2002:a9d:63d7:: with SMTP id e23mr2753358otl.269.1565867165330;
 Thu, 15 Aug 2019 04:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
 <446eb284a096a1fd8998765669b1c9a2f78d7d22.1565785291.git.baolin.wang@linaro.org>
 <20190814150304.x44lalde3cwp67ge@pengutronix.de> <CAMz4kuLiS=cGTA=uEi9ABOVAOb1M0Pcd2a_xU5VsdLo1DGd0Hg@mail.gmail.com>
 <20190815061540.763ue2ogkvuyhzcu@pengutronix.de> <CAMz4kuL_74V3M-8Zo99GnLaYbmgfQXO-h0Yz5qeXLQQ0ZR3TkA@mail.gmail.com>
 <20190815085452.2cipewq3l3krnwzv@pengutronix.de> <CAMz4kuJs7pCXWyWd_WMK24JeLOzdVC8zPacRTp91nyTYDDdk5g@mail.gmail.com>
 <20190815101147.azbbjcvafwjx67wc@pengutronix.de>
In-Reply-To: <20190815101147.azbbjcvafwjx67wc@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 15 Aug 2019 19:05:53 +0800
Message-ID: <CAMz4ku+AAGC6TgxOA5EZGFeqpsq_Q8=S+DkDk9Rm_G=yAshJ0w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sprd: Add Spreadtrum PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 15 Aug 2019 at 18:11, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Thu, Aug 15, 2019 at 05:34:02PM +0800, Baolin Wang wrote:
> > On Thu, 15 Aug 2019 at 16:54, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Thu, Aug 15, 2019 at 04:16:32PM +0800, Baolin Wang wrote:
> > > > On Thu, 15 Aug 2019 at 14:15, Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > On Thu, Aug 15, 2019 at 11:34:27AM +0800, Baolin Wang wrote:
> > > > > > On Wed, 14 Aug 2019 at 23:03, Uwe Kleine-K=C3=B6nig
> > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > > On Wed, Aug 14, 2019 at 08:46:11PM +0800, Baolin Wang wrote:
> > > > > > > > +     /*
> > > > > > > > +      * The hardware provides a counter that is feed by th=
e source clock.
> > > > > > > > +      * The period length is (PRESCALE + 1) * MOD counter =
steps.
> > > > > > > > +      * The duty cycle length is (PRESCALE + 1) * DUTY cou=
nter steps.
> > > > > > > > +      * Thus the period_ns and duty_ns calculation formula=
 should be:
> > > > > > > > +      * period_ns =3D NSEC_PER_SEC * (prescale + 1) * mod =
/ clk_rate
> > > > > > > > +      * duty_ns =3D NSEC_PER_SEC * (prescale + 1) * duty /=
 clk_rate
> > > > > > > > +      */
> > > > > > > > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESC=
ALE);
> > > > > > > > +     prescale =3D val & SPRD_PWM_PRESCALE_MSK;
> > > > > > > > +     tmp =3D (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_=
MAX;
> > > > > > > > +     state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk=
_rate);
> > > > > > > > +
> > > > > > > > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY)=
;
> > > > > > > > +     duty =3D val & SPRD_PWM_DUTY_MSK;
> > > > > > > > +     tmp =3D (prescale + 1) * NSEC_PER_SEC * duty;
> > > > > > > > +     state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, chn-=
>clk_rate);
> > > > > > > > +
> > > > > > > > +     /* Disable PWM clocks if the PWM channel is not in en=
able state. */
> > > > > > > > +     if (!state->enabled)
> > > > > > > > +             clk_bulk_disable_unprepare(SPRD_PWM_CHN_CLKS_=
NUM, chn->clks);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int sprd_pwm_config(struct sprd_pwm_chip *spc, stru=
ct pwm_device *pwm,
> > > > > > > > +                        int duty_ns, int period_ns)
> > > > > > > > +{
> > > > > > > > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > > > > > > > +     u32 prescale, duty;
> > > > > > > > +     u64 tmp;
> > > > > > > > +
> > > > > > > > +     /*
> > > > > > > > +      * The hardware provides a counter that is feed by th=
e source clock.
> > > > > > > > +      * The period length is (PRESCALE + 1) * MOD counter =
steps.
> > > > > > > > +      * The duty cycle length is (PRESCALE + 1) * DUTY cou=
nter steps.
> > > > > > > > +      *
> > > > > > > > +      * To keep the maths simple we're always using MOD =
=3D SPRD_PWM_MOD_MAX.
> > > > > > >
> > > > > > > Did you spend some thoughts about how wrong your period can g=
et because
> > > > > > > of that "lazyness"?
> > > > > > >
> > > > > > > Let's assume a clk rate of 100/3 MHz. Then the available peri=
od lengths
> > > > > > > are:
> > > > > > >
> > > > > > >         PRESCALE =3D  0  ->  period =3D   7.65 =C2=B5s
> > > > > > >         PRESCALE =3D  1  ->  period =3D  15.30 =C2=B5s
> > > > > > >         ...
> > > > > > >         PRESCALE =3D 17  ->  period =3D 137.70 =C2=B5s
> > > > > > >         PRESCALE =3D 18  ->  period =3D 145.35 =C2=B5s
> > > > > > >
> > > > > > > So the error can be up to (nearly) 7.65 =C2=B5s (or in genera=
l
> > > > > >
> > > > > > Yes, but for our use case (pwm backlight), the precision can me=
et our
> > > > > > requirement. Moreover, we usually do not change the period, jus=
t
> > > > > > adjust the duty to change the back light.
> > > > >
> > > > > Is this a license requirement for you SoC to only drive a backlig=
ht with
> > > > > the PWM? The idea of having a PWM driver on your platform is that=
 it can
> > > > > also be used to control a step motor or a laser.
> > > >
> > > > Not a license requirement. Until now we have not got any higher
> > > > precision requirements, and we've run this driver for many years in
> > > > our downstream kernel.
> > >
> > > I understood that you're not ambitious to do something better than "i=
t
> > > worked for years".
> >
> > How do you know that?
>
> I showed you how you could match the requested PWM output better and
> you refused telling it worked for years and the added precision isn't
> necessary for a backlight.

Please I said the reason, it is not that I do not want a better
precision. The problem is we do not know how much precision to be
asked by users if no use case, and if improve the precision, which
means we should not keep MOD as a constant and suitable value, we
should do more mathematics to get a suitable MOD and DUTY, but there
is no necessary for now.

> > If there are some cases expect a higher precision, then we can analyze
> > how precision asked by the user, then we have a goal to improve it,
> > even improve the hardware. But now, I said there are no these use
> > cases, why I should add more mathematics to increase load and
> > complication.
> >
> > > > > > > PRESCALE =3D 18 and MOD =3D 254 you get a period of 144.78 =
=C2=B5s and so the
> > > > > > > error is only 0.56 =C2=B5s which is a factor of 13 better.
> > > > > > >
> > > > > > > Hmm.
> > > > > > >
> > > > > > > > +      * The value for PRESCALE is selected such that the r=
esulting period
> > > > > > > > +      * gets the maximal length not bigger than the reques=
ted one with the
> > > > > > > > +      * given settings (MOD =3D SPRD_PWM_MOD_MAX and input=
 clock).
> > > > > > > > +      */
> > > > > > > > +     duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> > > > > > >
> > > > > > > I wonder if you loose some precision here as you use period_n=
s but might
> > > > > > > actually implement a shorter period.
> > > > > > >
> > > > > > > Quick example, again consider clk_rate =3D 100 / 3 MHz,
> > > > > > > period_ns =3D 145340, duty_ns =3D 72670. Then you end up with
> > > > > > >
> > > > > > >         PRESCALE =3D 17
> > > > > > >         MOD =3D 255
> > > > > > >         DUTY =3D 127
> > > > > >
> > > > > > Incorrect, we will get PRESCALE =3D 18,  MOD =3D 255, DUTY =3D =
127.
> > > > > >
> > > > > > > That corresponds to period_ns =3D 137700, duty_ns =3D 68580. =
With DUTY =3D 134
> > > > > > > you get 72360 ns which is still smaller than the requested 72=
670 ns.
> > > > > >
> > > > > > Incorrect, with DUTY =3D 134 (PRESCALE =3D 18  ->  period =3D 1=
45.35 =C2=B5s),
> > > > > > duty_ns =3D 76380ns
> > > > >
> > > > > Yes, as above. When using rounding-closest your error is not in [=
0, 7.65
> > > > > =C2=B5s] but in [-3.825 =C2=B5s, 3.825 =C2=B5s]. Doesn't make it =
better.
> > > >
> > > > Actually our use case really dose not care about this error.
> > >
> > > I assume that Thierry will apply your patch anyhow. But be prepared t=
hat
> > > you get a patch from me then to improve precision. It would be a wast=
e
> > > of resources not to do that after doing all the necessary math alread=
y.
> >
> > Glad to see your improvement without introducing complicated and more
> > mathematics.
>
> I don't understand you. Either you or me will improve the precision. The
> maths is the same for both cases. I would prefer you do it, otherwise I
> will have the problem later that I must get you to invest the time to
> test or I'd have to argue the change to go in untested.
>
> > > > > all lowlevel drivers. If you do this now I won't bother you later=
 when
> > > > > the requirement is implemented in your driver. And the comment he=
lps
> > > > > someone who evaluates your SoC to judge if there is still work to=
 do if
> > > > > they have higher requirements for the PWM.
> > > >
> > > > So what you asked is something like below, right?
> > > > diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> > > > index 96f8aa0..1d3db94 100644
> > > > --- a/drivers/pwm/pwm-sprd.c
> > > > +++ b/drivers/pwm/pwm-sprd.c
> > > > @@ -103,12 +103,12 @@ static void sprd_pwm_get_state(struct pwm_chi=
p
> > > > *chip, struct pwm_device *pwm,
> > > >         val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
> > > >         prescale =3D val & SPRD_PWM_PRESCALE_MSK;
> > > >         tmp =3D (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> > > > -       state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate)=
;
> > > > +       state->period =3D DIV_ROUND_UP_ULL(tmp, chn->clk_rate);
> > > >
> > > >         val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> > > >         duty =3D val & SPRD_PWM_DUTY_MSK;
> > > >         tmp =3D (prescale + 1) * NSEC_PER_SEC * duty;
> > > > -       state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_r=
ate);
> > > > +       state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, chn->clk_rate);
> > > >
> > > >         /* Disable PWM clocks if the PWM channel is not in enable s=
tate. */
> > > >         if (!state->enabled)
> > > > @@ -135,8 +135,8 @@ static int sprd_pwm_config(struct sprd_pwm_chip
> > > > *spc, struct pwm_device *pwm,
> > > >         duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> > > >
> > > >         tmp =3D (u64)chn->clk_rate * period_ns;
> > > > -       do_div(tmp, NSEC_PER_SEC);
> > > > -       prescale =3D DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) -=
 1;
> > > > +       div =3D 1000000000ULL * SPRD_PWM_MOD_MAX;
> > > > +       prescale =3D div64_u64(tmp, div) - 1;
> > > >         if (prescale > SPRD_PWM_PRESCALE_MSK)
> > > >                 prescale =3D SPRD_PWM_PRESCALE_MSK;
> > >
> > > This goes in the right direction for sure.
> > >
> > > Without taking paper and pencil I wouldn't be surprised if the
> > > calculation of duty_cycle in .get_state didn't match the calculation =
of
> > > DUTY in .apply yet though.
> > >
> > > > But our MOD is constant, it did not help to improve the precision.
> > > > Instead, like you said, when period_ns =3D 145340, we will set PRES=
CALE
> > > > =3D 17, so in .get_state(), user will get period_ns =3D 137700 (err=
or
> > > > is145340 -  137700).
> > > >
> > > > But if we use DIV_ROUND_CLOSEST, in .get_state(), user will get
> > > > period_ns =3D 145350 (error is 145350 -  145340).
> > >
> > > In this case DIV_ROUND_CLOSEST seems to get nearer to the requested
> > > value than when rounding down. But this example was constructed to sh=
ow
> > > your original algorithm to be bad, and just because you modify your
> > > algorithm to perform better on that constructed example doesn't imply
> > > the new one is better. Moreover you implement a bigger period than
> > > requested which is something I intend to forbid in the future.
> > >
> > > And note that with PWMs there is no "objective" metric that can tell =
you
> > > which of two implementable outputs better match a given request. It
> > > depends on the use case, so the best we can do is to tell our users o=
ur
> > > metric and with that in mind they can create a request that then fits
> > > their needs.
> >
> > Yes, that should be asked by the use case, some cases do not care a
> > little bigger period than requested.
>
> So for some cases it is beneficial to be predictable and for other it
> isn't. So the only safe thing to do for a lowlevel driver is to be
> predictable always because it cannot (and shouldn't) tell if the current
> request is one of cases where precision matters.
>
> > As you said, what you asked did not get a consensus yet, so I'd like
> > to wait for Thierry's suggestion.
> >
> > > > > > > twice instead of once before. (I don't know what architecture=
 your SoC
> > > > > > > uses, but compared to a multiplication a division is usually =
expensive.)
> > > > > > > Also the math is more complicated now as you have a round-dow=
n div and a
> > > > > > > round-closest div.
> > > > > > >
> > > > > > > My preference for how to fix that is to restore the behaviour=
 of v2 that
> > > > > > > matches the comment and adapt .get_state() instead.
> > > > > >
> > > > > > Using DIV_ROUND_CLOSEST_ULL can get a same prescale which match=
es with
> > > > > > .get_state().
> > > > >
> > > > > I don't get you here. Do you say that with DIV_ROUND_CLOSEST_ULL =
you get
> > > > > the same result but DIV_ROUND_CLOSEST_ULL matches .get_state whil=
e
> > > > > rounding down doesn't? I cannot follow.
> > > >
> > > > Yes, that's what I mean.
> > >
> > > But that is logically broken. If both approaches yield the same
> > > results it cannot be true that exactly one of them matches the invers=
e
> > > of .get_state.
> >
> > What I mean is use DIV_ROUND_CLOSEST_ULL we can get a nearer value to
> > the requested like above example.
>
> But given that it's unclear if 137700 ns or 145350 ns is better when
> 145340 ns was requested this is not a strong argument to use
> DIV_ROUND_CLOSEST_ULL. With the global picture for the pwm framework in
> mind it is sensible to request the same rounding from all drivers to get
> a consistent behaviour. And I believe the maths with rounding down is
> easier than when rounding up or nearest. That's why I argue in this
> direction.

Let's wait for Thierry's suggestion to get a consensus firstly.

--=20
Baolin Wang
Best Regards
