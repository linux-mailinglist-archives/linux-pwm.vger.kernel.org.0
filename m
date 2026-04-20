Return-Path: <linux-pwm+bounces-8656-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJF2Gnw+5mkAtwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8656-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 16:55:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC4442DA0A
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 16:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1E7430468AF
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EBB31E827;
	Mon, 20 Apr 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="eAB4XvI2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E3314A73;
	Mon, 20 Apr 2026 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693255; cv=pass; b=XVFbrw4D8n3U4uQRg9R1jAIyRYIqHrTQnhgXMU1zn0MBhyl6beFm68X5H6dgBEyYyG1GAprcjk90ZKdSTgkKi9RouWThkqxFTg+RunTOvWcd28VfXVc/VzteCGlzKljzED9wdMabvd3Ri18CN5tuP8ToLYbTEbCJvqYWMqa4W0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693255; c=relaxed/simple;
	bh=NDwsz0wtXOoTQkwS/bP7yJLnrDbAVK1rQhUwTJPR25s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQZl3+9M5kJZFaPk1cutfk+JnbpdZVTY2dahuVJDMFv6LsWR9XVu0TyEHMqbH7aeR3L85JuNRqAcuQBHzEBLp7JmRLHIIwQrPLPD0cszJmH1uBY8G9liPK/avk1MOThISgYn1fSH//9aCdW1iLKEvVNR3dHuRvT2Y8VfoTsmYF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=eAB4XvI2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776693228; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j+aOhXs4DVBwpxsZJ16wnb8P+Ej+na5XG0cov4RxMfY9vpGwPemjRyoT77CuYHMjKPTlEtaeBplP+G6Uw0J0qPTi48/5dfZ8PStwY9FFjodK6f9FyOjy/1qZIE4YShsfTJEKuHaeTnEWce3VsYfpRSgoZAf7Wd0vhV8o/rTHGdo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776693228; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TSolDDpiDBp7rWjrXiBrHsvEmvUxxGJrGij6jJWU4VQ=; 
	b=BpNkWjeou5e0zBbgKhgmRj8/GxMbx1pH/9uOxnoWcWa5MEHMrlevCxurSPHT/9AIPR5fxUxkCOKD0TYy/h56deoAfOfnMFf5oHKVQOQNnE9ti04qeMGmexSFH7m7NFQzD4UAs0byKegGQZSQ1dSDI0a0fg/mSObWY8nHtkB+2HY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776693228;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=TSolDDpiDBp7rWjrXiBrHsvEmvUxxGJrGij6jJWU4VQ=;
	b=eAB4XvI29uF/Nc/BCc2+dtMZ2ztvb6s5frR5Jov1nHT7P1ruF8spmhitsxyEETCP
	A9qgzN9T03GRUTJNEy02EmtfT33qKjWFfsxLC8mHh6Rwi3kd4feGD3xLbsHNazceCs7
	zY4N4jFn/h6xbSpSByBvMFFckRBjDC06TfBnLdEg=
Received: by mx.zohomail.com with SMTPS id 1776693225862706.463009848236;
	Mon, 20 Apr 2026 06:53:45 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 20 Apr 2026 15:52:42 +0200
Subject: [PATCH v5 5/6] arm64: dts: rockchip: add PWM nodes to RK3576 SoC
 dtsi
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-rk3576-pwm-v5-5-ae7cfbbe5427@collabora.com>
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
In-Reply-To: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8656-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[1.161.201.32:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[2add0000:email,collabora.com:email,collabora.com:dkim,collabora.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,2ade4000:email,2ade7000:email,2adc0000:email,2ade0000:email,2ade3000:email,2ade2000:email]
X-Rspamd-Queue-Id: 2EC4442DA0A
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


