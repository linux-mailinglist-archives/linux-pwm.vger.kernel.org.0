Return-Path: <linux-pwm+bounces-1190-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8B5848738
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Feb 2024 16:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66E1B26D53
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Feb 2024 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840D15F549;
	Sat,  3 Feb 2024 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YNDnvWLU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F15F547
	for <linux-pwm@vger.kernel.org>; Sat,  3 Feb 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975270; cv=none; b=QeWcWx3eWasb0WCiNr2nIC889eYMSd6hQ4uCIxlIKemLQgF/8yJWNDoRumKtnZs5vf46rj6SDDpO29KXW3oh9/SeluBrzFw1C+Okwbf2FduuE02r8wS96UPvGLBHerx2vigc1D2M5oAal2R6i+1aLEgrLQq/DICk5z7rAts2dOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975270; c=relaxed/simple;
	bh=4VsMVgkKNr4aDxCymIdFswH9Cysdcq63FHQxspuGJ10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLbUOHLvSGy1tDWuQAoQAPPqViPTTPYazPSDDGYF7omiXmcEFU63sZmDvrObYjUrKQs0vWWffkzXeeaZI3eCcoZqFWtOKHxe/Uf03GBkOueJgeAoU7Ojp4M0SM5rQlXR/qN3OIhz79uSkR65QKWWzcCpRgisOh65Nn2+Lf7klqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YNDnvWLU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a35e9161b8cso406100766b.3
        for <linux-pwm@vger.kernel.org>; Sat, 03 Feb 2024 07:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706975267; x=1707580067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvbWoswNaGVqXOS/Y81TnW60rEhWx123p06GMhO9oQI=;
        b=YNDnvWLUtqeXV0Wa9QXVm+e7Um1UJwIYPo/ajBRNKX6e2wHjoa1eW/d1zeQ+qsmwGL
         u4wy5isX1JY5EcAt7W4RvOI8GxGXzdOIFjU3T5d8j+xya8A3oY6Mqyh7pDOdY+bDCy6U
         wzbYoX2eGOBokSX/xa0viOeqNZ9lg2G2wTbt0DvyhgljjGwJM2okZzUVox1+pTXavzdn
         hBtsKnd3shdaj2JJy6c6Kx1Neb6FeX4nsOVPIhQ2thqxQkIDoZNSm7ce0ngG5HtAdt7l
         nVXg3A9NXp+J+Mq8zYWhuNMHYgI4MkD7zlnqqKE/unHRFWKdKCP40o4hRwH0oV95YU0W
         CEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706975267; x=1707580067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvbWoswNaGVqXOS/Y81TnW60rEhWx123p06GMhO9oQI=;
        b=UZj5B1W4fEnOMumRPOs/IUtc3imtNCeo4bsmxrlh0JF2T0cAhucG4IaLSn6IlLAkN/
         n6BHs1Nr4fdyczC0LTG3s46FIKye46mQqOrFlf+j9+y9iTlS2tJC3jHtt/S4QrkYnZjA
         oi/W6H42jcDLz+5PVF2mbKwpNU9/OydtsOkO55ubie/Llpg0q67pmhCnDpcktrzqrzyv
         pwFfQTG88YoEnn4MKd67QAsz03BNKF2iI4fUe5PJFCidosFPhGMOXKXzq21Jw73rVcqy
         Ent7++ob2ptslTLK9K2FYlq+qNuPdBWu7r61kHHK6v45uPgyzFLLnadrNdI4q3095MVq
         yetw==
X-Gm-Message-State: AOJu0YxxQV46uUOg80BkhjvG7BFF+SuwFi0NOcinfa8VoKhteXgbAV7+
	omK4u0vcuhKhCnVy9Xf7rfxqZx+pbi40I57zv8mPNDbzVQ0fcGIywbjeSuftwhM8lTeGIl2NU/k
	y
X-Google-Smtp-Source: AGHT+IF3FvBatr0/ILHi1/5DIZyhaHerns1yE/6MyuJKC/c+Qzk0KG4qfh/Udos94Dx0DuHONsOCwQ==
X-Received: by 2002:a17:907:78ca:b0:a37:6519:93b2 with SMTP id kv10-20020a17090778ca00b00a37651993b2mr674088ejc.55.1706975267073;
        Sat, 03 Feb 2024 07:47:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXHnLnkAkbzF1cHsh8m55N0T+Xh7AnLtuglmUqu1nYk7oQu0ttshOtxZf0XgARNjnrjAxu/pc2MayQ4aZEGCoqiEz41ulAm7hBOkekcp+5TpPpZRjKxsNWnEgtoL4XnFf7HzMCnRyh0H7MousYD4LHuGjiBGWSjhbhUMawf3StPZ82i2wfVWlS1MJKYbiR7JhL8jJ2rx5qisexu3OYNoXcUVfWpZfsMB8P+dRieM/ps/58t7hcmZK+NEBG8ZnKerbfXVI14YmHTxac+n0QSCC4r9ySiCkzsBsweWC4HiamGv5YqS588yxWus7F0lFFjWFoUitY=
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id vq11-20020a170907a4cb00b00a36cc8c1bcbsm2119253ejc.173.2024.02.03.07.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 07:47:46 -0800 (PST)
Message-ID: <9e337e19-9aaf-45c4-b2ee-09f77e1680fd@tuxon.dev>
Date: Sat, 3 Feb 2024 17:47:45 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: atmel-hlcdc: Don't use pwm consumer API
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Boris Brezillon <bbrezillon@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <cover.1706269232.git.u.kleine-koenig@pengutronix.de>
 <6e34607828b290cd64ca9f82df40872853069f07.1706269232.git.u.kleine-koenig@pengutronix.de>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <6e34607828b290cd64ca9f82df40872853069f07.1706269232.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26.01.2024 14:04, Uwe Kleine-König wrote:
> Lowlevel driver callbacks are not supposed to use the consumer API
> functions. Currently this works, but with the upcoming locking changes
> this probably results in dead locks.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index 1f6fc9a9fcf3..2d64af045fc5 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -183,9 +183,10 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
>  static int atmel_hlcdc_pwm_suspend(struct device *dev)
>  {
>  	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
> +	struct pwm_device *pwm = &atmel->chip.pwms[0];
>  
>  	/* Keep the periph clock enabled if the PWM is still running. */
> -	if (!pwm_is_enabled(&atmel->chip.pwms[0]))
> +	if (!pwm->state.enabled)
>  		clk_disable_unprepare(atmel->hlcdc->periph_clk);
>  
>  	return 0;
> @@ -194,20 +195,17 @@ static int atmel_hlcdc_pwm_suspend(struct device *dev)
>  static int atmel_hlcdc_pwm_resume(struct device *dev)
>  {
>  	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
> -	struct pwm_state state;
> +	struct pwm_device *pwm = &atmel->chip.pwms[0];
>  	int ret;
>  
> -	pwm_get_state(&atmel->chip.pwms[0], &state);
> -
>  	/* Re-enable the periph clock it was stopped during suspend. */
> -	if (!state.enabled) {
> +	if (!pwm->state.enabled) {
>  		ret = clk_prepare_enable(atmel->hlcdc->periph_clk);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
> -				     &state);
> +	return atmel_hlcdc_pwm_apply(&atmel->chip, pwm, &pwm->state);
>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,

