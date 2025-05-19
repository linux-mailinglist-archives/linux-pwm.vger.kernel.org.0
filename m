Return-Path: <linux-pwm+bounces-6009-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3958AABBE18
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D09189DEE4
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4AC275840;
	Mon, 19 May 2025 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKDFLM/c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F671DFD84;
	Mon, 19 May 2025 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658433; cv=none; b=L3N+T18CgO2qdDnQV5yzKLt2YDgGJQ0ySepicN9cBTy5nk1K+8db5rmABWkr7tiD846SZOq5ekZGI0RsKoUIdSrZUkGb+xthXI90sVhwxl8ibZ89BoBmBapWgyZlWJ2D+2VkNiBq4g2HqF4CY5KEGhGmhin6yRtTCH/Uaq8zuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658433; c=relaxed/simple;
	bh=dG9OJXrzeBQcmp2ENNcvBN9tLfbZo5E+wUXYJrzdr6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYiiOxfwwUp7cAh04NBekQUYqi5Cpky7Rfc/gBRdhGrQ5q3qnmHgM4gb7XAsVb6iyASxYWF29zyL25XaUU+pYxq1pgsPFMBci0wKcXqRCS+V+Bte/ha7E/yFucuwZCeMCNQpTRAkWFAw9fHe/iV4pDFHI7WkLvZ6wOdtLUsBVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKDFLM/c; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60119cd50b6so4891546a12.0;
        Mon, 19 May 2025 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747658430; x=1748263230; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9JSHeno+xJiiaDay6iz2yV2CTlTnkq+BUkMGKsqpt7M=;
        b=jKDFLM/cIQ447pesn4BKFzyjoXTltOSPGm7flBxjQ33AUNQ9JeCtKwnBYBUhslqI5X
         fpEgGxpBJfe0teAzYMBRBD9rLAHpkcknaRfzzb49izqnwu2QHHX9xCDGLnN/mqR+Wvy0
         PO/5VlF1KIjcY/HWOW/KnknIYxil0ZLChgtnFRvraho/WDa0y88VGe38dDCoMv9BvMQO
         k5O+96+mGIL14GIB29QhOY+bmeubOAcCQqQPcWABqfV1OA0SnOYfj4SzZzu/7afE7rM0
         gZIYAvAJLk3jQuW+53XFSXLYpQntP9XMEsW/JKY5qfXlun7WSSsdwvKaFHFOrYwqI91X
         rAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747658430; x=1748263230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JSHeno+xJiiaDay6iz2yV2CTlTnkq+BUkMGKsqpt7M=;
        b=YfwjJabZJBlz7so3BRS01KyMMUHBk8Y9B+JI2my0goF99dx36RVry1NnX1GDak5L7p
         3ZL1gIgT+QCeyZwWrL6pGvrT3kbFbTZqlfqTGtsan6qaKk/rQDfpeYDXuqey3MxUgfyR
         nkjfnPi55UBmOo1OxuW3jufFKUNnleZ5te8/pkWCHk3H/nQMBLWVJj0p7BM8fc0Di6VM
         xEkOZpU6cLoPY9xGdiB/yPzlkRi6U5ql+ASaLuLCyoQFS1z7VJCQC3v53Wp3KGZR8RL9
         RYBZpr3q11TKVkM0pGkmL/hGjufGXhjPhxbszg2ktdhlJiHoD1xHUFug1LFYO6kJ4kCS
         vIAA==
X-Forwarded-Encrypted: i=1; AJvYcCUnSckKwxNZoq3aoAyZZbXOeVKR2Qxf3TjWIhV2ZAkYz4ANcmfB8uj13Fzl6HU6gqzf6PGJi7i8v9RBLb6v@vger.kernel.org, AJvYcCVvYOblgDrs12nX0tfaCKX6XLdDQNpqeymOCai4Ec8ZZUkv9zwQvkKoRQrHwoEme4JP5o2tOn5Fb34TqA==@vger.kernel.org, AJvYcCXCQrFi3bfJf0I+MmvdcGo8NbbmR6q8AMJrRCHmObSe5a2AZzUGdYBZgL9xC/guYR2ExoNt/trhfbbx@vger.kernel.org
X-Gm-Message-State: AOJu0YzPk+A/L3+xsHZROsAZbt95qAvC1TnnrI55CfFUOgd0V7z25TT3
	nB4nUSaC/EZIEuxfvK+SyN5ZxNUY22iz4vzcLsOrcN4tarlrRI7/RWYg
X-Gm-Gg: ASbGncu0PXy0qsRepOL2Cri1qKO4n/BQEiCTtVG3ehcwDECcpvLK+xTUqDVrq4ByoDx
	zgHBHLgMTY9i3w+NGoqwaiAhiNsHF+SQkyqf6z5xcLSSRjgrLaQuyTUWvEUIXSwGQo8SsUvWcy0
	pjjppVntCaVux+xLi5wo4U/Yducwk6HaC2qZUAPbN1INz5VEG9WS53AE0WZZ39hsJHd+T0PcYoF
	MLEXvtjxy7MvyPwkgU3bGQ+/QVtLxaTjciD9F+PhUhVttYt6ISCKHTb1Z/R0ZCfcwbWaB1fV5QO
	SoSNSYK0rqcptCDeXAGlSiWgdCYQ85SsgODDWoGS0NRc9XFg3fYI12xA6UTj
