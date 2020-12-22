Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B511C2E0D71
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 17:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgLVQft (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Dec 2020 11:35:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:49887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgLVQft (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Dec 2020 11:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608654841;
        bh=2qHrVeF0hspGHjAMpPkADCdAp3z6v/tgvY4qkHKeB3A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NDmQXScjqf4YMa2Eg+jXOnbAMaXMEjbNhRKHPtBg5V4GbVeMbn5ZK8I0Io+v90yZP
         8G4d8awAgWvZ6njEGiOAEdVcgfnfgpii07dinRzYuZ90FAgxftfPmOjX0XRF+A4aYz
         2zhRM5pvhtZ8bmw3W0aR8TYZfey0flxBfiuri2ko=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1kGDic2wvL-00pc3M; Tue, 22
 Dec 2020 17:34:01 +0100
Subject: Re: [PATCH] pwm: bcm2835: Improve period and duty cycle calculation
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sean Young <sean@mess.org>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20201221165501.717101-1-u.kleine-koenig@pengutronix.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <3e202765-d747-148c-160d-21bacede6f13@gmx.de>
Date:   Tue, 22 Dec 2020 17:34:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221165501.717101-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XWI8AJaKpUXc05bqwVIrlD9oz7zBdyackPExuJu3XqiWpirY2Fd
 SseTwFZCgrULp9eLRfA6Iv44iRhREuVfSJnDFZOtwl89+w/m5/wPAVM+FZojDaBkOC80iRB
 nxDdSSMaiT8dixOMvuL92tQOJBvZFV3OpmHpL/vEL2zuUcDfMcE5Rxbw67TlTL2rulxOx70
 ROA4qFk03mOLhEHC/P/IQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UtrId62g7UU=:ZQzpBKdMzPlq641I5Q3QiQ
 KGwHLM5vFeFQMoAzk2gEguJ2jy1o1uR6nWxYKDuKJ4ZHgVLuR2YzVuoOYRcc8dmwjoFxWKoT7
 W2TwrvPJQYGPY0VY7j7Z+tQ8VeKMYEXCt4MMtYDLUsx7Wvg+VAaHstFUtxUH7gVrZPsWV9lTG
 LK+vHuKMPzr/ytsG0vq4A6tAX/Qb5sa8omCijeV3tFcc6ytr4rBEKRFfeO5FhCg2xr66dr3hr
 z2GK18lGkkbmqmnB3vznJ2infCJLLTCcYncNqo6ptMG3DBbmJCG5Ikt20NHfF5ahF1KiVjIO6
 2mz/kGLwR2UxporI6L7d1mzlym3TWXkM7j3JxEJROLkphHDz5lJlgqHVxbSNcO4aLHFxEMkK1
 Qe9xxSqlvxLmgXWcxXNYyE2SVyte/31CljV/eA9xM0Toi3OWRFu1KHX5lSVsX/R3gLo4MeNs4
 MH4h8fUKzGBjIww4ooq7dLcVk9vkv0XSDijKLXaumZD+nwBrAB68UZGuVIEVVwpJf5776ccfD
 mf3J+zr46kob8PRb7X0R3gq9pEsULVoEAggJMnTlA7mpK8qyKpa669zWHesYbTS4RkLzllH4a
 u8vF3S1GFZWt1+GF7QBB3/SWKTR+6rzihI19Jy+r7xsowkrO9hAtaK0Tt1HGAQJNaGpNBpsse
 pPkM4658q+vlvg/oVyK1KzodjFdoCF3eythPT1Uifl8IBEQIwCUDmVKvK4ASA+nq1nNmyMPuZ
 qIfl5hlMiUqKFVPFQf4fbdpb0YabQi7skqT7s7++BJ32hcZZIkiYW2RYinulIxH7TsUMMqVq4
 KZUIPgJtWkcRPBcmNmHVr+pm0gEuCZFtUNh2njZKX6G0K/sd4PlQ6I9UudO4ETdXPR8wxoUcy
 DYA3GxgBg5TviMI1tUww==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 21.12.20 at 17:55, Uwe Kleine-K=C3=B6nig wrote:
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
> during review of the bcm2835 driver I noticed this double division.
>
> I think the practical relevance is low however because the clock rate is
> fixed to 10 MHz on this platform which doesn't result in these
> deviations. (Is this right, what is the actual rate?)

clk_get_rate() on my Raspberry Pi 4 returns 9999999.

>
> Having said that this patch is only compile tested.

I tested this on the RP and everything still works so far, so FWIW
Tested-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>


> +
> +	if (state->period > max_period)
> +		period =3D max_period;
> +	else
> +		period =3D state->period;
> +

We return EINVAL if the value for period is too small, so should we not do=
 the
same for the case that the value is too high?

Regards,
Lino
