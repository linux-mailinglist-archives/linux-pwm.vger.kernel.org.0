Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7220F8E333
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2019 05:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfHODel (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 23:34:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33151 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfHODel (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 23:34:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id u15so344823oiv.0
        for <linux-pwm@vger.kernel.org>; Wed, 14 Aug 2019 20:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0JIQRQ+xNbbHKLeC4kEeQF0KjMCRGExp2a+6cMV/Yzs=;
        b=D6xWg31eAx37dbBFh2UHPoO7jB0Tj7vTtasYLZ0gi3iI06sjjzXJC4DyDWnCz4kCv7
         y/TyN35MAbuMvqjy/NElFecs5Mokai3s2vydtylLX3adVdeV+EKVR5Dmh7anWNvtt9p6
         nAdEx7zhH0wdDkuF0QbggALjJK0UGBmg8GawwnGk14xA8mp4AyaS7NKtRSuSgWJAKi/9
         kXUu/229gpfmb3SSAHpmQwFUvn8SzhAc0ZyZTQ9O7r8GKvBCTdeGZgs6Cj8rQlzFJJte
         b59lJI6LYNXvAFrm/MQMn/VAJiR9zjBcGUNP5AD25l5fhu0zvsOAUgV6ZaXewIpT1DOb
         23rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0JIQRQ+xNbbHKLeC4kEeQF0KjMCRGExp2a+6cMV/Yzs=;
        b=pwsTf3wDRzTSUlwhFFFv1bryvqCkWrWGmToLPZFXn203xcEkieLvZNmSjT5I8hHuol
         7ZBiJ1nSRwbwPJBaSLLK8fR4RaVdc/QSNGCaFXHtvh8QW0JzYFwJ/JKstb1cbp5+hezD
         /IG1bClzU8QXCyaVzQhBFVtiayvSrUObt5/Ny1G4PDS/Wthe8OdU4IyYVLTBrgC3LkmQ
         C5mFBHhPwBfabFJssBoI1PLQlr9rfm6Vk/74E6OOeRFcrg4YbLGHX4ww7B0YrZiUaJof
         MAALXryAHcQk4N020ddUDHe1CKIGiihRDQsw+qWdzhv3YQGE+UQV8E59vD7PRqJ7d7rZ
         wptw==
X-Gm-Message-State: APjAAAXiP/uRshTCXfh5GIZVwI+chojgB7e06SLpCszV/U6L84DD6eTr
        Htt1nKkq7f8EcqLXRDdS0e9JNSJV2SBWjI/ccUMyZc2ayxMtrg==
X-Google-Smtp-Source: APXvYqz2WW/ZUZs3f9DE3/5TOF72f8NVhhdHDWXWLqGs3GshPIHar7YD+ZZAObNfFBIbBv2aGU+AZ1O4ADcHpCaMGWM=
X-Received: by 2002:aca:6056:: with SMTP id u83mr255579oib.27.1565840079545;
 Wed, 14 Aug 2019 20:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
 <446eb284a096a1fd8998765669b1c9a2f78d7d22.1565785291.git.baolin.wang@linaro.org>
 <20190814150304.x44lalde3cwp67ge@pengutronix.de>
In-Reply-To: <20190814150304.x44lalde3cwp67ge@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 15 Aug 2019 11:34:27 +0800
Message-ID: <CAMz4kuLiS=cGTA=uEi9ABOVAOb1M0Pcd2a_xU5VsdLo1DGd0Hg@mail.gmail.com>
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

On Wed, 14 Aug 2019 at 23:03, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Wed, Aug 14, 2019 at 08:46:11PM +0800, Baolin Wang wrote:

> > +
> > +     /*
> > +      * The hardware provides a counter that is feed by the source clo=
ck.
> > +      * The period length is (PRESCALE + 1) * MOD counter steps.
> > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> > +      * Thus the period_ns and duty_ns calculation formula should be:
> > +      * period_ns =3D NSEC_PER_SEC * (prescale + 1) * mod / clk_rate
> > +      * duty_ns =3D NSEC_PER_SEC * (prescale + 1) * duty / clk_rate
> > +      */
> > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
> > +     prescale =3D val & SPRD_PWM_PRESCALE_MSK;
> > +     tmp =3D (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> > +     state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > +
> > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> > +     duty =3D val & SPRD_PWM_DUTY_MSK;
> > +     tmp =3D (prescale + 1) * NSEC_PER_SEC * duty;
> > +     state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > +
> > +     /* Disable PWM clocks if the PWM channel is not in enable state. =
*/
> > +     if (!state->enabled)
> > +             clk_bulk_disable_unprepare(SPRD_PWM_CHN_CLKS_NUM, chn->cl=
ks);
> > +}
> > +
> > +static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_devic=
e *pwm,
> > +                        int duty_ns, int period_ns)
> > +{
> > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > +     u32 prescale, duty;
> > +     u64 tmp;
> > +
> > +     /*
> > +      * The hardware provides a counter that is feed by the source clo=
ck.
> > +      * The period length is (PRESCALE + 1) * MOD counter steps.
> > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> > +      *
> > +      * To keep the maths simple we're always using MOD =3D SPRD_PWM_M=
OD_MAX.
>
> Did you spend some thoughts about how wrong your period can get because
> of that "lazyness"?
>
> Let's assume a clk rate of 100/3 MHz. Then the available period lengths
> are:
>
>         PRESCALE =3D  0  ->  period =3D   7.65 =C2=B5s
>         PRESCALE =3D  1  ->  period =3D  15.30 =C2=B5s
>         ...
>         PRESCALE =3D 17  ->  period =3D 137.70 =C2=B5s
>         PRESCALE =3D 18  ->  period =3D 145.35 =C2=B5s
>
> So the error can be up to (nearly) 7.65 =C2=B5s (or in general

Yes, but for our use case (pwm backlight), the precision can meet our
requirement. Moreover, we usually do not change the period, just
adjust the duty to change the back light.

> 255 / clk_rate) because if 145.34 =C2=B5s is requested you configure
> PRESCALE =3D 17 and so yield a period of 137.70 =C2=B5s. If however you'd=
 pick

I did not get you here, if period is 145.34, we still get the
corresponding PRESCALE =3D 18 by below formula:

tmp =3D (u64)chn->clk_rate * period_ns;
do_div(tmp, NSEC_PER_SEC);
prescale =3D DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;

> PRESCALE =3D 18 and MOD =3D 254 you get a period of 144.78 =C2=B5s and so=
 the
> error is only 0.56 =C2=B5s which is a factor of 13 better.
>
> Hmm.
>
> > +      * The value for PRESCALE is selected such that the resulting per=
iod
> > +      * gets the maximal length not bigger than the requested one with=
 the
> > +      * given settings (MOD =3D SPRD_PWM_MOD_MAX and input clock).
> > +      */
> > +     duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
>
> I wonder if you loose some precision here as you use period_ns but might
> actually implement a shorter period.
>
> Quick example, again consider clk_rate =3D 100 / 3 MHz,
> period_ns =3D 145340, duty_ns =3D 72670. Then you end up with
>
>         PRESCALE =3D 17
>         MOD =3D 255
>         DUTY =3D 127

Incorrect, we will get PRESCALE =3D 18,  MOD =3D 255, DUTY =3D 127.

> That corresponds to period_ns =3D 137700, duty_ns =3D 68580. With DUTY =
=3D 134
> you get 72360 ns which is still smaller than the requested 72670 ns.

Incorrect, with DUTY =3D 134 (PRESCALE =3D 18  ->  period =3D 145.35 =C2=B5=
s),
duty_ns =3D 76380ns

> (But then again it is not obvious which of the two is the "better"
> approximation because Thierry doesn't seem to see the necessity to
> discuss or define a policy here.)

Like I said, this is the simple calculation formula which can meet our
requirement (we limit our DUTY value can only be 0 - 254).
duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;

>
> (And to pick up the thoughts about not using SPRD_PWM_MOD_MAX
> unconditionally, you could also use
>
>         PRESCALE =3D 18
>         MOD =3D 254
>         DUTY =3D 127
>
> yielding period_ns =3D 144780 and duty_ns =3D 72390. Summary:
>
>         Request:                 72670 / 145340
>         your result:             68580 / 137700
>         also possible:           72390 / 144780
>
> Judge yourself.)
>
> > +     tmp =3D (u64)chn->clk_rate * period_ns;
> > +     do_div(tmp, NSEC_PER_SEC);
> > +     prescale =3D DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;
>
> Now that you use DIV_ROUND_CLOSEST_ULL the comment is wrong because you
> might provide a period bigger than the requested one. Also you divide

Again, that's the precision can meet our requirement.

> twice instead of once before. (I don't know what architecture your SoC
> uses, but compared to a multiplication a division is usually expensive.)
> Also the math is more complicated now as you have a round-down div and a
> round-closest div.
>
> My preference for how to fix that is to restore the behaviour of v2 that
> matches the comment and adapt .get_state() instead.

Using DIV_ROUND_CLOSEST_ULL can get a same prescale which matches with
.get_state().

>
> For .get_state() this should then be:
>
>         val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
>         prescale =3D FIELD_GET(SPRD_PWM_PRESCALE_MSK, val);
>
>         tmp =3D (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
>         state->period =3D DIV_ROUND_UP_ULL(tmp, chn->clk_rate);
>
> > +     if (prescale > SPRD_PWM_PRESCALE_MSK)
> > +             prescale =3D SPRD_PWM_PRESCALE_MSK;
> > +
> > +     /*
> > +      * Note: Writing DUTY triggers the hardware to actually apply the
> > +      * values written to MOD and DUTY to the output, so must keep wri=
ting
> > +      * DUTY last.
> > +      *
> > +      * The hardware can ensures that current running period is comple=
ted
> > +      * before changing a new configuration to avoid mixed settings.
>
> I'm not a native English speaker, but I would write:
>
>         * The hardware ensures that currently running period is
>         * completed before changing to the new configuration to avoid
>         * mixed settings.

Sure

>
> Does this mechanism also apply to PRESCALE? If yes, please include it in

Yes.

> your description. If not there is still a possibility for a wrong
> period.
>
> > +      */
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
> > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
> > +
> > +     return 0;
> > +}
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|



--=20
Baolin Wang
Best Regards
