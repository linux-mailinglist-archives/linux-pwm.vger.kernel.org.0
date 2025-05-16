Return-Path: <linux-pwm+bounces-6000-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F004BAB93A6
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 03:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC894E82C3
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A9D221DB1;
	Fri, 16 May 2025 01:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7p6hAkV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EC21FF4E;
	Fri, 16 May 2025 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747359205; cv=none; b=ioK77YHO2cxoTs8hkDbducGZG6isqf8nCQfE4VxSR5gU8VmGzXKmiyKAVSLUMi+p0HAsBK/UnVFhOirSz0O9Cscz3TlPYTaFxabPmHO3RRwzKrExDZX7Du/PV8kxkeF4JK/pRWoo6fTHyNpkBMdHWGwzqET9JIgeo0N4PmYvzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747359205; c=relaxed/simple;
	bh=6tky0WRUnXN1pVa8ZWtAuOYVr0jmKviuD9iBrzuqbIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5GRIXtubpzd8WYabIB3CEF6upx9v72Lcef63QzKrhRoFczaRUbx8Fb5Rg0TesCW5F7fxX/7zWnTZHzbNxgdvDSHFr3ZMoveucy76GASts8mNV3LoxpVmslZ6adMfbvoSbpSsTId3qYo3f5l/Kz0LQcY1HVXG0sBUhloKuM/uL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7p6hAkV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7423fadbe77so1707310b3a.3;
        Thu, 15 May 2025 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747359203; x=1747964003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WcIMluiDhNsO88W6D0wBkTDK2MX1Icz6eAHmn+54U6U=;
        b=g7p6hAkV4XOkxcJUTaJ2eqnRUoHjlA8z8SPw7poOJsiNl9igshB0CtY99rbtcdvq8+
         RPdhoQfl7KhfGDruH6w1wqxcv1otqen8zoNWmaxSTwhjiGjziCkma396/W550D33qRSz
         vwARo5r3degQ6xxGCXMvK0iS2vndnKusVFIE3/5wU2LGLVPmeGEqmUwXr060RYwsrZop
         xm6qTCkzVagC+YR7rj548OO1Hu3zkwGE3L6Lm6KMI2bG36ch0sdOgqxTdt8T9DvME9GB
         F9OHFCiiMbTcmRO+UJ9d6P4y+2fgYVepDRaWDDHXP0RFS7C3RhqK7oUpUY4MztMeV8Pr
         w66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747359203; x=1747964003;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcIMluiDhNsO88W6D0wBkTDK2MX1Icz6eAHmn+54U6U=;
        b=oIUqQ9ioi8YzjDxx8yTxtZCY8eqaDeeLp63SIgsrzv6OUOgN8qOclF6Yiydvjinol9
         FRi7Pczm4oYOHIw6ETnb3TN8cdTaY7DnfpryR7QdMcbVbPB0Obku53OC/IGos/DOuxc/
         qCmRMqL7UD+JkXuFrjx2Xjfbx9vhALdVoWuy7av/w3DBepHa1uPxJTs6nadvz0W6y/bH
         KCyYc9bMXEXWXBMjV/D3i0KY8vmYOdV6ZbZEduW/wknrptMtQfIzRidAjymL04bDvSAS
         BSdCP2GGP26w5nDwcxRVWuEE0F9nyebeA8634AUpEkt5FHyPcARU+ZgmaTpXlD3Ge284
         NLhw==
X-Forwarded-Encrypted: i=1; AJvYcCUWOl06vY+ir25iwqQE9hjtXMg1Oz1TpU+TirwDKbN6GSA1ZFTABSohYl+x4+vbWu5PI2n+5yxUX6RkuEbr@vger.kernel.org, AJvYcCXMXJWtuVgJ6Vf41fRCJORWO0RePc8DaJ9PamYasb8enbXo4iDtwL1+Nf/V5umXN+gkpey05tARagGChA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/733GwZ32Kr0Naj2e6/D8mNo2JzIZYxKRo8qZwuNZeP40IJCV
	cjlcGYfd0qbluYhHJdu7BDekKgbkstdDFQ4VPaFzX7eaxJnLHT9UbT+o
