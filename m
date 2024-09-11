Return-Path: <linux-pwm+bounces-3216-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE5975CB8
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 23:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518D0B22567
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DF81AC899;
	Wed, 11 Sep 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="eRa/R0Wt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E625E2EAE5;
	Wed, 11 Sep 2024 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091948; cv=none; b=WVywpAzf63NO5LY3lWBkk9wTpldITj15MHxqWypY+l/WPKVVhTyk9DYotaIHWvY26aKUk7zQMO9SV2QCBN5606H/AhKoD+78Mwk6K9jQb2Vx6Z6c6248g6EDQGQqGakAvxWdX3QschTCpbIeZroPyisuGhVVT54lgdzlj2TPl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091948; c=relaxed/simple;
	bh=/FMTpaXe29m2XEsEhkjC/5l3YoAYu9PTcJ/hZCVUfjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ll4J3ggDnKmkEcNcbbxEgNYisaiNJbyo4eTHGMM6PvDu7bCLob1rh0jkDoyLj4aEBr5+Yuy16Slbo8CT+3b22qwF0RSPsCxR8y+v+2L4fALGr4EIav0FpRzxvSiO0Mt2owZAuGEUNau0FBN2Mic+2FSTUe2vd6oV1uE2k7Y2e9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=eRa/R0Wt; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8046010001E;
	Thu, 12 Sep 2024 00:59:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8046010001E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1726091940;
	bh=cdJ+IYoU3pvgqGac2TNQ0TifdmYXIl3dQHax/I3kpys=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=eRa/R0WtGmrs1McBKfIJV5RGaBtl3yb/YEbb4rxoup6CslBNLFr/JeXFU9O5J7+6b
	 aguNULO0XuI2sbclUVIFGWz1EVK91ismDh2llTy9AWu1qmsT+DVyUybyloxWkF9S3w
	 SriXGo6KZpRTO8isucJI72tnBe0KqtUL8MKomh0zsE2Eb6dn4deGAHc01b5ATmP5wZ
	 Z/+JKjqW+lK5ezNqAVFUr0cAQeaP5UH9757d1/h6am3rrq9nvQppdl5IMo8QgGtmGv
	 6CofW1KtWHemvTdDm8qCvTn06UFQZfq2Hl8EK+lrr/on1vhw7K3kwc1/+4Oez/lvMt
	 hxVS4IVYPoYag==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 12 Sep 2024 00:59:00 +0300 (MSK)
Message-ID: <d9dfa72d-b2d5-4772-b799-653c7b51ee87@salutedevices.com>
Date: Thu, 12 Sep 2024 00:58:59 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: meson: a1: add definitions for meson
 PWM
