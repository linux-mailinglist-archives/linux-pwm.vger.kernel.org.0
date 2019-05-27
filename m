Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E832B516
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2019 14:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfE0M0x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 May 2019 08:26:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54007 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfE0M0w (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 May 2019 08:26:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id d17so2808041wmb.3
        for <linux-pwm@vger.kernel.org>; Mon, 27 May 2019 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IVzLJGX+MsmE++PjIznjRjrAkMHMmJHi4jtucTUiuuc=;
        b=f71JNsaDsE2CrHCXE59CaLNQDmC3DOXsCmgc2KFa2aXT/7SLbuXAS/VYyGWn2Za6zI
         NR62HtrFl8BR5iw2BrYb7GFNuw4YOjMMas9Ncz5AhXtXl60EU5KJNF2362gvM8Vm2Ytl
         LtBBxVyYDGqXUVoHIucDsPN4tVuL1UFVXpqT6Xw3+6ctqv46MDN+7/Gya0x9xly+wrJP
         YAUvYA8zBw+KOeNiyQERgiT/rB7dvmkhZvYKZ+AgZELOjiHZcwKc+Fsd/KraLANl62vD
         BXzqwcB0Ta+q0/uQSE3ev16+Z1s+SP0qCTxcbYppfsiNpVlaBzkRT6yBzuOAYPC003oO
         i4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IVzLJGX+MsmE++PjIznjRjrAkMHMmJHi4jtucTUiuuc=;
        b=jb3a+pnKrl1AacG6Zu1fV2zVQxacG1+No9uYWjB4HdkOTHNWCR54i7z9vjPVJNvScp
         z2hstzmSxaA5roVgfXSlTa006kScHicSpu8iX62d39ETAldrmKigzvCMZLjtDlf5+XZV
         c4MYyWsHAOGTA6aopPCcPi8/AwhzJo39wu1whYI0H6ERYbooSeJ2igKwS66oFXwK+iJk
         xjY0qElR1GB5WbV+fHRwVyn6A7dxs9rImDYpk2J8ZvabU1i4C4N52w4KYj30TFvOOJnc
         zbg1s36D6vb/YOkZJKzqwF4hYs1bZyvwp3C9/Ze4ac8+5UabbE07wxfU6Z0zurnRbXG/
         pIQA==
X-Gm-Message-State: APjAAAXyFhf+Crk0zzmalRtQkZm5nM8lLFNMYuUV4a3Cp0fhJBgragjQ
        d5RPzvFUSMFN1U/GNtg02gQl7A==
X-Google-Smtp-Source: APXvYqzC6r8dIkZ/r1ai8+S7e0Xsf+eUf1PZs6k1kuWcoBlp5qWJGGul/RRx+fWRP5pgO0v7rxKyhQ==
X-Received: by 2002:a1c:254:: with SMTP id 81mr9551903wmc.151.1558960009913;
        Mon, 27 May 2019 05:26:49 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a204sm4733445wmh.8.2019.05.27.05.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 05:26:49 -0700 (PDT)
Subject: Re: [PATCH 05/14] pwm: meson: don't duplicate the polarity internally
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-6-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <edb82eba-2576-f99a-5553-cec18ee292f1@baylibre.com>
Date:   Mon, 27 May 2019 14:26:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525181133.4875-6-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> Let meson_pwm_calc() use the polarity from struct pwm_state directly.
> This removes a level of indirection where meson_pwm_apply() first had to
> set a driver-internal inverter mask which was then only used by
> meson_pwm_calc().
> 
> Instead of adding the polarity as parameter to meson_pwm_calc() switch
> to struct pwm_state directly to make it easier to see where the
> parameters are actually coming from.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 84b28ba0f903..39ea119add7b 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -63,7 +63,6 @@ struct meson_pwm {
>  	struct pwm_chip chip;
>  	const struct meson_pwm_data *data;
>  	void __iomem *base;
> -	u8 inverter_mask;
>  	/*
>  	 * Protects register (write) access to the REG_MISC_AB register
>  	 * that is shared between the two PWMs.
> @@ -116,14 +115,17 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  }
>  
>  static int meson_pwm_calc(struct meson_pwm *meson,
> -			  struct meson_pwm_channel *channel, unsigned int id,
> -			  unsigned int duty, unsigned int period)
> +			  struct meson_pwm_channel *channel,
> +			  struct pwm_state *state)
>  {
> -	unsigned int pre_div, cnt, duty_cnt;
> +	unsigned int duty, period, pre_div, cnt, duty_cnt;
>  	unsigned long fin_freq = -1;
>  	u64 fin_ps;
>  
> -	if (~(meson->inverter_mask >> id) & 0x1)
> +	duty = state->duty_cycle;
> +	period = state->period;
> +
> +	if (state->polarity == PWM_POLARITY_INVERSED)
>  		duty = period - duty;
>  
>  	if (period == channel->state.period &&
> @@ -278,15 +280,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (state->period != channel->state.period ||
>  	    state->duty_cycle != channel->state.duty_cycle ||
>  	    state->polarity != channel->state.polarity) {
> -		if (state->polarity != channel->state.polarity) {
> -			if (state->polarity == PWM_POLARITY_NORMAL)
> -				meson->inverter_mask |= BIT(pwm->hwpwm);
> -			else
> -				meson->inverter_mask &= ~BIT(pwm->hwpwm);
> -		}
> -
> -		err = meson_pwm_calc(meson, channel, pwm->hwpwm,
> -				     state->duty_cycle, state->period);
> +		err = meson_pwm_calc(meson, channel, state);
>  		if (err < 0)
>  			return err;
>  
> @@ -520,7 +514,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  	meson->chip.of_pwm_n_cells = 3;
>  
>  	meson->data = of_device_get_match_data(&pdev->dev);
> -	meson->inverter_mask = BIT(meson->chip.npwm) - 1;
>  
>  	channels = devm_kcalloc(&pdev->dev, meson->chip.npwm,
>  				sizeof(*channels), GFP_KERNEL);
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
