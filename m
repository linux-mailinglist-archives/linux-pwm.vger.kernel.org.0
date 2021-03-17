Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C34733ED3C
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Mar 2021 10:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCQJlw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Mar 2021 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCQJli (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Mar 2021 05:41:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9022C06174A
        for <linux-pwm@vger.kernel.org>; Wed, 17 Mar 2021 02:41:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 04AF81F44EA4
Subject: Re: [PATCH] pwm: cros-ec: Refuse requests with unsupported polarity
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
References: <20210312090058.386850-1-u.kleine-koenig@pengutronix.de>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <4d00dcb6-70ed-f528-0e49-5fc50aa63b8c@collabora.com>
Date:   Wed, 17 Mar 2021 10:41:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312090058.386850-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for your patch.

On 12/3/21 10:00, Uwe Kleine-König wrote:
> The driver only supports normal polarity and so should refuse requests
> for inversed polarity.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/pwm/pwm-cros-ec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index c1c337969e4e..349ba3f02a54 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -124,6 +124,9 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (state->period != EC_PWM_MAX_DUTY)
>  		return -EINVAL;
>  
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
>  	/*
>  	 * EC doesn't separate the concept of duty cycle and enabled, but
>  	 * kernel does. Translate.
> 
> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
> 
