Return-Path: <linux-pwm+bounces-2094-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A038B13A2
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 21:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12EAB24A25
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E168178B4E;
	Wed, 24 Apr 2024 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHrIypZj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C00768E1
	for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987452; cv=none; b=tuczUvqMJeuUpfDFb3QkGIYf6JNvPi0xyu8F6K5BKPOl5LAABbd7+u2/sG6rmXqQ3ICZtNmtVKKKQNqeK8sbEikTulyPJzBf02p3cHeTlHcQ4IvOG6vBctiAi+Hf1+gbjyhpcce97bzAPq0dxoQnKC2LmTQDv0eWrtMLUZzlQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987452; c=relaxed/simple;
	bh=QuiGqNYK4cdps4RhJVDWFUWd1Kak+RK6M7PfXbL2cPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lomA2PJzJBgJf0TGW3FW9AFeXNZbNoR7JjYvGo8JDMoJ3Ve6QNgOZxFImBpQ8fEXnQRVzkuf6b7EH1KuZCHD3m6F3CMuJ3rdPuUdk2RuVvgkdx0Pvj6UN+BDaoTQOt0BVEUpZIoWB6cD/3fxNwM8ah2uef+2tCqBDq7W2lVcrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QHrIypZj; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2dae975d0dcso13832961fa.1
        for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713987449; x=1714592249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRQMK46HDuhLKU1QrN81gmIGPmB/RJZ6AB3Yod7zVCo=;
        b=QHrIypZj9zSuyv/DZI0WdaiIgaUAlvkX/02TG4Hdsu03m1Y7wQo2i+COqoXw388iI3
         BhhTqUoh6n1k/CHM7pzUIwyCHo59GbKyBfcOqqGJU8+cZBs80rVT4u6mEwM6XHffyWcq
         tZt/oZXT6ETNlcIGAEBkt4LS8jyaBVY+M4rqXeF9+UM/j46lnkIuPXdyFLAM2+LKsfKQ
         uhFLn3CMlVtPHSoqEOOZq5vFXnkjjecTtEeMsWD5VkiihC5+vgKOUitGBjxxi4exmzcA
         FkSbUCwOjzqOKA5sbkZcdTIfOGFKT+cMvgYKcXCrSBSxN8mpRSK0Az/X7vnaArvpxIgb
         Vo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987449; x=1714592249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRQMK46HDuhLKU1QrN81gmIGPmB/RJZ6AB3Yod7zVCo=;
        b=Xp5ghtvzycr7CmBmJj4LFTCY90ErTI7azBhY51Hj0Mw48E6yBbze3i2JxFSGK/bJ0O
         y5Tv6F6tXpiK6oHqTkSqlDlsRvsFM1lUJCS9Bor6UPN45TidgjhPUotwSkQuv2nO6qzW
         ByWx7CpZCD4hmq5POPVLmHiCECnUIDust1eZJeD0JCD+x4WGfwk/+CCDZSmLwS1LOVRC
         Lcr+jvyF54Y5LiZ32Z+rLu3rM1v+/kprsvLYOQVyn4MnBLX5bGtcZfYsK6cw/cFYLTEj
         B3X0hQMHzIearcKgeohXjoj0sfE9XJPxdTy7G0gBujqmiTA98tm830JIgMY3MqtkfO2F
         gvkQ==
X-Gm-Message-State: AOJu0YzKRQcDmoWaQaOgoohdAxYkaKRrRjNQvD0sDMX6gVPyBiSfbye+
	SFoxDrok3OEeaRKl3rvB1e6LYHM+0rU6FSSHC4wanNJO7baf6g1wDH6dXrynipI=
X-Google-Smtp-Source: AGHT+IGiRoHTTiEuE65JavqIJ1EiDt4nqgFHQU16wmeKJ3TTmtXrar1F+DhjaKBxGWJDHzT3hwV9pw==
X-Received: by 2002:a2e:3506:0:b0:2dc:f13f:8a96 with SMTP id z6-20020a2e3506000000b002dcf13f8a96mr187145ljz.5.1713987449211;
        Wed, 24 Apr 2024 12:37:29 -0700 (PDT)
Received: from [172.30.204.223] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id by7-20020a05651c1a0700b002dd2046afd8sm1361992ljb.97.2024.04.24.12.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 12:37:28 -0700 (PDT)
Message-ID: <af62742c-8d6d-4fa9-b2e4-f83253e6e388@linaro.org>
Date: Wed, 24 Apr 2024 21:37:25 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] pwm: Add SI-EN SN3112 PWM support
To: wuxilin123@gmail.com, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Junhao Xie <bigfoot@classfun.cn>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Molly Sophia <mollysophia379@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-2-e0aa05c991fd@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240424-ayn-odin2-initial-v1-2-e0aa05c991fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/24 17:29, Xilin Wu via B4 Relay wrote:
> From: Junhao Xie <bigfoot@classfun.cn>
> 
> Add a new driver for the SI-EN SN3112 12-channel 8-bit PWM LED controller.
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---

