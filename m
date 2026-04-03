Return-Path: <linux-pwm+bounces-8472-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFxrJc/Oz2m50gYAu9opvQ
	(envelope-from <linux-pwm+bounces-8472-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 16:29:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE273953DC
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AED7230138F2
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2026 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D6F3C5DDA;
	Fri,  3 Apr 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fz4Q0Yyn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA953C5DB4
	for <linux-pwm@vger.kernel.org>; Fri,  3 Apr 2026 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226544; cv=none; b=GoFm0nKc/ubLE59XpuF8VQPMS8zWO57sRmU2nwIhR9lTTAD7tNrGKVAGpYMzr1q2PwEfzMOAHtEelEOmKgtvs7EB5UETppNzZeDd1y8u73mAR0BdgqAwEdA8uUnXWEhmzHBMoDoJ5es49pC2f03NDsCYOAV8tV9P9a8KZRgxiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226544; c=relaxed/simple;
	bh=Nzx14HACRM0d0HjpzRQyGv4cu3F3Ed1W2tIIdEaeORY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqdEev8zNSbLmaFHN20vBMf+21CpXtQIO+32kwH1lHSWtj6eleS553BskncAdDZRUjq22LjScZynUPo7RNZ71kWIq7+VuaPgKhomFOsy6juBh1+DWcAfwcy3SRVlvT3lBEVKpqbVchliObGUg3c1Pk9fAAoBlFwSn48DL3Mne+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fz4Q0Yyn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so19755945e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 03 Apr 2026 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775226541; x=1775831341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tgGNuvlVR75U6twtOQ2sB+iKcvPJAVB1mzayebN+L4=;
        b=Fz4Q0Yyn6FO/m+VS7ye5rW6FILOj/ZSIZdyr7n+Kas6qiws+s56pKJuVpvqVZ1Z+dB
         VWd9Tofts8VZqg/m//1codfxwLZYE9H4cK+zeI5f9j7hMgeeEKUIET7kgeAdLXW3Q7+k
         8zRSUXb9v1ik+gpONMWAvownDdRcCBimoGE+IVLVLtMXLSOraBCDlcw52jD0GaIYIZ5m
         BkQVXstJ3C+y/7yj3BgcV15q0+vqtfqwOfTs2Om1w8oM4xGaRvtbzVl3K6AQr/pUia3V
         P1Ynz4Ph4IV5MdnpAZnRlM7VcpbMIAOppvDJtYpOYoO54j0GrXsduqHuD57XsDTy20dt
         XsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775226541; x=1775831341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2tgGNuvlVR75U6twtOQ2sB+iKcvPJAVB1mzayebN+L4=;
        b=Ap4Kx53LY/n6MsLGVtAX5Y2uHjBgpbse5E1+L7MTOXxuotXpZcovlhxcFuf1g3+Ubl
         fpgwH0ihkiAMUvSVa6BOldXWMki6jZCWRTyi1JOo6/gzNtKSoCz9AAenxfPCtyHG9Z1S
         kZ+j3stWpMLR0U3xt4E3CMLE0Y1O21rb/hem6Y0nAXRjkau8vqVG8oWfuwr5+krb5ppw
         j5BlKhm2YyK3uBz05AODy1e4fK0UZJwQCl8FG3wVdty99eEjAwnyRczM10ejqdvPqiHK
         Hd+f4O1dlrKytQGNPMZ3j4LwUPtTRsaHyeLiBm+5S9AZ7Y8FmaxqxQ6INN52/DjL/2ZO
         kHNg==
X-Forwarded-Encrypted: i=1; AJvYcCUHQ+8/qs0udwzfDqOKIKzKzLORqrq7ogSqMxarhkygFifxGte5sks2MSnWNfn346qR0JxZr9jStXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63c4EzLrPd6STBCkkiVVigGPmdbhEPXevyUK9d2ZETGw7DGEQ
	atPI6+8kED2icKFQH2iWo79WRAymnYa390OUWXAKGMGJUz0VL6iCAph4oNOoZavWes8=
X-Gm-Gg: ATEYQzw1tduObe9ZvqBdAvOV51PlSY3qbsTe6jXgWGzFoNshEM6w0b18+VZC7CxyDlr
	lSSF2H9jRVjII1ty0mTQl7CXiowPEM57xvuIKqCYIDXn2iLotyjdqOxqUL5PCoRfwZSV0awJeHT
	YcBugMu9V6Sd57ADQsE554FQmx3WhFQzsSCkAz/0xyuyT5Zr8zgExIOGOIpEarGNcGA0840Dg5i
	T0mElBAg3TD7JO9aD3plVW64/NhD0+Ge8qZOWQ+NGT0L+022H/CG1Ci0xX4nDYSJj7+ZRqw2UQe
	0Ga+iiJCskscywuRAEciLOoUlpnNH77ohMBPnaWplUINa7P5hZQxtPZKJBWH6vzA6dh7Z/ol3dL
	9WocgJUV0aWwY5O3/AFAmGD3cj3HVaAaTlon8C/ZLHMnMMKBMVoEhR5MeJ1g2tDeQxjCwfnyma3
	2dxYWzx0w8+AKH0ZCeGcjq/kJdtn7dpqVpV+r3ZgSPxr8rAq25Htzyd7WPbpxpw6DKnLpG5Ee9C
	jF+oxM=
X-Received: by 2002:a05:600c:1394:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-488994a7a76mr49414895e9.13.1775226540607;
        Fri, 03 Apr 2026 07:29:00 -0700 (PDT)
Received: from localhost (host-79-33-140-232.retail.telecomitalia.it. [79.33.140.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a72baa8sm142747135e9.15.2026.04.03.07.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:29:00 -0700 (PDT)
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
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 3/3] arm64: dts: broadcom: rp1: Add PWM node
Date: Fri,  3 Apr 2026 16:31:56 +0200
Message-ID: <ef79e974c6680202294a4cfde7cc791753bf1b3e.1775223441.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775223441.git.andrea.porta@suse.com>
References: <cover.1775223441.git.andrea.porta@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8472-lists,linux-pwm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[2.99.224.160:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email,0.0.0.1:email,2.101.103.64:email]
X-Rspamd-Queue-Id: 8FE273953DC
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
index 5a815c3797945..7e78501e62b0c 100644
--- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
+++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
@@ -56,6 +56,16 @@ rp1_eth: ethernet@40100000 {
 		#size-cells = <0>;
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
 	rp1_usb0: usb@40200000 {
 		compatible = "snps,dwc3";
 		reg = <0x00 0x40200000  0x0 0x100000>;
-- 
2.35.3


