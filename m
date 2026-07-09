Return-Path: <linux-pwm+bounces-9664-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FTt0MG5PT2qaeAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9664-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:36:14 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ABB72DCAA
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 09:36:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=V+sgXOuC;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="V d6/HSh";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9664-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9664-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C04B930506C0
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C0E3F165C;
	Thu,  9 Jul 2026 07:31:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8F3F0A82;
	Thu,  9 Jul 2026 07:31:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582305; cv=none; b=VyyfgNKOu7QtayNoZd9SN53QdZKyy6ar7xc+pWxgx+mEvdiGOMqKDvhFpbgIcn2yfhi+ngIqdIBfXnIq+pHqpGW7BT7YS0LkcT3DFaaZdXv6Wl2l9cMFeqODCRfViFASTaMm9LStbKeq7He+i03WrcH1bF3GRLbRnYk+KH4ioAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582305; c=relaxed/simple;
	bh=RhtiPf62bP31NtPY528mnXXc79V1rAFEnbhtYccZFc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SW25nTc+AHRYqaT2xxeuX2S6YVBnhV4+1EbS2mWmAC7ffQML4nsr7+JvFZU3ZuBtw7MYoahKPAo0VMdj2lIlZlMPBk1wsCOzmQDi6Z2+rnRxiG0rUtY5suwTvjkJihKUSXlhGWSzaFsLWgl9920362iE9yZqq53bZ3N3WmMJ/Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=V+sgXOuC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vd6/HShM; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 05C84138017C;
	Thu,  9 Jul 2026 03:31:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 03:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582295;
	 x=1783589495; bh=5hOpyOrGjXOFYKINEDMgeFpOxXv3AOwxS8jxQdeqhyA=; b=
	V+sgXOuCqum8BVkAHeILcffvhzhWWZQ2bzNPmKS18r/Xs3cDGwNClujlmXHPnw8b
	NrlwWW2kmXiHf+SdQaZhp4TZJLXrk52Q8Vkr3D/BTy2ueYmbEKag3PahF2CSH1+w
	NhO1ooq/hZ/tSEc8aHEklKbfKljN+hWoAHUOpSIbZ8LacXhogJ2wbrO0+ZwkaqhD
	fh1UWZWPKBJWBpgzimCwmAK7DqvpttSwjvb8skpMTCJUpxSrsr3u8kAIxiEWWWAB
	e4TJgFdnPxlZSGGbfitzNPU7+5IgiEiPI2GRStoRNdXnRHd8zPNkxYxJIUdNPIMM
	uG+slXR5irqAO92hL/kShA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582295; x=
	1783589495; bh=5hOpyOrGjXOFYKINEDMgeFpOxXv3AOwxS8jxQdeqhyA=; b=V
	d6/HShMC4EFZTlUhc4+TB2ZnHJD5vYnPU/ypaBfax30N5HfAm0T14bSnePCGVzNo
	U9C4iL9FExWwMFmC/ofKlyNZLsypiP9lep2lERZjFyshaYZc44HcJv/PE+Po4Bbc
	HY6MbFMqy8Pyh0nyT/j/wGLJPZpBS5VX2I8uSeL/KCcvfIcj1qmoxp62AX/1OG09
	jwEfrO3MjiPacWdWkJCxGDq08j6rIsac++FuOQhwp++7EV90KrC45Gg4VRzGpzOW
	1RfL/gpDHyMS2uqxaLJ+En+0Nw8viDTiuoFdmWvcs3mlIKx0zFCivSxSrACmOK1u
	p8DCuzTA9TnNZzfQSY9kw==
X-ME-Sender: <xms:V05PavAp7_nhx1dp5R0PmBpOSbCheF6tpc9c6fiFj_g8oMYGHZSOYA>
    <xme:V05PaqZuExYljU8S9_rWuaB6PUX4PKMZWSOwsoR4f6jRSajZlYdklpGG1lUneAVOI
    w1SReK42Vqe85N2Q9hBM5MnVtm_xS2mAPdbLuRtKMfSed5p6efmHmM>
X-ME-Received: <xmr:V05PaoJR4yi-xykKuiApPkI2ZASNgFjIUNXAQSFuZvWJEltL_gB81q_Er9QUDDwFILwy2k_Q4adxfn-LW6LpOtcDtBPBZZawQ3s>
X-ME-Proxy-Cause: dmFkZTFDgvji+KZOYa7+nDRYV5XjpiHYyZNb+S62U1l3I0KgY+OxJTHOccc7LleD76+n6b
    Vf0fTkznQWCQtUJWgIlosDWTwuMIFaBxPt3fTu/P9Cx41Cuvrk6EyPr+NNfcbSVCPT3+Dc
    C6efMtdHDRJF5NN4unR+Llnrm9yKKGkxbNssZuc0MV99+GgEHaiE4b6Jv7DPfedmhEtrjl
    UIJxXa0C0eF7kFlLWMf7rGql7KQXWx+/7Zo6i0e6y7H1udqz2uSFZ55rFZXpgMXMistz7D
    Zk29AuVpkBQ7eIeXTsIe1jlElcCjhKZ98d11EqdTlN+SxLlaQ0qYrg2hFiC7rk7Z0xHuhw
    73hlP3cG0UTQg98n3OkEJOJ79kIgRs9G5d0KND+1njPwqT5Dykm0wGBibSn6qexh8MNkDp
    GMmZft5X0Tj8ov2qb1PGSfKjWPA9IAB5JG9Wrs7tW1i3E8uphaD05o4ihLrcev9zsz5dNv
    gNWwZSYvcjGQT4O97+C83JZxeBEUPrzMDMroFiCUzxhWoFVSfsBuWbyG4Biw2y+F1VGcfL
    Deq5U5taTeoqMQvazgAJ6Kp47+5R1uE3i88fp5/wqk1n4XdfmEk/AneiIv7OM1qWzK2ldc
    WYPsQTn8ZA/ZU6R1OWeWTkb2FuDJx9PKUrz3TmHNQUBgFPSGlWXweqbi7P6Q
X-ME-Proxy: <xmx:V05Paj1Qf5ApToyrs0OdtJOqYKeo-G-LKImIVVpXqFVYJSn1HG3q6w>
    <xmx:V05PajZR0GIHVPrq-P0KmJ4qwkXW7hHhxG3zkRbeugBv3t6F0aZvRQ>
    <xmx:V05PamVfm7s43-GFta8hEK5PhD8jLjD9BzsztGmDYkJsFgZlz17zNA>
    <xmx:V05PauebtUjM22gOg3NR3QCwAxX2GEzY3qDNsPgX8H6pQABEGyZuCw>
    <xmx:V05Pat9TaGSnitFxzpvbZwxmYzRu2sVBuJzrnwZWUpMcC4FzNee2RuZR>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:34 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:56 +0200
Subject: [PATCH 10/11] arm64: dts: apple: Initial T603[124] (M3 Max and
 Ultra) device trees
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-10-55b305833123@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=114529; i=j@jannau.net;
 h=from:subject:message-id; bh=RhtiPf62bP31NtPY528mnXXc79V1rAFEnbhtYccZFc8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/P3tp755v/9hEDrio7Uy0OHrZVWSm9Nd8fYtNQRu99
 oafyFfvmMjCIMbFYCmmyJKk/bKDYXWNYkztgzCYOaxMYENEGhiAgIWBLzcxr9RIx0jPVNtQz9BI
 x1jHiIGLUwCm+so5hj98O58F9PBX/tzDc8X02Owlzmf3V7fv2nh2m0/ixJB55xaeZvgf+t7w+H3
 7P8oXmNcdZ3KI7HM/7R9/4D7r/LeakxakefSwAwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9664-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:j@jannau.net,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,jannau.net:from_mime,jannau.net:email,jannau.net:mid,jannau.net:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0ABB72DCAA

