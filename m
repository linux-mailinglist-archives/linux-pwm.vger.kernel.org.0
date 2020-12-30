Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7362E7B06
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Dec 2020 17:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgL3QV0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Dec 2020 11:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgL3QVZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Dec 2020 11:21:25 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D6C06179C;
        Wed, 30 Dec 2020 08:20:45 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id q25so15738345otn.10;
        Wed, 30 Dec 2020 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kaKOMj3HUFKT00qKqs+P+UOKiqeyEkDl/aHWHZhY7t0=;
        b=P56V8HJtMvKUJCE7c4G/vUM4joj1rNZGM7xQpU9G/KzkxEd0g28EYZ6xNAYy2c5OSn
         TmLe+dOhvZTYus1KhDrlqHs7lq8XijY4rA1/ENNgHkaD5bmWx3TJKlni0ffjmVpAlYM5
         XEBGMPUGpzuIYRdkCa5IEIQQRiUZYNvQkNm4wZO0n3aqoC+40PDwowZAktu6yHb9AXr6
         LfnUIWT83Yy3SK7JMxbvLy5kzwimiugW5+LQx9THgPCQSndFb645CEuG9yBePgSdQAF0
         /H7tdYHRB7j8d06WfwKNvR2W6NDI3G524gPV7qRK5ZSsBF37ahVwEBD5sKCZC9gsdJsX
         AQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kaKOMj3HUFKT00qKqs+P+UOKiqeyEkDl/aHWHZhY7t0=;
        b=STzb0Xu3/h3Fxbv+hjdibZunkPlRkdQpxfH8YLtvidygN9ru9fgWe+NUAW74qn/f0E
         py+B6GH+8/nRYVI28uXjbLBpc5ijE+LuPe05yKryfmhvhDaZJWnvE8kZ1ZJ7dik19Haf
         Sq0hN0um2RiXNIPh0HyEw+42wN371oF92flMHmi+zl2lk0MXuSGZioNlqz+7XHZdbRhx
         f9AvngAJJ4davI5Nl+TjyDmubFrpTjhKucIIx0z85wJWBEYWdtGAIpJK3/ikR+p3QKAg
         HFafjps9tDxwZofII565ejeWKkLoiJ3hK1byKVLobCk6lvvgflf1o0HEiBq0MVaUgzci
         dVdg==
X-Gm-Message-State: AOAM5315hWFRgP1oMgjt8TZMtLu6EYJNYxCDJbaFnybydzgyKwDscEbv
        BmUkH0/nlInMrTiJc8itDYw=
X-Google-Smtp-Source: ABdhPJxyayBJ3Ss4JlHGrgdlSnVn2JlrP6FqN3anUH1T0ISTq0I/C7kyu1noSzKa5xL9BsiaOd5P8g==
X-Received: by 2002:a9d:a61:: with SMTP id 88mr37736451otg.18.1609345244597;
        Wed, 30 Dec 2020 08:20:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x1sm6295812ota.32.2020.12.30.08.20.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Dec 2020 08:20:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Dec 2020 08:20:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Ensure that calculation doesn't
 discard big period values
Message-ID: <20201230162042.GA102327@roeck-us.net>
References: <20201215092031.152243-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201215092031.152243-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Dec 15, 2020 at 10:20:30AM +0100, Uwe Kleine-König wrote:
> With MAX_PWM being defined to 255 the code
> 
> 	unsigned long period;
> 	...
> 	period = ctx->pwm->args.period;
> 	state.duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
> 
> calculates a too small value for duty_cycle if the configured period is
> big (either by discarding the 64 bit value ctx->pwm->args.period or by
> overflowing the multiplication). As this results in a too slow fan and
> so maybe an overheating machine better be safe than sorry and error out
> in .probe.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 1f63807c0399..ec171f2b684a 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -324,8 +324,18 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	ctx->pwm_value = MAX_PWM;
>  
> -	/* Set duty cycle to maximum allowed and enable PWM output */
>  	pwm_init_state(ctx->pwm, &state);
> +	/*
> +	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
> +	 * long. Check this here to prevent the fan running at a too low
> +	 * frequency.
> +	 */
> +	if (state.period > ULONG_MAX / MAX_PWM + 1) {
> +		dev_err(dev, "Configured period too big\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Set duty cycle to maximum allowed and enable PWM output */
>  	state.duty_cycle = ctx->pwm->args.period - 1;
>  	state.enabled = true;
>  
