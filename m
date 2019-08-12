Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32B897D7
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfHLH3V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 03:29:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43641 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfHLH3U (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 03:29:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so11208181otp.10
        for <linux-pwm@vger.kernel.org>; Mon, 12 Aug 2019 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a5aTkNyNQpnTDblbg7EX7YSfJ3L9MslqQrpJziWh5Tc=;
        b=Ve/gw486vDcHiLqJx8sVIKEa5aF0Cz0pUACQeRj1uGg65ADuTT92pXhepEAZdPaJy5
         Ktp0OXXWcUgo8id91YutizXIMcnzyx+TzZna0CAypokpRz1+h+wHGQz8Gl4gc/L2kqau
         99TBcCVqd+G1BaYPNvLN8TKqXCkoJn4BYeiengs/SOtuCOKuyToEbU+9G75qHogl/iqb
         Gyqk8z3FspIohFazaXX5aiw8YL+P9Pp6I6OaxueDqyhO08xQR8IbbYxdSRCeBnTm+BYu
         ZoZ1v7EiGY1kdNCwTyK+7q/MD9MPqFvYK8xzhEBdQn4i3fi0t8ol5bpruC5/AZR132zG
         ko1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a5aTkNyNQpnTDblbg7EX7YSfJ3L9MslqQrpJziWh5Tc=;
        b=mTHgUrGvlu3t35khIIoJGmRwgog6IisK3t5eTJxlsD/2Y37ab76sAjiNPhvqjcFyFv
         iknuo4aRfM/ypmiT1HGlmONmq1aMc2CAts1HFuoypH8wU2YKjKv9i+uyt5cDw5js9B6Y
         6ShaMF7dcyHSWrGMPW5d7Ov/ZF3LWJ9leSz0tF17I6HQXDl+F60lyKuagp5fnIR/zq5Q
         nWXh4xRY/F17FYaChWz//hg6K77dRcXvHnTzWK8zWzNPwqQOC/aWrsBM9N7ioV4lhX/y
         f1x7WHklUBnB8qTZM3yLiMZy0PcFEq/py5Oq1GcWeZR79CvRWcKZDOVNNVqgbA7IkvkY
         ZWTg==
X-Gm-Message-State: APjAAAUcRv3TfomFdf7uceBH5kjicymkEVBeHwVumlSNF124GLUWHpWV
        86ww2UQWz6lsYCiV0pSRZCRz4Gx/whMLQWqDdx3kiw==
X-Google-Smtp-Source: APXvYqzGG0KBTmlQlvXvsrXa/TpjrvX3+wyWt5cLGy5eFqwtUJQneBoAK5mOZ9lZMY+iquFGH2zUoV5IAhUkvRrRyks=
X-Received: by 2002:aca:6056:: with SMTP id u83mr14078528oib.27.1565594959591;
 Mon, 12 Aug 2019 00:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de> <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
 <20190809144124.3as3rtctlywxkudr@pengutronix.de>
In-Reply-To: <20190809144124.3as3rtctlywxkudr@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 12 Aug 2019 15:29:07 +0800
Message-ID: <CAMz4ku+o6dCyxhR3-5yM+zr2nBpTQG5A8Pbnxpo7yRciwPbv3Q@mail.gmail.com>
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

On Fri, 9 Aug 2019 at 22:41, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Baolin,
>
> On Fri, Aug 09, 2019 at 06:06:21PM +0800, Baolin Wang wrote:
> > On Fri, 9 Aug 2019 at 17:10, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Thu, Aug 08, 2019 at 04:59:39PM +0800, Baolin Wang wrote:
> > > > +{
> > > > +     struct sprd_pwm_chip *spc =3D
> > > > +             container_of(chip, struct sprd_pwm_chip, chip);
> > > > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > > > +     u64 div, tmp;
> > > > +     u32 prescale, duty;
> > > > +     int ret;
> > > > +
> > > > +     /*
> > > > +      * NOTE: the clocks to PWM channel has to be enabled first be=
fore
> > > > +      * writing to the registers.
> > > > +      */
> > > > +     if (!chn->clk_enabled) {
> > > > +             ret =3D clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, ch=
n->clks);
> > >
> > > Do you really need to enable all 8 clocks to configure a single chann=
el?
> >
> > We have 4 channels, and each channel use 2 clocks, so here only enable
> > 2 clocks, see SPRD_PWM_NUM_CLKS.
>
> Ah, I thought SPRD_PWM_NUM_CLKS was 8.
>
> > > > +             if (ret) {
> > > > +                     dev_err(spc->dev, "failed to enable pwm%u clo=
ck\n",
> > > > +                             pwm->hwpwm);
> > > > +                     return ret;
> > > > +             }
> > > > +
> > > > +             chn->clk_enabled =3D true;
> > > > +     }
> > > > +
> > > > +     duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> > >
> > > @Baolin: until we're there that there are framework requirements how =
to
> > > round, please document at least how you do it here. Also describing t=
he
> > > underlying concepts would be good for the driver reader.
> > >
> > > Something like:
> > >
> > > /*
> > >  * The hardware provides a counter that is feed by the source clock.
> > >  * The period length is (PRESCALE + 1) * MOD counter steps.
> > >  * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> > >  *
> > >  * To keep the maths simple we're always using MOD =3D MOD_MAX.
> > >  * The value for PRESCALE is selected such that the resulting period
> > >  * gets the maximal length not bigger than the requested one with the
> > >  * given settings (MOD =3D MOD_MAX and input clock).
> > >  */
> >
> > Yes, totally agree with you. I will add some documentation for our
> > controller's setting.
> >
> > >
> > > @Thierry: having a framework guideline here would be good. Or still
> > > better a guideline and a debug setting that notices drivers stepping =
out
> > > of line.
> > >
> > > I assume using MOD =3D 0 is forbidden?
> > >
> > > > +     /*
> > > > +      * According to the datasheet, the period_ns calculation form=
ula
> > > > +      * should be:
> > > > +      * period_ns =3D 10^9 * (prescale + 1) * mod / clk_rate
> > > > +      *
> > > > +      * Then we can get the prescale formula:
> > > > +      * prescale =3D (period_ns * clk_rate) / (10^9 * mod) -1
> > > > +      */
> > > > +     tmp =3D chn->clk_rate * period_ns;
> > > > +     div =3D 1000000000ULL * SPRD_PWM_MOD_MAX;
> > >
> > > Please use NSEC_PER_SEC instead of 1000000000ULL.
> >
> > Sure.
> >
> > >
> > > > +     prescale =3D div64_u64(tmp, div) - 1;
> > >
> > > If tmp is smaller than div you end up with prescale =3D 0xffffffff wh=
ich
> > > should be catched. What if prescale > 0xffff?
> >
> > Usually we can not meet this case, but you are right, the prescale has
> > a limit according to the register definition. So will add a validation
> > here.
> >
> > >
> > > > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MA=
X);
> > > > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
> > >
> > > You're losing precision here as you always use SPRD_PWM_MOD_MAX, righ=
t?
> > > (Just for my understanding, if this simpler approach is good enough
> > > here that's fine.)
> >
> > Yes, SPRD_PWM_MOD_MAX is good enough.
>
> ok.
>
> > >
> > > > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PAT_LOW, SPRD_PWM_RE=
G_MSK);
> > > > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PAT_HIGH, SPRD_PWM_R=
EG_MSK);
> > >
> > > Please describe these two registers in a short comment.
> >
> > Sure.
> >
> > >
> > > > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
> > >
> > > Is the configuration here atomic in the sense that the write of DUTY
> > > above only gets effective when PRESCALE is written? If not, please ad=
d
> >
> > Yes.
> >
> > > a describing paragraph at the top of the driver similar to what is
> > > written in pwm-sifive.c. When the PWM is already running before, how
> > > does a configuration change effects the output? Is the currently runn=
ing
> > > period completed?
> >
> > Anyway, I'll add some comments to explain how it works.
>
> I'd apreciate if you'd stick to the format in pwm-sifive.c to make it
> easier to grep for that.

