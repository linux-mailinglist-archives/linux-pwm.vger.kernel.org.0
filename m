Return-Path: <linux-pwm+bounces-8675-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCtsINHY6WmglQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8675-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 10:31:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8999944E8ED
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 10:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0961030B65AF
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 08:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1BD382F20;
	Thu, 23 Apr 2026 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HN4D0qJU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B733C4574
	for <linux-pwm@vger.kernel.org>; Thu, 23 Apr 2026 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932859; cv=none; b=SfSJomSTdyPreYke82f2/juHPCNuM7Y5Grv8pwmy7upIQ/uz8PVCDiDmwBWzRbPY0Yya2afKV5ZPIOwGdkcDYK7t6BpjWs7RKq400zSCxJFDu2NBKkkeGu+lN1kO38zmk1qeyzSZcU7GyStU+JKlte4KQ/xwY06XV10HBzJinaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932859; c=relaxed/simple;
	bh=fLM8M+exZKgQsFh5tdcGS1DmZreTyFRyr9bIXtCcplM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doMj6WEKK4e0xwz+Z2XeXIfedYoMCX8FfBPKN75B6HmcqXq0EOaz0YpiLr/JnypVlEyEYm0ExE/BCfyBg3UJDyT2sQ3oiiM/4crF/UsWabxix3aaNZyLPeqNVMk6rNNj6sOITNB5yuzQg/4/K6YoXMlhXURaPbiT5TmcfXvGTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HN4D0qJU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891f625344so48062285e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 23 Apr 2026 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776932851; x=1777537651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUTaySjIgh6lfu9rWtVOEFr4avLmeO2LROURou8Y2uw=;
        b=HN4D0qJU1Vo2fsFKl+MMANnkIQ5Vs6TvZ2d7/BIT62H/KdDKJvulgIr6mhxvb41zDS
         34rMZSnpPeBtVd76tkJAgsBD2banAvk/WkGAfBsfVGMwqitwQkgkMrCEbiG13IPzd333
         MqQQ7XVwlQV5U93qSFrA/YQBdEsIY2FxfhnkrzcCQBpm1Er6J7sdgV5DClR+L6zRuqUc
         KIWtxNfMGfFs0NyeT32kL9Q1xsokneVUm4N8qqjTBNCNSV07Ass/CmXsTN0HlrPu8cKX
         AsofUdXPdoeBlBHVbY9Rpc1ISG/UxDYSA2fINgqQ8UmZVmsX51Mqh7HEm3fsWbqbOEaZ
         /kxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776932851; x=1777537651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aUTaySjIgh6lfu9rWtVOEFr4avLmeO2LROURou8Y2uw=;
        b=DsgllZRTlQiLyFEHlOgp5gJcAWki4M6YwBydE7w8/9pUE1jtZBfrPHogLUqos6OXv9
         EgDT5To5fG6cAMo5dOS7SNna4HER/sRvDWIaOTeCaTDOz8TkELJEa6NgSdfF07fWyyqu
         f0ZtTN/SQCTqrcMhzLo7Zjk6UlqpwYTj8bqySlByOvEac2Dp6Qc2+SOmv+GOvYJZtCYS
         LwweXe7yWJ+1DwM9B6IGdKvHBs27FCH1GkA14GVFR3gNUEndT2w/qnjuJXas1P/2lUlt
         zz24rsTkFf4oA7pyLM01ZIFIHN7lZwD8l2dafrHr6R596fQVpT1rtbovHpKtLwBbSW1t
         7BIw==
X-Forwarded-Encrypted: i=1; AFNElJ/5l9N1iSFPkqIej23hKgYwgIkHSVLxC3JHA0JN2K9hRJ2Crum9RG6OfoRR3qiSyXgCq/AQD/CjH6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJIPwaKFDbYnCFGqJu6gLB2HT5XXv255cvPLa5TW7B0zyd8io
	JRyOLKDxv0jXdLxnf+Mq6jwPpdEyfaOhrvpvVEYqApiyqOZj7hXoU0YyaIQPGLNoCBs=
