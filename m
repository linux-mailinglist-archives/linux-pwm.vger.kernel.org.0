Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD88E602
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2019 10:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfHOIQe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Aug 2019 04:16:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33504 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHOIQe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Aug 2019 04:16:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so3428026otl.0
        for <linux-pwm@vger.kernel.org>; Thu, 15 Aug 2019 01:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iNFAOv9kRLG4Tiw9iE459JYJVJAp37sF+GKq5FBdrp8=;
        b=ZyK1BYp5qJBBXBvGJr3WNinwqrW1LS+xT11pmtgZV1OHpgNovAEJgvjuXv+nKG0prJ
         amUF9v+QQN0ulWb/BVKvAXZs2uw58afr8jRYhz4xHQQKCPGsOZEt9RUY/de2HhARhFKz
         p7fUyhihFM8jX/8zVykTXmo/dRXHcj+IesHoQIpP5jaPUgb8hoyDgyQqCJvzWJ6QyhED
         azrmZNEiY8djd1CP59FavVJT3RCdhRCXiJww6vnVX/V41n0R7QSDkYvx2sl+D15814EU
         4jAtXSE+YZhxeywRjmaNB3nHMQJRXyZa21VGL8gIrSmOwak9dgk9pWomuZAMZBMepKwS
         OCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iNFAOv9kRLG4Tiw9iE459JYJVJAp37sF+GKq5FBdrp8=;
        b=KrJ3VMZEPUpOuTqn/C1vdgBw9aNBM9+0WS9i1orHH/+GvQcOKzAv1wd8Spd73kO8GK
         xEnGZpphllQgr4VFj5+Fl7h++1/08gzf9xmTT8rWXxbod9TaqdU8vPBXRccCW9WsczW4
         msDngqD9X1MlWo97/ULO39k42dBq6gVNpPh/lo1xSI9bIxk8jXSqziExFmGvIGYfqxYx
         qRB6zrvU/pdlGFBDhzeTk+8H74zJbdLj2e8WSDvrB1eN7gkWVmqfsoGsoXkl0+R6pmK8
         +XHRsSiFs4AMcgisr6PgR4NM12dKyKmFagx8p0tCbpCAv1ZPA+GT3l8/8OtHYK1jugFF
         I1Vw==
X-Gm-Message-State: APjAAAUc1UNgKfxZ2yOV4Cdqacu+t1n/5pyyWiYy7lAOhwt5s/3sTmbQ
        jE5HrDXe/GvIsh28ozuVl/uWWcUhkZ4VlDcVJLCNog==
X-Google-Smtp-Source: APXvYqz1CcwMyun+cfm9Gpu0kZPkxmotKm8yMI0QAIs/uf6qc4e+58mZetp0jxZGy8aS+xyVwuPJt3i24vqgIp8hMgM=
X-Received: by 2002:a05:6830:42:: with SMTP id d2mr2646826otp.123.1565856992944;
 Thu, 15 Aug 2019 01:16:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6a:0:0:0:0:0 with HTTP; Thu, 15 Aug 2019 01:16:32 -0700 (PDT)
In-Reply-To: <20190815061540.763ue2ogkvuyhzcu@pengutronix.de>
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
 <446eb284a096a1fd8998765669b1c9a2f78d7d22.1565785291.git.baolin.wang@linaro.org>
 <20190814150304.x44lalde3cwp67ge@pengutronix.de> <CAMz4kuLiS=cGTA=uEi9ABOVAOb1M0Pcd2a_xU5VsdLo1DGd0Hg@mail.gmail.com>
 <20190815061540.763ue2ogkvuyhzcu@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 15 Aug 2019 16:16:32 +0800