OK.

>
> > > > +static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> > > > +                            struct pwm_state *state)
> > > > +{
> > > > +     struct sprd_pwm_chip *spc =3D
> > > > +             container_of(chip, struct sprd_pwm_chip, chip);
> > > > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > > > +     u32 enabled, duty, prescale;
> > > > +     u64 tmp;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks)=
;
> > > > +     if (ret) {
> > > > +             dev_err(spc->dev, "failed to enable pwm%u clocks\n",
> > > > +                     pwm->hwpwm);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     chn->clk_enabled =3D true;
> > > > +
> > > > +     duty =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY) & SPRD=
_PWM_REG_MSK;
> > > > +     prescale =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE=
) & SPRD_PWM_REG_MSK;
> > > > +     enabled =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE) &=
 SPRD_PWM_ENABLE_BIT;
> > > > +
> > > > +     /*
> > > > +      * According to the datasheet, the period_ns and duty_ns calc=
ulation
> > > > +      * formula should be:
> > > > +      * period_ns =3D 10^9 * (prescale + 1) * mod / clk_rate
> > > > +      * duty_ns =3D 10^9 * (prescale + 1) * duty / clk_rate
> > > > +      */
> > > > +     tmp =3D (prescale + 1) * 1000000000ULL * SPRD_PWM_MOD_MAX;
> > > > +     state->period =3D div64_u64(tmp, chn->clk_rate);
> > >
> > > This is not idempotent. If you apply the configuration that is return=
ed
> > > here this shouldn't result in a reconfiguration.
> >
> > Since we may configure the  PWM in bootloader, so in kernel part we
> > should get current PWM state to avoid reconfiguration if state
> > configuration are same.
>
> This is also important as some consumers might do something like:
>
>         state =3D pwm_get_state(mypwm)
>         if (something):
>                 state->duty =3D 0
>         else:
>                 state->duty =3D state->period / 2
>         pwm_set_state(mypwm, state)
>
> and then period shouldn't get smaller in each step.
> (This won't happen as of now because the PWM framework caches the last
> state that was set and returns this for pwm_get_state. Still getting
> this right would be good.)

