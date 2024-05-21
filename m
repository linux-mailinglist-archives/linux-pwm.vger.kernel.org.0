Return-Path: <linux-pwm+bounces-2213-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 962208CB5E9
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 00:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559EE282D24
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 22:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3D149C6A;
	Tue, 21 May 2024 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="IC/aGxvm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C41865A;
	Tue, 21 May 2024 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716329889; cv=none; b=oUfNljSuHT/2748dPKOgNafqCuZvgGI2ek+SkFsVNt9E2E3bLKjEMuadzMcpdSB4qvBDAeKkq0AKjLFYzBaNrXSZH7DjSTdPkLIw4EMlZ8FIXGMWRt6vuB9/b/56xS1OXLVVL8IDHikQdR1usLJwuB2PtH698L0tMgW3guMbntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716329889; c=relaxed/simple;
	bh=SeLo2TzoPZmRCROP3xeS9xNG8LTfQBWVoigFnZMbfhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DpQDwOZH508Z5dAiNHuLurglm+5CUUxu5iQUNJCjS0IsN7ewynH9xvO4D0PZPGH+b7m2Sa+kJTXlfeEj2WhN6uepx7lpHYpnVAqQyEs+8c/Ka4FplleT3SHPHPWZ9Zq5ALKXSRGN9XE1bJ12Pu31z1PlxfNAHTF8Wfr+nIrZcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=IC/aGxvm; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B62CD10000F;
	Wed, 22 May 2024 01:17:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B62CD10000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1716329875;
	bh=IlVnMWoOm8OINmNC56cel4gwgIlkbosRXGc5fhbKMqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=IC/aGxvmS9k17J2eAcUiVR3k86n4j0Lq2Gb/oIGAYLYK0uPeXYfNBKv4N7xUjpw7x
	 LzZAyi6dLy5H9h3MG6dIBLBoZAHaw70sDtOYz71kRoK8J8mjIS2OpsU+65k0hWbke4
	 ENQH2NP7c2GD+TbRPQkxPNKn1BC8cMUaSckOvBVz4EYMRf/NngLLm3lHr7w6XpSAka
	 k5a6miT3WPDepPh0UsW0lvYQw5ER00KdlLDMLV/IzLX4GoJjbrAkxUjAmrHHvzMu3N
	 BvZ3ICUwH3kNnRTS8DSvq/QCfJV60LeXQMXhB1tBrUNWBocyt69PCoguuflIfUBf4S
	 3AK3f2qPeYPpw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 22 May 2024 01:17:55 +0300 (MSK)
Received: from [172.28.65.135] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 May 2024 01:17:55 +0300
Message-ID: <11ad766f-0fc7-4d26-aad6-a98095986b24@salutedevices.com>
Date: Wed, 22 May 2024 01:17:54 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH v5 2/2] arm64: dts: amlogic: Add
 Amlogic S4 PWM
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
 <20240521-s4-pwm-v5-2-0c91f5fa32cd@amlogic.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240521-s4-pwm-v5-2-0c91f5fa32cd@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185400 [May 21 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/21 08:41:00 #25230763
X-KSMG-AntiVirus-Status: Clean, skipped


Hello Kelvin, Junyi

On 5/21/24 11:31, Kelvin Zhang via B4 Relay wrote:
> From: Junyi Zhao <junyi.zhao@amlogic.com>
> 
> Add device nodes for PWM_AB, PWM_CD, PWM_EF, PWM_GH and PWM_IJ
> along with GPIO PIN configs of each channel.
> 
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 207 ++++++++++++++++++++++++++++++
>   1 file changed, 207 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index 10896f9df682..d0c170368892 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -292,6 +292,168 @@ mux {
>   					};
>   				};
>   
...
> @@ -449,6 +611,51 @@ i2c4: i2c@6e000 {
>   				status = "disabled";
>   			};
>   
> +			pwm_ab: pwm@58000 {
> +				compatible = "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x58000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_A>,
> +						<&clkc_periphs CLKID_PWM_B>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_cd: pwm@5a000 {
> +				compatible = "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x5a000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_C>,
> +						<&clkc_periphs CLKID_PWM_D>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ef: pwm@5c000 {
> +				compatible = "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x5c000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_E>,
> +						<&clkc_periphs CLKID_PWM_F>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_gh: pwm@5e000 {
> +				compatible = "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x5e000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_G>,
> +						<&clkc_periphs CLKID_PWM_H>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ij: pwm@60000 {
> +				compatible = "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x60000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_I>,
> +						<&clkc_periphs CLKID_PWM_J>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
>   			nand: nand-controller@8c800 {
>   				compatible = "amlogic,meson-axg-nfc";
>   				reg = <0x0 0x8c800 0x0 0x100>, <0x0 0x8c000 0x0 0x4>;
> 

Nodes on any bus, thus using unit addresses for children, shall be 
ordered by unit address in ascending order.

So the pwm_xx nodes should be placed between spicc0: spi@50000 and
i2c0: i2c@66000 nodes

-- 
Best regards
George

