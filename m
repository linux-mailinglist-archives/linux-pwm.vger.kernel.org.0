Return-Path: <linux-pwm+bounces-9663-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gjaDHPlPT2rbeAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9663-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:38:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0909F72DD47
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:38:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=cCIEkQub;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="c orQbOb";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9663-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9663-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AF2D305C037
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567373F12F9;
	Thu,  9 Jul 2026 07:31:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0B3E6DD4;
	Thu,  9 Jul 2026 07:31:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582304; cv=none; b=t00pECRzvyFlb6T6xXsyPN7ivba+Cnnx5A/9Q59wUC5q3zoco6KvHP3L4tmodOtdCWpVnCpEKsLfv2sDMu4TnMhHptg7TZSRHyGTaAC299DjjDcUEDuX7aZOGGQymwAfFM3r1I+/coXt0bLUcQhpLhYLslVyyfa3/NCeDrR9dAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582304; c=relaxed/simple;
	bh=vtT3fq92Jr0DE4IqC+aqsET5XreH+3vnZPtLNfpKDCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g+2E/q01AqW9CmYeZCtaq33NGSec2LR6zcvyxKOVcEomId0VsPk12eSkwmeNsZrltgBlSdKjQ4XeuZxngwSsQ8BVZRoAXe+1n2DUuf+RQndPrmQxCxJLAJrkMBhL9Gl1R+76HUgAviODNhK7ela88AAT5RmFUE37rp3uU6QnKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=cCIEkQub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=corQbObq; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 4888C13801B2;
	Thu,  9 Jul 2026 03:31:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 03:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582298;
	 x=1783589498; bh=LZ43n1VmiQ0bhC6HCoJlZmMAJYs90yCx2COcwCMoyK4=; b=
	cCIEkQubtu+ngW5vvBm5IQo8+mFLm1ivkQc2yFaug9+8AVWNU3P7QrtwU9NAp8l4
	9ELDNPyRWC+IWmHqg87dWYcdhZlTQNKzlgAx7WGatK7oT7/gCqVHEeR1AxuDVTRW
	eNYQDyAzjjLXGprK3oNHEq5f3NcId86fNg+h+iHdFq02nXlhev6Aa8HQCElekHOC
	IDvTgvNArdh9oJqbSZJmC7FD3FLJ7OcDn7LG3e8kmNiQDCzfGE5XomCpHr7nkGV5
	QGGDXhbsjS2w4+0+bpdf3Zj3M+unrk5qx7UWybTxgJVhd7rgF+qb7yCurD7Y80it
	jITIY2Tqt2C6OUhmrBVmfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582298; x=
	1783589498; bh=LZ43n1VmiQ0bhC6HCoJlZmMAJYs90yCx2COcwCMoyK4=; b=c
	orQbObqZHOTO6Gm7CLfDO2FEH4fSKH/9eP2hf95z5reaS+Q1wS170gZUL/IyPD72
	lUC4quwVv4XS9GS/veximm+P3RXO03PyuAImhyL+XgAMMBFWTvAGgswAW3Zjq27G
	J4tcjb4Tu4KVV/44BLR6iDT1FycDnLXWYtiaH2i2i5HWq6zUpBUtw5TONooVKiY4
	AGTJG+cdvInB5ixw5S3va5308z9UDjNd8/lb53cY7HfIniEDZxPFGTqaDFaYBGnD
	8Cn/JKeBVVc4Fpqs1VLjDH4BixaZPzi0ku1EqGMAtgpp0rcFpb9ZpeyRgMULNXFj
	s8cm/GRL4Ys+vY2kiu+2w==
X-ME-Sender: <xms:WU5Pambjs8RZAJvluz-PZo1yj_zGOOSUugE_MEidbLjcrMx7pfQwyA>
    <xme:WU5PakKHGc2E0y6nhCGPixgmFr4Y0guFssfKyK9A1iCh6Fv9uQMoJGmQuO0Il8nqk
    pnUwYhlDgFv-DenbO6e0AMO_6AVXMZqmCyMNQ4SXJ-G7nl60SHUzD0>