[...]

> +static int sn3112_set_en_reg(struct sn3112 *priv, unsigned int channel,
> +			     bool enabled, bool write)
> +{
> +	unsigned int reg, bit;
> +
> +	if (channel >= SN3112_CHANNELS)
> +		return -EINVAL;
> +
> +	/* LED_EN1: BIT5:BIT3 = OUT3:OUT1 */
> +	if (channel >= 0 && channel <= 2)
> +		reg = 0, bit = channel + 3;
> +	/* LED_EN2: BIT5:BIT0 = OUT9:OUT4 */
> +	else if (channel >= 3 && channel <= 8)
> +		reg = 1, bit = channel - 3;
> +	/* LED_EN3: BIT2:BIT0 = OUT12:OUT10 */
> +	else if (channel >= 9 && channel <= 11)
> +		reg = 2, bit = channel - 9;
> +	else
> +		return -EINVAL;
> +
> +	dev_dbg(priv->pdev, "channel %u enabled %u\n", channel, enabled);
> +	dev_dbg(priv->pdev, "reg %u bit %u\n", reg, bit);
> +	if (enabled)
> +		set_bit(bit, (ulong *)&priv->pwm_en_reg[reg]);
> +	else
> +		clear_bit(bit, (ulong *)&priv->pwm_en_reg[reg]);
> +	dev_dbg(priv->pdev, "set enable reg %u to %u\n", reg,
> +		priv->pwm_en_reg[reg]);
> +
> +	if (!write)
> +		return 0;
> +	return sn3112_write_reg(priv, SN3112_REG_PWM_EN + reg,
> +				priv->pwm_en_reg[reg]);

This looks like a weird reimplementation of regmap_update_bits


> +}
> +
> +static int sn3112_set_val_reg(struct sn3112 *priv, unsigned int channel,
> +			      uint8_t val, bool write)
> +{
> +	if (channel >= SN3112_CHANNELS)
> +		return -EINVAL;
> +	priv->pwm_val[channel] = val;
> +	dev_dbg(priv->pdev, "set value reg %u to %u\n", channel,
> +		priv->pwm_val[channel]);
> +
> +	if (!write)
> +		return 0;

There's only a single call, with write == true

> +	return sn3112_write_reg(priv, SN3112_REG_PWM_VAL + channel,
> +				priv->pwm_val[channel]);
> +}
> +
> +static int sn3112_write_all(struct sn3112 *priv)
> +{
> +	int i, ret;
> +
> +	/* regenerate enable register values */
> +	for (i = 0; i < SN3112_CHANNELS; i++) {
> +		ret = sn3112_set_en_reg(priv, i, priv->pwm_en[i], false);
> +		if (ret != 0)
> +			return ret;
> +	}
> +
> +	/* use random value to clear all registers */
> +	ret = sn3112_write_reg(priv, SN3112_REG_RESET, 0x66);
> +	if (ret != 0)

if (ret) is the same as if (ret != 0)

[...]

> +
> +	/* use random value to apply changes */
> +	ret = sn3112_write_reg(priv, SN3112_REG_APPLY, 0x66);

"a random value"? sounds suspicious..

> +	if (ret != 0)
> +		return ret;
> +
> +	dev_dbg(priv->pdev, "reinitialized\n");

Please remove such "got here" messages once you're done with testing
the driver locally

[...]

> +
> +#if IS_ENABLED(CONFIG_GPIOLIB)

I'm not sure this would be ever disabled on any embedded system nowadays.
Especially with I2C.

[...]

> +
> +	dev_info(&client->dev,
> +		 "Found SI-EN SN3112 12-channel 8-bit PWM LED controller\n");

This sort of message only makes sense if there's a CHIP_ID register that
you can actually validate. If you bind this driver to a device at the same
expected address, it will say it's there even if it's not.


> +	return 0;
> +}
> +
> +static void sn3112_pwm_remove(struct i2c_client *client)
> +{
> +	struct pwm_chip *chip = i2c_get_clientdata(client);
> +	struct sn3112 *priv = pwmchip_get_drvdata(chip);
> +
> +	dev_dbg(priv->pdev, "remove\n");
> +
> +	/* set software enable register */
> +	sn3112_write_reg(priv, SN3112_REG_ENABLE, 0);
> +
> +	/* use random value to apply changes */
> +	sn3112_write_reg(priv, SN3112_REG_APPLY, 0x66);
> +
> +#if IS_ENABLED(CONFIG_GPIOLIB)
> +	/* enable hardware shutdown pin */
> +	if (priv->sdb)
> +		gpiod_set_value(priv->sdb, 1);
> +#endif
> +
> +	/* power-off sn5112 power vdd */
> +	regulator_disable(priv->vdd);
> +
> +	pwmchip_remove(chip);

devm_pwmchip_add?

Konrad

