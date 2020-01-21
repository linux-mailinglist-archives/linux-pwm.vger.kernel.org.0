Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0DA143597
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2020 03:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgAUCQ0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 21:16:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55856 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUCQ0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 21:16:26 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so590937pjz.5;
        Mon, 20 Jan 2020 18:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gLXjP8X2Zeb/RU/7hx4cipQE1z/yzC2KfTwuzJ11qFQ=;
        b=WLYDRUzcI9DVrnozRbXntvJrtd/agxRyE4YHBfk8k8QEWoxbNZe9WPYzSidngwUywf
         n8DhLlNvJboZUbkaBb6ifiJ/N/+cahS/GjqCRTA1P4ENURzzN+v4dsSuv2nZFYl0HGYr
         QSjWd90V9UNTIG8AspYWneg+wIRXR4KcgAcdEBjL1hFcwP7SNX7WLCFYjsJa5LOv/SFV
         iHzyNzJowp4S0cXVQD3JF5iEhBIxhrBXWhpSLdv6QAtGqCRxMjJS5hgS1DZFiq5FuG94
         0ReHgvA1ij8C6MhJq/fnGolVEIiRZZjuiss2uT1WSG5WLfo7amNbIOs/klz2e1AF+o6d
         vMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gLXjP8X2Zeb/RU/7hx4cipQE1z/yzC2KfTwuzJ11qFQ=;
        b=av+jkwYIalH9e++Rfavq6yV7ctQ+DOn3Txhh7dMZVOB8C/MpR+BO8y1aokut68TG4f
         GLS70SuG05IXgi2Js9wqds7webQ8Ru0z6NiXBV+JtuzEtJqvj1r9LjTcsbuVHcsLjmuC
         AcQpTgZdrw4uo33ocwHv+PZq+hq9OtED3vctzFhh9nk+LfBgbTAvbfepaKZgu/tq5Y8g
         AUlU8zpYCUhGDBMk216MWTcu0onEWpaRGvKPJ+iJgJavNKOS48RD3Jrg/8ql2kNGxTgp
         yRwUlW/4T/x8ZAPr/RFunFaVFtnQ5PNn60TkuUHH3CJobs2D3gs+/I4G5nNX5NNNDVbh
         nldw==
X-Gm-Message-State: APjAAAXbAKN6JtTxHblSShBNijx5k16FVtgh8f/zZhIduKZYxr0r0g/t
        e60rziLasjNO4yUZjcsxj20=
X-Google-Smtp-Source: APXvYqyOP5HMYNJRmYUdBWy8hYYcpqA69nsege8VW7ZF+vNPmQFhjtPBCy9XnIiT8aU3r+fx0+fxdw==
X-Received: by 2002:a17:902:9a8e:: with SMTP id w14mr2879404plp.315.1579572985597;
        Mon, 20 Jan 2020 18:16:25 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m71sm932106pje.0.2020.01.20.18.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jan 2020 18:16:24 -0800 (PST)
Date:   Mon, 20 Jan 2020 18:16:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] hwmon: (pwm-fan) stop fan on shutdown
Message-ID: <20200121021623.GA32430@roeck-us.net>
References: <1579534344-11694-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579534344-11694-1-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jan 21, 2020 at 12:32:24AM +0900, Akinobu Mita wrote:
> The pwm-fan driver stops the fan in suspend but leaves the fan on in
> shutdown.  It seems strange to leave the fan on in shutdown because there
> is no use case in my mind and the gpio-fan driver on the other hand stops
> in shutdown.
> 
> This change turns off the fan in shutdown.  If anyone complains then we'll
> add an optional property to switch the behavior.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kamil Debski <kamil@wypas.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Applied.

Thanks,
Guenter

> ---
> * v2
> - remove optional property and just turn off the fan in shutdown
> 
>  drivers/hwmon/pwm-fan.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 42ffd2e..30b7b3e 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -390,8 +390,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int pwm_fan_suspend(struct device *dev)
> +static int pwm_fan_disable(struct device *dev)
>  {
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>  	struct pwm_args args;
> @@ -418,6 +417,17 @@ static int pwm_fan_suspend(struct device *dev)
>  	return 0;
>  }
>  
> +static void pwm_fan_shutdown(struct platform_device *pdev)
> +{
> +	pwm_fan_disable(&pdev->dev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int pwm_fan_suspend(struct device *dev)
> +{
> +	return pwm_fan_disable(dev);
> +}
> +
>  static int pwm_fan_resume(struct device *dev)
>  {
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> @@ -455,6 +465,7 @@ MODULE_DEVICE_TABLE(of, of_pwm_fan_match);
>  
>  static struct platform_driver pwm_fan_driver = {
>  	.probe		= pwm_fan_probe,
> +	.shutdown	= pwm_fan_shutdown,
>  	.driver	= {
>  		.name		= "pwm-fan",
>  		.pm		= &pwm_fan_pm,