X-ME-Received: <xmr:WU5Pav2y3jwR2p-n-GZwVnH5H6FK5sJLcxMy72LSjY9NHc9q8OuTXuGdg6iaBSOXo2cPDgGN56ZTXBQoHmzJ6PH5PtbG1VPEs9s>
X-ME-Proxy-Cause: dmFkZTFDgvji+KZOYa7+nDRYV5XjpiHYyZNb+S62U1l3I0KgY+OxJTHOccc7LleD76+n6b
    Vf0fTkznQWCQtUJWgIlosDWTwuMIFaBxPt3fTu/P9Cx41Cuvrk6EyPr+NNfcbSVCPT3+Dc
    C6efMtdHDRJF5NN4unR+Llnrm9yKKGkxbNssZuc0MV99+GgEHaiE4b6Jv7DPfedmhEtrjl
    UIJxXa0C0eF7kFlLWMf7rGql7KQXWx+/7Zo6i0e6y7H1udqz2uSFZ55rFZXpgMXMistz7D
    Zk29AuVpkBQ7eIeXTsIe1jlElcCjhKZ98d11EqdTlN+SxLlaQ0qYrg2hFiC7rk7Z0xHuC+
    WuQc1S0HdThkVWZ9DA/iNpkIzXVQlwqrWnBqojKHQSUZ8MTOfVjWVw5IvSD8XvvPPZYAaq
    /Czfq0Ke1LYHsjWZYk6oOxglCajh41zhFbqXhILP7PvGswN6KPjAFUl4y809SSGmP7hp8s
    fvK1go5UEhxEiTbW1ZkyU7VHfE8AM11Ctv5HQXBMHOaSgHqIUy5RP0IuDE8IzUU1U8QPOw
    G7PuFaF6eGHqDO6KIkhR698Z3urFbE7Qkf7sZUjPzywlXxrpKvFVHCsZZFWCI1K3gueAaz
    +KFRcKV+PCkoTTcB8844/d6WbJ+WmLZoEps2iCQRmvgP5mBnMLRhC0U9gvAQ
X-ME-Proxy: <xmx:WU5PavbcJQNPoXRIFZt8ixWdIKprCLrPaTpW_6_eC8lSW-K2Ot1BSw>
    <xmx:WU5PaiVgljDKPcVKZvv0GwIUCYI-_BomE7bzbGVqkDV3y9jm_aQ5YQ>
    <xmx:WU5PaqdtQcugWGNRE6vvc7EsFWB60lps7eSAtLo6-_LosdX1az22-g>
    <xmx:WU5PavPKL63HQQI2peWiMeMolexDtzj1A5rkvBobYnNG6mB7ImvMRQ>
    <xmx:Wk5Pap8BzyUc_yaJDQrKJSPEn512a3IvdErlju5ngc9ScVI3Gjk1eKiY>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:37 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:57 +0200
Subject: [PATCH 11/11] arm64: dts: apple: Initial T6030 (M3 Pro) device
 trees
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-11-55b305833123@jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=58010; i=j@jannau.net;
 h=from:subject:message-id; bh=vtT3fq92Jr0DE4IqC+aqsET5XreH+3vnZPtLNfpKDCc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/P4f7wWatSvycZ51kS/43vpT/t32B9R/PV099P/5/L
 BrUqJDaMZGFQYyLwVJMkSVJ+2UHw+oaxZjaB2Ewc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 kY6xjhEDF6cATHWbD8P/0lLp2pPfL73XqG+9wFjHLXgzg+tYjmrf9LlGNtY88f63GRmecp/oY2O
 seNS8dZMbn9PuhqzKSft81UrXzVo3fQEjeygvAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9663-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:j@jannau.net,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:from_mime,jannau.net:email,jannau.net:mid,jannau.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0909F72DD47

