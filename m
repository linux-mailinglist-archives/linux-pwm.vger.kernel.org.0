Return-Path: <linux-pwm+bounces-2442-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170839075F5
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2024 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7143A288C7A
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2024 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA9148FFF;
	Thu, 13 Jun 2024 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="JPfDaIow"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF911494AC;
	Thu, 13 Jun 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290993; cv=none; b=QMEz3oBe4XTLG9hRE/P7W6RRJ6y0KJDnn01b+hemDNMTfvjdMwNTtXBkQ4VCDlEdq2FFIGaOTNFtkA2olpI0ZqlAqQNuF3ip82xzD1LvAbZIEu4VvIdub+aU10OF+LJhLRpz0rljrWVwtIdRY8EqR9aC5oYBdBzFYETeUQvO2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290993; c=relaxed/simple;
	bh=eDRUosPcVn8FXq3BOkao9YxZoLEVPNhNTeJ3UYuka3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=awHNaEv/lw2a7/okZC1M09Ti2u4k4ec/V+n2y8+prH7mN08TK9tL6JlC8QKRTH5NWMWvACfUxZzG4A2NaAvvmjHbPJTVuEFdtP2zDR6RFMMjdYMzN2HSVrEIufEZPRtl5nxB8coqz76sYzodDtw2blsRpnCp+r5KocsUUzkzAbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=JPfDaIow; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D44E6120005;
	Thu, 13 Jun 2024 18:03:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D44E6120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718290984;
	bh=TZO5FKnfdLf3+BDNI9OpSudEvUr/3a4vwS8jvLm/wHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=JPfDaIowoydrSjpWIZUsYTBJZoD+H3UC63kb9INCtqFCwLD/2fG8vKCv4Ul8n5+TZ
	 w+oyneTsRRJrF64wB1yPgXVV9Py+X6jXDOyttM6XykIkqzGMUW3RSPu7wTctb+FNDF
	 /wkQMowWVBx693zPZ83h8qnRaOwxMcWph3fwgIWVgjdOCvjA8KYWYqvy/bEO4KZJWr
	 KlKDNwLg/umhIVnPedtPufM618gRgaNd1OAbH36EaM+nFTL81ngggGarc18YuocV94
	 PdkXyyngwpjYYEZnASF2FakZFmRh2ARmdYg8e6fKWE5i6rFHqMArwwTwqX1/ZLcjbU
	 jH6I57gRtsJMA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 13 Jun 2024 18:03:04 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 13 Jun 2024 18:03:04 +0300
Message-ID: <ddc470fe-6d7d-4c5c-8de6-15cfd35d74cb@salutedevices.com>
Date: Thu, 13 Jun 2024 18:03:03 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH v8 1/2] pwm: meson: Add support
 for Amlogic S4 PWM
To: <kelvin.zhang@amlogic.com>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jerome
 Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Conor
 Dooley <conor+dt@kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Junyi Zhao
	<junyi.zhao@amlogic.com>, Rob Herring <robh@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
 <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185904 [Jun 13 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/13 10:31:00 #25588438
X-KSMG-AntiVirus-Status: Clean, skipped

If there's another series you can fix log messages and start it from 
low-case letter as in the rest of the file.

Either way
Reviewed-by: George Stark <gnstark@salutedevices.com>

On 6/13/24 14:46, Kelvin Zhang via B4 Relay wrote:
> From: Junyi Zhao <junyi.zhao@amlogic.com>
> 
> Add support for Amlogic S4 PWM.
> 
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   drivers/pwm/pwm-meson.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index b2f97dfb01bb..98e6c1533312 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -460,6 +460,37 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
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
> +		if (IS_ERR(meson->channels[i].clk))
> +			return dev_err_probe(dev,
> +					     PTR_ERR(meson->channels[i].clk),
> +					     "Failed to get clk\n");
> +
> +		ret = devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
> +					       meson->channels[i].clk);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to add clk_put action\n");
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct meson_pwm_data pwm_meson8b_data = {
>   	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> @@ -498,6 +529,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
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
> @@ -536,6 +571,10 @@ static const struct of_device_id meson_pwm_matches[] = {
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

