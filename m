Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F7B2557CE
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Aug 2020 11:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgH1Jh4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Aug 2020 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbgH1Jhy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 05:37:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61665C061264
        for <linux-pwm@vger.kernel.org>; Fri, 28 Aug 2020 02:37:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so305001wmb.4
        for <linux-pwm@vger.kernel.org>; Fri, 28 Aug 2020 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Bw/hJUCksUzdnYz1OV2HXr3nd3wIg7/5HBoKNMsU7YU=;
        b=l9bHksVSc3466fdG9auSnxZgvNILFVOMJ1JD4XkUzy2/snmm4w6CGGgsQ8aer64RR5
         XRMTJa7zN7/aMkfzmRWeycIQOI+f9B8b6mOpmqnKWN4E177x0b2z+hiSY+BgH8vXLqIL
         URVBo7uIbqpigTS+JBP5hmly9B+FrIVMZOHN58pJtoMSltkOaVhLv6QaTkTMy7zEByY2
         dWVnOjDJgsomEGP1OI4j2E+ECT6ne6P+Ef6hitG0L2Rhxk8eyVJMZJrKQFZ1lRid9+bT
         ZZCIhXiz+ZjfCnIphZUqu25tw/8Z1ct4/SRRTi+HzLOqMpkvdrSCHhZ9y+Gl6dgTYUu4
         BAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Bw/hJUCksUzdnYz1OV2HXr3nd3wIg7/5HBoKNMsU7YU=;
        b=b+SMcANPk3XnwFICBSFat2YTyok508EU1nWRHbbZenAgmaHaixCeyAU/FrASzjcoH4
         dt5DMXop/bnuHpCjNMLbAjJ8nKKw0dRDYpRwjmXE6PXZ/5dvO4DZPVisEzaIU5obyxlD
         rr10tRGDH6Dl7sNPGez47W5UvI++j1dRYYTL6xnHuU/bE3RCvb6dqtlCzZKmq6SQBsai
         6gjqBCcubdeKt/yiUUKymUgR6q0JrEARfeEuQFSz9tFsfMyqCIee1tXFOppzJ+zkyTQr
         UpbL5THOSbr/arAorSI/ITJe2W1k/UalHrZbjNjW2W1FJ/f2tbfHTPfTqq9UWzPpF1iU
         3hOA==
X-Gm-Message-State: AOAM530eY5URnQ9qXa271XtjMN/r9xpRErDBncP5y9dEE7BHkHYYGr55
        Fj6lCBDzM7rIRq8R67ZlsLib2A==
X-Google-Smtp-Source: ABdhPJxl5wmAWuFFGhxJGgDkhxBj3PbLL7k0DpkB7xh5nKEYgMTIb7wUBb3Akksqx+Yq1ttHLfhxQw==
X-Received: by 2002:a7b:c925:: with SMTP id h5mr769066wml.28.1598607473006;
        Fri, 28 Aug 2020 02:37:53 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id 21sm1152049wrc.55.2020.08.28.02.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:37:52 -0700 (PDT)
Date:   Fri, 28 Aug 2020 10:37:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     David Jander <david@protonic.nl>
Cc:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] drivers: pwm: pwm-pca9685.c: Disable unused alternative
 addresses
Message-ID: <20200828093750.GE1826686@dell>
References: <20200820121358.729873-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820121358.729873-1-david@protonic.nl>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 20 Aug 2020, David Jander wrote:

> The PCA9685 supports listening to 1 or more alternative I2C chip addresses
> for some special features that this driver does not support.
> By default the LED ALLCALL address is active (default 0x70), which causes
> this chip to respond to address 0x70 in addition to its main address
> (0x41). This is not desireable if there is another device on the same bus
> that uses this address (like a TMP103 for example).
> Since this feature is not supported by this driver, it is best to disable
> these addresses in the chip to avoid unsuspecting bus collisions.

Nit: s/unsuspecting/unsuspected/

"Those unsuspecting bus collisions didn't know what hit them!"

> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/pwm/pwm-pca9685.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 76cd22bd6614..63ff1f22246d 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -58,6 +58,10 @@
>  #define PCA9685_MAXCHAN		0x10
>  
>  #define LED_FULL		(1 << 4)
> +#define MODE1_ALLCALL		(1 << 0)
> +#define MODE1_SUB3		(1 << 1)
> +#define MODE1_SUB2		(1 << 2)
> +#define MODE1_SUB1		(1 << 3)
>  #define MODE1_SLEEP		(1 << 4)
>  #define MODE2_INVRT		(1 << 4)
>  #define MODE2_OUTDRV		(1 << 2)

Nit: Consider converting these to BIT() in a subsequent patch.

> @@ -444,7 +448,7 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>  {
>  	struct pca9685 *pca;
>  	int ret;
> -	int mode2;
> +	int reg;
>  
>  	pca = devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
>  	if (!pca)
> @@ -461,19 +465,24 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, pca);
>  
> -	regmap_read(pca->regmap, PCA9685_MODE2, &mode2);
> +	regmap_read(pca->regmap, PCA9685_MODE2, &reg);
>  
>  	if (device_property_read_bool(&client->dev, "invert"))
> -		mode2 |= MODE2_INVRT;
> +		reg |= MODE2_INVRT;
>  	else
> -		mode2 &= ~MODE2_INVRT;
> +		reg &= ~MODE2_INVRT;
>  
>  	if (device_property_read_bool(&client->dev, "open-drain"))
> -		mode2 &= ~MODE2_OUTDRV;
> +		reg &= ~MODE2_OUTDRV;
>  	else
> -		mode2 |= MODE2_OUTDRV;
> +		reg |= MODE2_OUTDRV;
>  
> -	regmap_write(pca->regmap, PCA9685_MODE2, mode2);
> +	regmap_write(pca->regmap, PCA9685_MODE2, reg);
> +
> +	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
> +	regmap_read(pca->regmap, PCA9685_MODE1, &reg);
> +	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
> +	regmap_write(pca->regmap, PCA9685_MODE1, reg);
>  
>  	/* clear all "full off" bits */

Nit: Consider drafting a patch to make commenting more consistent in
     this file.  I suggest always starting with an uppercase char.

>  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);

The patch itself is generally okay though:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
