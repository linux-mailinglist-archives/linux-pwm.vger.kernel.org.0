Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B422D431E
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Dec 2020 14:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgLINVv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Dec 2020 08:21:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:37853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgLINVu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 9 Dec 2020 08:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607520006;
        bh=zAnsVzlKtDFf8rlLGKNYmI2t6mkp8AFROP2Nh83D9wg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EouvbU0ImX2++An5OBOZFOm10xCDo4svsKIWRMjnRTchfoQkTZGKKuKUrErkghdFS
         JBhXToGhRjPH+dr73QGZBHjiSLW2QJp7sF5yWkr13gz9WA8k/flCOtnNGVyT1vDBzI
         +9+FhCUSE5Ia5nsiiuN85XM5k/q4VDPyuSn/6lCs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [87.130.101.138] ([87.130.101.138]) by web-mail.gmx.net
 (3c-app-gmx-bap29.server.lan [172.19.172.99]) (via HTTP); Wed, 9 Dec 2020
 14:20:05 +0100
MIME-Version: 1.0
Message-ID: <trinity-d6d039f6-44e5-4c30-ad17-7fa4dbedcf7e-1607520005953@3c-app-gmx-bap29>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sean@mess.org, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH v3] pwm: bcm2835: Support apply function for atomic
 configuration
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 9 Dec 2020 14:20:05 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20201209070516.yw5bpsh474k7mnfx@pengutronix.de>
References: <1607464905-16630-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201209070516.yw5bpsh474k7mnfx@pengutronix.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:NeLwQDnZjDRL8pPhrfxRVEcfkhdsfwiPMYeKrVMjV4HKBqVeDxW4BRQnyU3BTU4pwIzdo
 qwj/9n0s31LBsymOdTEFiRxbi6ryFNc1khyxzDSHWG8JFR9G+VcblhAMo5xQUakJ/WdZ7D/39/qi
 PhhxzrZU4SwT0RW3mp/UVKYYh3LJagKxsMMMR3yWv7KGJZXmt+SdndWlfMykGEM9HkU3ZXazsCcs
 Hc6MyAghCIIa7VrXzxjOYzobL3sRWtrsOHxpOQW+QHI/Bve4opN+yDkJp4VeILr8jRX1Z+OUjdKG
 ek=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QFlLyWexZ84=:MoIzZjYkgsnTrcAqSQR4Zl
 n8e2SQ8lc9qo1MUO9BzPwcAIJjDb0D3lU9Kg6vdzuCfHjRI3V1rb8YO2WkhT1Se4oEB9DTaOT
 wE5X1if1qsuVz9nS75O4BJO3W24V2hlswA+7LDA0x/2rdwyLkZ0SqCROlyJTklIsbnQvp+CUk
 be80Xo3sOSBVet7IXChXIlkFmQRSTBfcvlehJ749JAIqvGBPokNi5Mz+IH7yYWB5d+PXkE/xo
 ffhHBrT7RwoYlraojMj6i2ypXOaFYg4YexjJvIPRJphV7SuMtGhHDCumbEOKgr0NOmWPhsryo
 9lPhMgW2193bh0NprsWxplha9HNVJIKt6fgHzhluWJIGeKAXGKdBAi5I9OtuYfKc3sI1VvsO/
 rmSdTz7j+SozQ+cxLu0QInfr+g2EUj+s0FszW4xPr07t/kKs/Uh4SyD2yTE9+TB/oWU7qvwyM
 B+KJ6D+BbZwW5gkzZnFQ/7OcWv9Jt/E/35HR/DuHpVyhi8fGqWXmLZG14/NR421TCIj9F+4E2
 7J5/FApM9vANn0NuDHtkjr7choqazVRx8vxqLS/Z53uCV+GOxLkmDVqbTEpQ44RLPYp0c/Yo7
 20aKSxAMq/BBQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe

> Hello Lino,
>
> On Tue, Dec 08, 2020 at 11:01:45PM +0100, Lino Sanfilippo wrote:
> > Use the newer .apply function of pwm_ops instead of .config, .enable,
> > .disable and .set_polarity. This guarantees atomic changes of the pwm
> > controller configuration. It also reduces the size of the driver.
> >
> > Since now period is a 64 bit value, add an extra check to reject perio=
ds
> > that exceed the possible max value for the 32 bit register.
> >
> > This has been tested on a Raspberry PI 4.
>
> This looks right, just two small nitpicks below.
>

>
> This cast isn't necessary. (And if it was, I *think* the space between
> "(u32)" and "period" is wrong. But my expectation that checkpatch warns
> about this is wrong, so take this with a grain of salt.)

OK, I will omit the cast in the next patch version (it was primarily
meant for documentation purposes but now it seems to me rather
unusual for kernel code)

>
> > -	value =3D readl(pc->base + PWM_CONTROL);
> > -	value &=3D ~(PWM_ENABLE << PWM_CONTROL_SHIFT(pwm->hwpwm));
> > -	writel(value, pc->base + PWM_CONTROL);
> > -}
> > +	/* set duty cycle */
> > +	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, scaler);
> > +	writel(val, pc->base + DUTY(pwm->hwpwm));
> >
> > -static int bcm2835_set_polarity(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > -				enum pwm_polarity polarity)
> > -{
> > -	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
> > -	u32 value;
> > +	/* set polarity */
> > +	val =3D readl(pc->base + PWM_CONTROL);
> >
> > -	value =3D readl(pc->base + PWM_CONTROL);
> > +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> > +		val &=3D ~(PWM_POLARITY << PWM_CONTROL_SHIFT(pwm->hwpwm));
> > +	else
> > +		val |=3D PWM_POLARITY << PWM_CONTROL_SHIFT(pwm->hwpwm);
> >
> > -	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> > -		value &=3D ~(PWM_POLARITY << PWM_CONTROL_SHIFT(pwm->hwpwm));
> > +	/* enable/disable */
> > +	if (state->enabled)
> > +		val |=3D PWM_ENABLE << PWM_CONTROL_SHIFT(pwm->hwpwm);
> >  	else
> > -		value |=3D PWM_POLARITY << PWM_CONTROL_SHIFT(pwm->hwpwm);
> > +		val &=3D ~(PWM_ENABLE << PWM_CONTROL_SHIFT(pwm->hwpwm));
> >
> > -	writel(value, pc->base + PWM_CONTROL);
> > +	writel(val, pc->base + PWM_CONTROL);
> >
> >  	return 0;
> >  }
> >
> > +
>
> I wouldn't have added this empty line. But I guess that's subjective. Or
> did you add this by mistake?

I cannot remember that the line was added by intention, so I am fine to re=
move it.

Thanks and regards,
Lino