Minimal device trees for the M3 Pro based 14-inch and 16-inch MacBook
Pro released in November 2023. The M3 Pro is a distinct SoC design and
not a cut down version of the Max variant like for M1 and M2 Pro.
The M3 Pro has only a single cluster with up to 6 performance cores and
one cluster with 6 efficiency cores.
While it no longer shares a common SoC .dtsi the devices itself are
still similar to the ones with M3 Max. It is still useful to share the
basic device composition in t603x-j514-j516.dtsi. For the M3 Pro based
devices additional overrides for diverging pin and irq numbers are
expected.
The device trees have devices nodes for CPU cores, timer, interrupt
controller, power states, watchdog, serial, pin controller, i2c,
PWM based keyboard LED illumination and the boot framebuffer.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/Makefile        |    2 +
 arch/arm64/boot/dts/apple/t6030-j514s.dts |   22 +
 arch/arm64/boot/dts/apple/t6030-j516s.dts |   22 +
 arch/arm64/boot/dts/apple/t6030-pmgr.dtsi | 1437 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6030.dtsi      |  524 +++++++++++
 5 files changed, 2007 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index a22b4a8068b6..9fea43f760ec 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -87,6 +87,8 @@ dtb-$(CONFIG_ARCH_APPLE) += t6021-j416c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6020-j474s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6021-j475c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6022-j475d.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6030-j514s.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6030-j516s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6031-j514c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6031-j516c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6032-j575d.dtb
