Return-Path: <linux-pwm+bounces-8695-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3+6IIfTQ7WkEoAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8695-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 10:46:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE7469242
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9008F3005EA8
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1826ED41;
	Sun, 26 Apr 2026 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="IbFrEF5A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49224.qiye.163.com (mail-m49224.qiye.163.com [45.254.49.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0F19E819;
	Sun, 26 Apr 2026 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777193200; cv=none; b=PYhHTJFhP/2muvCLH8Sw02QLvBCwO4vmod391gajuZt63paxqmmJqyHQE/VKcY5Lm2/52tK+pAx2Uurn2BVDD5eNRLe6TFLA1rG5M3rHtmGRORWy/tdaE48yodVmAbQDSR6Tz1kqbE5LPRmHQyWcpqMbOKiK7pjmKyklseE1rwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777193200; c=relaxed/simple;
	bh=L2lmvLBo7kwQqnoKMMibhJ38HixexXwMyjLfJZAqF+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEg8bYmDAlkofuEvjicocq/FIaiybeQRVRrR3uaw4aBPX8xiTPuS9C3QMVYh7BNFoI4uL50p3Y+N1ArVKanN8mbMvUPIM6gFSGNLRDyQUXMRTINgup7K6gTcnrWXw495jie07t9QMF1VGUNwzGmLPK+WyNqdKtdZ+Q3xECxGbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=IbFrEF5A; arc=none smtp.client-ip=45.254.49.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.43] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c2a404a3;
	Sun, 26 Apr 2026 15:30:35 +0800 (GMT+08:00)
Message-ID: <7e55f270-5422-4696-987d-e2a2ab16240b@rock-chips.com>
Date: Sun, 26 Apr 2026 15:30:35 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] arm64: dts: rockchip: add PWM nodes to RK3576 SoC
 dtsi
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
 <20260420-rk3576-pwm-v5-5-ae7cfbbe5427@collabora.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260420-rk3576-pwm-v5-5-ae7cfbbe5427@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9dc8b282f103a3kunm5e5a610713ec55
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUIdH1ZIGUlJQ0pPSx
	8dQh9WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=IbFrEF5AZwgTn9ILKm7PdjZuml/51hPqi9yF563W+xC4TVPGo4y99OxqEX1Wj8x7+IPz6bTT46VYGLM/kXqYcO94cJ3wBGZC+kPSmMjJj1pQuka2tuZf0pWSwRRgjIlXUSjZgIzhsWZhvL66UGkXrQI9oNIAm+fa3tg0gtFiq2k=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=cvKBY+c+iYjGsEpoYL9NRwD1uu5gqclMVNxmGMDvE7c=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Queue-Id: C4AE7469242
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8695-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damon.ding@rock-chips.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Nicolas,

On 4/20/2026 9:52 PM, Nicolas Frattaroli wrote:
> The RK3576 SoC features three distinct PWM controllers, with variable
> numbers of channels. Add each channel as a separate node to the SoC's
> device tree, as they don't really overlap in register ranges.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3576.dtsi | 208 +++++++++++++++++++++++++++++++
>   1 file changed, 208 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> index e12a2a0cfb89..55d6b103c329 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1032,6 +1032,32 @@ uart1: serial@27310000 {
>   			status = "disabled";
>   		};
>   
> +		pwm0_2ch_0: pwm@27330000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x27330000 0x0 0x1000>;
> +			clocks = <&cru CLK_PMU1PWM>, <&cru PCLK_PMU1PWM>,
> +				 <&cru CLK_PMU1PWM_OSC>, <&cru CLK_PMU1PWM_RC>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm0m0_ch0>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm0_2ch_1: pwm@27331000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x27331000 0x0 0x1000>;
> +			clocks = <&cru CLK_PMU1PWM>, <&cru PCLK_PMU1PWM>,
> +				 <&cru CLK_PMU1PWM_OSC>, <&cru CLK_PMU1PWM_RC>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm0m0_ch1>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
>   		pmu: power-management@27380000 {
>   			compatible = "rockchip,rk3576-pmu", "syscon", "simple-mfd";
>   			reg = <0x0 0x27380000 0x0 0x800>;
> @@ -2630,6 +2656,188 @@ uart9: serial@2adc0000 {
>   			status = "disabled";
>   		};
>   
> +		pwm1_6ch_0: pwm@2add0000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2add0000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
> +				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm1m0_ch0>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm1_6ch_1: pwm@2add1000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2add1000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
> +				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm1m0_ch1>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm1_6ch_2: pwm@2add2000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2add2000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
> +				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm1m0_ch2>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm1_6ch_3: pwm@2add3000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2add3000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
> +				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm1m0_ch3>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm1_6ch_4: pwm@2add4000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2add4000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
> +				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm1m0_ch4>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm1_6ch_5: pwm@2add5000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2add5000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
> +				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm1m0_ch5>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm2_8ch_0: pwm@2ade0000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2ade0000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
> +				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm2m0_ch0>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm2_8ch_1: pwm@2ade1000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2ade1000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
> +				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm2m0_ch1>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm2_8ch_2: pwm@2ade2000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2ade2000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
> +				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm2m0_ch2>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm2_8ch_3: pwm@2ade3000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2ade3000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
> +				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm2m0_ch3>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm2_8ch_4: pwm@2ade4000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2ade4000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
> +				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm2m0_ch4>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm2_8ch_5: pwm@2ade5000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2ade5000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
> +				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm2m0_ch5>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm2_8ch_6: pwm@2ade6000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2ade6000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
> +				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm2m0_ch6>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		pwm2_8ch_7: pwm@2ade7000 {
> +			compatible = "rockchip,rk3576-pwm";
> +			reg = <0x0 0x2ade7000 0x0 0x1000>;
> +			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
> +				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
> +			clock-names = "pwm", "pclk", "osc", "rc";
> +			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pwm2m0_ch7>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
>   		saradc: adc@2ae00000 {
>   			compatible = "rockchip,rk3576-saradc", "rockchip,rk3588-saradc";
>   			reg = <0x0 0x2ae00000 0x0 0x10000>;
> 

According to the RK3576 TRM, the register base address, clocks and 
interrupt configuration of the PWM node are all correct

Reviewed-by: Damon Ding <damon.ding@rock-chips.com>

Best regards,
Damon