I understood your concern, but the period can be configured in
bootloader, we have no software things to save the accurate period.
Moreover I think I can change to use DIV_ROUND_CLOSET_ULL to keep the
accuracy.

>
> > > > +     tmp =3D (prescale + 1) * 1000000000ULL * duty;
> > > > +     state->duty_cycle =3D div64_u64(tmp, chn->clk_rate);
> > > > +
> > > > +     state->enabled =3D !!enabled;
> > > > +
> > > > +     /* Disable PWM clocks if the PWM channel is not in enable sta=
te. */
> > > > +     if (!enabled) {
> > > > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->cl=
ks);
> > > > +             chn->clk_enabled =3D false;
> > > > +     }
> > > > +}
> > > > +
> > > > +static const struct pwm_ops sprd_pwm_ops =3D {
> > > > +     .config =3D sprd_pwm_config,
> > > > +     .enable =3D sprd_pwm_enable,
> > > > +     .disable =3D sprd_pwm_disable,
> > > > +     .get_state =3D sprd_pwm_get_state,
> > > > +     .owner =3D THIS_MODULE,
> > > > +};
> > > > +
> > > > +static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
> > > > +{
> > > > +     struct clk *clk_parent, *clk_pwm;
> > > > +     int ret, i, clk_index =3D 0;
> > > > +
> > > > +     clk_parent =3D devm_clk_get(spc->dev, "source");
> > > > +     if (IS_ERR(clk_parent)) {
> > > > +             dev_err(spc->dev, "failed to get source clock\n");
> > > > +             return PTR_ERR(clk_parent);
> > > > +     }
> > > > +
> > > > +     for (i =3D 0; i < SPRD_PWM_NUM; i++) {
> > > > +             struct sprd_pwm_chn *chn =3D &spc->chn[i];
> > > > +             int j;
> > > > +
> > > > +             for (j =3D 0; j < SPRD_PWM_NUM_CLKS; ++j)
> > > > +                     chn->clks[j].id =3D sprd_pwm_clks[clk_index++=
];
> > > > +
> > > > +             ret =3D devm_clk_bulk_get(spc->dev, SPRD_PWM_NUM_CLKS=
, chn->clks);
> > > > +             if (ret) {
> > > > +                     if (ret =3D=3D -ENOENT)
> > > > +                             break;
> > >
> > > devm_clk_bulk_get_optional ? I'm sure you don't want to get all 8 clo=
cks
> > > 8 times.
> >
> > This is not optional, each channel has 2 required clocks, and we have
> > 4 channels. (SPRD_PWM_NUM_CLKS =3D=3D 2)
>
> I see. Currently it is not possible to use channel 2 if there are no
> clocks for channel 0, right? There is no hardware related problem here,

Yes.

> just a shortcoming of the driver?

Yes.

>
> > > > +
> > > > +                     dev_err(spc->dev, "failed to get channel cloc=
ks\n");
> > > > +                     return ret;
> > > > +             }
> > > > +
> > > > +             clk_pwm =3D chn->clks[1].clk;
> > >
> > > This 1 looks suspicious. Are you using all clocks provided in the dtb=
 at
> > > all? You're not using i in the loop at all, this doesn't look right.
> >
> > Like I said above, each channel has 2 clocks: enable clock and pwm
> > clock, the 2nd clock of each channel's bulk clocks is the pwm clock,
> > which is used to set the source clock. I know this's not easy to read,
> > so do you have any good suggestion?
>
> Not sure this is easily possible to rework to make this clearer.
>
> Do these clks have different uses? e.g. one to enable register access
> and the other to enable the pwm output? If so just using

Yes.

> devm_clk_bulk_get isn't the right thing because you should be able know
> if clks[0] or clks[1] is the one you need to enable the output (or
> register access).

We've fixed the clock order in bulk clocks by the array
'sprd_pwm_clks', maybe I should define one readable macro instead of
magic number.

>
> > > > +             if (!clk_set_parent(clk_pwm, clk_parent))
> > > > +                     chn->clk_rate =3D clk_get_rate(clk_pwm);
> > > > +             else
> > > > +                     chn->clk_rate =3D SPRD_PWM_DEFAULT_CLK;
> > >
> > > I don't know all the clock framework details, but I think there are
> > > better ways to ensure that a given clock is used as parent for anothe=
r
> > > given clock. Please read the chapter about "Assigned clock parents an=
d
> > > rates" in the clock bindings and check if this could be used for the
> > > purpose here and so simplify the driver.
> >
> > Actually there are many other drivers set the parent clock like this,
> > and we want a default clock if failed to set the parent clock.
>
> These might be older than the clk framework capabilities, or the
> reviewers didn't pay attention to this detail; both shouldn't be a
> reason to not make it better here.

The clock framework supplies 'assigned-clocks' and
'assigned-clock-parents' properties to set parent, but for our case we
still want to set a default clock rate if failed to set parent when
met some abnormal things.

>
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int sprd_pwm_remove(struct platform_device *pdev)
> > > > +{
> > > > +     struct sprd_pwm_chip *spc =3D platform_get_drvdata(pdev);
> > > > +     int i;
> > > > +
> > > > +     for (i =3D 0; i < spc->num_pwms; i++)
> > > > +             pwm_disable(&spc->chip.pwms[i]);
> > >
> > > This is wrong. You must not call pwm_disable here. It's the consumer'=
s
> > > responsibility to disable the hardware.
> >
> > Emm, I saw some drivers did like this, like pwm-spear.c.
> > Could you elaborate on what's the problem if the driver issues pwm_disa=
ble?
>
> This is a function to be called from code that called pwm_get before
> (i.e. pwm consumers). This just doesn't explode because up to now the
> PWM framework is only a thin wrapper around the lowlevel driver
> callbacks.
>
> The reasoning is similar to what I wrote in commit
> f82d15e223403b05fffb33ba792b87a8620f6fee. I'd like to have a PWM_DEBUG
> setting that catches such problems but the discussion with Thierry to
> even document the expectations is stuck, see
> https://patchwork.ozlabs.org/patch/1021566/.
>

Thanks for your explanation, and I'll remove pwm_disable from driver.

Thanks for your comments.

--=20
Baolin Wang
Best Regards
