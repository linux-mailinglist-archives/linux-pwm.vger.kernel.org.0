Return-Path: <linux-pwm+bounces-2299-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A2B8D4BBC
	for <lists+linux-pwm@lfdr.de>; Thu, 30 May 2024 14:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F4B1C221C8
	for <lists+linux-pwm@lfdr.de>; Thu, 30 May 2024 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F39132113;
	Thu, 30 May 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="KxIG3iXU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB0132108;
	Thu, 30 May 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072417; cv=none; b=uFH+Wd15BWrIxScUwvgy2iFGVkdmNZ9o3x8Vl34zldkM7+x1P2IUNaC1YquCSW50Ou9hcpjsJRwnpdbKF6iQ4zP3Ab5UfAufYxqtQ3M/I+94myg7D+UyNh/XdAZ+1HFJn2B5/QBTW2rScV41sxdoLwwOrH0VbKc3JmKCM5xthc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072417; c=relaxed/simple;
	bh=dW4bcjlcOrtKrwSH6Xhx6UyOur/wI1upPgMKli7Ak5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h/XolkTKiUk76H84MCcOYdUv09Ju62qhHzkbdTi+TjQHFlwUYfY96F4zx8tUmG1gdKQGqGFQgS/n9RP4LzszIDu6mEcjaEkVRoyEO0fQoxoeQTEogHK6CoMvuDp8Hh2d2ARBSS4M1vRKEa+kpOyuk3x1JT6+FPZj58TUhudT3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=KxIG3iXU; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 246D8100076;
	Thu, 30 May 2024 15:33:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 246D8100076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1717072404;
	bh=Xn/eklJidr8sBeXDY6IWBvMAWwt7sfTy9eksj5XyJvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=KxIG3iXUl3iiOhQmBUtEL/wJ7WR5xReJ76YtQHimNvUy8OXYofFzwAtpRtQtwXpa1
	 6v/rwKnpFJ992GFzxsEOEhD9alaWG58FIw9CcYn+xCPy6lMVciPVBHLwUwy+0CMZ+g
	 QUJ4cqUCYkrUe7a5BqvemIQfL4EqVIt2FoaGRWpw31G6RLBlwDwvR1PABDHg/7jvQj
	 9iuxdZAFAggKpCXkbgkfw0+/9Gzj/fWNNiVz9cpZzcc4U8owBhb8YXp7hYHIsiWQEq
	 w0KTrWpyKwm3DDcC+Ew3Hte77RLgEHgSozCACEWD6uiZkT4dGNWIDGtDDMEyovLY2M
	 aQJRR1cvpPzdw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 30 May 2024 15:33:23 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 30 May 2024 15:33:23 +0300
Message-ID: <81bf75e9-6aac-4c18-aac7-3cb127d9a7b8@salutedevices.com>
Date: Thu, 30 May 2024 15:33:23 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH v6 1/2] pwm: meson: Add support
 for Amlogic S4 PWM
To: <kelvin.zhang@amlogic.com>
CC: Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>, Jerome
 Brunet <jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Conor
 Dooley <conor+dt@kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Junyi Zhao <junyi.zhao@amlogic.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, "kernel@salutedevices.com"
	<kernel@salutedevices.com>
References: <20240529-s4-pwm-v6-0-270f63049f20@amlogic.com>
 <20240529-s4-pwm-v6-1-270f63049f20@amlogic.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240529-s4-pwm-v6-1-270f63049f20@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185615 [May 30 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/30 07:25:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/30 07:25:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/30 07:20:00 #25352518
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Kelvin, Junyi

On 5/29/24 13:00, Kelvin Zhang via B4 Relay wrote:
> From: Junyi Zhao <junyi.zhao@amlogic.com>
> 
> Add support for Amlogic S4 PWM.
> 
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   drivers/pwm/pwm-meson.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index b2f97dfb01bb..a513ebbb5666 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -460,6 +460,47 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>   	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>   }
>   
> +static void meson_pwm_s4_put_clk(void *data)
> +{
> +	struct meson_pwm *meson = (struct meson_pwm *)data;
There's no need for type-casting. Here is maintainers' request for a 
similar case:
https://lore.kernel.org/lkml/CAHp75VeNijg6sXyW_frwD4siJ-LWBLBfVCmMDug8jYAVVg9Bmw@mail.gmail.com/

> +	int i;
> +
> +	for (i = 0; i < MESON_NUM_PWMS; i++)
> +		clk_put(meson->channels[i].clk);
> +}
> +
> +static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
> +{
> +	struct device *dev = pwmchip_parent(chip);
> +	struct device_node *np = dev->of_node;
> +	struct meson_pwm *meson = to_meson_pwm(chip);
> +	struct meson_pwm_channel *channel;
> +	int i, ret;
> +
> +	for (i = 0; i < MESON_NUM_PWMS; i++) {
> +		channel = &meson->channels[i];
> +		channel->clk = of_clk_get(np, i);
> +		if (IS_ERR(channel->clk)) {
> +			ret = PTR_ERR(channel->clk);
> +			dev_err_probe(dev, ret, "Failed to get clk\n");
> +			goto err;
> +		}
> +	}
> +	ret = devm_add_action_or_reset(dev, meson_pwm_s4_put_clk, meson);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +
> +err:
> +	while (--i >= 0) {
> +		channel = &meson->channels[i];
> +		clk_put(channel->clk);
> +	}
Just as in meson_pwm_s4_put_clk() you can write it shorter:
	while (--i >= 0)
		clk_put(meson->channels[i].clk);

> +
> +	return ret;
> +}
> +
>   static const struct meson_pwm_data pwm_meson8b_data = {
>   	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> @@ -498,6 +539,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>   	.channels_init = meson_pwm_init_channels_meson8b_v2,
>   };
>   
> +static const struct meson_pwm_data pwm_s4_data = {
> +	.channels_init = meson_pwm_init_channels_s4,
> +};
> +
>   static const struct of_device_id meson_pwm_matches[] = {
>   	{
>   		.compatible = "amlogic,meson8-pwm-v2",
> @@ -536,6 +581,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>   		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>   		.data = &pwm_g12a_ao_cd_data
>   	},
> +	{
> +		.compatible = "amlogic,meson-s4-pwm",
> +		.data = &pwm_s4_data
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> 

-- 
Best regards
George

