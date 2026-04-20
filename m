Return-Path: <linux-pwm+bounces-8647-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O/XMBRS5mkDuwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8647-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 18:19:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C76F742F4FB
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 18:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E276B32467BB
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0343D2FE1;
	Mon, 20 Apr 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="jURJ2NzR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689293B4EB0;
	Mon, 20 Apr 2026 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692205; cv=pass; b=kqMfskbWNtXV94LGli4l4YpCxcnMGMP/fyq+kOuuhz8BH977htvKCf9Fk2TXt2DQeOXyT4TPgrWM72qDsvoPtSMvG2yqhAr9D7ZyRYIrWUZDdOTo+HpR/MeL10PjSoJ41YtAxEMPTFun7ZUvG/qg4ZvT3XZBfioUK3uXZJF//1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692205; c=relaxed/simple;
	bh=NDwsz0wtXOoTQkwS/bP7yJLnrDbAVK1rQhUwTJPR25s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCjnRlENSg7LGWP9UsEvppCxggcNM/qS1On36fAsot+Y5WC/JLEqfdnPSoy2cy6ULoqisyBnabeoRjJ3jH9I9yNtd9gBVfp6ICUmevKn+MffYLp2yFCnmMwmsrY1aJL0EKj/7Pw9TbODU+pYoFIz2keNg3mjk5/AzOWeo8vk0OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=jURJ2NzR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776692176; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Oo3wGrFzM/4V8VYBS/j8NXXmCXM5uREuXBX1UFq3Hzkn3DXamdvaC7zlAjDnrS85pGoV2lq+L1t0mD4aq+i9N3Zfg3v6E6tvCpX7ZbWex3J+iYXOYV7S2OOFx4SwIoYwBLRB8JKbr/rdtj+zNOZRkiXE5cU8QbLFbsff120vPJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776692176; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TSolDDpiDBp7rWjrXiBrHsvEmvUxxGJrGij6jJWU4VQ=; 
	b=NfI1V+ldULicHt9+hWrc7GQoe2Y56zuSEHOJB6vKWMlcy1QdMmcSEC0App0/rRVVzxiznr3PbdRYBkqC29TiZYjaB6CMEuSibKq7AYfbKxhiwYclaGdg5TmJ5hYH45Y7SlnMgcD+MW6P0VjnhkPwuutVM6qNSNg00nOsyhobK7E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776692176;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=TSolDDpiDBp7rWjrXiBrHsvEmvUxxGJrGij6jJWU4VQ=;
	b=jURJ2NzRayZTpsfx6TxqTo3l7pH/lpQeSyUklDQhO7iNn40S+aERlYZH9rHLCJdX
	F18quwxwrx+cDu5VivAsiGJVyXY6apEVlOuMLvvQADmBeZtlf40yQ6ZSZDfFDlzFBwo
	7zsBf756385OsUDZV0XAkPCtZOUTtJqi2n1z/2oE=
Received: by mx.zohomail.com with SMTPS id 1776692176063610.8493801618305;
	Mon, 20 Apr 2026 06:36:16 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 20 Apr 2026 15:35:22 +0200
Subject: [PATCH v4 4/5] arm64: dts: rockchip: add PWM nodes to RK3576 SoC
 dtsi
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-rk3576-pwm-v4-4-421738c7bf28@collabora.com>
References: <20260420-rk3576-pwm-v4-0-421738c7bf28@collabora.com>
In-Reply-To: <20260420-rk3576-pwm-v4-0-421738c7bf28@collabora.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>, 
 Damon Ding <damon.ding@rock-chips.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8647-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[1.161.9.184:email,1.161.5.208:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,2ade4000:email,2ade7000:email,2add0000:email,2adc0000:email,2ade2000:email,2ade1000:email,2ade3000:email]
X-Rspamd-Queue-Id: C76F742F4FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RK3576 SoC features three distinct PWM controllers, with variable
numbers of channels. Add each channel as a separate node to the SoC's
device tree, as they don't really overlap in register ranges.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 208 +++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index e12a2a0cfb89..55d6b103c329 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1032,6 +1032,32 @@ uart1: serial@27310000 {
 			status = "disabled";
 		};
 
+		pwm0_2ch_0: pwm@27330000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x27330000 0x0 0x1000>;
+			clocks = <&cru CLK_PMU1PWM>, <&cru PCLK_PMU1PWM>,
+				 <&cru CLK_PMU1PWM_OSC>, <&cru CLK_PMU1PWM_RC>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm0m0_ch0>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm0_2ch_1: pwm@27331000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x27331000 0x0 0x1000>;
+			clocks = <&cru CLK_PMU1PWM>, <&cru PCLK_PMU1PWM>,
+				 <&cru CLK_PMU1PWM_OSC>, <&cru CLK_PMU1PWM_RC>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm0m0_ch1>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		pmu: power-management@27380000 {
 			compatible = "rockchip,rk3576-pmu", "syscon", "simple-mfd";
 			reg = <0x0 0x27380000 0x0 0x800>;
@@ -2630,6 +2656,188 @@ uart9: serial@2adc0000 {
 			status = "disabled";
 		};
 
+		pwm1_6ch_0: pwm@2add0000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2add0000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
+				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm1m0_ch0>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1_6ch_1: pwm@2add1000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2add1000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
+				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm1m0_ch1>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1_6ch_2: pwm@2add2000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2add2000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
+				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm1m0_ch2>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1_6ch_3: pwm@2add3000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2add3000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
+				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm1m0_ch3>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1_6ch_4: pwm@2add4000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2add4000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
+				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm1m0_ch4>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1_6ch_5: pwm@2add5000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2add5000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>,
+				 <&cru CLK_OSC_PWM1>, <&cru CLK_RC_PWM1>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm1m0_ch5>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2_8ch_0: pwm@2ade0000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2ade0000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
+				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm2m0_ch0>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2_8ch_1: pwm@2ade1000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2ade1000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
+				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm2m0_ch1>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2_8ch_2: pwm@2ade2000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2ade2000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
+				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm2m0_ch2>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2_8ch_3: pwm@2ade3000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2ade3000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
+				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm2m0_ch3>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2_8ch_4: pwm@2ade4000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2ade4000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
+				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm2m0_ch4>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2_8ch_5: pwm@2ade5000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2ade5000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
+				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm2m0_ch5>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2_8ch_6: pwm@2ade6000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2ade6000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
+				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm2m0_ch6>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2_8ch_7: pwm@2ade7000 {
+			compatible = "rockchip,rk3576-pwm";
+			reg = <0x0 0x2ade7000 0x0 0x1000>;
+			clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>,
+				 <&cru CLK_OSC_PWM2>, <&cru CLK_RC_PWM2>;
+			clock-names = "pwm", "pclk", "osc", "rc";
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm2m0_ch7>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		saradc: adc@2ae00000 {
 			compatible = "rockchip,rk3576-saradc", "rockchip,rk3588-saradc";
 			reg = <0x0 0x2ae00000 0x0 0x10000>;

-- 
2.53.0


