Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B908998A
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 11:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfHLJMJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 05:12:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42624 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfHLJMJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 05:12:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so11491175ota.9
        for <linux-pwm@vger.kernel.org>; Mon, 12 Aug 2019 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wdZyun565rMEMI5nrVFcxcYEx7GFK77k+ZNdL1lQ6FQ=;
        b=bCiDFOiEutFtUSei8uS30/dZCyknXL3Y+sdcVYHReFPlkqv99B4MbUZDmE5THMle1N
         zqnu8ePllUKJDrV9qFjij+kGlx4JmPzKOsqRArrYUoi3MZoc+6NEKRDcn7SI6hs9y0MZ
         CQB1D6F/RHnIT2Ea4HtcG2wtOjni9GhfPr/3uYwWMa0kYKlcQMPpkH/5NeF9cxzmaDgY
         58dWl6Zq4yHI2J3l4TLGgQ6ytnCLfquaos5ycEwAQA4ceJoUITiXxZR4vo0E4jzc5SuI
         UX34bKGQ6Mukjc/hGlzSPoZ2esR+U/NcZa9+ibT9K+Qbo0LWvVJjPiJVak1Tf0y7EDSb
         YuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wdZyun565rMEMI5nrVFcxcYEx7GFK77k+ZNdL1lQ6FQ=;
        b=PSTuASpbcLNbzuRFic70VhhFh9Q8nCiN2F4aRU8mcKzNJR1I0F3c39ex5708VpoFcM
         nyJEC8VeSK9pH6BWC8Fk38Rrx1S0i5liWKbQan5wUkuqgY3YwVkcBMwj4NiCCFMDww85
         wgx5gcx5hAGiD9wvih13kNdMMQ6jGoiFXLytP/U8jWCOKqDPQs0raI3zC6+j8NKpOMA4
         fQnxA2Oge7KTN7u5RUC5/gvi0virRq9v2KiMMDQD31Q6ocFOa8lWWr8ysLuT2DPEqXnn
         TvXIFcmIYs6YPvHPUupJYqZNhuQ+jqkalr7mQFd1/RJohaN690a8y2PshE9v7cd+oXVK
         BUsg==
X-Gm-Message-State: APjAAAU8ijqWN/sOTKajD/cAXVG79fw6SBySJL5myUEzrqYtsdFNFtPF
        /4sKI4AoSyPx/hC6JfcAToPWr4EYgQ0Ad9yl5y65ew==
X-Google-Smtp-Source: APXvYqzjxs1NKNev+ynqOpkaypGZyhAhPHyQqRrmfnNxDVkl/4mg+MgIbBda7CqtUUC7iUBpKhscpYIJ8hfrw+iGSAo=
X-Received: by 2002:aca:6183:: with SMTP id v125mr12824531oib.6.1565601127888;
 Mon, 12 Aug 2019 02:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de> <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
 <20190809144124.3as3rtctlywxkudr@pengutronix.de> <CAMz4ku+o6dCyxhR3-5yM+zr2nBpTQG5A8Pbnxpo7yRciwPbv3Q@mail.gmail.com>
 <20190812083556.dvprpwv6mjy3cjae@pengutronix.de>
In-Reply-To: <20190812083556.dvprpwv6mjy3cjae@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 12 Aug 2019 17:11:56 +0800
Message-ID: <CAMz4kuJA81ZP6Kc63dPV1jEn1ah=jow6tQBfO=UDCcTzSf3y-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, 12 Aug 2019 at 16:36, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Baolin,
>
> On Mon, Aug 12, 2019 at 03:29:07PM +0800, Baolin Wang wrote:
> > Hi Uwe,
> >
> > On Fri, 9 Aug 2019 at 22:41, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Aug 09, 2019 at 06:06:21PM +0800, Baolin Wang wrote:
> > > > On Fri, 9 Aug 2019 at 17:10, Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > On Thu, Aug 08, 2019 at 04:59:39PM +0800, Baolin Wang wrote:
> > > > > > +static void sprd_pwm_get_state(struct pwm_chip *chip, struct p=
wm_device *pwm,
> > > > > > +                            struct pwm_state *state)
> > > > > > +{
> > > > > > +     struct sprd_pwm_chip *spc =3D
> > > > > > +             container_of(chip, struct sprd_pwm_chip, chip);
> > > > > > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > > > > > +     u32 enabled, duty, prescale;
> > > > > > +     u64 tmp;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     ret =3D clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->c=
lks);
> > > > > > +     if (ret) {
> > > > > > +             dev_err(spc->dev, "failed to enable pwm%u clocks\=
n",
> > > > > > +                     pwm->hwpwm);
> > > > > > +             return;
> > > > > > +     }
> > > > > > +
> > > > > > +     chn->clk_enabled =3D true;
> > > > > > +
> > > > > > +     duty =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY) & =
SPRD_PWM_REG_MSK;
> > > > > > +     prescale =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRES=
CALE) & SPRD_PWM_REG_MSK;
> > > > > > +     enabled =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABL=
E) & SPRD_PWM_ENABLE_BIT;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * According to the datasheet, the period_ns and duty_ns =
calculation
> > > > > > +      * formula should be:
> > > > > > +      * period_ns =3D 10^9 * (prescale + 1) * mod / clk_rate
> > > > > > +      * duty_ns =3D 10^9 * (prescale + 1) * duty / clk_rate
> > > > > > +      */
> > > > > > +     tmp =3D (prescale + 1) * 1000000000ULL * SPRD_PWM_MOD_MAX=
;
> > > > > > +     state->period =3D div64_u64(tmp, chn->clk_rate);
> > > > >
> > > > > This is not idempotent. If you apply the configuration that is re=
turned
> > > > > here this shouldn't result in a reconfiguration.
> > > >
> > > > Since we may configure the  PWM in bootloader, so in kernel part we
> > > > should get current PWM state to avoid reconfiguration if state
> > > > configuration are same.
> > >
> > > This is also important as some consumers might do something like:
> > >
> > >         state =3D pwm_get_state(mypwm)
> > >         if (something):
> > >                 state->duty =3D 0
> > >         else:
> > >                 state->duty =3D state->period / 2
> > >         pwm_set_state(mypwm, state)
> > >
> > > and then period shouldn't get smaller in each step.
> > > (This won't happen as of now because the PWM framework caches the las=
t
> > > state that was set and returns this for pwm_get_state. Still getting
> > > this right would be good.)
> >
> > I understood your concern, but the period can be configured in
> > bootloader, we have no software things to save the accurate period.
>
> I don't understand what you're saying here. The bootloader configuring
> the hardware is a usual use-case. That's why we have the .get_state
> callback in the first place.