To: <neil.armstrong@linaro.org>
CC: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
 <20240710234116.2370655-4-gnstark@salutedevices.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240710234116.2370655-4-gnstark@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187695 [Sep 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32 766319f57b3d5e49f2c79a76e7d7087b621090df, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/11 19:25:00 #26555689
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Neil

Please take a look at this patch. Appropriate bindings were merged recently.


On 7/11/24 02:41, George Stark wrote:
> The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF those
> can be connected to various digital I/O pins.
> 
> Each of 6 PWM is driven by individually selected clock parent and
> 8-bit divider. The PWM signal is generated using two 16-bit counters.
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 215 ++++++++++++++++++++++
>   1 file changed, 215 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index 85e56c021e99..0dc39fb8f59d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -307,6 +307,188 @@ mux {
>   					};
>   				};
>   
> +				pwm_a_pins1: pwm-a-pins1 {
> +					mux {
> +						groups = "pwm_a_x6";
> +						function = "pwm_a";
> +					};
> +				};
> +
> +				pwm_a_pins2: pwm-a-pins2 {
> +					mux {
> +						groups = "pwm_a_x7";
> +						function = "pwm_a";
> +					};
> +				};
> +
> +				pwm_a_pins3: pwm-a-pins3 {
> +					mux {
> +						groups = "pwm_a_f10";
> +						function = "pwm_a";
> +					};
> +				};
> +
> +				pwm_a_pins4: pwm-a-pins4 {
> +					mux {
> +						groups = "pwm_a_f6";
> +						function = "pwm_a";
> +					};
> +				};
> +
> +				pwm_a_pins5: pwm-a-pins5 {
> +					mux {
> +						groups = "pwm_a_a";
> +						function = "pwm_a";
> +					};
> +				};
> +
> +				pwm_b_pins1: pwm-b-pins1 {
> +					mux {
> +						groups = "pwm_b_x";
> +						function = "pwm_b";
> +					};
> +				};
> +
> +				pwm_b_pins2: pwm-b-pins2 {
> +					mux {
> +						groups = "pwm_b_f";
> +						function = "pwm_b";
> +					};
> +				};
> +
> +				pwm_b_pins3: pwm-b-pins3 {
> +					mux {
> +						groups = "pwm_b_a";
> +						function = "pwm_b";
> +					};
> +				};
> +
> +				pwm_c_pins1: pwm-c-pins1 {
> +					mux {
> +						groups = "pwm_c_x";
> +						function = "pwm_c";
> +					};
> +				};
> +
> +				pwm_c_pins2: pwm-c-pins2 {
> +					mux {
> +						groups = "pwm_c_f3";
> +						function = "pwm_c";
> +					};
> +				};
> +
> +				pwm_c_pins3: pwm-c-pins3 {
> +					mux {
> +						groups = "pwm_c_f8";
> +						function = "pwm_c";
> +					};
> +				};
> +
> +				pwm_c_pins4: pwm-c-pins4 {
> +					mux {
> +						groups = "pwm_c_a";
> +						function = "pwm_c";
> +					};
> +				};
> +
> +				pwm_d_pins1: pwm-d-pins1 {
> +					mux {
> +						groups = "pwm_d_x15";
> +						function = "pwm_d";
> +					};
> +				};
> +
> +				pwm_d_pins2: pwm-d-pins2 {
> +					mux {
> +						groups = "pwm_d_x13";
> +						function = "pwm_d";
> +					};
> +				};
> +
> +				pwm_d_pins3: pwm-d-pins3 {
> +					mux {
> +						groups = "pwm_d_x10";
> +						function = "pwm_d";
> +					};
> +				};
> +
> +				pwm_d_pins4: pwm-d-pins4 {
> +					mux {
> +						groups = "pwm_d_f";
> +						function = "pwm_d";
> +					};
> +				};
> +
> +				pwm_e_pins1: pwm-e-pins1 {
> +					mux {
> +						groups = "pwm_e_p";
> +						function = "pwm_e";
> +					};
> +				};
> +
> +				pwm_e_pins2: pwm-e-pins2 {
> +					mux {
> +						groups = "pwm_e_x16";
> +						function = "pwm_e";
> +					};
> +				};
> +
> +				pwm_e_pins3: pwm-e-pins3 {
> +					mux {
> +						groups = "pwm_e_x14";
> +						function = "pwm_e";
> +					};
> +				};
> +
> +				pwm_e_pins4: pwm-e-pins4 {
> +					mux {
> +						groups = "pwm_e_x2";
> +						function = "pwm_e";
> +					};
> +				};
> +
> +				pwm_e_pins5: pwm-e-pins5 {
> +					mux {
> +						groups = "pwm_e_f";
> +						function = "pwm_e";
> +					};
> +				};
> +
> +				pwm_e_pins6: pwm-e-pins6 {
> +					mux {
> +						groups = "pwm_e_a";
> +						function = "pwm_e";
> +					};
> +				};
> +
> +				pwm_f_pins1: pwm-f-pins1 {
> +					mux {
> +						groups = "pwm_f_b";
> +						function = "pwm_f";
> +					};
> +				};
> +
> +				pwm_f_pins2: pwm-f-pins2 {
> +					mux {
> +						groups = "pwm_f_x";
> +						function = "pwm_f";
> +					};
> +				};
> +
> +				pwm_f_pins3: pwm-f-pins3 {
> +					mux {
> +						groups = "pwm_f_f4";
> +						function = "pwm_f";
> +					};
> +				};
> +
> +				pwm_f_pins4: pwm-f-pins4 {
> +					mux {
> +						groups = "pwm_f_f12";
> +						function = "pwm_f";
> +					};
> +				};
> +
>   				sdio_pins: sdio {
>   					mux0 {
>   						groups = "sdcard_d0_x",
> @@ -648,6 +830,28 @@ uart_AO_B: serial@2000 {
>   				status = "disabled";
>   			};
>   
> +			pwm_ab: pwm@2400 {
> +				compatible = "amlogic,meson-a1-pwm",
> +					     "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x2400 0x0 0x24>;
> +				#pwm-cells = <3>;
> +				clocks = <&clkc_periphs CLKID_PWM_A>,
> +					 <&clkc_periphs CLKID_PWM_B>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +				status = "disabled";
> +			};
> +
> +			pwm_cd: pwm@2800 {
> +				compatible = "amlogic,meson-a1-pwm",
> +					     "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x2800 0x0 0x24>;
> +				#pwm-cells = <3>;
> +				clocks = <&clkc_periphs CLKID_PWM_C>,
> +					 <&clkc_periphs CLKID_PWM_D>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +				status = "disabled";
> +			};
> +
>   			saradc: adc@2c00 {
>   				compatible = "amlogic,meson-g12a-saradc",
>   					"amlogic,meson-saradc";
> @@ -732,6 +936,17 @@ sec_AO: ao-secure@5a20 {
>   				amlogic,has-chip-id;
>   			};
>   
> +			pwm_ef: pwm@5400 {
> +				compatible = "amlogic,meson-a1-pwm",
> +					     "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x5400 0x0 0x24>;
> +				#pwm-cells = <3>;
> +				clocks = <&clkc_periphs CLKID_PWM_E>,
> +					 <&clkc_periphs CLKID_PWM_F>;
> +				power-domains = <&pwrc PWRC_I2C_ID>;
> +				status = "disabled";
> +			};
> +
>   			clkc_pll: pll-clock-controller@7c80 {
>   				compatible = "amlogic,a1-pll-clkc";
>   				reg = <0 0x7c80 0 0x18c>;

-- 
Best regards
George

