Return-Path: <linux-pwm+bounces-2298-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FAB8D4B03
	for <lists+linux-pwm@lfdr.de>; Thu, 30 May 2024 13:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C21328520A
	for <lists+linux-pwm@lfdr.de>; Thu, 30 May 2024 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C9D1761BC;
	Thu, 30 May 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="uwT3vHvd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7417183964;
	Thu, 30 May 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717069820; cv=none; b=CBtCjlJZB5nfV5iySWWwUWC8Zbes99cRxY5OafblvJGnA5lO+lg8M3/+L5gpVA+iSyrseyMoz6T41wuOWT4hA0v7SP1qmc5TiiJvaAxYJiLwmRmAnduP1exshEPT+tNDOMS61Y8NO3yiAgwKPe09xce0bIj0ZfzRUM/NBFRrHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717069820; c=relaxed/simple;
	bh=VrYT1OEB6ocFlr6hvtBUzSwJ47Co1zYWFR3HE7zzLsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qIZue+8gSu5X/8Rf/ThePK128QtkZuyLEYs/tLG45Bdlm1EdPfNxIN7I4UrVIBgjUMyQPOgwiyw4KquLCi6tXIBjFS3bar7P+oJmFdMhIPPCI5uB7Ofe7hbkFzUYGFTYg35YjCC7nGSVz4ot48t4Jdxs6f8sPzorW9fI7McRo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=uwT3vHvd; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3C38F120003;
	Thu, 30 May 2024 14:50:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3C38F120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1717069805;
	bh=xhZ0LuzpL57JCIpP9rLdpiSgKgNXZfSC8qE7zYal93Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=uwT3vHvdaZTnWKPz++UZ0FvWeM1zcQNvm3+q4Gprab2eR/VLeYQ83HVH+y1/QMe1n
	 BBStF1+XHoMT8346FWJ6OL38z8WjsmtmgrK6c2VEwnkz6AWvG7kWlElQ5Ii76iMI/c
	 sIQ/ezzQPu1nMAv9kLILZlwk6CsDGvMXey+cIXvzCXN3UkfPpO+6bmhUf8Cio6LAxp
	 HItFD3CF732bqeDWIy7yzUAW/gk9HvD71FrMVrEkBt3wSUn2vamjJJX1sseXEzU68z
	 8ALpW/4n/aE4iAEw7DTqax/j6h7CrRhV3NPTTcTRvjLdcJ1hINCZiW1AKOVIEJRSXl
	 WXAx8O9yq7f5g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 30 May 2024 14:50:05 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 30 May 2024 14:50:04 +0300
Message-ID: <4cc234db-b795-4cfc-8e47-e89642f932f5@salutedevices.com>
Date: Thu, 30 May 2024 14:50:03 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH v6 2/2] arm64: dts: amlogic: Add
 Amlogic S4 PWM
To: <kelvin.zhang@amlogic.com>
CC: Jerome Brunet <jbrunet@baylibre.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
	<devicetree@vger.kernel.org>, Junyi Zhao <junyi.zhao@amlogic.com>, Rob
 Herring <robh@kernel.org>, "kernel@salutedevices.com"
	<kernel@salutedevices.com>