X-Gm-Gg: ASbGncvgncKD7/VlseKDAROlXJS50mkZULsKFHNBLG4mWPkuOK3lx6MtNsDytauc7xM
	v+K270OaNpOwNUpb8w4L543x1ZCTymxSWvY8yY9v+ijHWotZEVr1Ghf1AL5VZRsYy00rhtr17Qp
	lvzSXxziJuDnMRzhwEIatbw5pNWcFgZL03QvCyR2sNlHnjVjZcdyBVxVW8kZoXw15Z2ZcjFtm0p
	xxbft6LFaY0bL9ZNsvi5WoW+0qT7pXTCiYQuvG9pPtBl7+Dd2fKxjbLOQjDfQKOmJAOfreoFTdy
	tqWGjsEF2smnDhwp80Q6yjy+TboakcoxagwPgZlQGoo+nvvmCIYWjpBHph+I5Ul/WWFa8DpjM3J
	tE8VqQHKU12CELgj90/hu4h1X
X-Google-Smtp-Source: AGHT+IFOvsbQY0wUwqEPfbiJr1nsDkpdmDzjCqH9S5CCdbeUWzfv441mFcoUPQncCq6t+RZuyX6cEQ==
X-Received: by 2002:a05:6a21:710a:b0:215:d4be:b0ad with SMTP id adf61e73a8af0-2170ce19e95mr1233767637.28.1747359202635;
        Thu, 15 May 2025 18:33:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9878b53sm439364b3a.152.2025.05.15.18.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 18:33:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <55789f60-fd7b-44d6-a757-2b4ca0f727c1@roeck-us.net>
Date: Thu, 15 May 2025 18:33:20 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: mc33xs2410: add support for temperature sensors
To: dimitri.fedrau@liebherr.com, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Jean Delvare <jdelvare@suse.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>
References: <20250515-mc33xs2410-hwmon-v2-1-8d2e78f7e30d@liebherr.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250515-mc33xs2410-hwmon-v2-1-8d2e78f7e30d@liebherr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/25 05:40, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> The MC33XS2410 provides temperature sensors for the central die temperature
> and the four outputs. Additionally a common temperature warning threshold
> can be configured for the outputs. Add hwmon support for the sensors.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

 From hwmon perspective:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> - Remove helper mc33xs2410_hwmon_read_out_status and report the last