Message-ID: <CAMz4kuL_74V3M-8Zo99GnLaYbmgfQXO-h0Yz5qeXLQQ0ZR3TkA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sprd: Add Spreadtrum PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, 15 Aug 2019 at 14:15, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Baolin,
>
> On Thu, Aug 15, 2019 at 11:34:27AM +0800, Baolin Wang wrote:
> > On Wed, 14 Aug 2019 at 23:03, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Wed, Aug 14, 2019 at 08:46:11PM +0800, Baolin Wang wrote:
> >
> > > > +
> > > > +     /*
> > > > +      * The hardware provides a counter that is feed by the source=
 clock.
> > > > +      * The period length is (PRESCALE + 1) * MOD counter steps.
> > > > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter ste=
ps.
> > > > +      * Thus the period_ns and duty_ns calculation formula should =
be:
> > > > +      * period_ns =3D NSEC_PER_SEC * (prescale + 1) * mod / clk_ra=
te
> > > > +      * duty_ns =3D NSEC_PER_SEC * (prescale + 1) * duty / clk_rat=
e
> > > > +      */
> > > > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
> > > > +     prescale =3D val & SPRD_PWM_PRESCALE_MSK;
> > > > +     tmp =3D (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> > > > +     state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > > > +
> > > > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> > > > +     duty =3D val & SPRD_PWM_DUTY_MSK;
> > > > +     tmp =3D (prescale + 1) * NSEC_PER_SEC * duty;
> > > > +     state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rat=
e);
> > > > +
> > > > +     /* Disable PWM clocks if the PWM channel is not in enable sta=
te. */
> > > > +     if (!state->enabled)
> > > > +             clk_bulk_disable_unprepare(SPRD_PWM_CHN_CLKS_NUM, chn=
->clks);
> > > > +}
> > > > +
> > > > +static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_d=
evice *pwm,
> > > > +                        int duty_ns, int period_ns)
> > > > +{
> > > > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > > > +     u32 prescale, duty;
> > > > +     u64 tmp;
> > > > +
> > > > +     /*
> > > > +      * The hardware provides a counter that is feed by the source=
 clock.
> > > > +      * The period length is (PRESCALE + 1) * MOD counter steps.
> > > > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter ste=
ps.
> > > > +      *
> > > > +      * To keep the maths simple we're always using MOD =3D SPRD_P=
WM_MOD_MAX.
> > >
> > > Did you spend some thoughts about how wrong your period can get becau=
se
> > > of that "lazyness"?
> > >
> > > Let's assume a clk rate of 100/3 MHz. Then the available period lengt=
hs
> > > are:
> > >
> > >         PRESCALE =3D  0  ->  period =3D   7.65 =C2=B5s
> > >         PRESCALE =3D  1  ->  period =3D  15.30 =C2=B5s
> > >         ...
> > >         PRESCALE =3D 17  ->  period =3D 137.70 =C2=B5s
> > >         PRESCALE =3D 18  ->  period =3D 145.35 =C2=B5s
> > >
> > > So the error can be up to (nearly) 7.65 =C2=B5s (or in general
> >
> > Yes, but for our use case (pwm backlight), the precision can meet our
> > requirement. Moreover, we usually do not change the period, just
> > adjust the duty to change the back light.
>
> Is this a license requirement for you SoC to only drive a backlight with
> the PWM? The idea of having a PWM driver on your platform is that it can
> also be used to control a step motor or a laser.

Not a license requirement. Until now we have not got any higher
precision requirements, and we've run this driver for many years in
our downstream kernel.

> > > 255 / clk_rate) because if 145.34 =C2=B5s is requested you configure
> > > PRESCALE =3D 17 and so yield a period of 137.70 =C2=B5s. If however y=
ou'd pick
> >
> > I did not get you here, if period is 145.34, we still get the
> > corresponding PRESCALE =3D 18 by below formula:
> >
> > tmp =3D (u64)chn->clk_rate * period_ns;
> > do_div(tmp, NSEC_PER_SEC);
> > prescale =3D DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;
>
> I assumed you switch back to rounding down to match your comment and
> which is how I think a pwm should behave. With rounding down we get
> PRESCALE =3D 17 as I claimed.

OK.

>
> > > PRESCALE =3D 18 and MOD =3D 254 you get a period of 144.78 =C2=B5s an=
d so the
> > > error is only 0.56 =C2=B5s which is a factor of 13 better.
> > >
> > > Hmm.
> > >
> > > > +      * The value for PRESCALE is selected such that the resulting=
 period
> > > > +      * gets the maximal length not bigger than the requested one =
with the
> > > > +      * given settings (MOD =3D SPRD_PWM_MOD_MAX and input clock).
> > > > +      */
> > > > +     duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> > >
> > > I wonder if you loose some precision here as you use period_ns but mi=
ght
> > > actually implement a shorter period.
> > >
> > > Quick example, again consider clk_rate =3D 100 / 3 MHz,
> > > period_ns =3D 145340, duty_ns =3D 72670. Then you end up with
> > >
> > >         PRESCALE =3D 17
> > >         MOD =3D 255
> > >         DUTY =3D 127
> >
> > Incorrect, we will get PRESCALE =3D 18,  MOD =3D 255, DUTY =3D 127.
> >
> > > That corresponds to period_ns =3D 137700, duty_ns =3D 68580. With DUT=
Y =3D 134
> > > you get 72360 ns which is still smaller than the requested 72670 ns.
> >
> > Incorrect, with DUTY =3D 134 (PRESCALE =3D 18  ->  period =3D 145.35 =
=C2=B5s),
> > duty_ns =3D 76380ns
>
> Yes, as above. When using rounding-closest your error is not in [0, 7.65
> =C2=B5s] but in [-3.825 =C2=B5s, 3.825 =C2=B5s]. Doesn't make it better.

Actually our use case really dose not care about this error.

>
> > > (But then again it is not obvious which of the two is the "better"
> > > approximation because Thierry doesn't seem to see the necessity to
> > > discuss or define a policy here.)
> >
> > Like I said, this is the simple calculation formula which can meet our
> > requirement (we limit our DUTY value can only be 0 - 254).
> > duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
>
> simple is often good but sometimes different from correct. And even with

I do not think this is incorrect.

> rounding closest instead of rounding down you're giving away precision
> here and the size of the error interval is the same, it is just centered
> around 0 instead of only positive. If I hadn't spend so much time with
> pwm reviews this week I'd try to come up with an example.

I am very appreciated for your comments.

> > > (And to pick up the thoughts about not using SPRD_PWM_MOD_MAX
> > > unconditionally, you could also use
> > >
> > >         PRESCALE =3D 18
> > >         MOD =3D 254
> > >         DUTY =3D 127
> > >
> > > yielding period_ns =3D 144780 and duty_ns =3D 72390. Summary:
> > >
> > >         Request:                 72670 / 145340
> > >         your result:             68580 / 137700
> > >         also possible:           72390 / 144780
> > >
> > > Judge yourself.)
> > >
> > > > +     tmp =3D (u64)chn->clk_rate * period_ns;
> > > > +     do_div(tmp, NSEC_PER_SEC);
> > > > +     prescale =3D DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1=
;
> > >
> > > Now that you use DIV_ROUND_CLOSEST_ULL the comment is wrong because y=
ou
> > > might provide a period bigger than the requested one. Also you divide
> >
> > Again, that's the precision can meet our requirement.
>
> If you go back to rounding down, use the matching rounding up in
> .get_state and adapt your comment describing you're sticking to MOD=3D255
> to say explicitly that you're loosing precision I can live with that. I
> even did the math for .get_state in my previous mail for you.
>
> The idea of the requirement to round down is that I want to introduce
> this as policy for the PWM framework to get some uniform behaviour from

Have you made a consensus about this? Documented it?

> all lowlevel drivers. If you do this now I won't bother you later when
> the requirement is implemented in your driver. And the comment helps
> someone who evaluates your SoC to judge if there is still work to do if
> they have higher requirements for the PWM.

So what you asked is something like below, right?
diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index 96f8aa0..1d3db94 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -103,12 +103,12 @@ static void sprd_pwm_get_state(struct pwm_chip
*chip, struct pwm_device *pwm,
        val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
        prescale =3D val & SPRD_PWM_PRESCALE_MSK;
        tmp =3D (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
-       state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
+       state->period =3D DIV_ROUND_UP_ULL(tmp, chn->clk_rate);

        val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
        duty =3D val & SPRD_PWM_DUTY_MSK;
        tmp =3D (prescale + 1) * NSEC_PER_SEC * duty;
-       state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
+       state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, chn->clk_rate);

        /* Disable PWM clocks if the PWM channel is not in enable state. */
        if (!state->enabled)
@@ -135,8 +135,8 @@ static int sprd_pwm_config(struct sprd_pwm_chip
*spc, struct pwm_device *pwm,
        duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;

        tmp =3D (u64)chn->clk_rate * period_ns;
-       do_div(tmp, NSEC_PER_SEC);
-       prescale =3D DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;
+       div =3D 1000000000ULL * SPRD_PWM_MOD_MAX;
+       prescale =3D div64_u64(tmp, div) - 1;
        if (prescale > SPRD_PWM_PRESCALE_MSK)
                prescale =3D SPRD_PWM_PRESCALE_MSK;

But our MOD is constant, it did not help to improve the precision.
Instead, like you said, when period_ns =3D 145340, we will set PRESCALE
=3D 17, so in .get_state(), user will get period_ns =3D 137700 (error
is145340 -  137700).

But if we use DIV_ROUND_CLOSEST, in .get_state(), user will get
period_ns =3D 145350 (error is145350 -  145340).

> > > twice instead of once before. (I don't know what architecture your So=
C
> > > uses, but compared to a multiplication a division is usually expensiv=
e.)
> > > Also the math is more complicated now as you have a round-down div an=
d a
> > > round-closest div.
> > >
> > > My preference for how to fix that is to restore the behaviour of v2 t=
hat
> > > matches the comment and adapt .get_state() instead.
> >
> > Using DIV_ROUND_CLOSEST_ULL can get a same prescale which matches with
> > .get_state().
>
> I don't get you here. Do you say that with DIV_ROUND_CLOSEST_ULL you get
> the same result but DIV_ROUND_CLOSEST_ULL matches .get_state while
> rounding down doesn't? I cannot follow.

Yes, that's what I mean.


--
Baolin Wang
Best Regards