diff --git a/arch/arm64/boot/dts/apple/t6030-j514s.dts b/arch/arm64/boot/dts/apple/t6030-j514s.dts
new file mode 100644
index 000000000000..3ba2c9ca4347
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6030-j514s.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (14-inch, M3 Pro, Nov 2023)
+ *
+ * target-type: J514s
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6030.dtsi"
+#include "t603x-j514-j516.dtsi"
+
+/ {
+	compatible = "apple,j514s", "apple,t6030", "apple,arm-platform";
+	model = "Apple MacBook Pro (14-inch, M3 Pro, Nov 2023)";
+};
+
+&framebuffer0 {
+	power-domains = <&ps_disp_cpu>;
+};
diff --git a/arch/arm64/boot/dts/apple/t6030-j516s.dts b/arch/arm64/boot/dts/apple/t6030-j516s.dts
new file mode 100644
index 000000000000..ab07bf7939ab
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6030-j516s.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (16-inch, M3 Pro, Nov 2023)
+ *
+ * target-type: J516s
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6030.dtsi"
+#include "t603x-j514-j516.dtsi"
+
+/ {
+	compatible = "apple,j516s", "apple,t6030", "apple,arm-platform";
+	model = "Apple MacBook Pro (16-inch, M3 Pro, Nov 2023)";
+};
+
+&framebuffer0 {
+	power-domains = <&ps_disp_cpu>;
+};
diff --git a/arch/arm64/boot/dts/apple/t6030-pmgr.dtsi b/arch/arm64/boot/dts/apple/t6030-pmgr.dtsi
new file mode 100644
index 000000000000..932388ea13c9
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6030-pmgr.dtsi
@@ -0,0 +1,1437 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for Apple T6030 "M3 Pro" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&pmgr_gfx {
+	ps_gpx: power-controller@0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpx";
+		apple,always-on;
+	};
+
+	ps_afr: power-controller@100 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "afr";
+		apple,always-on;
+	};
+
+	ps_gfx: power-controller@110 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+		power-domains = <&ps_gpx>, <&ps_afr>;
+	};
+};
+
+&pmgr {
+	ps_msg: power-controller@108 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msg";
+		apple,always-on;
+	};
+
+	ps_aic: power-controller@110 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+	};
+
+	ps_dwi: power-controller@118 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@120 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_pms_fpwm0: power-controller@138 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm0";
+	};
+
+	ps_pms_fpwm1: power-controller@140 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm1";
+	};
+
+	ps_pms_fpwm2: power-controller@148 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm2";
+	};
+
+	ps_pms_fpwm3: power-controller@150 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm3";
+	};
+
+	ps_pms_fpwm4: power-controller@158 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_fpwm4";
+	};
+
+	ps_pms_c1ppt: power-controller@160 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_c1ppt";
+	};
+
+	ps_soc_rc: power-controller@168 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_rc";
+	};
+
+	ps_soc_dpe: power-controller@170 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "soc_dpe";
+		apple,always-on;
+	};
+
+	ps_pmgr_soc_ocla: power-controller@178 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmgr_soc_ocla";
+	};
+
+	ps_ispsens0: power-controller@180 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens0";
+	};
+
+	ps_aft0: power-controller@190 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aft0";
+	};
+
+	ps_ap_tmm: power-controller@1a8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ap_tmm";
+	};
+
+	ps_sio: power-controller@1b8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio";
+	};
+
+	ps_disp_sys: power-controller@1c0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_sys";
+	};
+
+	ps_jpg: power-controller@1c8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+	};
+
+	ps_sio_cpu: power-controller@1d0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_cpu";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_fpwm0: power-controller@1d8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm0";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_fpwm1: power-controller@1e0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm1";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_fpwm2: power-controller@1e8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "fpwm2";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c0: power-controller@1f0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c1: power-controller@1f8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c2: power-controller@200 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c3: power-controller@208 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c4: power-controller@210 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c4";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c5: power-controller@218 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c5";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c6: power-controller@220 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c6";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c7: power-controller@228 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c7";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_i2c8: power-controller@230 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c8";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_spi_p: power-controller@238 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi_p";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_uart_p: power-controller@240 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_p";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_audio_p: power-controller@248 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "audio_p";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_aes: power-controller@250 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes";
+		power-domains = <&ps_sio>;
+	};
+
+	ps_disp_fe: power-controller@258 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_fe";
+		power-domains = <&ps_disp_sys>;
+	};
+
+	ps_spi0: power-controller@260 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi1: power-controller@268 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi2: power-controller@270 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi3: power-controller@278 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi4: power-controller@280 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi4";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_spi5: power-controller@288 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi5";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_qspi: power-controller@290 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "qspi";
+		power-domains = <&ps_spi_p>;
+	};
+
+	ps_uart_n: power-controller@298 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart_n";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart0: power-controller@2a0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart1: power-controller@2a8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart2: power-controller@2b0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart3: power-controller@2b8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart4: power-controller@2c0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart5: power-controller@2c8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_uart6: power-controller@2d0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_uart_p>;
+	};
+
+	ps_sio_adma: power-controller@2d8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_adma";
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dpa0: power-controller@2e0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa0";
+		apple,always-on;
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dpa1: power-controller@2e8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa1";
+		apple,always-on;
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dpa2: power-controller@2f0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa2";
+		apple,always-on;
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dpa3: power-controller@2f8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa3";
+		apple,always-on;
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_dpa4: power-controller@300 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa4";
+		apple,always-on;
+		power-domains = <&ps_audio_p>;
+	};
+
+	ps_mca0: power-controller@308 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_dcs0: power-controller@320 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs0";
+		apple,always-on;
+	};
+
+	ps_dcs2: power-controller@328 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs2";
+		apple,always-on;
+	};
+
+	ps_dcs1: power-controller@330 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs1";
+		apple,always-on;
+	};
+
+	ps_dcs3: power-controller@338 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x338 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs3";
+		apple,always-on;
+	};
+
+	ps_dcs4: power-controller@340 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x340 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs4";
+		apple,always-on;
+	};
+
+	ps_dcs5: power-controller@348 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x348 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs5";
+		apple,always-on;
+	};
+
+	ps_dcs6: power-controller@358 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x358 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs6";
+		apple,always-on;
+	};
+
+	ps_dcs7: power-controller@360 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x360 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs7";
+		apple,always-on;
+	};
+
+	ps_dcs8: power-controller@368 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x368 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs8";
+		apple,always-on;
+	};
+
+	ps_dcs9: power-controller@370 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x370 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs9";
+		apple,always-on;
+	};
+
+	ps_dcs10: power-controller@378 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x378 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs10";
+		apple,always-on;
+	};
+
+	ps_dcs11: power-controller@380 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x380 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs11";
+		apple,always-on;
+	};
+
+	ps_mca1: power-controller@388 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x388 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_mca2: power-controller@390 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x390 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_mca3: power-controller@398 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x398 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_sio_adma>, <&ps_audio_p>;
+	};
+
+	ps_ioa1: power-controller@3a0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ioa1";
+		apple,always-on;
+	};
+
+	ps_ls1: power-controller@3a8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ls1";
+		apple,always-on;
+		power-domains = <&ps_ioa1>;
+	};
+
+	ps_lw10: power-controller@3b0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "lw10";
+		apple,always-on;
+		power-domains = <&ps_ls1>;
+	};
+
+	ps_dispext0_sys: power-controller@3b8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext0_sys";
+		power-domains = <&ps_lw10>;
+	};
+
+	ps_dispext1_sys: power-controller@3c0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext1_sys";
+		power-domains = <&ps_lw10>;
+	};
+
+	ps_isp_sys: power-controller@3c8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sys";
+		power-domains = <&ps_lw10>;
+	};
+
+	ps_venc_sys: power-controller@3d0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_sys";
+		power-domains = <&ps_lw10>;
+	};
+
+	ps_dispext0_fe: power-controller@3d8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext0_fe";
+		power-domains = <&ps_dispext0_sys>;
+	};
+
+	ps_dispext0_cpu: power-controller@3e0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext0_cpu";
+		power-domains = <&ps_dispext0_fe>;
+	};
+
+	ps_trace_fab: power-controller@3e8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "trace_fab";
+	};
+
+	ps_dispext1_fe: power-controller@3f0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext1_fe";
+		power-domains = <&ps_dispext1_sys>;
+	};
+
+	ps_dispext1_cpu: power-controller@3f8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dispext1_cpu";
+		power-domains = <&ps_dispext1_fe>;
+	};
+
+	ps_dptx_phy: power-controller@408 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x408 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dptx_phy";
+		apple,always-on;
+	};
+
+	ps_avd_sys: power-controller@490 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x490 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "avd_sys";
+	};
+
+	ps_ane_sys: power-controller@498 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x498 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ane_sys";
+	};
+
+	ps_scodec: power-controller@4a0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "scodec";
+	};
+
+	ps_scodec_stream: power-controller@4a8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "scodec_stream";
+		power-domains = <&ps_scodec>;
+	};
+
+	ps_ioa3: power-controller@4b0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ioa3";
+		apple,always-on;
+	};
+
+	ps_ls3: power-controller@4b8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ls3";
+		apple,always-on;
+		power-domains = <&ps_ioa3>;
+	};
+
+	ps_lw30: power-controller@4c0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "lw30";
+		apple,always-on;
+		power-domains = <&ps_ls3>;
+	};
+
+	ps_pmp: power-controller@4c8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmp";
+	};
+
+	ps_pms_sram: power-controller@4d0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_sram";
+	};
+
+	ps_lw31: power-controller@4d8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "lw31";
+		apple,always-on;
+		power-domains = <&ps_ls3>;
+	};
+
+	ps_atc0_common: power-controller@4e0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_common";
+		power-domains = <&ps_lw30>;
+	};
+
+	ps_atc1_common: power-controller@4e8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_common";
+		power-domains = <&ps_lw30>;
+	};
+
+	ps_atc2_common: power-controller@4f0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_common";
+		power-domains = <&ps_lw30>;
+	};
+
+	ps_atc3_common: power-controller@4f8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_common";
+		power-domains = <&ps_lw30>;
+	};
+
+	ps_apcie_gp: power-controller@500 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x500 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_gp";
+		power-domains = <&ps_lw31>;
+	};
+
+	ps_msr: power-controller@508 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x508 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_lw31>;
+	};
+
+	ps_ans: power-controller@510 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x510 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans";
+		power-domains = <&ps_lw31>;
+	};
+
+	ps_atc0_pcie: power-controller@518 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x518 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_pcie";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_atc0_cio: power-controller@520 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x520 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio";
+		power-domains = <&ps_atc0_common>;
+	};
+
+	ps_atc1_pcie: power-controller@528 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x528 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_pcie";
+		power-domains = <&ps_atc1_common>;
+	};
+
+	ps_atc1_cio: power-controller@530 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x530 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio";
+		power-domains = <&ps_atc1_common>;
+	};
+
+	ps_atc2_pcie: power-controller@538 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x538 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_pcie";
+		power-domains = <&ps_atc2_common>;
+	};
+
+	ps_atc2_cio: power-controller@540 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x540 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_cio";
+		power-domains = <&ps_atc2_common>;
+	};
+
+	ps_atc3_pcie: power-controller@548 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x548 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_pcie";
+		power-domains = <&ps_atc3_common>;
+	};
+
+	ps_atc3_cio: power-controller@550 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x550 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_cio";
+		power-domains = <&ps_atc3_common>;
+	};
+
+	ps_apcie_sys_gp: power-controller@558 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x558 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_sys_gp";
+		power-domains = <&ps_apcie_gp>;
+	};
+
+	ps_msr_ase_core: power-controller@560 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x560 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr_ase_core";
+		power-domains = <&ps_msr>;
+	};
+
+	ps_apcie_st: power-controller@568 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x568 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_st";
+		power-domains = <&ps_ans>;
+	};
+
+	ps_atc0_cio_pcie: power-controller@570 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x570 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio_pcie";
+		power-domains = <&ps_atc0_cio>;
+	};
+
+	ps_atc0_cio_usb: power-controller@578 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x578 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_cio_usb";
+		power-domains = <&ps_atc0_cio>;
+	};
+
+	ps_atc1_cio_pcie: power-controller@580 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x580 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio_pcie";
+		power-domains = <&ps_atc1_cio>;
+	};
+
+	ps_atc1_cio_usb: power-controller@588 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x588 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_cio_usb";
+		power-domains = <&ps_atc1_cio>;
+	};
+
+	ps_atc2_cio_pcie: power-controller@590 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x590 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_cio_pcie";
+		power-domains = <&ps_atc2_cio>;
+	};
+
+	ps_atc2_cio_usb: power-controller@598 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x598 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_cio_usb";
+		power-domains = <&ps_atc2_cio>;
+	};
+
+	ps_atc3_cio_pcie: power-controller@5a0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_cio_pcie";
+		power-domains = <&ps_atc3_cio>;
+	};
+
+	ps_atc3_cio_usb: power-controller@5a8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_cio_usb";
+		power-domains = <&ps_atc3_cio>;
+	};
+
+	ps_apcie_sys_st: power-controller@5b0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_sys_st";
+		power-domains = <&ps_apcie_st>, <&ps_ans>;
+	};
+
+	ps_apcie_phy_sw: power-controller@5b8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "apcie_phy_sw";
+		apple,always-on; /* macOS does not turn this off */
+	};
+
+	ps_sep: power-controller@c00 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc00 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on;
+	};
+
+	ps_isp_cpu: power-controller@4000 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_cpu";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_fe: power-controller@4008 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_fe";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_dprx: power-controller@4010 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dprx";
+		power-domains = <&ps_isp_fe>;
+	};
+
+	ps_isp_secure: power-controller@4018 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_secure";
+		power-domains = <&ps_isp_fe>;
+	};
+
+	ps_isp_be: power-controller@4020 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_be";
+		power-domains = <&ps_isp_fe>;
+	};
+
+	ps_isp_clr: power-controller@4028 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_clr";
+		power-domains = <&ps_isp_be>;
+	};
+
+	ps_venc_dma: power-controller@8000 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_dma";
+		power-domains = <&ps_venc_sys>;
+	};
+
+	ps_venc_pipe4: power-controller@8008 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe4";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_pipe5: power-controller@8010 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe5";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_me0: power-controller@8018 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me0";
+		power-domains = <&ps_venc_dma>;
+	};
+
+	ps_venc_me1: power-controller@8020 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me1";
+		power-domains = <&ps_venc_me0>;
+	};
+
+	ps_disp_cpu: power-controller@10000 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x10000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_cpu";
+		power-domains = <&ps_disp_fe>;
+		apple,min-state = <4>;
+	};
+};
+
+&pmgr_mini {
+	ps_debug_gated: power-controller@0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_gated";
+		apple,always-on;
+	};
+
+	ps_nub_spmi0: power-controller@58 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x58 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi0";
+		apple,always-on;
+	};
+
+	ps_nub_spmi1: power-controller@60 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x60 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi1";
+		apple,always-on;
+	};
+
+	ps_nub_spmi2: power-controller@68 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x68 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi2";
+		apple,always-on;
+	};
+
+	ps_nub_spmi_a0: power-controller@70 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x70 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi_a0";
+		apple,always-on;
+	};
+
+	ps_nub_spmi_a1: power-controller@78 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x78 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spmi_a1";
+		apple,always-on;
+	};
+
+	ps_nub_spi0: power-controller@88 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x88 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_spi0";
+		apple,always-on;
+	};
+
+	ps_nub_ocla: power-controller@90 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x90 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_ocla";
+		apple,always-on;
+	};
+
+	ps_nub_gpio: power-controller@98 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x98 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_gpio";
+		apple,always-on;
+	};
+
+	ps_nub_sram: power-controller@a8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "nub_sram";
+		apple,always-on;
+	};
+
+	ps_debug_switch: power-controller@b0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xb0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug_switch";
+		apple,always-on;
+	};
+
+	ps_atc0_usb_aon: power-controller@b8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xb8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb_aon";
+	};
+
+	ps_atc1_usb_aon: power-controller@c0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_usb_aon";
+	};
+
+	ps_atc2_usb_aon: power-controller@c8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_usb_aon";
+	};
+
+	ps_atc3_usb_aon: power-controller@d0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xd0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_usb_aon";
+	};
+
+	ps_atc0_usb: power-controller@d8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xd8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc0_usb";
+		power-domains = <&ps_atc0_usb_aon>, <&ps_atc0_common>;
+	};
+
+	ps_atc1_usb: power-controller@e0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xe0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc1_usb";
+		power-domains = <&ps_atc1_usb_aon>, <&ps_atc1_common>;
+	};
+
+	ps_atc2_usb: power-controller@e8 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xe8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc2_usb";
+		power-domains = <&ps_atc2_usb_aon>, <&ps_atc2_common>;
+	};
+
+	ps_atc3_usb: power-controller@f0 {
+		compatible = "apple,t6030-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xf0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "atc3_usb";
+		power-domains = <&ps_atc3_usb_aon>, <&ps_atc3_common>;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/apple/t6030.dtsi
new file mode 100644
index 000000000000..f79fbadaa92c
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6030.dtsi
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T6030 "M3 Pro" SoC
+ *
+ * Other names: H15J, "Lobos"
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_e00>;
+				};
+				core1 {
+					cpu = <&cpu_e01>;
+				};
+				core2 {
+					cpu = <&cpu_e02>;
+				};
+				core3 {
+					cpu = <&cpu_e03>;
+				};
+				core4 {
+					cpu = <&cpu_e04>;
+				};
+				core5 {
+					cpu = <&cpu_e05>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_p00>;
+				};
+				core1 {
+					cpu = <&cpu_p01>;
+				};
+				core2 {
+					cpu = <&cpu_p02>;
+				};
+				core3 {
+					cpu = <&cpu_p03>;
+				};
+				core4 {
+					cpu = <&cpu_p04>;
+				};
+				core5 {
+					cpu = <&cpu_p05>;
+				};
+			};
+		};
+
+		cpu_e00: cpu@0 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* to be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e01: cpu@1 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* to be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e02: cpu@2 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* to be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e03: cpu@3 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* to be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e04: cpu@4 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x4>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* to be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e05: cpu@5 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x5>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* to be filled by loader */
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_p00: cpu@10100 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p01: cpu@10101 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p02: cpu@10102 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10102>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p03: cpu@10103 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10103>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p04: cpu@10104 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10104>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p05: cpu@10105 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10105>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		l2_cache_0: l2-cache-0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x400000>;
+		};
+
+		l2_cache_1: l2-cache-1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x1000000>;
+		};
+	 };
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&aic>;
+		interrupt-names = "phys", "virt", "hyp-phys", "hyp-virt";
+		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_HV_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "clkref";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges;
+		nonposted-mmio;
+		/* Required to get >32-bit DMA via DARTs */
+		dma-ranges = <0 0 0 0 0xffffffff 0xffffc000>;
+
+		i2c1: i2c@289014000 {
+			compatible = "apple,t6030-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x89014000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 890 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c1_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@289018000 {
+			compatible = "apple,t6030-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x89018000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 891 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c2_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c2>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@28901c000 {
+			compatible = "apple,t6030-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x8901c000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 892 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c3_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c3>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@289020000 {
+			compatible = "apple,t6030-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x89020000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 893 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c4_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c4>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@289028000 {
+			compatible = "apple,t6030-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x89028000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 895 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c6_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c6>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@289030000 {
+			compatible = "apple,t6030-i2c", "apple,t8103-i2c";
+			reg = <0x2 0x89030000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 897 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c8_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c8>;
+			status = "disabled";
+		};
+
+		fpwm0: pwm@289040000 {
+			compatible = "apple,t6030-fpwm", "apple,s5l-fpwm";
+			reg = <0x2 0x89040000 0x0 0x4000>;
+			power-domains = <&ps_fpwm0>;
+			clocks = <&clkref>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pmgr_gfx: power-management@290e80000 {
+			compatible = "apple,t6030-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0x90e80000 0 0x4000>;
+			/* child nodes are added in t6030-pmgr.dtsi */
+		};
+
+		serial0: serial@2892000000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0x89200000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 866 IRQ_TYPE_LEVEL_HIGH>;
+			/*
+			 * TODO: figure out the clocking properly, there may
+			 * be a third selectable clock.
+			 */
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
+			status = "disabled";
+		};
+
+		pinctrl_ap: pinctrl@347100000 {
+			compatible = "apple,t6030-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x3 0x47100000 0x0 0x4000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 273 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 274 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 275 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 276 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 278 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 279 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&ps_gpio>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 224>;
+			apple,npins = <224>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			i2c1_pins: i2c1-pins {
+				pinmux = <APPLE_PINMUX(37, 1)>,
+					 <APPLE_PINMUX(36, 1)>;
+			};
+
+			i2c2_pins: i2c2-pins {
+				pinmux = <APPLE_PINMUX(43, 1)>,
+					 <APPLE_PINMUX(42, 1)>;
+			};
+
+			i2c3_pins: i2c3-pins {
+				pinmux = <APPLE_PINMUX(41, 1)>,
+					 <APPLE_PINMUX(40, 1)>;
+			};
+
+			i2c4_pins: i2c4-pins {
+				pinmux = <APPLE_PINMUX(39, 1)>,
+					 <APPLE_PINMUX(38, 1)>;
+			};
+
+			i2c6_pins: i2c6-pins {
+				pinmux = <APPLE_PINMUX(47, 1)>,
+					 <APPLE_PINMUX(46, 1)>;
+			};
+
+			i2c8_pins: i2c8-pins {
+				pinmux = <APPLE_PINMUX(51, 1)>,
+					 <APPLE_PINMUX(50, 1)>;
+			};
+		};
+
+		pmgr: power-management@350700000 {
+			compatible = "apple,t6030-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x3 0x50700000 0 0x14000>;
+			/* child nodes are added in t6030-pmgr.dtsi */
+		};
+
+		aic: interrupt-controller@351000000 {
+			compatible = "apple,t6030-aic3", "apple,t8122-aic3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+
+			reg = <0x3 0x51000000 0x0 0x184000>,
+			      <0x3 0x51040000 0x0 0x4000>;
+			reg-names = "core", "event";
+			power-domains = <&ps_aic>;
+		};
+
+		pinctrl_nub: pinctrl@3641f0000 {
+			compatible = "apple,t6030-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x3 0x641f0000 0x0 0x4000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 472 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 473 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 474 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 477 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 478 IRQ_TYPE_LEVEL_HIGH>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 37>;
+			apple,npins = <37>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pmgr_mini: power-management@364280000 {
+			compatible = "apple,t6030-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x3 0x64280000 0 0x4000>;
+			/* child nodes are added in t6030-pmgr.dtsi */
+		};
+
+		wdt: watchdog@3642b0000 {
+			compatible = "apple,t6030-wdt", "apple,t8103-wdt";
+			reg = <0x3 0x642b0000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 480 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_smc: pinctrl@36c820000 {
+			compatible = "apple,t6030-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x3 0x6c820000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_smc 0 0 18>;
+			apple,npins = <18>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 545 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 546 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 547 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 548 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 549 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 550 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 551 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_aop: pinctrl@374824000 {
+			compatible = "apple,t6030-pinctrl", "apple,t8103-pinctrl";
+			reg = <0x3 0x74824000 0x0 0x4000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 394 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 400 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&clkref>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 54>;
+			apple,npins = <54>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
+
+#include "t6030-pmgr.dtsi"

-- 
2.54.0


