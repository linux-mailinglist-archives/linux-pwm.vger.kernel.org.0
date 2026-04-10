Return-Path: <linux-pwm+bounces-8549-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHpSJEEE2WnolAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8549-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 16:08:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773A3D877D
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 16:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A7EE30488FB
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95F3CE480;
	Fri, 10 Apr 2026 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="guIaUm/I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893503CB2FE
	for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830030; cv=none; b=Z6INsyA4jNLfFmfvqku143qrtcDtqsB5X3uD3CDxjQnUVke8nbow51Do4hEt66LnS2EtGxb3TdrzyVDb+wEk5BgSNmvIOVHivJcKRt9NdDUgxFxhK5AZ60yqe7DHc8Cp+vB4A2IR7Z+amoom0RAaDYmvljr+lMhxZ1w9LjM2mjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830030; c=relaxed/simple;
	bh=fLM8M+exZKgQsFh5tdcGS1DmZreTyFRyr9bIXtCcplM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuSgIIS1tfvFc5TO8PnA4LG5k0G8oxiXD9zphZzumqawvU5oH+webKylTQFS7AoL+tVl5DmE9/qrTsQQ3RwHgjBbWj35M8FtnE+mcOe5z8oZjtwtZP36YmEFhW/jhqsTTezvbN+Z82qLwtsU0fFFi/QIYFdmk3OcefHW1ccGgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=guIaUm/I; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso32947665e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775830027; x=1776434827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUTaySjIgh6lfu9rWtVOEFr4avLmeO2LROURou8Y2uw=;
        b=guIaUm/Ig4S1Znyrp4UMP1qm/cqwoz4yl+Cs6Cf4bz/F4dQw2j88pEL219KHWtyKQc
         2dp9fSPasQGM4zSKpeLlj4j0UqfyztGDVBhsYhh6rooIK7u2g5uDrN+Wpyr+/7FiHnHU
         AVthi2J7QEarl+YEyLmZzMXuM4OIh0B1giq9k6oRt/jN3ejDPcK84B1bAjuVABaAcnGj
         gEUo1SUnwBDSCaBLy3MqEekG/jrPQ+fWt9cZyBuy8nt/bqiNYSmdgcRQWBc6rGP9IrdF
         Dx+SB7Co7JsSB8+TsdXtO37P0NFv9diJbQQ0kzGpWLDMnY0XOLYUVMh6jlURGFK7K1Zf
         3xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830027; x=1776434827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aUTaySjIgh6lfu9rWtVOEFr4avLmeO2LROURou8Y2uw=;
        b=Exhkfzgbl5+PI6yOoVZKZUj/zdXiTZ7bX8cLLjHRlcBlaP4emjiAyqCUF7DtnDM9Mq
         6vpPdiSeNhcW+WyOXW1apcwi7LJUjW2u3XoKUWuAkSI+s6c15jIR2MxlBLAWQ5upjg0t
         b9rm5ldgqntw5TJD+TnEx4HmxDO9UnJSTc+JV8CaqRePOIuf2NxWgN86YyL2knjT1xT1
         Ws+5czgSN7Zpqnoh2dsup7sgp1epuWqEkV3WovuoS1nT4LDiRRGoatQmcp/1kvG3Kx1w
         dVewY9PNcNWVwaOPcl6n4Raybr8JvDLoRTNaqBn5ELd8WQNXpcnuk99LCDYExTYNydFS
         xygg==
X-Forwarded-Encrypted: i=1; AJvYcCW+/GFqJYS4dX9acizVZ1EIioJMadw9UYTeVIoKCiG9ezGERgKKCwVzlvUJXNQb0mHfjwJRpv8+TNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6QhYqvUQtIp0k4MAzqtVv9QXsgeg9uOb78aT2W/0SjjfljIo
	2zB1TW1dlen/NJfOVc6YlqyTJm0/DBTNljcal8eeUVUEDMU5UMjsQOBhEW+oRDG192o=
X-Gm-Gg: AeBDieu04mv03cbjtk/EE+GjFYXwSFIA5WXG4qLDPvGQ70pQ6NdXgHg3qwBjH4gd7vn
	uw0WrKOHEa8CiqAZLcGNoXX1gJ8Bj6+VdAhYtgOzFT8ER7Z/SChiSA50trdJsqtbpUMuJ0afkgl
	xAxb4say3IREKdlw7LyFBRQ6FmbnAfzXJi1KqMUEW27FJ75tZO1FmO2z4ct0P93pZvvSo/rvXwZ
	JHTk11IXYt3gr2F4el6cwGf4b7nFZ+XGWYxk0MHyOd4xzAWJYFaLvUTTnLeEjJU27+/0ohwb6WB
	6/2UXCtIEn/K/+48GtfdJYHe01KdOihccqNrX0eqiNmgD+x+As6445b9XujkEbkZ9IlT/LdnR35
	x9rLI2G/ROPrAAg67MIP0vYJGNRTUXujehespa83KQ6Cuy6BpPeNAkiWwreESQjPlIxHWNe2f70
	Y7NsLsHENmALPmS5K8Cib+IPsy7I84ynt992hrjchM2pvLlcoJ8LTbJcE9qZ+p
X-Received: by 2002:a05:600c:608e:b0:488:8185:e672 with SMTP id 5b1f17b1804b1-488d688d2fbmr43720335e9.30.1775830026934;
        Fri, 10 Apr 2026 07:07:06 -0700 (PDT)
Received: from localhost (93-41-3-120.ip79.fastwebnet.it. [93.41.3.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63deb904sm8504646f8f.9.2026.04.10.07.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:07:06 -0700 (PDT)
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
Subject: [PATCH v2 3/3] arm64: dts: broadcom: rpi-5: Add RP1 PWM node
Date: Fri, 10 Apr 2026 16:09:59 +0200
Message-ID: <ba57b3b38757d37cf09ea1b8b9e6b6a106d0b292.1775829499.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775829499.git.andrea.porta@suse.com>
References: <cover.1775829499.git.andrea.porta@suse.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-8549-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0773A3D877D
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