>    latched status.
> - Link to v1: https://lore.kernel.org/r/20250512-mc33xs2410-hwmon-v1-1-addba77c78f9@liebherr.com
> ---
>   drivers/pwm/Kconfig          |   1 +
>   drivers/pwm/pwm-mc33xs2410.c | 164 ++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6faa8b2ec0a4844f667a84335f30bde44d52378e..0deaf8447f4302e7cfd3b4cb35c7d46ef19e006c 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -425,6 +425,7 @@ config PWM_LPSS_PLATFORM
>   
>   config PWM_MC33XS2410
>   	tristate "MC33XS2410 PWM support"
> +	depends on HWMON || HWMON=n
>   	depends on OF
>   	depends on SPI
>   	help
> diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> index a1ac3445ccdb4709d92e0075d424a8abc1416eee..c1b99b1143141242ce99782162ae05536dd88163 100644
> --- a/drivers/pwm/pwm-mc33xs2410.c
> +++ b/drivers/pwm/pwm-mc33xs2410.c
> @@ -21,6 +21,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
> +#include <linux/hwmon.h>
>   #include <linux/math64.h>
>   #include <linux/minmax.h>
>   #include <linux/module.h>
> @@ -29,6 +30,8 @@
>   
>   #include <linux/spi/spi.h>
>   
> +/* ctrl registers */
> +
>   #define MC33XS2410_GLB_CTRL			0x00
>   #define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
>   #define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
> @@ -51,6 +54,21 @@
>   
>   #define MC33XS2410_WDT				0x14
>   
> +#define MC33XS2410_TEMP_WT			0x29
> +#define MC33XS2410_TEMP_WT_MASK			GENMASK(7, 0)
> +
> +/* diag registers */
> +
> +/* chan in { 1 ... 4 } */
> +#define MC33XS2410_OUT_STA(chan)		(0x02 + (chan) - 1)
> +#define MC33XS2410_OUT_STA_OTW			BIT(8)
> +
> +#define MC33XS2410_TS_TEMP_DIE			0x26
> +#define MC33XS2410_TS_TEMP_MASK			GENMASK(9, 0)
> +
> +/* chan in { 1 ... 4 } */
> +#define MC33XS2410_TS_TEMP(chan)		(0x2f + (chan) - 1)
> +
>   #define MC33XS2410_PWM_MIN_PERIOD		488282
>   /* step in { 0 ... 3 } */
>   #define MC33XS2410_PWM_MAX_PERIOD(step)		(2000000000 >> (2 * (step)))
> @@ -125,6 +143,11 @@ static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
>   	return mc33xs2410_read_reg(spi, reg, val, MC33XS2410_FRAME_IN_DATA_RD);
>   }
>   
> +static int mc33xs2410_read_reg_diag(struct spi_device *spi, u8 reg, u16 *val)
> +{
> +	return mc33xs2410_read_reg(spi, reg, val, 0);
> +}
> +
>   static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val)
>   {
>   	u16 tmp;
> @@ -140,6 +163,145 @@ static int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u8 mask, u8 val
>   	return mc33xs2410_write_reg(spi, reg, tmp);
>   }
>   
> +#if IS_ENABLED(CONFIG_HWMON)
> +static const struct hwmon_channel_info * const mc33xs2410_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> +			   HWMON_T_ALARM,
> +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> +			   HWMON_T_ALARM,
> +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> +			   HWMON_T_ALARM,
> +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> +			   HWMON_T_ALARM),
> +	NULL,
> +};
> +
> +static umode_t mc33xs2410_hwmon_is_visible(const void *data,
> +					   enum hwmon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_alarm:
> +	case hwmon_temp_label:
> +		return 0444;
> +	case hwmon_temp_max:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int mc33xs2410_hwmon_read(struct device *dev,
> +				 enum hwmon_sensor_types type,
> +				 u32 attr, int channel, long *val)
> +{
> +	struct spi_device *spi = dev_get_drvdata(dev);
> +	u16 reg_val;
> +	int ret;
> +	u8 reg;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		reg = (channel == 0) ? MC33XS2410_TS_TEMP_DIE :
> +				       MC33XS2410_TS_TEMP(channel);
> +		ret = mc33xs2410_read_reg_diag(spi, reg, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* LSB is 0.25 degree celsius */
> +		*val = FIELD_GET(MC33XS2410_TS_TEMP_MASK, reg_val) * 250 - 40000;
> +		return 0;
> +	case hwmon_temp_alarm:
> +		ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel),
> +					       &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = FIELD_GET(MC33XS2410_OUT_STA_OTW, reg_val);
> +		return 0;
> +	case hwmon_temp_max:
> +		ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_TEMP_WT, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* LSB is 1 degree celsius */
> +		*val = FIELD_GET(MC33XS2410_TEMP_WT_MASK, reg_val) * 1000 - 40000;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int mc33xs2410_hwmon_write(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long val)
> +{
> +	struct spi_device *spi = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		val = clamp_val(val, -40000, 215000);
> +
> +		/* LSB is 1 degree celsius */
> +		val = (val / 1000) + 40;
> +		return mc33xs2410_modify_reg(spi, MC33XS2410_TEMP_WT,
> +					     MC33XS2410_TEMP_WT_MASK, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const char *const mc33xs2410_temp_label[] = {
> +	"Central die temperature",
> +	"Channel 1 temperature",
> +	"Channel 2 temperature",
> +	"Channel 3 temperature",
> +	"Channel 4 temperature",
> +};
> +
> +static int mc33xs2410_read_string(struct device *dev,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel, const char **str)
> +{
> +	*str = mc33xs2410_temp_label[channel];
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops mc33xs2410_hwmon_hwmon_ops = {
> +	.is_visible = mc33xs2410_hwmon_is_visible,
> +	.read = mc33xs2410_hwmon_read,
> +	.read_string = mc33xs2410_read_string,
> +	.write = mc33xs2410_hwmon_write,
> +};
> +
> +static const struct hwmon_chip_info mc33xs2410_hwmon_chip_info = {
> +	.ops = &mc33xs2410_hwmon_hwmon_ops,
> +	.info = mc33xs2410_hwmon_info,
> +};
> +
> +static int mc33xs2410_hwmon_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct device *hwmon;
> +
> +	hwmon = devm_hwmon_device_register_with_info(dev, NULL, spi,
> +						     &mc33xs2410_hwmon_chip_info,
> +						     NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon);
> +}
> +
> +#else
> +static int mc33xs2410_hwmon_probe(struct spi_device *spi)
> +{
> +	return 0;
> +}
> +#endif
> +
>   static u8 mc33xs2410_pwm_get_freq(u64 period)
>   {
>   	u8 step, count;
> @@ -361,7 +523,7 @@ static int mc33xs2410_probe(struct spi_device *spi)
>   	if (ret < 0)
>   		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
>   
> -	return 0;
> +	return mc33xs2410_hwmon_probe(spi);
>   }
>   
>   static const struct spi_device_id mc33xs2410_spi_id[] = {
> 
> ---
> base-commit: 7395eb13e3a85067de3e083d3781630ea303c0c4
> change-id: 20250507-mc33xs2410-hwmon-a5ff9efec005
> 
> Best regards,