Ah, sorry for confusing. I think I get your point now with below explanatio=
n.

>
> > Moreover I think I can change to use DIV_ROUND_CLOSET_ULL to keep the
> > accuracy.
>
> DIV_ROUND_CLOSEST_ULL still doesn't match what the apply callback uses.
> With the lack of an official statement from the maintainer I'd prefer
> .apply to round down and implement .get_state such that
>
>         pwm_apply(pwm, pwm_get_state(pwm))
>
> is a no-op.

OK.

>
> > > > > > +
> > > > > > +                     dev_err(spc->dev, "failed to get channel =
clocks\n");
> > > > > > +                     return ret;
> > > > > > +             }
> > > > > > +
> > > > > > +             clk_pwm =3D chn->clks[1].clk;
> > > > >
> > > > > This 1 looks suspicious. Are you using all clocks provided in the=
 dtb at
> > > > > all? You're not using i in the loop at all, this doesn't look rig=
ht.
> > > >
> > > > Like I said above, each channel has 2 clocks: enable clock and pwm
> > > > clock, the 2nd clock of each channel's bulk clocks is the pwm clock=
,
> > > > which is used to set the source clock. I know this's not easy to re=
ad,
> > > > so do you have any good suggestion?
> > >
> > > Not sure this is easily possible to rework to make this clearer.
> > >
> > > Do these clks have different uses? e.g. one to enable register access
> > > and the other to enable the pwm output? If so just using
> >
> > Yes.
>
> So assuming one of the clocks is for operation of the output and the
> other for accessing the registers, the latter can be disabled at the end

Right.

> of each callback?

We can not disable the latter one when using the PWM channel, we must
enable the pwm-enable clock, then enable pwm-output clock to make PWM
work. When disabling PWM channel, we should disable the pwm-output
clock, then pwm-enable clock.

>
> > > devm_clk_bulk_get isn't the right thing because you should be able kn=
ow
> > > if clks[0] or clks[1] is the one you need to enable the output (or
> > > register access).
> >
> > We've fixed the clock order in bulk clocks by the array
> > 'sprd_pwm_clks', maybe I should define one readable macro instead of
> > magic number.
>
> ack.
>
> > > > > > +             if (!clk_set_parent(clk_pwm, clk_parent))
> > > > > > +                     chn->clk_rate =3D clk_get_rate(clk_pwm);
> > > > > > +             else
> > > > > > +                     chn->clk_rate =3D SPRD_PWM_DEFAULT_CLK;
> > > > >
> > > > > I don't know all the clock framework details, but I think there a=
re
> > > > > better ways to ensure that a given clock is used as parent for an=
other
> > > > > given clock. Please read the chapter about "Assigned clock parent=
s and
> > > > > rates" in the clock bindings and check if this could be used for =
the
> > > > > purpose here and so simplify the driver.
> > > >
> > > > Actually there are many other drivers set the parent clock like thi=
s,
> > > > and we want a default clock if failed to set the parent clock.
> > >
> > > These might be older than the clk framework capabilities, or the
> > > reviewers didn't pay attention to this detail; both shouldn't be a
> > > reason to not make it better here.
> >
> > The clock framework supplies 'assigned-clocks' and
> > 'assigned-clock-parents' properties to set parent, but for our case we
> > still want to set a default clock rate if failed to set parent when
> > met some abnormal things.
>
> Without understanding the complete problem I'd say this is out of the
> area the driver should care about.

Fair enough, I will try to use 'assigned-clocks' and
'assigned-clock-parents' to simplify the code.

Thanks.

--=20
Baolin Wang
Best Regards