X-Gm-Gg: AeBDiesmgEPZv85tg8tqaYc/FCZ/N2ItAwkG52SayHPLnpbqcebIdrFPyaJ2W5e4Dw0
	QGmbNFzo69BkiPBpvl1OsKeXKi8LjWOSf+gPSjRP7zMf0udawNRgpRNCqgMdNAdHh7brTIkLXXC
	zJuSYiXoh9W5BsT1BcLgUxdJNS/eRBKluWM22umoqb6F+cM078ZvMHS11jyGr21OZ1D+fd+pSVL
	xqKhxJiAZriVMTof4u4fMpmLBsOgwgZJwalACsxa8BTNARc6zCRnvVYk2XEbpegtH4uQY2goaEJ
	aPBBt7/xkN/whGrOLTUharXY3V4yLqlWcwmZWAFlG6Td6RYv+n+dRMuf66Pzg9Ogo5jKsOdfhn6
	XrOKKF5W6YyKBp0NoadIca0AYuY8wQWQan34dHF/8iULNsv8fCh8La7T9JUPZM7e/i3k4BqRLbT
	kbY1udVwA4LWPQFF6x3xp+fdXSjpgsu3BNximmTBPpU3dSeoKh66d8hXKkqarcbh6L/mnaIUWCU
	L3wFi8=
X-Received: by 2002:a05:600c:691:b0:488:9ec1:4976 with SMTP id 5b1f17b1804b1-488fb88b81emr223263245e9.8.1776932851294;
        Thu, 23 Apr 2026 01:27:31 -0700 (PDT)
Received: from localhost (host-79-33-140-232.retail.telecomitalia.it. [79.33.140.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm55901924f8f.6.2026.04.23.01.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:27:31 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	mbrugger@suse.com
Subject: [PATCH v3 3/3] arm64: dts: broadcom: rpi-5: Add RP1 PWM node
Date: Thu, 23 Apr 2026 10:30:21 +0200
Message-ID: <d6af30e0d72b2df2a0b640d413314a9377cfb226.1776932336.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776932336.git.andrea.porta@suse.com>
References: <cover.1776932336.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8675-lists,linux-pwm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid,2.98.160.80:email]
X-Rspamd-Queue-Id: 8999944E8ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stanimir Varbanov <svarbanov@suse.de>

The RP1 chipset used on the Raspberry Pi 5 features an integrated
PWM controller to drive the cooling fan.

Add the corresponding DT node for this PWM controller.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 12 ++++++++++++
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi     | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index 2856082814462..a4e5ba23bf536 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -64,12 +64,24 @@ phy1: ethernet-phy@1 {
 };
 
 &rp1_gpio {
+	fan_pwm_default_state: fan-pwm-default-state {
+		function = "pwm1";
+		pins = "gpio45";
+		bias-pull-down;
+	};
+
 	usb_vbus_default_state: usb-vbus-default-state {
 		function = "vbus1";
 		groups = "vbus1";
 	};
 };
 
+&rp1_pwm {
+	pinctrl-0 = <&fan_pwm_default_state>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &rp1_usb0 {
 	pinctrl-0 = <&usb_vbus_default_state>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
index 5a815c3797945..d0f4d6be75500 100644
--- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
+++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
@@ -26,6 +26,16 @@ rp1_clocks: clocks@40018000 {
 				       <200000000>;  // RP1_CLK_SYS
 	};
 
+	rp1_pwm: pwm@4009c000 {
+		compatible = "raspberrypi,rp1-pwm";
+		reg = <0x00 0x4009c000  0x0 0x100>;
+		clocks = <&rp1_clocks RP1_CLK_PWM1>;
+		assigned-clocks = <&rp1_clocks RP1_CLK_PWM1>;
+		assigned-clock-rates = <50000000>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
 	rp1_gpio: pinctrl@400d0000 {
 		compatible = "raspberrypi,rp1-gpio";
 		reg = <0x00 0x400d0000  0x0 0xc000>,
-- 
2.35.3