Contains minimal device trees for all M3 Max and Ultra Apple silicon
devices. Those are 14-inch and 16-inch MacBook Pros with M3 Max released
in November 2023 and Mac Studio with M3 Ultra released in 2025.
This does not include M3 Pro since it is separate SoC and not a smaller
variant of the M3 Max contrary to the M1 and M2 generations.
The smaller M3 Max variant (10 performance cores) has its own chip
variant (T6034) but is clearly the same design as T6031. Besides fewer
CPU performance cores and GPU cores it misses also on fourth of the
memory controllers and thus has an aggregated bus width of 384 bit
instead of 512 bit.
Both M3 Ultra variants (28 or 32 CPU cores) are based on T6031 judging
by the advertised memory bandwidth of 819GB/s.
This uses the same multi-die macros as t600x*.dtsi and t602x.dtsi to
support M3 Max and M3 Ultra without duplicating device nodes. Since the
M3 Pro can't use the same .dtsi files "t6031*.dtsi" are used to define
common nodes for T6031, T6032 and T6034.
The device trees have devices nodes for CPU cores, timer, interrupt
controller, power states, watchdog, serial, pin controller, i2c,
PWM based keyboard LED illumination and the boot framebuffer.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/Makefile             |    5 +
 arch/arm64/boot/dts/apple/t6031-base.dtsi      |  297 +++
 arch/arm64/boot/dts/apple/t6031-die0.dtsi      |  197 ++
 arch/arm64/boot/dts/apple/t6031-dieX.dtsi      |  107 ++
 arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi |   53 +
 arch/arm64/boot/dts/apple/t6031-j514c.dts      |   18 +
 arch/arm64/boot/dts/apple/t6031-j516c.dts      |   18 +
 arch/arm64/boot/dts/apple/t6031-pmgr.dtsi      | 2400 ++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031.dtsi           |   48 +
 arch/arm64/boot/dts/apple/t6032-j575d.dts      |   46 +
 arch/arm64/boot/dts/apple/t6032.dtsi           |  419 +++++
 arch/arm64/boot/dts/apple/t6034-j514m.dts      |   18 +
 arch/arm64/boot/dts/apple/t6034-j516m.dts      |   18 +
 arch/arm64/boot/dts/apple/t6034.dtsi           |   12 +
 arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi |   67 +
 15 files changed, 3723 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 6fc3349a5842..a22b4a8068b6 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -87,6 +87,11 @@ dtb-$(CONFIG_ARCH_APPLE) += t6021-j416c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6020-j474s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6021-j475c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6022-j475d.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6031-j514c.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6031-j516c.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6032-j575d.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6034-j514m.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6034-j516m.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j415.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