References: <20240529-s4-pwm-v6-0-270f63049f20@amlogic.com>
 <20240529-s4-pwm-v6-2-270f63049f20@amlogic.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240529-s4-pwm-v6-2-270f63049f20@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185613 [May 30 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/30 07:20:00 #25352518
X-KSMG-AntiVirus-Status: Clean, skipped



On 5/29/24 13:00, Kelvin Zhang via B4 Relay wrote:
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
> index 10896f9df682..98f554577bae 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -312,6 +312,168 @@ mux {
>   					};
>   				};
>   
> +				pwm_a_pins1: pwm-a-pins1 {
> +					mux {
> +						groups = "pwm_a_d";
> +						function = "pwm_a";
> +					};
> +				};
> +
> +				pwm_a_pins2: pwm-a-pins2 {
> +					mux {
> +						groups = "pwm_a_x";
> +						function = "pwm_a";
> +					};
> +				};
> +
> +				pwm_a_pins: pwm-a-pins {
> +					mux {
> +						groups = "pwm_a_d";
> +						function = "pwm_a";
> +					};
> +				};
pwm_a_pins is just a copy of pwm_a_pins1 node
> +
> +				pwm_b_pins1: pwm-b-pins1 {
> +					mux {
> +						groups = "pwm_b_d";
> +						function = "pwm_b";
> +					};
> +				};
> +
> +				pwm_b_pins2: pwm-b-pins2 {
> +					mux {
> +						groups = "pwm_b_x";
> +						function = "pwm_b";
> +					};
> +				};
> +
> +				pwm_c_pins1: pwm-c-pins1 {
> +					mux {
> +						groups = "pwm_c_d";
> +						function = "pwm_c";
> +					};
> +				};
> +
> +				pwm_c_pins2: pwm-c-pins2 {
> +					mux {
> +						groups = "pwm_c_x";
> +						function = "pwm_c";
> +					};
> +				};
> +
> +				pwm_d_pins1: pwm-d-pins1 {
> +					mux {
> +						groups = "pwm_d_d";
> +						function = "pwm_d";
> +					};
> +				};
> +
> +				pwm_d_pins2: pwm-d-pins2 {
> +					mux {
> +						groups = "pwm_d_h";
> +						function = "pwm_d";
> +					};
> +				};
> +
> +				pwm_e_pins1: pwm-e-pins1 {
> +					mux {
> +						groups = "pwm_e_x";
> +						function = "pwm_e";
> +						drive-strength-microamp = <500>;
AFAIU GPIOX_16 (groups = "pwm_e_x") is frequently used to generate
clock for wifi module and drive-strength-microamp property here is 
needed only for that special case. If so then should that property be 
put in board dts file instead?
> +					};
> +				};
> +
> +				pwm_e_pins2: pwm-e-pins2 {
> +					mux {
> +						groups = "pwm_e_z";
> +						function = "pwm_e";
> +					};
> +				};
> +
> +				pwm_f_pins1: pwm-f-pins1 {
> +					mux {
> +						groups = "pwm_f_x";
> +						function = "pwm_f";
> +					};
> +				};
> +
> +				pwm_f_pins2: pwm-f-pins2 {
> +					mux {
> +						groups = "pwm_f_z";
> +						function = "pwm_f";
> +					};
> +				};
> +
> +				pwm_g_pins1: pwm-g-pins1 {
> +					mux {
> +						groups = "pwm_g_d";
> +						function = "pwm_g";
> +					};
> +				};
> +
> +				pwm_g_pins2: pwm-g-pins2 {
> +					mux {
> +						groups = "pwm_g_z";
> +						function = "pwm_g";
> +					};
> +				};
> +
> +				pwm_h_pins: pwm-h-pins {
> +					mux {
> +						groups = "pwm_h";
> +						function = "pwm_h";
> +					};
> +				};
> +
> +				pwm_i_pins1: pwm-i-pins1 {
> +					mux {
> +						groups = "pwm_i_d";
> +						function = "pwm_i";
> +					};
> +				};
> +
> +				pwm_i_pins2: pwm-i-pins2 {
> +					mux {
> +						groups = "pwm_i_h";
> +						function = "pwm_i";
> +					};
> +				};
> +
> +				pwm_j_pins: pwm-j-pins {
> +					mux {
> +						groups = "pwm_j";
> +						function = "pwm_j";
> +					};
> +				};
> +
> +				pwm_a_hiz_pins: pwm-a-hiz-pins {
> +					mux {
> +						groups = "pwm_a_hiz";
> +						function = "pwm_a_hiz";
> +					};
> +				};
> +
> +				pwm_b_hiz_pins: pwm-b-hiz-pins {
> +					mux {
> +						groups = "pwm_b_hiz";
> +						function = "pwm_b_hiz";
> +					};
> +				};
> +
> +				pwm_c_hiz_pins: pwm-c-hiz-pins {
> +					mux {
> +						groups = "pwm_c_hiz";
> +						function = "pwm_b_hiz";
Should it be function = "pwm_c_hiz"?
> +					};
> +				};
> +
> +				pwm_g_hiz_pins: pwm-g-hiz-pins {
> +					mux {
> +						groups = "pwm_g_hiz";
> +						function = "pwm_g_hiz";
> +					};
> +				};
> +
>   				spicc0_pins_x: spicc0-pins_x {
>   					mux {
>   						groups = "spi_a_mosi_x",
> @@ -399,6 +561,51 @@ spicc0: spi@50000 {
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
>   			i2c0: i2c@66000 {
>   				compatible = "amlogic,meson-axg-i2c";
>   				reg = <0x0 0x66000 0x0 0x20>;
> 

-- 
Best regards
George