X-Google-Smtp-Source: AGHT+IGvVkzIVWbfpQWFpqrdJS+tPeSk+0ZwUBS8L7f8oWG1HDIcHiEqiBPkSfBvh2zfXs+bntusQQ==
X-Received: by 2002:a17:906:f5a4:b0:ad2:450b:f8da with SMTP id a640c23a62f3a-ad52d4ca492mr1133788966b.19.1747658430184;
        Mon, 19 May 2025 05:40:30 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:604:5d00:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d49889asm590773066b.141.2025.05.19.05.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 05:40:29 -0700 (PDT)
Date: Mon, 19 May 2025 14:40:28 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <20250519124028.GA423953@legfed1>
References: <20250515-mc33xs2410-hwmon-v2-1-8d2e78f7e30d@liebherr.com>
 <mjmrgvw7dg6wlipvku4yzaazbxomsfpr42hdvh37c3r5zybjyh@4olym5bwde45>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mjmrgvw7dg6wlipvku4yzaazbxomsfpr42hdvh37c3r5zybjyh@4olym5bwde45>

Hi Uwe,

Am Fri, May 16, 2025 at 11:24:33AM +0200 schrieb Uwe Kleine-König:
> Hello Dimitri,
> 
> On Thu, May 15, 2025 at 02:40:54PM +0200, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > The MC33XS2410 provides temperature sensors for the central die temperature
> > and the four outputs. Additionally a common temperature warning threshold
> > can be configured for the outputs. Add hwmon support for the sensors.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> > Changes in v2:
> > - Remove helper mc33xs2410_hwmon_read_out_status and report the last
> >   latched status.
> > - Link to v1: https://lore.kernel.org/r/20250512-mc33xs2410-hwmon-v1-1-addba77c78f9@liebherr.com
> > ---
> 
> Mostly fine from my POV. I suggest to squash the following change into
> your patch:
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a0c077af9c98..d9bcd1e8413e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -425,7 +425,6 @@ config PWM_LPSS_PLATFORM
>  
>  config PWM_MC33XS2410
>  	tristate "MC33XS2410 PWM support"
> -	depends on HWMON || HWMON=n
>  	depends on OF
>  	depends on SPI
>  	help
> diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> index c1b99b114314..f5bba1a7bcc5 100644
> --- a/drivers/pwm/pwm-mc33xs2410.c
> +++ b/drivers/pwm/pwm-mc33xs2410.c
> @@ -163,7 +163,6 @@ static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val
>  	return mc33xs2410_write_reg(spi, reg, tmp);
>  }
>  
> -#if IS_ENABLED(CONFIG_HWMON)
>  static const struct hwmon_channel_info * const mc33xs2410_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(temp,
>  			   HWMON_T_LABEL | HWMON_T_INPUT,
> @@ -286,21 +285,20 @@ static const struct hwmon_chip_info mc33xs2410_hwmon_chip_info = {
>  static int mc33xs2410_hwmon_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> -	struct device *hwmon;
>  
> -	hwmon = devm_hwmon_device_register_with_info(dev, NULL, spi,
> -						     &mc33xs2410_hwmon_chip_info,
> -						     NULL);
> +	if (IS_REACHABLE(CONFIG_HWMON)) {
> +		struct device *hwmon;
>  
> -	return PTR_ERR_OR_ZERO(hwmon);
> -}
> +		hwmon = devm_hwmon_device_register_with_info(dev, NULL, spi,
> +							     &mc33xs2410_hwmon_chip_info,
> +							     NULL);
>  
> -#else
> -static int mc33xs2410_hwmon_probe(struct spi_device *spi)
> -{
> -	return 0;
> +		return PTR_ERR_OR_ZERO(hwmon);
> +	} else {
> +		dev_dbg(dev, "Not registering hwmon sensors\n");
> +		return 0;
> +	}
>  }
> -#endif
>  
>  static u8 mc33xs2410_pwm_get_freq(u64 period)
>  {
> @@ -523,7 +521,11 @@ static int mc33xs2410_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
>  
> -	return mc33xs2410_hwmon_probe(spi);
> +	ret = mc33xs2410_hwmon_probe(spi);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to register hwmon sensors\n");
> +
> +	return 0;
>  }
>  
>  static const struct spi_device_id mc33xs2410_spi_id[] = {

Perfering IS_REACHABLE over IS_ENABLED is fine for me. Is there a reason
why you just didn't replace IS_ENABLED with IS_REACHABLE ?

Best regards,
Dimitri Fedrau


