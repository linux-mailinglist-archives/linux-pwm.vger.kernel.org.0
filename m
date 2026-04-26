Return-Path: <linux-pwm+bounces-8694-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /HeQJqC+7WlNnAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8694-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 09:28:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40654468F64
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 09:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62232300B992
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425892E11BC;
	Sun, 26 Apr 2026 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="eUjhWMrc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49231.qiye.163.com (mail-m49231.qiye.163.com [45.254.49.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555C2BEC5F;
	Sun, 26 Apr 2026 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777188508; cv=none; b=k5aDDO2qxySVQSf8wX7h5+rIQG5LGfaAdVxcdQcYhMRXz61RNZnXyBjKb4lu8/pzbvgNrsVTYwgH/5l5zHd6bLN+LT3ipzbbqL41LIUAOFTKZtnTaxVXXYNjdB/bs7pV4N1uN/ycKW2LX/NtR6dgToHB4DD4LHpE8weYENjuizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777188508; c=relaxed/simple;
	bh=Y+1zkimE70w8bkm9KFIoUdi+t4U2NymBCl+12h/51K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvX0AjXKyzRo1lfSFOe1oeQwsJV8zic65iJcnn0vJUPAXyGxg9/rcjgg5KnfBmEX8KG8LAHQTSPuEEfUr3Q0G78otMGcmoKM0elj0U74YtE24zLatnyGOkvO/6zjwjQdcBFNunrUqZIk8dh80OG7ffi3+8lnm4T4dTgjB/fSdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=eUjhWMrc; arc=none smtp.client-ip=45.254.49.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.43] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c2a40191;
	Sun, 26 Apr 2026 15:23:00 +0800 (GMT+08:00)
Message-ID: <35afc21f-74c9-4f52-bdf1-18a34fb58578@rock-chips.com>
Date: Sun, 26 Apr 2026 15:23:01 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] arm64: dts: rockchip: Add cooling fan to ROCK 4D
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>
Cc: kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-6-ae7cfbbe5427@collabora.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260420-rk3576-pwm-v5-6-ae7cfbbe5427@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9dc8ab938e03a3kunm608d0a1f13e627
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ08YSVYZTU1PSUMeSh
	hCHkxWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eUjhWMrcKnY5LlEG1ShyEX5gpPrTxsDLAiqhKFZuGYIn9YmGbcKOJ9cbbMupRyX0IHZsQ02lJAkUP5ZC3WtabW9h/ra6UnjQjpmj3VzuRn0rqLdsSmTHXj8Gmb0ysUl+tHUSOaVGyn5+pUgzHVTb8NidTbjAnCP+EAcvO7OceX0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jVYUAUD3MtOhd5xJ/8bgt/jc3lNhNlVgEg2Y7JvdCe4=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Queue-Id: 40654468F64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8694-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damon.ding@rock-chips.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]

Hi Nicolas,

On 4/20/2026 9:52 PM, Nicolas Frattaroli wrote:
> The ROCK 4D has a header to connect a small cooling fan. This fan is
> driven by one of the SoC's PWM outputs driving a transistor, that in
> turn controls the fan's power.
> 
> With the introduction of PWM support, add a description of this cooling
> fan, as well as the additional trips and cooling-maps for it.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 50 +++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> index 899a84b1fbf9..2d5ede010ad0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> @@ -45,6 +45,14 @@ rfkill {
>   		shutdown-gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_HIGH>;
>   	};
>   
> +	fan: pwm-fan {
> +		compatible = "pwm-fan";
> +		cooling-levels = <0 180 205 230 255>;
> +		fan-supply = <&vcc_5v0_sys>;
> +		pwms = <&pwm2_8ch_5 0 60000 0>;
> +		#cooling-cells = <2>;
> +	};
> +
>   	leds: leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> @@ -711,6 +719,36 @@ rgmii_phy0: ethernet-phy@1 {
>   	};
>   };
>   
> +&package_thermal {
> +	polling-delay = <100>;
> +
> +	trips {
> +		package_fan0: package-fan0 {
> +			temperature = <50000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +
> +		package_fan1: package-fan1 {
> +			temperature = <60000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map1 {
> +			trip = <&package_fan0>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> +		};
> +
> +		map2 {
> +			trip = <&package_fan1>;
> +			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
>   &pcie0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pcie_reset>;
> @@ -720,6 +758,13 @@ &pcie0 {
>   };
>   
>   &pinctrl {
> +	fan {
> +		fan_pwm: fan-pwm {
> +			rockchip,pins =
> +				<4 RK_PC5 14 &pcfg_pull_down_drv_level_5>;
> +		};
> +	};
> +
>   	hym8563 {
>   		hym8563_int: hym8563-int {
>   			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> @@ -770,6 +815,11 @@ wifi_en_h: wifi-en-h {
>   	};
>   };
>   
> +&pwm2_8ch_5 {
> +	pinctrl-0 = <&fan_pwm>;

May I ask why the pinctrl does not directly use &pwm2m1_ch5?

Is it because the default pin configuration cannot meet the requirements 
of the fan?

> +	status = "okay";
> +};
> +
>   &sai6 {
>   	status = "okay";
>   };
> 

Best regards,
Damon


