Return-Path: <linux-pwm+bounces-8658-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMAyHJQ+5mlutgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8658-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 16:56:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB4D42DA39
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 16:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E5F8304D0CA
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB103242B2;
	Mon, 20 Apr 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="diKJZQKQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660231E83D;
	Mon, 20 Apr 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693257; cv=pass; b=aL4Jnkb3oQWVvd23fcR7E5wZx31qr/5Piwnw/Rk9qYzuP2yATHEdmSvn7xuEHCz+WZ+2FvskNhsEJEP+2fyh1mV+/f/vVj9mymXVlv6DTK2Cd3L7HijcWB5FQ+U3CIxdwQ/+yC80CMF08dMZZkFoHrAExkEU/223DEEBafr1rik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693257; c=relaxed/simple;
	bh=7nxH65M+nVV6F8JGySK3S8PzTWwDQbriCEZGH0kEsio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLtrjzkvpxOyl1MHDqKg/u4jhIdyppo8Sssdyjg+ecMq1TIZOhaejiQbneQvEvQrd2zKHFWsEJyQXXm6LTX/HvS5tZKgAGJSQMviqllYV+cHQa/bjEYlNmDBdLuw5jv5T8L566MyNTV8uUJ42Xd8nH4b4Ykok0/PEPa/puyyPSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=diKJZQKQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776693232; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZmRGHhCbVVuntIQN7Lwlw8IHc47PIo9QgzlRXcIOHN1ifbnllB7EL07s2o/T+lVGBVlXcHXQv0vGu0swmOsfkpxB3FzHHc4vyrjEUlWibDWgRNvB2UhV56CcfIKKFLVdMaIiMAlXMG2JID2jBkOgwCshHTFgr1GqpEMTB4Un8ac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776693232; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r4cDyWh6L3sYfjSwYgHFLsyc+ptcJlt/BspUsjzlPPc=; 
	b=a5NFLqCLaZt8JyFsHCyRJC0Nvrkj1dfRcg3lsoWEmjcSAvBbrd0Afd68nf7Oklpv2jc+HA2GwVgrIgubqW1nzbj3RfwtP5KOQwFylFIpfinJQ4rhqUdiXW0q8V7SHgPjVCBMQOxOqz8sizHxCpap0LgY0MpJfqAX1gByczcDAb8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776693232;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=r4cDyWh6L3sYfjSwYgHFLsyc+ptcJlt/BspUsjzlPPc=;
	b=diKJZQKQ2PpHUhWXUMICWt4DiEYfNOX1onWvh6SxNmsKKVeFvouD/3vXnnmRsw3e
	3jTszb8usASmgBb4s4ThmT1nu5QUi+b8JTlpKdLnPeMKDnwR8VW0jDONwK5qnGoydgC
	NgxXJXuzOWAx5c8RyovPTJB6YvHfQB2Eb/KhLuOY=
Received: by mx.zohomail.com with SMTPS id 1776693229607341.23138685458855;
	Mon, 20 Apr 2026 06:53:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 20 Apr 2026 15:52:43 +0200
Subject: [PATCH v5 6/6] arm64: dts: rockchip: Add cooling fan to ROCK 4D
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-rk3576-pwm-v5-6-ae7cfbbe5427@collabora.com>
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
	TAGGED_FROM(0.00)[bounces-8658-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EB4D42DA39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ROCK 4D has a header to connect a small cooling fan. This fan is
driven by one of the SoC's PWM outputs driving a transistor, that in
turn controls the fan's power.

With the introduction of PWM support, add a description of this cooling
fan, as well as the additional trips and cooling-maps for it.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 50 +++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 899a84b1fbf9..2d5ede010ad0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -45,6 +45,14 @@ rfkill {
 		shutdown-gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_HIGH>;
 	};
 
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 180 205 230 255>;
+		fan-supply = <&vcc_5v0_sys>;
+		pwms = <&pwm2_8ch_5 0 60000 0>;
+		#cooling-cells = <2>;
+	};
+
 	leds: leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -711,6 +719,36 @@ rgmii_phy0: ethernet-phy@1 {
 	};
 };
 
+&package_thermal {
+	polling-delay = <100>;
+
+	trips {
+		package_fan0: package-fan0 {
+			temperature = <50000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		package_fan1: package-fan1 {
+			temperature = <60000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map2 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_reset>;
@@ -720,6 +758,13 @@ &pcie0 {
 };
 
 &pinctrl {
+	fan {
+		fan_pwm: fan-pwm {
+			rockchip,pins =
+				<4 RK_PC5 14 &pcfg_pull_down_drv_level_5>;
+		};
+	};
+
 	hym8563 {
 		hym8563_int: hym8563-int {
 			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -770,6 +815,11 @@ wifi_en_h: wifi-en-h {
 	};
 };
 
+&pwm2_8ch_5 {
+	pinctrl-0 = <&fan_pwm>;
+	status = "okay";
+};
+
 &sai6 {
 	status = "okay";
 };

-- 
2.53.0


