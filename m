Return-Path: <linux-pwm+bounces-5452-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7BA85E9A
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B005E1B85B55
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0DC1E5B6B;
	Fri, 11 Apr 2025 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="odpgcOrr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455B1E0E0C
	for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377364; cv=none; b=JbSnokEKBsPu2gxaWFeWF23ENd1lSrc3aD80GWSCiBkVfFb+iqdmRzpOJHH9/XWv5oS+KfavlrvGnBM2E6s1vwoO4bjc84jMau+UbX0ij/a1FhBU6gd5zHKWLN4CIue9t41B8g/d93c9zFtpvmAC0128gPoTGA5IO2ReE6NWHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377364; c=relaxed/simple;
	bh=MjIPXLoM5IUhIoZhl+wifWQND7T3/kSCdIUtGuu23/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paQzABsUvmR9M8XGdS/XzaMNjumfnt+NQm2oQ4Y2IsjALPtmmsJaaq25FFAlyHorEDAyBMUQE1VNCH5wdckS3J1zVP5F86D5C12FL03dIuKxwKIcw/4T6KWIfNRoYcWxVMBEtIGtSjSrF3FxtIDKHs0XoMrgdgy6IdljrfEWWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=odpgcOrr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de12bso26442575ad.2
        for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744377362; x=1744982162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq/zLUOAjmqMOQyCH6CedvdIB7nhaB2p2wb10oaF0qQ=;
        b=odpgcOrrn8ZqSaSCAdG37wsEEL3dyRUBAF3pfqHPTrSQyvt3PTWeZqHA9umviBMHf8
         9bgrYqw5nbNA5VrBNbNUq4x+ENZlzQdt5uBhpcEREAfsbibGKoGTh0T1BrumJBdKN1sq
         V2E8eZuqsOjQsmES2n3Vf73FbvCthPdbESxjCBg0NB4vNiwWLn6J/ShAnbvYhX/OyaK3
         7MKU8giQydMOpMVOMHs97hnrlEc0biUs9MlkizS7cu89ZniOJ8gqegaCbBLcsdk4KRN6
         759j0/VBjpRVgTFrAv9RvfAP2OP1j1lSoNFY6AhAyvp+fwpmYZihuokilA4sPcMhWYJg
         18yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377362; x=1744982162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq/zLUOAjmqMOQyCH6CedvdIB7nhaB2p2wb10oaF0qQ=;
        b=frnyMcmdSc/cOL0Dy2HghJoOm5wEZWS1dRDr89VzKdswtcVHqfrvsD+6K+eouSL2w1
         5+FW9sP172XcqDi6v323PrvZXoZ/9h/BQTcy4wP7I/QM6u53g5lEfBZP6+Ay/a/PPraU
         yDLMEpeCrj6drjpbaLpvBxW2Sq4Ej5DS7S6NJeK94L8np0ZNCmWOqpThqkdtZmx8Bqn6
         6n7q0+Lg67G1yIZpxNzpzrHmChY2ROimdS46ak21Lt0Dd3sfZmYdbyGm1yMUaJH5hyin
         hyQRRNMTAfsd7kLONk/8GP1UCCqKmXY/m4fWsP0KRnUXUxj+XXd9iGXWuge6DrdeEROk
         NOgA==
X-Forwarded-Encrypted: i=1; AJvYcCUaVSnWXCjAQunTUWteRgzGrcYULaFmKuHJpW+WyqPLNO99ppaN8F4on0FDgM72dsMam1WPqKLOwTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTmmK3bGa0nVyMXa+cJ/mfhvSe1Grg3/Y0P1OK0mI8ag2xKj6
	DrpiIWfM9pgHIBEbmEmWJFGztuhSXq4bB2HO+AiOqRVBqvvgYf+T2e4UuFPkcbA=
X-Gm-Gg: ASbGncss1QA9aQVBvzDbn6uGBov1LUhFaXdq3lF7WHW1MtUNtx157yw/HqX2+XJfka3
	qK/q4xPGQdxUboRCte318p44nvWTxaJJC2bvb790gzGV4Q6b/3Sr2PP2/TmJ7PRs+AzKiFqs0+T
	5RtltoeMggopotm83AQTkpiWMjjYWH4SndSI3qxvO9QRCc6qczTezYVdE7FFRemeqR9qy8RUGil
	20rmwhEOnhwrKDrbtC97iLEbiADEFOf7BpYBOSkV5ZpTDE47jc3SCGsU0oAu21w3oZuRWzKWcCA
	dnaLjY3I3v2xaOXI7hXsDsGu3bXjSFM=
