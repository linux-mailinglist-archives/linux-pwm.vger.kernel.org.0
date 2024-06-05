Return-Path: <linux-pwm+bounces-2348-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE718FCDFF
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 14:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D916B1F242E2
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180CE196C93;
	Wed,  5 Jun 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="j5HwE2dp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D8196C8A;
	Wed,  5 Jun 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589584; cv=none; b=KAEffpeJHubC2Mqn8KEeZikMyfJwbmBwj5f9zGwpJBBVIvL+y1FGwG2ZHgMSw2SsgfLsIeUNda5YuZTILi7xu9ifpalNsgZZr4/pAOtkIyWEeWyCLffS5wqQU9YhBhXeMYNI+HsK9mAYXRI9AU2VlY8KZinhw2MyY9krUewv2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589584; c=relaxed/simple;
	bh=E+8fa5QckyNs0rg+CMmCRno+rSlQBw+/aLFaSLV9R3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hFy/4NE0HoIb9qdJnjHHibtDpJp7LpB95TmqFd10RO3mnPvbP7mbfm80u3NrodXYyT0o1slzGVhx97YjkkAlWbkM+LkkMciM+idWangch7Q1C9s37MLbcACSAqX0gzXx8V28K0XI2HLxD7/6DknMnjGc1jUG5VFaEaXJm6h8bv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=j5HwE2dp; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D8ECE120004;
	Wed,  5 Jun 2024 15:12:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D8ECE120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1717589575;
	bh=2z/5jcit4ED6/bQSchswwiQ4yyjb3x0SPW6la7FZmUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=j5HwE2dpDC/pSgVsdScU1ekDN807PhqvrNu1REDKtH+TW7clPibaT17Gun/hBAlDs
	 Ms8njuKLPRJT/oi70O7elwLn5sqGBgRrM4InJY5JddC/1wZf0ZIlLpoNP5poOF+wqU
	 04GnkPpYkoUp+0PkJgJ9A/vlYqeKgM2pK+qy5nPuZYSsMAghI4JQPU08Uqfgyya34o
	 +3uyK3HCXaXIQEQEaW0l2cN54GTo/BvDPWEmALJiaDdqDTw23LTOSJwHa2HvH835ac
	 mqugrFffhEICPsiajuaTuFB2/Ra7KA1xfGfRwYxKQjl0Xvks860w90TxAWXSlquyI9
	 Bd+snRZaT2IEA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  5 Jun 2024 15:12:55 +0300 (MSK)
Received: from [172.28.65.20] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 5 Jun 2024 15:12:55 +0300
Message-ID: <ce3c2772-8e91-4fd3-b52e-2a35d5759664@salutedevices.com>
Date: Wed, 5 Jun 2024 15:12:54 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH v7 1/2] pwm: meson: Add support
 for Amlogic S4 PWM
To: <kelvin.zhang@amlogic.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Junyi Zhao <junyi.zhao@amlogic.com>
References: <20240605-s4-pwm-v7-0-e822b271d7b0@amlogic.com>
 <20240605-s4-pwm-v7-1-e822b271d7b0@amlogic.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240605-s4-pwm-v7-1-e822b271d7b0@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185739 [Jun 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/05 08:34:00 #25451662
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Kelvin, Junyi

On 6/5/24 05:44, Kelvin Zhang via B4 Relay wrote:
> From: Junyi Zhao <junyi.zhao@amlogic.com>
> 
> Add support for Amlogic S4 PWM.
> 
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   drivers/pwm/pwm-meson.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index b2f97dfb01bb..4f01847525b2 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -460,6 +460,34 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>   	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>   }
>   
> +static void meson_pwm_s4_put_clk(void *data)
> +{
> +	struct clk *clk = data;
> +
> +	clk_put(clk);
> +}
> +
> +static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
> +{
> +	struct device *dev = pwmchip_parent(chip);
> +	struct device_node *np = dev->of_node;
> +	struct meson_pwm *meson = to_meson_pwm(chip);
> +	int i, ret;
> +
> +	for (i = 0; i < MESON_NUM_PWMS; i++) {
> +		meson->channels[i].clk = of_clk_get(np, i);
> +		if (IS_ERR(meson->channels[i].clk)) {
> +			ret = PTR_ERR(meson->channels[i].clk);
> +			dev_err_probe(dev, ret, "Failed to get clk\n");
> +			return ret;
> +		}
> +		devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
> +					 meson->channels[i].clk);

devm_add_action_or_reset() result should be checked

> +	}
> +
> +	return 0;
> +}

You can rewrite it a bit to always have a single allocation for devm node:

static void meson_pwm_s4_put_clk(void *data)
{
	struct meson_pwm *meson = data;
	int i;

	for (i = 0; i < MESON_NUM_PWMS; i++)
		clk_put(meson->channels[i].clk);
}

static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
{
	struct device *dev = pwmchip_parent(chip);
	struct device_node *np = dev->of_node;
	struct meson_pwm *meson = to_meson_pwm(chip);
	int i, ret;

	ret = devm_add_action(dev, meson_pwm_s4_put_clk, meson);
	if (ret)
		return ret;

	for (i = 0; i < MESON_NUM_PWMS; i++) {
		meson->channels[i].clk = of_clk_get(np, i);
		if (IS_ERR(meson->channels[i].clk)) {
			ret = PTR_ERR(meson->channels[i].clk);
			dev_err_probe(dev, ret, "Failed to get clk\n");
			return ret;
		}
	}

	return 0;
}


-- 
Best regards
George

