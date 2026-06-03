Return-Path: <linux-pwm+bounces-9240-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7mrCIL9TIGqn1AAAu9opvQ
	(envelope-from <linux-pwm+bounces-9240-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 18:18:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80262639A08
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 18:18:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=SKMcKD79;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9240-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9240-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70D1F324BBC5
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF243D45FE;
	Wed,  3 Jun 2026 15:24:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0B3E0C44
	for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2026 15:24:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500286; cv=none; b=Uq/820My7GhbyI+XCkaJy2/DnVHHU8g+wTJLe48WKp36I/cLWQ0s3sx94svZCiH8uFZGLhTb2nfzjzjbUD4a9PP3KULWL6j6VxBT/jon99YeUT41Huo+uVy23ipMkS7b+D/jwxivdwkGKbxIUd7N8Lrxinqvttqwka9whBZfFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500286; c=relaxed/simple;
	bh=NyT3bvkYhBzVis/qc4NVpDUc0HxiHbXcgKHaKLAMasY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deoBVibWSbfZjdAuqdcC5UGfy93FTW+OG4Rb/eEX6Y/J+aIKydPsvEg5IAVfOVwytSvNznx14gfZlseO/39FXDYv3RVKu5X/HL1rTUps8NOyDhNlYvSHA86hZlQFyLcu8gF1950CydnAW0vR1+dpWKPznu7aKS3lGNCnRZRJY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SKMcKD79; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45eec22fab7so3613203f8f.3
        for <linux-pwm@vger.kernel.org>; Wed, 03 Jun 2026 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780500283; x=1781105083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=SKMcKD79kKsplaImXWSljuoFk26lfBdoU25DlYGEsC9+fm3BKwzdYPqDRwTw8yd3U1
         Fvj9SPZUGjupaU5FcchcO8i4Mi/9ps23oAHxStsDm8lkNAXh4m3yTYBqOHBrnq0NRjmY
         7tfDZaA2jUJamDc3nQeqvE3x10p1gzjoU6VRk37+JqN49Qv3XJcPAjf9z7142sD7yG/j
         gk1RbgYX9Ng3zonqH7EfH2qL5NPcqoG/ER+11y+Ri/hOtehxhpbTNJ2WnJrjOS0APYFp
         22A+Dr4jv0YUZNG/e5GZt/L914f5XLFWQbp8HH4V1F1YzwDVEt8WeaInVujVrTHk/hez
         HFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500283; x=1781105083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUWg5GWqhMeDrgGwJjMhc1B+7LHRy8TQo04xcORPTAE=;
        b=GZWEMua+kgC6AQ7TV0gpcSIQKDuHY/tprWd5dO+xrWbHLr2ON0dWmrJs88LZDHXF0f
         7Mx0s4dWMltvhTLn2VlUVEfXRYAtehbC2rjB4OgZ3RWuURDVKUPEMQKEYijn90beIRAw
         yur89igb0fCcS2vunc1g7fTtODSALR6aq6dCTHll+owGZULCJR5nwXisPp9cfk89jHvD
         ZfFt+f8G/4YDkayWeMgWO+NY0bMv9Rn5XuCfqjLqrXsXeyAlmBeFORYL3MFD+YQQDYNE
         Xm2ckKHnopSqgiFK5cP7FbbD2RqHK/3YuCQ4Do9weGJV7X98TPeirRnlB5lmIwyXJ7CZ
         sC2w==
X-Forwarded-Encrypted: i=1; AFNElJ9n2eK2455xXYAz5Oma3hXA6R1+7pGOTkGOl41plB6Rq9pugR9AuAMt8dXNidAVQOKfAStRgSKLFNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwc/1AKP0+h8wYs+dzC2qIB5OxkUhiv9ilXdA6yQHmmRiOnrc
	p4foKKvWi1uBvCIE/uxaY0bickmcDjofCgg3hQydZrHXvW3vzhtc1eZe71tM46pCd3k=
X-Gm-Gg: Acq92OHwXxGFMoDLKxvLC3IaFOBu6GdJN7uHZSCttgr7DKEcYt6JTNgfU6OcaogzXEP
	m3/rdXR/ZUfHo2lEAhRmobmHk957a0/J8V8D579Of7h9EfWeHNBbNzRyT9ksfKa8+JDIAYRjDfq
	ya3BarXpCsaVdKmkQ+sLQ7+4Esc/fnmiAstGIpsh/39pAgKSm0guldXnwNDpXc5GMO5NoJWOYYM
	YpaIEEs0cQSo+Rfdyj//aCLYr615XqtY8jhWCbtldbJ+TqmzdpbGnq7gpBhwTM+tSo2B5mbvvWi
	xxHaoMGmsc9KusLnmqh++gUzyp1HbQPuAS0NX3n1qROPQTJcPUVifrc3bREAcE7lJbf0Du6cMzN
	Xr/RZKlKgMrxYhPWkxae6KSde8eKIPc4CkniySALO5KS5S+gZOY0y7jj+lVtd6zuaeyB51Bh+oI
	/q4HdXuY+hyBMqqrq/lqVvaBUyjxM9G1uOiGxtCcl1Mag=
X-Received: by 2002:a05:600c:8b01:b0:490:6237:5200 with SMTP id 5b1f17b1804b1-490b5d36863mr63918565e9.10.1780500283560;
        Wed, 03 Jun 2026 08:24:43 -0700 (PDT)
Received: from localhost ([82.192.120.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b725fb1bsm63329125e9.8.2026.06.03.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:24:43 -0700 (PDT)
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
Subject: [PATCH v4 3/3] arm64: dts: broadcom: rpi-5: Add RP1 PWM node
Date: Wed,  3 Jun 2026 17:27:46 +0200
Message-ID: <3328baef11e5cf57391c2679d810922807f26a7a.1780498640.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780498640.git.andrea.porta@suse.com>
References: <cover.1780498640.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9240-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrea.porta@suse.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:mid,suse.com:dkim,suse.com:from_mime,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80262639A08

From: Stanimir Varbanov <svarbanov@suse.de>

The RP1 chipset used on the Raspberry Pi 5 features an integrated
PWM controller to drive the cooling fan.

Add the corresponding DT node for this PWM controller.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 12 ++++++++++++
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi     |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index 0fc57e72632ed..748be8f1ee9e2 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -64,6 +64,12 @@ phy1: ethernet-phy@1 {
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
@@ -94,6 +100,12 @@ &rp1_i2c6 {
 	pinctrl-names = "default";
 };
 
+&rp1_pwm1 {
+	pinctrl-0 = <&fan_pwm_default_state>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &rp1_usb0 {
 	pinctrl-0 = <&usb_vbus_default_state>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
index 16f5359395835..df4c2d09c8d34 100644
--- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
+++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
@@ -99,7 +99,16 @@ rp1_i2c6: i2c@40088000 {
 		clocks = <&rp1_clocks RP1_CLK_SYS>;
 		i2c-scl-rising-time-ns = <65>;
 		i2c-scl-falling-time-ns = <100>;
+		status = "disabled";
+	};
 
+	rp1_pwm1: pwm@4009c000 {
+		compatible = "raspberrypi,rp1-pwm";
+		reg = <0x00 0x4009c000  0x0 0x100>;
+		clocks = <&rp1_clocks RP1_CLK_PWM1>;
+		assigned-clocks = <&rp1_clocks RP1_CLK_PWM1>;
+		assigned-clock-rates = <50000000>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
-- 
2.35.3