X-Google-Smtp-Source: AGHT+IFYuzue8rTIhMXZdvGPMyvl0e8z93Koxv1rsyMMhwoJlET+hmldcsrrZX6b0qlRAdpPJUNnxg==
X-Received: by 2002:a17:902:f68f:b0:215:7421:262 with SMTP id d9443c01a7336-22bea4b40f9mr36467045ad.12.1744377362506;
        Fri, 11 Apr 2025 06:16:02 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a305:4::308a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95cc6sm48245005ad.122.2025.04.11.06.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:16:02 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	heylenay@4d2.org,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 5/9] riscv: dts: spacemit: add PWM support for K1 SoC
Date: Fri, 11 Apr 2025 21:14:19 +0800
Message-ID: <20250411131423.3802611-6-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411131423.3802611-1-guodong@riscstar.com>
References: <20250411131423.3802611-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC features a PWM controller with 20 independent
channels. Add the corresponding 20 PWM nodes to the device tree.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 180 +++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index c0cc4b99c935..609135cb5282 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -556,5 +556,185 @@ sec_uart1: serial@f0612000 {
 			reg-io-width = <4>;
 			status = "reserved"; /* for TEE usage */
 		};
+
+		pwm0: pwm@d401a000 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd401a000 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM0>;
+			resets = <&syscon_apbc RESET_PWM0>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@d401a400 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd401a400 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM1>;
+			resets = <&syscon_apbc RESET_PWM1>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@d401a800 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd401a800 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM2>;
+			resets = <&syscon_apbc RESET_PWM2>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@d401ac00 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd401ac00 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM3>;
+			resets = <&syscon_apbc RESET_PWM3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@d401b000 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd401b000 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM4>;
+			resets = <&syscon_apbc RESET_PWM4>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@d401b400 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd401b400 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM5>;
+			resets = <&syscon_apbc RESET_PWM5>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@d401b800 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd401b800 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM6>;
+			resets = <&syscon_apbc RESET_PWM6>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@d401bc00 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd401bc00 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM7>;
+			resets = <&syscon_apbc RESET_PWM7>;
+			status = "disabled";
+		};
+
+		pwm8: pwm@d4020000 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4020000 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM8>;
+			resets = <&syscon_apbc RESET_PWM8>;
+			status = "disabled";
+		};
+
+		pwm9: pwm@d4020400 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4020400 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM9>;
+			resets = <&syscon_apbc RESET_PWM9>;
+			status = "disabled";
+		};
+
+		pwm10: pwm@d4020800 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4020800 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM10>;
+			resets = <&syscon_apbc RESET_PWM10>;
+			status = "disabled";
+		};
+
+		pwm11: pwm@d4020c00 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4020c00 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM11>;
+			resets = <&syscon_apbc RESET_PWM11>;
+			status = "disabled";
+		};
+
+		pwm12: pwm@d4021000 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4021000 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM12>;
+			resets = <&syscon_apbc RESET_PWM12>;
+			status = "disabled";
+		};
+
+		pwm13: pwm@d4021400 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4021400 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM13>;
+			resets = <&syscon_apbc RESET_PWM13>;
+			status = "disabled";
+		};
+
+		pwm14: pwm@d4021800 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4021800 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM14>;
+			resets = <&syscon_apbc RESET_PWM14>;
+			status = "disabled";
+		};
+
+		pwm15: pwm@d4021c00 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4021c00 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM15>;
+			resets = <&syscon_apbc RESET_PWM15>;
+			status = "disabled";
+		};
+
+		pwm16: pwm@d4022000 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4022000 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM16>;
+			resets = <&syscon_apbc RESET_PWM16>;
+			status = "disabled";
+		};
+
+		pwm17: pwm@d4022400 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4022400 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM17>;
+			resets = <&syscon_apbc RESET_PWM17>;
+			status = "disabled";
+		};
+
+		pwm18: pwm@d4022800 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4022800 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM18>;
+			resets = <&syscon_apbc RESET_PWM18>;
+			status = "disabled";
+		};
+
+		pwm19: pwm@d4022c00 {
+			compatible = "spacemit,k1-pwm";
+			reg = <0x0 0xd4022c00 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM19>;
+			resets = <&syscon_apbc RESET_PWM19>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.43.0


