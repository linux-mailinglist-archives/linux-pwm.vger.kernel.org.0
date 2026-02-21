Return-Path: <linux-pwm+bounces-8144-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKKAKW/7mWngXgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8144-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 19:37:35 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 222A616D8B0
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 19:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39EA530364E6
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F86309EE7;
	Sat, 21 Feb 2026 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idNFKjKQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A23304BDF
	for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771699018; cv=none; b=tC8zoTpuh6THm5Ado3dEH6EeSxxZL8bERGlin863uvx7QJ31difby3adecXqZH4I6rU6lSJM5YCsHcHndmx4UpIO+p1MTmXh0gWSZJvZZKfyG24WCZL5KhN/8lRG9uGww1fMoVJ2JkJ0tGy33OgFvKyYeTyp30V3PA4ezmUXvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771699018; c=relaxed/simple;
	bh=vIgGOct6ry2KV3592MeOE+vIaVFPywrg89zWQ5z/wbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pNgJcyUfADhFrxLqWprwBDAVSGJr6EVHlkAVDSgeAI5zhJeSY6UXCe2Wm2qd0L03pJqLqH/Y58dqbsHrSseY2pyEQZu4oRmbBLwkXmUzieBLZVI79hUFFigWWypmBBPXIGMUbsrNzCB5dIoUCTt9cR+PuNuR0mG6QS4R0ZVGw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idNFKjKQ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3870dec27f4so36794711fa.1
        for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 10:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771699016; x=1772303816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi+zTY3v+XYAN7MEQwL4QN54NaCqF12xnryOs65hhBU=;
        b=idNFKjKQGjedzFXSgidguxLhgRcejYJuLTA6qer5jv+iVfdYuMyBXWQBONDUL2bI+X
         Vj81Co5d3dnLCKUgTJrwfEgpSAOn/5WCgqWGxFM8Ah6RhLs0P46YwLmgheuiiTWRsxOc
         HmJx6fmaFLPuGLqHxj259pjEGISepg22L2toDnuAmFPWdsVQyri9L+7/Gh/ZTcUQjQMj
         9162ClVMSU5zrQiZLtQxADyg5ShRTqcnU7SMTmJXJan/vi0YppAwRw2dSPN8c96iTBKG
         4gDvGTN88G/buxPq8EyxF25ZURcamI2uMyygt3UOA+rKxan9AKzMdgsyUwo6CXOU4RD2
         r8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771699016; x=1772303816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vi+zTY3v+XYAN7MEQwL4QN54NaCqF12xnryOs65hhBU=;
        b=xAMAA19niYuOIVkbY9s4KOY1BfFZKdpjY0IZ9xFQlYJI/+ejvgcgFNy95OeLWJ1DOJ
         9GgxxNRq8lG5vVmRThV+7nFRvcC6IgpsG1N+plDws11E7uaGuEZcKdozzByPB8owURuF
         lDfRG7lrHcgTeKxfyiLAWAE7hkPjn4BF82q8pkrtk/EaakUWmtRq2aylB717MBCSZDDn
         L58GpGL86QDBYS+Vk7F8MJ/hPC6V9b3OtSPKHetMT9yclkk29dvML97t2Nfq+UbwnPYO
         BEab0hefFdEn8eqiSAz3QlqVWm63CaGmyIer424Yh9sC3xB9ryj6R9DQu5i+OXCpxK7N
         hsEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAv8VKqabNOAbNLjfu/qjoezDYXk5qGDM32IL7vKMOL0FuhdxXqmEE1zUchJ196pwaEGrWv8f9K6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZIYNl90rsOAMuLwLm7cXs+HdnxXkMAPhYBjqQGyG4LF3NFT3
	qFhYZ2Sj+o4BQyKdbrSqDF4Y5grxQfATXtJSL0I7AZVQdl0VEMr3uIY=
X-Gm-Gg: AZuq6aJFmLGZV5SbIdyLVmlU9DBuWctQMyu9vokGkdAiwrrvZukh0LG4SZlqdQk6p9r
	zmUKaeVFDvJibEtPVjEp/rV0Lc/Rmb4S2P4D4DQgROLrh4Ef3O0vjOJH7oIKt0iom2ajJnIHDPg
	AIVvjP2Ma6SvjKtIOXA0s1rKfUYKPJMTN2BZewgSCkUD5FWYyiXCN69KxRNpnKNX5YwuLr0OGDK
	GYBhoNjR/UO1925NK0xAvZ777lJLBW6rrrxGSplgjYTi4bvW+iqMA9Z+2cH8Bu72YgIgsQ7WK3z
	Ih2jbc2sGxCJ9bLgse5cXpsOXlzuCuB1tZDFBgFwF+lAQ+Iu4BqP6ZaEWAgVRK0BgLNeDRw6Qtd
	6iHqKiggHz7JdPeN7RoFUYTqzUHbSzh6GPEgBMEzRqMeeZH1BVITYhKvNg7sGQvn50r/PCvOsm1
	HqA4zZZag7jaJSwo9PEPTE0ovsUpMWCTToJ4zY
X-Received: by 2002:a2e:9853:0:b0:385:b4ef:f667 with SMTP id 38308e7fff4ca-3885335b418mr22967171fa.0.1771699015563;
        Sat, 21 Feb 2026 10:36:55 -0800 (PST)
Received: from localhost.localdomain ([178.176.177.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7af19d4sm5006841fa.42.2026.02.21.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 10:36:53 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v13 3/3] riscv: dts: allwinner: d1: Add pwm node
Date: Sat, 21 Feb 2026 21:35:53 +0300
Message-Id: <20260221183609.95403-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260221183609.95403-1-privatesub2@gmail.com>
References: <20260221183609.95403-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,sholland.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,netcube.li,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-8144-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[privatesub2@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.30.136.104:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,2000c00:email]
X-Rspamd-Queue-Id: 222A616D8B0
X-Rspamd-Action: no action

D1 and T113s contain a pwm controller with 8 channels.
This controller is supported by the sun8i-pwm driver.

Add a device tree node for it.

Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 63e252b44973..8e38a0d95f5a 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -193,6 +193,19 @@ uart3_pb_pins: uart3-pb-pins {
 			};
 		};
 
+		pwm: pwm@2000c00 {
+			compatible = "allwinner,sun20i-d1-pwm";
+			reg = <0x02000c00 0x400>;
+			clocks = <&ccu CLK_BUS_PWM>,
+				 <&dcxo>,
+				 <&ccu CLK_APB0>;
+			clock-names = "bus", "hosc", "apb";
+			resets = <&ccu RST_BUS_PWM>;
+			status = "disabled";
+			#pwm-cells = <0x3>;
+			allwinner,npwms = <8>;
+		};
+
 		ccu: clock-controller@2001000 {
 			compatible = "allwinner,sun20i-d1-ccu";
 			reg = <0x2001000 0x1000>;
-- 
2.25.1