diff --git a/arch/arm64/boot/dts/apple/t6031-base.dtsi b/arch/arm64/boot/dts/apple/t6031-base.dtsi
new file mode 100644
index 000000000000..0bb7373b3f06
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6031-base.dtsi
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Nodes common for T6031, T6032 and T6034 family SoCs (M3 Max/Ultra)
+ *
+ * Other names: H15J, H15S, "Palma"
+ *
+ * Copyright The Asahi Linux Contributors
+ */
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
+
+			cluster2 {
+				core0 {
+					cpu = <&cpu_p10>;
+				};
+				core1 {
+					cpu = <&cpu_p11>;
+				};
+				core2 {
+					cpu = <&cpu_p12>;
+				};
+				core3 {
+					cpu = <&cpu_p13>;
+				};
+				core4 {
+					cpu = <&cpu_p14>;
+				};
+				core5 {
+					cpu = <&cpu_p15>;
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
+		cpu_p10: cpu@10200 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10200>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_2>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p11: cpu@10201 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10201>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_2>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p12: cpu@10202 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10202>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_2>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p13: cpu@10203 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10203>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_2>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p14: cpu@10204 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10204>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_2>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p15: cpu@10205 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10205>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_2>;
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
+
+		l2_cache_2: l2-cache-2 {
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
+		interrupts = <AIC_FIQ 0 AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ 0 AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ 0 AIC_TMR_HV_PHYS IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_FIQ 0 AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
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
+};
diff --git a/arch/arm64/boot/dts/apple/t6031-die0.dtsi b/arch/arm64/boot/dts/apple/t6031-die0.dtsi
new file mode 100644
index 000000000000..73f079312a53
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6031-die0.dtsi
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Devices used on die 0 on the Apple T6032 "M3 Ultra" SoC and present on
+ * Apple T6030 ("M3 Pro") and T6031 / T6034 ("M3 Max").
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+	wdt: watchdog@2a02d4000 {
+		compatible = "apple,t6031-wdt", "apple,t8103-wdt";
+		reg = <0x2 0xa02d4000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 718 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	aic: interrupt-controller@292400000 {
+		compatible = "apple,t6031-aic3", "apple,t8122-aic3";
+		#interrupt-cells = <4>;
+		interrupt-controller;
+
+		reg = <0x00000002 0x92400000 0x00000000 0x1cc000>,
+		      <0x00000002 0x92440000 0x00000000 0x4000>;
+		reg-names = "core", "event";
+		power-domains = <&ps_aic>;
+	};
+
+	pinctrl_smc: pinctrl@2a4820000 {
+		compatible = "apple,t6031-pinctrl", "apple,t8103-pinctrl";
+		reg = <0x2 0xa4820000 0x0 0x4000>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pinctrl_smc 0 0 30>;
+		apple,npins = <30>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 904 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 905 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 906 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 907 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 908 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 909 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 0 910 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	i2c0: i2c@391010000 {
+		compatible = "apple,t6031-i2c", "apple,t8103-i2c";
+		reg = <0x3 0x91010000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1326 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c0_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c0>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+	};
+
+	i2c1: i2c@391014000 {
+		compatible = "apple,t6031-i2c", "apple,t8103-i2c";
+		reg = <0x3 0x91014000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1327 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c1_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c1>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@391018000 {
+		compatible = "apple,t6031-i2c", "apple,t8103-i2c";
+		reg = <0x3 0x91018000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1328 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c2_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c2>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c3: i2c@39101c000 {
+		compatible = "apple,t6031-i2c", "apple,t8103-i2c";
+		reg = <0x3 0x9101c000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1329 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c3_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c3>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c4: i2c@391020000 {
+		compatible = "apple,t6031-i2c", "apple,t8103-i2c";
+		reg = <0x3 0x91020000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1330 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c4_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c4>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c5: i2c@391024000 {
+		compatible = "apple,t6031-i2c", "apple,t8103-i2c";
+		reg = <0x3 0x91024000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1331 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c5_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c5>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c6: i2c@39102c800 {
+		compatible = "apple,t6031-i2c", "apple,t8103-i2c";
+		reg = <0x3 0x91028000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1332 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c6_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c6>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c7: i2c@39102c000 {
+		compatible = "apple,t6031-i2c", "apple,t8103-i2c";
+		reg = <0x3 0x9102c000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1333 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c7_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c7>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	i2c8: i2c@391030000 {
+		compatible = "apple,t6031-i2c", "apple,t8103-i2c";
+		reg = <0x3 0x91030000 0x0 0x4000>;
+		clocks = <&clkref>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1334 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-0 = <&i2c8_pins>;
+		pinctrl-names = "default";
+		power-domains = <&ps_i2c8>;
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		status = "disabled";
+	};
+
+	fpwm0: pwm@391040000 {
+		compatible = "apple,t6031-fpwm", "apple,s5l-fpwm";
+		reg = <0x3 0x91040000 0x0 0x4000>;
+		power-domains = <&ps_fpwm0>;
+		clocks = <&clkref>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
+	serial0: serial@391200000 {
+		compatible = "apple,s5l-uart";
+		reg = <0x3 0x91200000 0x0 0x4000>;
+		reg-io-width = <4>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1303 IRQ_TYPE_LEVEL_HIGH>;
+		/*
+		 * TODO: figure out the clocking properly, there may
+		 * be a third selectable clock.
+		 */
+		clocks = <&clkref>, <&clkref>;
+		clock-names = "uart", "clk_uart_baud0";
+		power-domains = <&ps_uart0>;
+		status = "disabled";
+	};
diff --git a/arch/arm64/boot/dts/apple/t6031-dieX.dtsi b/arch/arm64/boot/dts/apple/t6031-dieX.dtsi
new file mode 100644
index 000000000000..2e9d3d2e6dea
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6031-dieX.dtsi
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Nodes present on both dies of T6032 (M3 Ultra) and present on T6031 / T6034
+ * (M3 Max).
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+	DIE_NODE(pmgr): power-management@292280000 {
+		compatible = "apple,t6031-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		reg = <0x2 0x92280000 0 0xc000>;
+	};
+
+	DIE_NODE(pmgr1): power-management@292800000 {
+		compatible = "apple,t6031-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		reg = <0x2 0x92800000 0 0x4000>;
+	};
+
+	DIE_NODE(pinctrl_nub): pinctrl@2a01f0000 {
+		compatible = "apple,t6031-pinctrl", "apple,t8103-pinctrl";
+		reg = <0x2 0xa01f0000 0x0 0x4000>;
+		power-domains = <&DIE_NODE(ps_nub_gpio)>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&DIE_NODE(pinctrl_nub) 0 0 59>;
+		apple,npins = <59>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ DIE_NO 710 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 711 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 712 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 713 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 714 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 715 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 716 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	DIE_NODE(pmgr_mini): power-management@2a0280000 {
+		compatible = "apple,t6031-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		reg = <0x2 0xa0280000 0 0x4000>;
+	};
+
+	DIE_NODE(pinctrl_aop): pinctrl@2a8824000 {
+		compatible = "apple,t6031-pinctrl", "apple,t8103-pinctrl";
+		reg = <0x2 0xa8824000 0x0 0x4000>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&DIE_NODE(pinctrl_aop) 0 0 102>;
+		apple,npins = <102>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ DIE_NO 595 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 596 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 597 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 598 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 599 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 600 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 601 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	DIE_NODE(pinctrl_ap): pinctrl@2b3000000 {
+		compatible = "apple,t6031-pinctrl", "apple,t8103-pinctrl";
+		reg = <0x2 0xb3000000 0x0 0x4000>;
+
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ DIE_NO 458 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 459 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 460 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 461 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 462 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 463 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ DIE_NO 464 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&clkref>;
+		power-domains = <&DIE_NODE(ps_gpio)>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&DIE_NODE(pinctrl_ap) 0 0 200>;
+		apple,npins = <200>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	DIE_NODE(pmgr_gfx): power-management@408e80000 {
+		compatible = "apple,t6031-pmgr", "apple,t8103-pmgr", "syscon", "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		reg = <0x4 0x8e80000 0 0x4000>;
+	};
diff --git a/arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi b/arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi
new file mode 100644
index 000000000000..5e4727e357d2
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6031-gpio-pins.dtsi
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * GPIO pin mappings for Apple T6031/T6032/T6034 SoCs.
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&pinctrl_ap {
+	i2c0_pins: i2c0-pins {
+		pinmux = <APPLE_PINMUX(56, 1)>,
+			<APPLE_PINMUX(57, 1)>;
+	};
+
+	i2c1_pins: i2c1-pins {
+		pinmux = <APPLE_PINMUX(58, 1)>,
+			<APPLE_PINMUX(59, 1)>;
+	};
+
+	i2c2_pins: i2c2-pins {
+		pinmux = <APPLE_PINMUX(60, 1)>,
+			<APPLE_PINMUX(61, 1)>;
+	};
+
+	i2c3_pins: i2c3-pins {
+		pinmux = <APPLE_PINMUX(62, 1)>,
+			<APPLE_PINMUX(63, 1)>;
+	};
+
+	i2c4_pins: i2c4-pins {
+		pinmux = <APPLE_PINMUX(64, 1)>,
+			<APPLE_PINMUX(65, 1)>;
+	};
+
+	i2c5_pins: i2c5-pins {
+		pinmux = <APPLE_PINMUX(66, 1)>,
+			<APPLE_PINMUX(67, 1)>;
+	};
+
+	i2c6_pins: i2c6-pins {
+		pinmux = <APPLE_PINMUX(68, 1)>,
+			<APPLE_PINMUX(69, 1)>;
+	};
+
+	i2c7_pins: i2c7-pins {
+		pinmux = <APPLE_PINMUX(70, 1)>,
+			<APPLE_PINMUX(71, 1)>;
+	};
+
+	i2c8_pins: i2c8-pins {
+		pinmux = <APPLE_PINMUX(72, 1)>,
+			<APPLE_PINMUX(73, 1)>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t6031-j514c.dts b/arch/arm64/boot/dts/apple/t6031-j514c.dts
new file mode 100644
index 000000000000..c1507158325e
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6031-j514c.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (14-inch, M3 Max, 16 CPU cores, Nov 2023)
+ *
+ * target-type: J514c
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6031.dtsi"
+#include "t603x-j514-j516.dtsi"
+
+/ {
+	compatible = "apple,j514c", "apple,t6031", "apple,arm-platform";
+	model = "Apple MacBook Pro (14-inch, M3 Max, 16 CPU cores, Nov 2023)";
+};
diff --git a/arch/arm64/boot/dts/apple/t6031-j516c.dts b/arch/arm64/boot/dts/apple/t6031-j516c.dts
new file mode 100644
index 000000000000..841b2bb10b06
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6031-j516c.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (16-inch, M3 Max, 16 CPU cores, Nov 2023)
+ *
+ * target-type: J516c
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6031.dtsi"
+#include "t603x-j514-j516.dtsi"
+
+/ {
+	compatible = "apple,j516c", "apple,t6031", "apple,arm-platform";
+	model = "Apple MacBook Pro (16-inch, M3 Max, 16 CPU cores, Nov 2023)";
+};
diff --git a/arch/arm64/boot/dts/apple/t6031-pmgr.dtsi b/arch/arm64/boot/dts/apple/t6031-pmgr.dtsi
new file mode 100644
index 000000000000..f80ee5f7ebcf
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6031-pmgr.dtsi
@@ -0,0 +1,2400 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for Apple T6031 "M3 Max/Ultra" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&DIE_NODE(pmgr) {
+	DIE_NODE(ps_ispsens0): power-controller@100 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ispsens0);
+	};
+
+	DIE_NODE(ps_apcie_gp): power-controller@108 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_gp);
+	};
+
+	DIE_NODE(ps_apcie_ge): power-controller@110 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_ge);
+	};
+
+	DIE_NODE(ps_apcie_st): power-controller@118 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_st);
+	};
+
+	DIE_NODE(ps_afnc3_ioa): power-controller@120 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc3_ioa);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_afnc3_ls): power-controller@128 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc3_ls);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc3_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc3_lw0): power-controller@138 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc3_lw0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc3_ls)>;
+	};
+
+	DIE_NODE(ps_afnc3_lw1): power-controller@148 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc3_lw1);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc3_ls)>;
+	};
+
+	DIE_NODE(ps_apcie_sys_gp): power-controller@158 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_sys_gp);
+		power-domains = <&DIE_NODE(ps_apcie_gp)>, <&DIE_NODE(ps_afnc3_lw0)>;
+	};
+
+	DIE_NODE(ps_afnc4_ioa): power-controller@168 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc4_ioa);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_afnc4_ls): power-controller@178 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc4_ls);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc4_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc4_lw0): power-controller@188 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc4_lw0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc4_ls)>;
+	};
+
+	DIE_NODE(ps_afnc5_ioa): power-controller@198 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc5_ioa);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_afnc5_ls): power-controller@1a8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc5_ls);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc5_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc5_lw0): power-controller@1b8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc5_lw0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc5_ls)>;
+	};
+
+	DIE_NODE(ps_afnc6_ioa): power-controller@1c8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc6_ioa);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_afnc6_ls): power-controller@1d8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc6_ls);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc6_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc6_lw0): power-controller@1e8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc6_lw0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc6_ls)>;
+	};
+
+	DIE_NODE(ps_sio): power-controller@1f8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sio);
+		power-domains = <&DIE_NODE(ps_afnc4_lw0)>;
+	};
+
+	DIE_NODE(ps_disp_sys): power-controller@200 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(disp_sys);
+		power-domains = <&DIE_NODE(ps_afnc4_lw0)>;
+	};
+
+	DIE_NODE(ps_isp_sys): power-controller@208 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(isp_sys);
+		power-domains = <&DIE_NODE(ps_afnc4_lw0)>;
+	};
+
+	DIE_NODE(ps_sio_cpu): power-controller@210 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sio_cpu);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_fpwm0): power-controller@218 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(fpwm0);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_fpwm1): power-controller@220 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(fpwm1);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_fpwm2): power-controller@228 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(fpwm2);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c0): power-controller@230 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c0);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c1): power-controller@238 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c1);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c2): power-controller@240 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c2);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c3): power-controller@248 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c3);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c4): power-controller@250 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c4);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c5): power-controller@258 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c5);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c6): power-controller@260 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c6);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c7): power-controller@268 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c7);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_i2c8): power-controller@270 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(i2c8);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_spi_p): power-controller@278 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi_p);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_uart_p): power-controller@280 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart_p);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_audio_p): power-controller@288 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(audio_p);
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_aes): power-controller@290 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(aes);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_sio)>;
+	};
+
+	DIE_NODE(ps_disp_fe): power-controller@298 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(disp_fe);
+		power-domains = <&DIE_NODE(ps_disp_cpu)>;
+		apple,min-state = <4>;
+	};
+
+	DIE_NODE(ps_disp_cpu): power-controller@2a0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(disp_cpu);
+		power-domains = <&DIE_NODE(ps_disp_sys)>;
+	};
+
+	DIE_NODE(ps_spi0): power-controller@2a8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi0);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_spi1): power-controller@2b0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi1);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_spi2): power-controller@2b8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi2);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_spi3): power-controller@2c0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi3);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_spi4): power-controller@2c8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi4);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_spi5): power-controller@2d0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(spi5);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_qspi): power-controller@2d8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(qspi);
+		power-domains = <&DIE_NODE(ps_spi_p)>;
+	};
+
+	DIE_NODE(ps_uart_n): power-controller@2e0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart_n);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart0): power-controller@2e8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart0);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart1): power-controller@2f0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart1);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart2): power-controller@2f8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart2);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart3): power-controller@300 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart3);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart4): power-controller@308 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart4);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart5): power-controller@310 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart5);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_uart6): power-controller@318 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(uart6);
+		power-domains = <&DIE_NODE(ps_uart_p)>;
+	};
+
+	DIE_NODE(ps_sio_adma): power-controller@320 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sio_adma);
+		power-domains = <&DIE_NODE(ps_sio)>, <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_dpa0): power-controller@328 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dpa0);
+		power-domains = <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_dpa1): power-controller@330 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dpa1);
+		power-domains = <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_dpa2): power-controller@338 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x338 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dpa2);
+		power-domains = <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_dpa3): power-controller@340 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x340 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dpa3);
+		power-domains = <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_dpa4): power-controller@348 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x348 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dpa4);
+		power-domains = <&DIE_NODE(ps_audio_p)>;
+	};
+
+	DIE_NODE(ps_amcc1): power-controller@350 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x350 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc1);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_amcc3): power-controller@360 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x360 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc3);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_amcc5): power-controller@370 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x370 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc5);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_amcc7): power-controller@380 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x380 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc7);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_dcs_04): power-controller@390 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x390 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_04);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc1)>;
+	};
+
+	DIE_NODE(ps_dcs_05): power-controller@3a0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_05);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc1)>;
+	};
+
+	DIE_NODE(ps_dcs_06): power-controller@3b0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_06);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc1)>;
+	};
+
+	DIE_NODE(ps_dcs_07): power-controller@3c0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_07);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc1)>;
+	};
+
+	DIE_NODE(ps_dcs_12): power-controller@3d0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_12);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc3)>;
+	};
+
+	DIE_NODE(ps_dcs_13): power-controller@3e0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_13);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc3)>;
+	};
+
+	DIE_NODE(ps_dcs_14): power-controller@3f0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_14);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc3)>;
+	};
+
+	DIE_NODE(ps_dcs_15): power-controller@400 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_15);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc3)>;
+	};
+
+	DIE_NODE(ps_dcs_20): power-controller@410 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x410 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_20);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc5)>;
+	};
+
+	DIE_NODE(ps_dcs_21): power-controller@420 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x420 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_21);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc5)>;
+	};
+
+	DIE_NODE(ps_dcs_22): power-controller@430 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x430 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_22);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc5)>;
+	};
+
+	DIE_NODE(ps_dcs_23): power-controller@440 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x440 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_23);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc5)>;
+	};
+
+	DIE_NODE(ps_dcs_28): power-controller@450 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x450 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_28);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc7)>;
+	};
+
+	DIE_NODE(ps_dcs_29): power-controller@460 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x460 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_29);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc7)>;
+	};
+
+	DIE_NODE(ps_dcs_30): power-controller@470 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x470 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_30);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc7)>;
+	};
+
+	DIE_NODE(ps_dcs_31): power-controller@480 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x480 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_31);
+		apple,always-on; /* LPDDR5 interface */
+		power-domains = <&DIE_NODE(ps_amcc7)>;
+	};
+
+	DIE_NODE(ps_mca0): power-controller@4e8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mca0);
+		power-domains = <&DIE_NODE(ps_audio_p)>, <&DIE_NODE(ps_sio_adma)>;
+	};
+
+	DIE_NODE(ps_mca1): power-controller@4f0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mca1);
+		power-domains = <&DIE_NODE(ps_audio_p)>, <&DIE_NODE(ps_sio_adma)>;
+	};
+
+	DIE_NODE(ps_mca2): power-controller@4f8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mca2);
+		power-domains = <&DIE_NODE(ps_audio_p)>, <&DIE_NODE(ps_sio_adma)>;
+	};
+
+	DIE_NODE(ps_mca3): power-controller@500 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x500 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mca3);
+		power-domains = <&DIE_NODE(ps_audio_p)>, <&DIE_NODE(ps_sio_adma)>;
+	};
+
+	DIE_NODE(ps_msr1): power-controller@508 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x508 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(msr1);
+		power-domains = <&DIE_NODE(ps_afnc5_lw0)>;
+	};
+
+	DIE_NODE(ps_venc1_sys): power-controller@510 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x510 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_sys);
+		power-domains = <&DIE_NODE(ps_afnc5_lw0)>;
+	};
+
+	DIE_NODE(ps_msr0): power-controller@518 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x518 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(msr0);
+		power-domains = <&DIE_NODE(ps_afnc6_lw0)>;
+	};
+
+	DIE_NODE(ps_ane_sys): power-controller@520 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x520 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ane_sys);
+		power-domains = <&DIE_NODE(ps_afnc5_lw0)>, <&DIE_NODE(ps_afnc6_lw0)>;
+	};
+
+	DIE_NODE(ps_msr1_ase_core): power-controller@538 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x538 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(msr1_ase_core);
+		power-domains = <&DIE_NODE(ps_msr1)>;
+	};
+
+	DIE_NODE(ps_apcie_sys_ge): power-controller@540 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x540 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_sys_ge);
+		power-domains = <&DIE_NODE(ps_apcie_ge)>, <&DIE_NODE(ps_afnc3_lw0)>;
+	};
+
+	DIE_NODE(ps_ans): power-controller@550 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x550 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ans);
+		power-domains = <&DIE_NODE(ps_afnc3_lw1)>;
+	};
+
+	DIE_NODE(ps_apcie_sys_st): power-controller@560 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x560 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_sys_st);
+		power-domains = <&DIE_NODE(ps_apcie_st)>, <&DIE_NODE(ps_ans)>;
+	};
+
+	DIE_NODE(ps_apcie_sys_st1): power-controller@570 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x570 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_sys_st1);
+		power-domains = <&DIE_NODE(ps_apcie_st)>, <&DIE_NODE(ps_ans)>;
+	};
+
+	DIE_NODE(ps_apcie_phy_sw): power-controller@580 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x580 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(apcie_phy_sw);
+		apple,always-on; /* macOS does not turn this off */
+	};
+
+	DIE_NODE(ps_msr0_ase_core): power-controller@590 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x590 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(msr0_ase_core);
+		power-domains = <&DIE_NODE(ps_msr0)>;
+	};
+
+	DIE_NODE(ps_ane_mpm): power-controller@5a0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ane_mpm);
+		power-domains = <&DIE_NODE(ps_ane_sys)>;
+	};
+
+	DIE_NODE(ps_ane_cpu): power-controller@5a8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ane_cpu);
+		power-domains = <&DIE_NODE(ps_ane_sys)>;
+	};
+
+	DIE_NODE(ps_ane_td): power-controller@5b8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ane_td);
+		power-domains = <&DIE_NODE(ps_ane_sys)>;
+	};
+
+	DIE_NODE(ps_ane_base): power-controller@5c0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ane_base);
+		power-domains = <&DIE_NODE(ps_ane_td)>;
+	};
+
+	DIE_NODE(ps_sep): power-controller@c00 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc00 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sep);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc4_lw0)>;
+	};
+
+	DIE_NODE(ps_isp_cpu): power-controller@4008 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(isp_cpu);
+		power-domains = <&DIE_NODE(ps_isp_sys)>;
+	};
+
+	DIE_NODE(ps_isp_fe): power-controller@4030 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(isp_fe);
+		power-domains = <&DIE_NODE(ps_isp_sys)>;
+	};
+
+	DIE_NODE(ps_dprx): power-controller@4038 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4038 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dprx);
+		power-domains = <&DIE_NODE(ps_isp_fe)>;
+	};
+
+	DIE_NODE(ps_isp_secure): power-controller@4040 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(isp_secure);
+		power-domains = <&DIE_NODE(ps_isp_fe)>;
+	};
+
+	DIE_NODE(ps_isp_be): power-controller@4048 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4048 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(isp_be);
+		power-domains = <&DIE_NODE(ps_isp_fe)>;
+	};
+
+	DIE_NODE(ps_isp_clr): power-controller@4050 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4050 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(isp_clr);
+		power-domains = <&DIE_NODE(ps_isp_be)>;
+	};
+
+	DIE_NODE(ps_venc1_dma): power-controller@8000 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_dma);
+		power-domains = <&DIE_NODE(ps_venc1_sys)>;
+	};
+
+	DIE_NODE(ps_venc1_pipe4): power-controller@8008 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_pipe4);
+		power-domains = <&DIE_NODE(ps_venc1_dma)>;
+	};
+
+	DIE_NODE(ps_venc1_pipe5): power-controller@8010 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_pipe5);
+		power-domains = <&DIE_NODE(ps_venc1_dma)>;
+	};
+
+	DIE_NODE(ps_venc1_me0): power-controller@8018 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_me0);
+		power-domains = <&DIE_NODE(ps_venc1_dma)>;
+	};
+
+	DIE_NODE(ps_venc1_me1): power-controller@8020 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x8020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc1_me1);
+		power-domains = <&DIE_NODE(ps_venc1_me0)>;
+	};
+};
+
+&DIE_NODE(pmgr1) {
+	DIE_NODE(ps_aic): power-controller@100 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(aic);
+	};
+
+	DIE_NODE(ps_dwi): power-controller@108 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dwi);
+	};
+
+	DIE_NODE(ps_sbr): power-controller@110 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(sbr);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_pms): power-controller@118 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_soc_dpe): power-controller@120 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(soc_dpe);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_pms_c1ppt): power-controller@128 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms_c1ppt);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_soc_dpe)>;
+	};
+
+	DIE_NODE(ps_pmgr_soc_ocla): power-controller@130 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pmgr_soc_ocla);
+	};
+
+	DIE_NODE(ps_pms_fpwm0): power-controller@138 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms_fpwm0);
+	};
+
+	DIE_NODE(ps_pms_fpwm1): power-controller@140 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms_fpwm1);
+	};
+
+	DIE_NODE(ps_pms_fpwm2): power-controller@148 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms_fpwm2);
+	};
+
+	DIE_NODE(ps_pms_fpwm3): power-controller@150 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms_fpwm3);
+	};
+
+	DIE_NODE(ps_pms_fpwm4): power-controller@158 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms_fpwm4);
+	};
+
+	DIE_NODE(ps_gpio): power-controller@160 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(gpio);
+		power-domains = <&DIE_NODE(ps_sbr)>;
+	};
+
+	DIE_NODE(ps_msg): power-controller@168 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(msg);
+	};
+
+	DIE_NODE(ps_afc): power-controller@170 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afc);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_amcc0): power-controller@180 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afc)>;
+	};
+
+	DIE_NODE(ps_amcc2): power-controller@190 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc2);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afc)>;
+	};
+
+	DIE_NODE(ps_amcc4): power-controller@1a0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc4);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afc)>;
+	};
+
+	DIE_NODE(ps_amcc6): power-controller@1b0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(amcc6);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afc)>;
+	};
+
+	DIE_NODE(ps_dcs_00): power-controller@1c0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_00);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc0)>;
+	};
+
+	DIE_NODE(ps_dcs_01): power-controller@1d0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_01);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc0)>;
+	};
+
+	DIE_NODE(ps_dcs_02): power-controller@1e0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_02);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc0)>;
+	};
+
+	DIE_NODE(ps_dcs_03): power-controller@1f0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x1f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_03);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc0)>;
+	};
+
+	DIE_NODE(ps_dcs_08): power-controller@200 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_08);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc2)>;
+	};
+
+	DIE_NODE(ps_dcs_09): power-controller@210 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_09);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc2)>;
+	};
+
+	DIE_NODE(ps_dcs_10): power-controller@220 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_10);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc2)>;
+	};
+
+	DIE_NODE(ps_dcs_11): power-controller@230 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_11);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc2)>;
+	};
+
+	DIE_NODE(ps_dcs_16): power-controller@240 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_16);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc4)>;
+	};
+
+	DIE_NODE(ps_dcs_17): power-controller@250 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_17);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc4)>;
+	};
+
+	DIE_NODE(ps_dcs_18): power-controller@260 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_18);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc4)>;
+	};
+
+	DIE_NODE(ps_dcs_19): power-controller@270 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_19);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc4)>;
+	};
+
+	DIE_NODE(ps_dcs_24): power-controller@280 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_24);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc6)>;
+	};
+
+	DIE_NODE(ps_dcs_25): power-controller@290 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_25);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc6)>;
+	};
+
+	DIE_NODE(ps_dcs_26): power-controller@2a0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_26);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc6)>;
+	};
+
+	DIE_NODE(ps_afi): power-controller@2b0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afi);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_dcs_27): power-controller@2c0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dcs_27);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_amcc6)>;
+	};
+
+	DIE_NODE(ps_afi_d2d_0): power-controller@2d0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afi_d2d_0);
+		apple,always-on;
+		status = "disabled";
+	};
+
+	DIE_NODE(ps_afi_d2d_1): power-controller@2e0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afi_d2d_1);
+		apple,always-on;
+		status = "disabled";
+	};
+
+	DIE_NODE(ps_afc_d2d_0): power-controller@2f0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afc_d2d_0);
+		apple,always-on;
+		status = "disabled";
+	};
+
+	DIE_NODE(ps_afc_d2d_1): power-controller@300 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afc_d2d_1);
+		apple,always-on;
+		status = "disabled";
+	};
+
+	DIE_NODE(ps_afr_d2d_0): power-controller@310 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afr_d2d_0);
+		apple,always-on;
+		status = "disabled";
+	};
+
+	DIE_NODE(ps_afr_d2d_1): power-controller@320 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afr_d2d_1);
+		apple,always-on;
+		status = "disabled";
+	};
+
+	DIE_NODE(ps_afnc1_ioa): power-controller@330 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc1_ioa);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_afnc0_ioa): power-controller@340 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x340 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc0_ioa);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_afnc2_ioa): power-controller@350 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x350 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc2_ioa);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_afnc7_ioa): power-controller@360 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x360 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc7_ioa);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afi)>;
+	};
+
+	DIE_NODE(ps_afnc1_ls): power-controller@370 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x370 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc1_ls);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc1_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc0_ls): power-controller@380 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x380 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc0_ls);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc0_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc2_ls): power-controller@390 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x390 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc2_ls);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc2_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc7_ls): power-controller@3a0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc7_ls);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc7_ioa)>;
+	};
+
+	DIE_NODE(ps_afnc1_lw0): power-controller@3b0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc1_lw0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc1_ls)>;
+	};
+
+	DIE_NODE(ps_afnc1_lw1): power-controller@3c0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc1_lw1);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc1_ls)>;
+	};
+
+	DIE_NODE(ps_afnc0_lw0): power-controller@3d0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc0_lw0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc0_ls)>;
+	};
+
+	DIE_NODE(ps_afnc2_lw0): power-controller@3e0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc2_lw0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc2_ls)>;
+	};
+
+	DIE_NODE(ps_afnc2_lw1): power-controller@3f0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x3f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc2_lw1);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_afnc2_ls)>;
+	};
+
+	DIE_NODE(ps_afnc7_lw0): power-controller@400 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afnc7_lw0);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_avd_sys): power-controller@410 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x410 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(avd_sys);
+		power-domains = <&DIE_NODE(ps_afnc1_lw0)>;
+	};
+
+	DIE_NODE(ps_jpg): power-controller@418 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x418 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(jpg);
+		power-domains = <&DIE_NODE(ps_afnc1_lw0)>;
+	};
+
+	DIE_NODE(ps_dispext3_sys): power-controller@420 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x420 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext3_sys);
+		power-domains = <&DIE_NODE(ps_afnc1_lw1)>;
+	};
+
+	DIE_NODE(ps_scodec): power-controller@428 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x428 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(scodec);
+		power-domains = <&DIE_NODE(ps_afnc1_lw1)>;
+	};
+
+	DIE_NODE(ps_venc0_sys): power-controller@430 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x430 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc0_sys);
+		power-domains = <&DIE_NODE(ps_afnc0_lw0)>;
+	};
+
+	DIE_NODE(ps_prores): power-controller@438 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x438 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(prores);
+		power-domains = <&DIE_NODE(ps_afnc0_lw0)>;
+	};
+
+	DIE_NODE(ps_dispext0_sys): power-controller@440 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x440 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext0_sys);
+		power-domains = <&DIE_NODE(ps_afnc2_lw0)>;
+	};
+
+	DIE_NODE(ps_atc0_common): power-controller@448 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x448 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_common);
+		power-domains = <&DIE_NODE(ps_afnc2_lw0)>;
+	};
+
+	DIE_NODE(ps_atc1_common): power-controller@450 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x450 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_common);
+		power-domains = <&DIE_NODE(ps_afnc2_lw1)>;
+	};
+
+	DIE_NODE(ps_atc2_common): power-controller@458 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x458 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_common);
+		power-domains = <&DIE_NODE(ps_afnc2_lw1)>;
+	};
+
+	DIE_NODE(ps_atc3_common): power-controller@460 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x460 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_common);
+		power-domains = <&DIE_NODE(ps_afnc2_lw1)>;
+	};
+
+	DIE_NODE(ps_trace_fab): power-controller@468 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x468 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(trace_fab);
+		power-domains = <&DIE_NODE(ps_afnc2_lw1)>;
+	};
+
+	DIE_NODE(ps_dispext1_sys): power-controller@470 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x470 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext1_sys);
+		power-domains = <&DIE_NODE(ps_afnc7_lw0)>;
+	};
+
+	DIE_NODE(ps_dispext2_sys): power-controller@478 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x478 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext2_sys);
+		power-domains = <&DIE_NODE(ps_afnc7_lw0)>;
+	};
+
+	DIE_NODE(ps_dispext3_fe): power-controller@480 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x480 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext3_fe);
+		power-domains = <&DIE_NODE(ps_dispext3_cpu)>;
+	};
+
+	DIE_NODE(ps_dispext3_cpu): power-controller@488 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x488 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext3_cpu);
+		power-domains = <&DIE_NODE(ps_dispext3_sys)>;
+	};
+
+	DIE_NODE(ps_scodec_streaming): power-controller@490 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x490 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(scodec_streaming);
+		power-domains = <&DIE_NODE(ps_scodec)>;
+	};
+
+	DIE_NODE(ps_venc0_dma): power-controller@498 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x498 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc0_dma);
+		power-domains = <&DIE_NODE(ps_venc0_sys)>;
+	};
+
+	DIE_NODE(ps_dispext0_fe): power-controller@4a0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext0_fe);
+		power-domains = <&DIE_NODE(ps_dispext0_cpu)>;
+	};
+
+	DIE_NODE(ps_dispext0_cpu): power-controller@4a8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext0_cpu);
+		power-domains = <&DIE_NODE(ps_dispext0_sys)>;
+	};
+
+	DIE_NODE(ps_atc0_cio): power-controller@4b0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_cio);
+		power-domains = <&DIE_NODE(ps_atc0_common)>;
+	};
+
+	DIE_NODE(ps_atc0_pcie): power-controller@4b8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_pcie);
+		power-domains = <&DIE_NODE(ps_atc0_common)>;
+	};
+
+	DIE_NODE(ps_atc1_cio): power-controller@4c0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_cio);
+		power-domains = <&DIE_NODE(ps_atc1_common)>;
+	};
+
+	DIE_NODE(ps_atc1_pcie): power-controller@4c8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_pcie);
+		power-domains = <&DIE_NODE(ps_atc1_common)>;
+	};
+
+	DIE_NODE(ps_atc2_cio): power-controller@4d0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_cio);
+		power-domains = <&DIE_NODE(ps_atc2_common)>;
+	};
+
+	DIE_NODE(ps_atc2_pcie): power-controller@4d8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_pcie);
+		power-domains = <&DIE_NODE(ps_atc2_common)>;
+	};
+
+	DIE_NODE(ps_atc3_cio): power-controller@4e0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_cio);
+		power-domains = <&DIE_NODE(ps_atc3_common)>;
+	};
+
+	DIE_NODE(ps_atc3_pcie): power-controller@4e8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_pcie);
+		power-domains = <&DIE_NODE(ps_atc3_common)>;
+	};
+
+	DIE_NODE(ps_dispext1_fe): power-controller@4f0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext1_fe);
+		power-domains = <&DIE_NODE(ps_dispext1_cpu)>;
+	};
+
+	DIE_NODE(ps_dispext1_cpu): power-controller@4f8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x4f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext1_cpu);
+		power-domains = <&DIE_NODE(ps_dispext1_sys)>;
+	};
+
+	DIE_NODE(ps_dispext2_fe): power-controller@500 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x500 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext2_fe);
+		power-domains = <&DIE_NODE(ps_dispext2_cpu)>;
+	};
+
+	DIE_NODE(ps_dispext2_cpu): power-controller@508 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x508 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(dispext2_cpu);
+		power-domains = <&DIE_NODE(ps_dispext2_sys)>;
+	};
+
+	DIE_NODE(ps_venc0_pipe4): power-controller@538 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x538 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc0_pipe4);
+		power-domains = <&DIE_NODE(ps_venc0_dma)>;
+	};
+
+	DIE_NODE(ps_venc0_pipe5): power-controller@540 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x540 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc0_pipe5);
+		power-domains = <&DIE_NODE(ps_venc0_dma)>;
+	};
+
+	DIE_NODE(ps_venc0_me0): power-controller@548 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x548 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc0_me0);
+		power-domains = <&DIE_NODE(ps_venc0_dma)>;
+	};
+
+	DIE_NODE(ps_pmp): power-controller@550 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x550 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pmp);
+	};
+
+	DIE_NODE(ps_pms_sram): power-controller@560 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x560 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(pms_sram);
+	};
+
+	DIE_NODE(ps_atc0_cio_pcie): power-controller@598 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x598 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_cio_pcie);
+		power-domains = <&DIE_NODE(ps_atc0_cio)>;
+	};
+
+	DIE_NODE(ps_atc0_cio_usb): power-controller@5a0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_cio_usb);
+		power-domains = <&DIE_NODE(ps_atc0_cio)>;
+	};
+
+	DIE_NODE(ps_atc1_cio_pcie): power-controller@5a8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_cio_pcie);
+		power-domains = <&DIE_NODE(ps_atc1_cio)>;
+	};
+
+	DIE_NODE(ps_atc1_cio_usb): power-controller@5b0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_cio_usb);
+		power-domains = <&DIE_NODE(ps_atc1_cio)>;
+	};
+
+	DIE_NODE(ps_atc2_cio_pcie): power-controller@5b8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_cio_pcie);
+		power-domains = <&DIE_NODE(ps_atc2_cio)>;
+	};
+
+	DIE_NODE(ps_atc2_cio_usb): power-controller@5c0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_cio_usb);
+		power-domains = <&DIE_NODE(ps_atc2_cio)>;
+	};
+
+	DIE_NODE(ps_atc3_cio_pcie): power-controller@5c8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_cio_pcie);
+		power-domains = <&DIE_NODE(ps_atc3_cio)>;
+	};
+
+	DIE_NODE(ps_atc3_cio_usb): power-controller@5d0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x5d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_cio_usb);
+		power-domains = <&DIE_NODE(ps_atc3_cio)>;
+	};
+
+	DIE_NODE(ps_venc0_me1): power-controller@638 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x638 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(venc0_me1);
+		power-domains = <&DIE_NODE(ps_venc0_me0)>;
+	};
+
+	DIE_NODE(ps_ap_tmm): power-controller@670 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x670 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(ap_tmm);
+	};
+};
+
+&DIE_NODE(pmgr_mini) {
+	DIE_NODE(ps_debug_gated): power-controller@58 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x58 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(debug_gated);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_nub_spmi_ahb_fab): power-controller@60 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x60 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi_ahb_fab);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_nub_spmi0): power-controller@68 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x68 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_nub_spmi_ahb_fab)>;
+	};
+
+	DIE_NODE(ps_nub_spmi_a0): power-controller@70 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x70 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi_a0);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_nub_spmi_a1): power-controller@78 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x78 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi_a1);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_nub_spmi_a2): power-controller@80 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x80 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi_a2);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_nub_aon): power-controller@90 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x90 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_aon);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_nub_gpio): power-controller@98 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x98 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_gpio);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_nub_ocla): power-controller@a0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_ocla);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_atc0_common_dp): power-controller@a8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xa8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_common_dp);
+	};
+
+	DIE_NODE(ps_atc1_common_dp): power-controller@b0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xb0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_common_dp);
+	};
+
+	DIE_NODE(ps_atc2_common_dp): power-controller@b8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xb8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_common_dp);
+	};
+
+	DIE_NODE(ps_atc3_common_dp): power-controller@c0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_common_dp);
+	};
+
+	DIE_NODE(ps_nub_spmi1): power-controller@c8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xc8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi1);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_nub_spmi_ahb_fab)>;
+	};
+
+	DIE_NODE(ps_atc0_usb_aon): power-controller@d0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xd0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_usb_aon);
+	};
+
+	DIE_NODE(ps_atc1_usb_aon): power-controller@d8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xd8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_usb_aon);
+	};
+
+	DIE_NODE(ps_atc2_usb_aon): power-controller@e0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xe0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_usb_aon);
+	};
+
+	DIE_NODE(ps_atc3_usb_aon): power-controller@e8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xe8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_usb_aon);
+	};
+
+	DIE_NODE(ps_nub_spmi2): power-controller@f0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xf0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi2);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_nub_spmi_ahb_fab)>;
+	};
+
+	DIE_NODE(ps_nub_spmi3): power-controller@f8 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0xf8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi3);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_nub_spmi_ahb_fab)>;
+	};
+
+	DIE_NODE(ps_nub_spmi4): power-controller@100 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi4);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_nub_spmi_ahb_fab)>;
+	};
+
+	DIE_NODE(ps_nub_spmi5): power-controller@108 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_spmi5);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_nub_spmi_ahb_fab)>;
+	};
+
+	DIE_NODE(ps_nub_fabric): power-controller@110 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_fabric);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_nub_sram): power-controller@120 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(nub_sram);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_debug_switch): power-controller@130 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(debug_switch);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_atc0_usb): power-controller@140 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc0_usb);
+		power-domains = <&DIE_NODE(ps_atc0_usb_aon)>, <&DIE_NODE(ps_atc0_common)>;
+	};
+
+	DIE_NODE(ps_atc1_usb): power-controller@148 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc1_usb);
+		power-domains = <&DIE_NODE(ps_atc1_usb_aon)>, <&DIE_NODE(ps_atc1_common)>;
+	};
+
+	DIE_NODE(ps_atc2_usb): power-controller@150 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc2_usb);
+		power-domains = <&DIE_NODE(ps_atc2_usb_aon)>, <&DIE_NODE(ps_atc2_common)>;
+	};
+
+	DIE_NODE(ps_atc3_usb): power-controller@158 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(atc3_usb);
+		power-domains = <&DIE_NODE(ps_atc3_usb_aon)>, <&DIE_NODE(ps_atc3_common)>;
+	};
+
+#if 0
+	/* MTP stuff is self-managed */
+	DIE_NODE(ps_mtp_fabric): power-controller@2000 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_fabric);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_nub_fabric)>;
+	};
+
+	DIE_NODE(ps_mtp_gpio): power-controller@2008 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_gpio);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_mtp_fabric)>;
+	};
+
+	DIE_NODE(ps_mtp_base): power-controller@2010 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_base);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_mtp_fabric)>;
+	};
+
+	DIE_NODE(ps_mtp_periph): power-controller@2018 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_periph);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_mtp_fabric)>;
+	};
+
+	DIE_NODE(ps_mtp_uart0): power-controller@2020 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_uart0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_mtp_fabric)>;
+	};
+
+	DIE_NODE(ps_mtp_cpu): power-controller@2028 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_cpu);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_mtp_fabric)>;
+	};
+
+	DIE_NODE(ps_mtp_scm_fabric): power-controller@2030 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_scm_fabric);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_mtp_periph)>;
+	};
+
+	DIE_NODE(ps_mtp_spi0): power-controller@2038 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2038 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_spi0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_mtp_fabric)>, <&DIE_NODE(ps_mtp_periph)>;
+	};
+
+	DIE_NODE(ps_mtp_i2cm0): power-controller@2040 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_i2cm0);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_mtp_fabric)>, <&DIE_NODE(ps_mtp_periph)>;
+	};
+
+	DIE_NODE(ps_mtp_sram): power-controller@2048 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2048 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_sram);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_mtp_cpu)>, <&DIE_NODE(ps_mtp_scm_fabric)>;
+	};
+
+	DIE_NODE(ps_mtp_dma): power-controller@2050 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x2050 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(mtp_dma);
+		apple,always-on;
+		power-domains = <&DIE_NODE(ps_mtp_fabric)>, <&DIE_NODE(ps_mtp_sram)>;
+	};
+#endif
+};
+
+&DIE_NODE(pmgr_gfx) {
+	DIE_NODE(ps_gpx): power-controller@0 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(gpx);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_afr): power-controller@100 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(afr);
+		apple,always-on;
+	};
+
+	DIE_NODE(ps_gfx): power-controller@110 {
+		compatible = "apple,t6031-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate";
+		reg = <0x110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = DIE_LABEL(gfx);
+		power-domains = <&DIE_NODE(ps_afr)>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t6031.dtsi b/arch/arm64/boot/dts/apple/t6031.dtsi
new file mode 100644
index 000000000000..0059afe9a844
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6031.dtsi
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T6031 "M3 Max" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+
+#include "multi-die-cpp.h"
+
+#include "t6031-base.dtsi"
+
+/ {
+	compatible = "apple,t6031", "apple,arm-platform";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
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
+		// filled via templated includes at the end of the file
+	};
+};
+
+#define DIE
+#define DIE_NO 0
+
+&soc {
+	#include "t6031-die0.dtsi"
+	#include "t6031-dieX.dtsi"
+};
+
+#include "t6031-gpio-pins.dtsi"
+#include "t6031-pmgr.dtsi"
+
+#undef DIE
+#undef DIE_NO
diff --git a/arch/arm64/boot/dts/apple/t6032-j575d.dts b/arch/arm64/boot/dts/apple/t6032-j575d.dts
new file mode 100644
index 000000000000..56edfb1139fb
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6032-j575d.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple Mac Studio (M3 Ultra, 2025)
+ *
+ * target-type: J575d
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6032.dtsi"
+
+/ {
+	compatible = "apple,j575d", "apple,t6032", "apple,arm-platform";
+	model = "Apple Mac Studio (M3 Ultra, 2025)";
+
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			/* Format properties will be added by loader */
+			status = "disabled";
+			power-domains = <&ps_dispext0_cpu>;
+		};
+	};
+
+	memory@10000000000 {
+		device_type = "memory";
+		reg = <0x100 0 0x2 0>; /* To be filled by loader */
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t6032.dtsi b/arch/arm64/boot/dts/apple/t6032.dtsi
new file mode 100644
index 000000000000..529e825c8da0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6032.dtsi
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T6032 "M3 Ultra" SoC
+ *
+ * Other names: H15J, "Palma 2C"
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/apple-aic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/spmi/spmi.h>
+
+#include "multi-die-cpp.h"
+
+#include "t6031-base.dtsi"
+
+/ {
+	compatible = "apple,t6032", "apple,arm-platform";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster3 {
+				core0 {
+					cpu = <&cpu_e10>;
+				};
+				core1 {
+					cpu = <&cpu_e11>;
+				};
+				core2 {
+					cpu = <&cpu_e12>;
+				};
+				core3 {
+					cpu = <&cpu_e13>;
+				};
+			};
+
+			cluster4 {
+				core0 {
+					cpu = <&cpu_p20>;
+				};
+				core1 {
+					cpu = <&cpu_p21>;
+				};
+				core2 {
+					cpu = <&cpu_p22>;
+				};
+				core3 {
+					cpu = <&cpu_p23>;
+				};
+				core4 {
+					cpu = <&cpu_p24>;
+				};
+				core5 {
+					cpu = <&cpu_p25>;
+				};
+			};
+
+			cluster5 {
+				core0 {
+					cpu = <&cpu_p30>;
+				};
+				core1 {
+					cpu = <&cpu_p31>;
+				};
+				core2 {
+					cpu = <&cpu_p32>;
+				};
+				core3 {
+					cpu = <&cpu_p33>;
+				};
+				core4 {
+					cpu = <&cpu_p34>;
+				};
+				core5 {
+					cpu = <&cpu_p35>;
+				};
+			};
+		};
+
+		cpu_e10: cpu@800 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x800>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* to be filled by loader */
+			next-level-cache = <&l2_cache_3>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e11: cpu@801 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x801>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* to be filled by loader */
+			next-level-cache = <&l2_cache_3>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e12: cpu@802 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x802>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* to be filled by loader */
+			next-level-cache = <&l2_cache_3>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_e13: cpu@803 {
+			compatible = "apple,sawtooth";
+			device_type = "cpu";
+			reg = <0x0 0x803>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* to be filled by loader */
+			next-level-cache = <&l2_cache_3>;
+			i-cache-size = <0x20000>;
+			d-cache-size = <0x10000>;
+		};
+
+		cpu_p20: cpu@10900 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10900>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_4>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p21: cpu@10901 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10901>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_4>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p22: cpu@10902 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10902>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_4>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p23: cpu@10903 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10903>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_4>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p24: cpu@10904 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10904>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_4>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p25: cpu@10905 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10105>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_4>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p30: cpu@10a00 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10a00>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_5>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p31: cpu@10a01 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10a01>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_5>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p32: cpu@10a02 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10a02>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_5>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p33: cpu@10a03 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10a03>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_5>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p34: cpu@10a04 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10a04>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_5>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		cpu_p35: cpu@10a05 {
+			compatible = "apple,everest";
+			device_type = "cpu";
+			reg = <0x0 0x10a05>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0>; /* To be filled by loader */
+			next-level-cache = <&l2_cache_5>;
+			i-cache-size = <0x30000>;
+			d-cache-size = <0x20000>;
+		};
+
+		l2_cache_3: l2-cache-3 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x400000>;
+		};
+
+		l2_cache_4: l2-cache-4 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x1000000>;
+		};
+
+		l2_cache_5: l2-cache-5 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x1000000>;
+		};
+	 };
+
+	die0: soc@200000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x02 0x00000000 0x02 0x00000000 0x4 0x00000000>,
+			 <0x05 0x80000000 0x05 0x80000000 0x1 0x80000000>,
+			 <0x07 0x00000000 0x07 0x00000000 0xf 0x80000000>,
+			 <0x16 0x80000000 0x16 0x80000000 0x5 0x80000000>;
+		nonposted-mmio;
+		/* Required to get >32-bit DMA via DARTs */
+		dma-ranges = <0 0 0 0 0xffffffff 0xffffc000>;
+
+		// filled via templated includes at the end of the file
+
+		aic: interrupt-controller@292400000 {
+			compatible = "apple,t8122-aic3";
+			#interrupt-cells = <4>;
+			interrupt-controller;
+
+			/*
+			 * reg[0]: Main MMIO range (approx 1.8 MB)
+			 * reg[1]: CPU Event/IACK register page (Base + 0x40000)
+			 */
+			reg = <0x00000002 0x92400000 0x00000000 0x1cc000>,
+				<0x00000002 0x92440000 0x00000000 0x4000>;
+		};
+	};
+
+	die1: soc@2200000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x02 0x00000000 0x22 0x00000000 0x4 0x00000000>,
+			 <0x07 0x00000000 0x27 0x00000000 0xf 0x80000000>,
+			 <0x16 0x80000000 0x36 0x80000000 0x5 0x80000000>;
+		nonposted-mmio;
+		/* Required to get >32-bit DMA via DARTs */
+		dma-ranges = <0 0 0 0 0xffffffff 0xffffc000>;
+
+		// filled via templated includes at the end of the file
+	};
+};
+
+
+#define DIE
+#define DIE_NO 0
+
+&die0 {
+	#include "t6031-die0.dtsi"
+	#include "t6031-dieX.dtsi"
+};
+
+#include "t6031-pmgr.dtsi"
+#include "t6031-gpio-pins.dtsi"
+
+#undef DIE
+#undef DIE_NO
+
+#define DIE _die1
+#define DIE_NO 1
+
+&die1 {
+	#include "t6031-dieX.dtsi"
+};
+
+#include "t6031-pmgr.dtsi"
+
+/delete-node/ &ps_pmp_die1;
+
+#undef DIE
+#undef DIE_NO
+
+/* delete non-present DISP power-states */
+/delete-node/ &ps_disp_cpu;
+/delete-node/ &ps_disp_cpu_die1;
+/delete-node/ &ps_disp_fe;
+/delete-node/ &ps_disp_fe_die1;
+/delete-node/ &ps_disp_sys;
+/delete-node/ &ps_disp_sys_die1;
+
+/* delete non-present ISP power-states */
+/delete-node/ &ps_dprx;
+/delete-node/ &ps_dprx_die1;
+/delete-node/ &ps_isp_be;
+/delete-node/ &ps_isp_be_die1;
+/delete-node/ &ps_isp_clr;
+/delete-node/ &ps_isp_clr_die1;
+/delete-node/ &ps_isp_cpu;
+/delete-node/ &ps_isp_cpu_die1;
+/delete-node/ &ps_isp_fe;
+/delete-node/ &ps_isp_fe_die1;
+/delete-node/ &ps_isp_secure;
+/delete-node/ &ps_isp_secure_die1;
+/delete-node/ &ps_isp_sys;
+/delete-node/ &ps_isp_sys_die1;
+
+&ps_afi_d2d_0 {
+	status = "okay";
+};
+&ps_afi_d2d_0_die1 {
+	status = "okay";
+};
+&ps_afi_d2d_1 {
+	status = "okay";
+};
+&ps_afi_d2d_1_die1 {
+	status = "okay";
+};
+&ps_afc_d2d_0 {
+	status = "okay";
+};
+&ps_afc_d2d_0_die1{
+	status = "okay";
+};
+&ps_afc_d2d_1 {
+	status = "okay";
+};
+&ps_afc_d2d_1_die1 {
+	status = "okay";
+};
+&ps_afr_d2d_0 {
+	status = "okay";
+};
+&ps_afr_d2d_0_die1 {
+	status = "okay";
+};
+&ps_afr_d2d_1 {
+	status = "okay";
+};
+&ps_afr_d2d_1_die1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t6034-j514m.dts b/arch/arm64/boot/dts/apple/t6034-j514m.dts
new file mode 100644
index 000000000000..e31bd0bc0592
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6034-j514m.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (14-inch, M3 Max, 14 CPU cores, Nov 2023)
+ *
+ * target-type: J514m
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6034.dtsi"
+#include "t603x-j514-j516.dtsi"
+
+/ {
+	compatible = "apple,j514m", "apple,t6034", "apple,arm-platform";
+	model = "Apple MacBook Pro (14-inch, M3 Max, 14 CPU cores, Nov 2023)";
+};
diff --git a/arch/arm64/boot/dts/apple/t6034-j516m.dts b/arch/arm64/boot/dts/apple/t6034-j516m.dts
new file mode 100644
index 000000000000..4d6513558597
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6034-j516m.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (16-inch, M3 Max, 14 CPU cores, Nov 2023)
+ *
+ * target-type: J516m
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6034.dtsi"
+#include "t603x-j514-j516.dtsi"
+
+/ {
+	compatible = "apple,j516m", "apple,t6034", "apple,arm-platform";
+	model = "Apple MacBook Pro (16-inch, M3 Max, 14 CPU cores, Nov 2023)";
+};
diff --git a/arch/arm64/boot/dts/apple/t6034.dtsi b/arch/arm64/boot/dts/apple/t6034.dtsi
new file mode 100644
index 000000000000..aa73af9c512d
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6034.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple T6034 "M3 Max" SoC
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include "t6031.dtsi"
+
+/ {
+	compatible = "apple,t6034", "apple,arm-platform";
+};
diff --git a/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi b/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi
new file mode 100644
index 000000000000..467d95cdaf6b
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (14/16-inch, 2023)
+ *
+ * This file contains the parts common to J514 and J516 devices with t6030,
+ * t6031 and t6034.
+ *
+ * target-type: J514s / J514m / J514c / J516s / J516m / J516c
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/*
+ * These models are essentially identical to the previous generations, other
+ * than the GPIO indices and using SPMI based USB Type-C port controllers.
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	chassis-type = "laptop";
+
+	aliases {
+		serial0 = &serial0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			/* Format properties will be added by loader */
+			status = "disabled";
+			power-domains = <&ps_disp_fe>;
+		};
+	};
+
+	memory@10000000000 {
+		device_type = "memory";
+		reg = <0x100 0 0x2 0>; /* To be filled by loader */
+	};
+
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm0 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&fpwm0 {
+	status = "okay";
+};

-- 
2.54.0


