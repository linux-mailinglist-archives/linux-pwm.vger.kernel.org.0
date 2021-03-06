Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6512432FC7A
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Mar 2021 19:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCFS25 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 6 Mar 2021 13:28:57 -0500
Received: from mout.gmx.net ([212.227.15.18]:34415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhCFS2p (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 6 Mar 2021 13:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615055312;
        bh=Ebo12erHvef4fa/y2X8RBysAnlBXqC3CQSnY5BeSMLI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=G0UFpzYxbnbdiq4yjf9VbWHbSs6nnYTwq/3WO3RZ88sjN+R0pwX/2kj2XjnI0yhtO
         enSaey7zWS5S6m9QHv9PEF+tGYrpXa1kqSTksTvkz2Kd/ESyAvz3jc9V8nHHs7KGeL
         Mq+pHVNTY0urKc+P/V8SFszPsenccnqzDMDTiYfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1lckJF3p4Y-00utFq; Sat, 06
 Mar 2021 19:28:32 +0100
Subject: Re: [PATCH v3] pwm: bcm2835: Improve period and duty cycle
 calculation
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sean Young <sean@mess.org>
Cc:     linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20210114204804.143892-1-u.kleine-koenig@pengutronix.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <f51690b2-abcf-9d1e-e301-5afb865e5779@gmx.de>
Date:   Sat, 6 Mar 2021 19:28:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114204804.143892-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vmMyDO1Au/8ha8oltIhFPk76xB9dz+9FxdnrJDjRP57DO5P/Zfd
 Ens6DhOMsV8zPIJGD8+OMQmrAZSXLVSCI33blD5o+hfLWT6EsbqKprvBxIy/qAxCOSubBje
 EhTjTjuk2+lByAhqxx+IXiIRrVSKJwm+JPlBhh2y6K2M0eU5iz8ojPj7SgH0ccX5quhbBKF
 kwH1F2BOUuZJNYPkxBhQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rCmrb+qk9YE=:mwR+p2SukKtpPh+oh8mXaD
 5/Yz0ZNKDvevOB3OI4s0ezXaOwbh+fYUJfarWUre7v6ig/xPN0VWgNArURbWWv2Ny7tox7I3w
 sQoUaCOM6bXzyZkkvM0KlREXDIx1cEb8h9wQpTgaA63T0oSw+0sq16hBExLUo7EDXyUODSA/c
 Z4t8eCMj0+6U/kA+vaVne48NQGDBA+cn9s6qPuNOU5DhKPPgRuxsP8rz9iZQbdAxJzGXXMhJQ
 5R92/frnVxTODT4rb+iP3TKiG0DdYpdgTB7VpOlcq469HjLh52Z8QCWyHHecL8CWAVipMlyob
 aAK/AFvHCHdfS69xA6JryVqDrwrU1Tk0Gq8hSZSmJuaRd4CsxOrEhDHnnWxEu0oCNbf6MDx2A
 k5Z5gReSkY7kTclxBo7iNKoZgvIls5UPyte7Lmd3jbekyj9i2ViDAa9l3dCSSddEaD7/hOgiO
 1m3AeKDjPjkHZRGdUr3sjJp5d5aLpsadwecY/D8rhzysuFP7WVjWSBxFG99bT1tNPrW9v2Y9+
 LMehk3nz0uMLKycAXHN/yAMNFx3vx95w+gNrxl+f6Av9AMf561wfCMPHCb7/PPaTx891BB+02
 7x9vL7O7k19L6/hvcSioLBQxaDf3EBr2sHwbUPl42E43LHYRaNRFxO7LvYLYI4Ii8V0lX9lOY
 YwePX8to0b1wrCDSBNnrpNUdsFHbDShvII3dZcKuwGlYz1DKCvI9H1+a56FYgK8dcEryfmOQB
 1OlsANVfqRvwdmPsVOwNcPThpST9VAgb/A9+XsuVEqvKJdB+vwOGVZO9Uwf7/JzCTaaktiEGL
 nLyyvpSUpm16Pkox1ylaJ97D47V0teT302foCabFwwehoE6XbMUL2Or+n0sGs+USPwA0BZU9Y
 0toO73h+vdng+KvtWeVw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 14.01.21 at 21:48, Uwe Kleine-K=C3=B6nig wrote:
> With an input clk rate bigger than 2000000000, scaler would have been
> zero which then would have resulted in a division by zero.
>
> Also the originally implemented algorithm divided by the result of a
> division. This nearly always looses precision. Consider a requested peri=
od
> of 1000000 ns. With an input clock frequency of 32786885 Hz the hardware
> was configured with an actual period of 983869.007 ns (PERIOD =3D 32258)
> while the hardware can provide 1000003.508 ns (PERIOD =3D 32787).
> And note if the input clock frequency was 32786886 Hz instead, the hardw=
are
> was configured to 1016656.477 ns (PERIOD =3D 33333) while the optimal
> setting results in 1000003.477 ns (PERIOD =3D 32787).
>
> This patch implements proper range checking and only divides once for
> the calculation of period (and similar for duty_cycle).
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> changes since v2 (Message-Id:
> 20201222221319.2101107-1-u.kleine-koenig@pengutronix.de):
>
>  - Add my calculation to the comment explaining the max_period formula
>    as discussed with Lino.
>
> Best regards
> Uwe
>
>  drivers/pwm/pwm-bcm2835.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index 6ff5f04b3e07..d593cce249d9 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -64,8 +64,9 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>
>  	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
>  	unsigned long rate =3D clk_get_rate(pc->clk);
> -	unsigned long long period;
> -	unsigned long scaler;
> +	unsigned long long period_cycles;
> +	u64 max_period;
> +
>  	u32 val;
>
>  	if (!rate) {
> @@ -73,18 +74,36 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  		return -EINVAL;
>  	}
>
> -	scaler =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);
> +	/*
> +	 * period_cycles must be a 32 bit value, so period * rate / NSEC_PER_S=
EC
> +	 * must be <=3D U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
> +	 * multiplication period * rate doesn't overflow.
> +	 * To calculate the maximal possible period that guarantees the
> +	 * above inequality:
> +	 *
> +	 *     round(period * rate / NSEC_PER_SEC) <=3D U32_MAX
> +	 * <=3D> period * rate / NSEC_PER_SEC < U32_MAX + 0.5
> +	 * <=3D> period * rate < (U32_MAX + 0.5) * NSEC_PER_SEC
> +	 * <=3D> period < ((U32_MAX + 0.5) * NSEC_PER_SEC) / rate
> +	 * <=3D> period < ((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate
> +	 * <=3D> period <=3D ceil((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / =
rate) - 1
> +	 */
> +	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER=
_SEC / 2, rate) - 1;
> +
> +	if (state->period > max_period)
> +		return -EINVAL;
> +
>  	/* set period */
> -	period =3D DIV_ROUND_CLOSEST_ULL(state->period, scaler);
> +	period_cycles =3D DIV_ROUND_CLOSEST_ULL(state->period * rate, NSEC_PER=
_SEC);
>
> -	/* dont accept a period that is too small or has been truncated */
> -	if ((period < PERIOD_MIN) || (period > U32_MAX))
> +	/* don't accept a period that is too small */
> +	if (period_cycles < PERIOD_MIN)
>  		return -EINVAL;
>
> -	writel(period, pc->base + PERIOD(pwm->hwpwm));
> +	writel(period_cycles, pc->base + PERIOD(pwm->hwpwm));
>
>  	/* set duty cycle */
> -	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle, scaler);
> +	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * rate, NSEC_PER_SEC);
>  	writel(val, pc->base + DUTY(pwm->hwpwm));
>
>  	/* set polarity */
>

I was able to test this now and everything looks good.

Tested-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

Best Regards,
Lino
