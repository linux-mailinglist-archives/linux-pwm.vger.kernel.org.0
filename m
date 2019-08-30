Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF0DA3D32
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Aug 2019 19:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfH3Rsu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 30 Aug 2019 13:48:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41936 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfH3Rst (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 30 Aug 2019 13:48:49 -0400
Received: from [104.132.1.107] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i3l0o-0005xA-HL; Fri, 30 Aug 2019 19:48:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <uwe@kleine-koenig.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 2/6] pwm: let pwm_get_state() return the last implemented state
Date:   Fri, 30 Aug 2019 19:48:35 +0200
Message-ID: <5802279.ETANMDGNFP@phil>
In-Reply-To: <20190824153707.13746-3-uwe@kleine-koenig.org>
References: <20190824153707.13746-1-uwe@kleine-koenig.org> <20190824153707.13746-3-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am Samstag, 24. August 2019, 17:37:03 CEST schrieb Uwe Kleine-König:
> When pwm_apply_state() is called the lowlevel driver usually has to
> apply some rounding because the hardware doesn't support nanosecond
> resolution. So let pwm_get_state() return the actually implemented state
> instead of the last applied one if possible.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>

With this applied, the display brightness on my rk3399-gru-scarlet gets
inverted. Now it's very bright on level 1 and very dim on the max level.

According to the debugfs, the inverted state changes:

OLD STATE:
----------
root@localhost:~# cat /debug/pwm
platform/ff420030.pwm, 1 PWM device
 pwm-0   (ppvar-bigcpu-pwm    ): requested enabled period: 3334 ns duty: 331 ns polarity: normal

platform/ff420020.pwm, 1 PWM device
 pwm-0   (ppvar-litcpu-pwm    ): requested enabled period: 3334 ns duty: 414 ns polarity: normal

platform/ff420010.pwm, 1 PWM device
 pwm-0   (backlight           ): requested enabled period: 999996 ns duty: 941148 ns polarity: normal

platform/ff420000.pwm, 1 PWM device
 pwm-0   (ppvar-gpu-pwm       ): requested enabled period: 3334 ns duty: 3334 ns polarity: normal

NEW STATE:
----------
root@localhost:~# cat /debug/pwm 
platform/ff420030.pwm, 1 PWM device
 pwm-0   (ppvar-bigcpu-pwm    ): requested enabled period: 3334 ns duty: 331 ns polarity: normal

platform/ff420020.pwm, 1 PWM device
 pwm-0   (ppvar-litcpu-pwm    ): requested enabled period: 3334 ns duty: 414 ns polarity: normal

platform/ff420010.pwm, 1 PWM device
 pwm-0   (backlight           ): requested enabled period: 999996 ns duty: 941148 ns polarity: inverse

platform/ff420000.pwm, 1 PWM device
 pwm-0   (ppvar-gpu-pwm       ): requested enabled period: 3334 ns duty: 3334 ns polarity: normal


And the reason is below.

> ---
>  drivers/pwm/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 72347ca4a647..92333b89bf02 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -473,7 +473,14 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>  		if (err)
>  			return err;
>  
> -		pwm->state = *state;
> +		/*
> +		 * .apply might have to round some values in *state, if possible
> +		 * read the actually implemented value back.
> +		 */
> +		if (chip->ops->get_state)
> +			chip->ops->get_state(chip, pwm, &pwm->state);
> +		else
> +			pwm->state = *state;

This should probably become
>-		pwm->state = *state;
> +
> +		/*
> +		 * .apply might have to round some values in *state, if possible
> +		 * read the actually implemented value back.
> +		 */
> +		if (chip->ops->get_state)
> +			chip->ops->get_state(chip, pwm, &pwm->state);

so always initialize the state to the provided one and then let the driver
override values?

The inversion case stems from the Rockchip pwm driver (wrongly?) only
setting the polarity field when actually inverted, so here the polarity field
probably never actually got set at all.

But while we should probably fix the rockchip driver to set polarity all the
time, this is still being true for possible future state-fields, which also
wouldn't get initialzed from all drivers, which might need an adaption
first?


Heiko


>  	} else {
>  		/*
>  		 * FIXME: restore the initial state in case of error.
> 




