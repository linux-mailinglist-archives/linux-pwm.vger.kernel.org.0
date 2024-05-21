Return-Path: <linux-pwm+bounces-2205-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF85D8CB3DA
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5566FB208F3
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101C22AEFB;
	Tue, 21 May 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="twf+yDEY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228417722;
	Tue, 21 May 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317427; cv=none; b=aXP8fqMY/QSfLVujeVfTXY7tStYnhv012OIU0GsHgdS1aZixEX/Mxv2vUzUWN+pTo4Uao+W7g20VjDUs+eacqwLaMlwSHeGc5VqAH3F5JXNYuqMADZqxAoxDUmI+ZDrHc5m+uwjqKKscfdb1qfu0Y6dx4Et4sql0AOoRXssGrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317427; c=relaxed/simple;
	bh=lRAe+LkKT4cBx4UtkXVFIn0h7vayN5ENbaTYWa1+Wc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e9bFpmRwi2UKgMEvg4iwBIK/LsV25lgNGlIn22r8KTXer3/sdadl/Je4OI+5FnTGeMBxAoxuUOVhEJzW19vAMud8ELPyIObucq88McQHoGKumZNvOGc4RTn8+3jFoE0FXdKXBctXzRT0n4MRL5JU3WbQilVR9w/Ma6YQFJCanJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=twf+yDEY; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2BB1F120005;
	Tue, 21 May 2024 21:50:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2BB1F120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1716317413;
	bh=layIMEI/pkFEQkS/PJJqywpWNGCjnNMloO+DcQbHo2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=twf+yDEYeGnc8V8rmhzGZNgtuCb1UG/9wxtYXD7uOUAfw8PWdYoIvnxNDrni9YUZF
	 pdhlqlgWSN6eAub5PMoPWf0CkTi682zSrm2bQ+7Qgr9MrbObX0iLFLuyCLueQ9Ugbg
	 9CAuInykDuKE50mG2TcWmCwYFRL3Nuzh9/TLt5Jw20e53jw0Uf6pIqu/0NMNCTj+pQ
	 //fUDTVaK9ycLN+YZwwGwPU5Dhl3HnMPC1HbzfUvEpDQTldPe8o9vK193kZ8/NOXc6
	 22ziJVXKTDc4ybFOgsz7ATDrkpILVsDSgFRc+EDbDlfxu0dReGzhVTLeoZbL0fCvZo
	 edxh+LI8gmvUw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 21 May 2024 21:50:12 +0300 (MSK)
Received: from [172.28.65.135] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 May 2024 21:50:12 +0300
Message-ID: <4fd9fe90-1da0-4b8c-8bc4-18b7a4dc38ab@salutedevices.com>
Date: Tue, 21 May 2024 21:50:12 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH v5 1/2] pwm: meson: Add support
 for Amlogic S4 PWM
To: <kelvin.zhang@amlogic.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Junyi Zhao <junyi.zhao@amlogic.com>,
	"kernel@salutedevices.com" <kernel@salutedevices.com>
References: <20240521-s4-pwm-v5-0-0c91f5fa32cd@amlogic.com>
 <20240521-s4-pwm-v5-1-0c91f5fa32cd@amlogic.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240521-s4-pwm-v5-1-0c91f5fa32cd@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185399 [May 21 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Tracking_dating_text_input_url}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;www.kernel.org:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/21 16:20:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/21 17:40:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/21 08:41:00 #25230763
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Kelvin, Junyi

On 5/21/24 11:31, Kelvin Zhang via B4 Relay wrote:
> From: Junyi Zhao <junyi.zhao@amlogic.com>
> 
> This patch adds support for Amlogic S4 PWM.

Please take a look at 
https://www.kernel.org/doc/html/v6.9/process/submitting-patches.html#describe-your-changes

It should be something like
Add support for Amlogic S4 PWM.


> 
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   drivers/pwm/pwm-meson.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index b2f97dfb01bb..9fea28a51921 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -460,6 +460,51 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>   	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>   }
>   
> +static void meson_pwm_s4_put_clk(void *data)
> +{
> +	int i;
> +	struct meson_pwm *meson;
> +	struct meson_pwm_channel *channel;
> +
> +	meson = (struct meson_pwm *)data;
You can initialize meson variable along with declaration; type casting 
is not needed

> +	for (i = 0; i < MESON_NUM_PWMS; i++) {
> +		channel = &meson->channels[i];
> +		clk_put(channel->clk);
> +	}
you can save 3 lines just by using clk_put(meson->channels[i].clk);

> +}
> +
> +static int meson_pwm_init_channels_meson_s4(struct pwm_chip *chip)
> +{
> +	int i, ret;
> +	struct device *dev = pwmchip_parent(chip);
> +	struct device_node *np = dev->of_node;
> +	struct meson_pwm *meson = to_meson_pwm(chip);
> +	struct meson_pwm_channel *channel;
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
> +
> +	return ret;
> +}
> +
>   static const struct meson_pwm_data pwm_meson8b_data = {
>   	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> @@ -498,6 +543,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>   	.channels_init = meson_pwm_init_channels_meson8b_v2,
>   };
>   
> +static const struct meson_pwm_data pwm_meson_s4_data = {
> +	.channels_init = meson_pwm_init_channels_meson_s4,
> +};
> +
according to already existing soc-specific named vars and functions
new names should be
static const struct meson_pwm_data pwm_s4_data
and
static int meson_pwm_init_channels_s4(struct pwm_chip *chip)

>   static const struct of_device_id meson_pwm_matches[] = {
>   	{
>   		.compatible = "amlogic,meson8-pwm-v2",
> @@ -536,6 +585,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>   		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>   		.data = &pwm_g12a_ao_cd_data
>   	},
> +	{
> +		.compatible = "amlogic,meson-s4-pwm",
> +		.data = &pwm_meson_s4_data
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> 

-- 
Best regards
George

