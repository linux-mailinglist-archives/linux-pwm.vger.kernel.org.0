Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445F644747D
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Nov 2021 18:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhKGR1X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 7 Nov 2021 12:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhKGR1X (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 7 Nov 2021 12:27:23 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF4FC061570
        for <linux-pwm@vger.kernel.org>; Sun,  7 Nov 2021 09:24:40 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HnLhj59YMzQjmg;
        Sun,  7 Nov 2021 18:24:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1636305875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qDrFbbUdva7Hj0vvtfgxHWkjVV1eDZ7/ERKfM0Dpvw=;
        b=ptmGYqMARzQrj8m7tG2WZIQdDzhmJbLMTWQZxIGVaQF1BR56lqUxZNUnj4iN+11HNwERcL
        d/hpyzqx/2rVBs/Zk8BbTIj85Q2+nFUnsc+ZyorwGw5m9mCjtcgKQK+IfJRmDC9fVPClkh
        tKh9VQtV77Y0iU8n5HiV+4ZMZ3acWULxphqwGs0F6ggvV7HSUbpD8AgOUq8xTG2YJL7f5d
        +ykRSqEjsPVstjCPcl27Ft1lewaPCkQopo3b9JkOXP0M3umPmLd0+P+TfZSAm4hQTRq3A5
        Dkngyxtof56fIH2ocWmWB+jdR/d6iki0IChc0ZyL5IUq9eeNdUnCN/+TbChSZg==
Subject: Re: [PATCH] pwm: img: Implement .apply() callback
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
References: <20211029105617.210178-1-u.kleine-koenig@pengutronix.de>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <fd4c37fa-20a1-8883-21db-0905afff8422@hauke-m.de>
Date:   Sun, 7 Nov 2021 18:24:33 +0100
MIME-Version: 1.0
In-Reply-To: <20211029105617.210178-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7442222F
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/29/21 12:56 PM, Uwe Kleine-König wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply(). This just pushes down a slightly
> optimized variant of how legacy drivers are handled in the core.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I applied this patch on top of kernel 5.10 and the system still boots up 
on the CI40 and I can make a LED blink.

Tested-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>   drivers/pwm/pwm-img.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> index f97f82548293..1f3d6346ab86 100644
> --- a/drivers/pwm/pwm-img.c
> +++ b/drivers/pwm/pwm-img.c
> @@ -184,10 +184,33 @@ static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>   	pm_runtime_put_autosuspend(chip->dev);
>   }
>   
> +static int img_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	int err;
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (pwm->state.enabled)
> +			img_pwm_disable(chip, pwm);
> +
> +		return 0;
> +	}
> +
> +	err = img_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
> +	if (err)
> +		return err;
> +
> +	if (!pwm->state.enabled)
> +		err = img_pwm_enable(chip, pwm);
> +
> +	return err;
> +}
> +
>   static const struct pwm_ops img_pwm_ops = {
> -	.config = img_pwm_config,
> -	.enable = img_pwm_enable,
> -	.disable = img_pwm_disable,
> +	.apply = img_pwm_apply,
>   	.owner = THIS_MODULE,
>   };
>   
> 
> base-commit: 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
> 

