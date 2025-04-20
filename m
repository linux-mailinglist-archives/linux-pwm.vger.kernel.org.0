Return-Path: <linux-pwm+bounces-5592-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A07A946EC
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 09:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F744175445
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 07:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF41A23A4;
	Sun, 20 Apr 2025 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="nxncdn0S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE561C32FF
	for <linux-pwm@vger.kernel.org>; Sun, 20 Apr 2025 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132722; cv=none; b=PEHMShfNDIovdB6QB0anULGayGKuB6MJZWx0I3qSb8ozqDv6NoOioIIYIm1P9MiO1U9hYQrVxQyl0gkIukQIiUHph3/Xt7QLT1cJXcz+hY30Ldse9Y9YvUnI2+1ZI6QvR9WWiDtsA7buDD8iBvQ5vsgDeSHtfYcmPj5C/Mum+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132722; c=relaxed/simple;
	bh=PNcTPNKTNZ1gKYtX8vTPGByuXKuF376uPXd94DI3iwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDeJFyfM/zSMXw2DLp5hmfBZ/TIDO3qpmPozT9u9K88lcNKsupPvPkbOFgGFidNiSRKXM0sgymDtf1ujdv3AmDTaelLnKtKOROX36b0Oh7CMkaDa6sZu1OR0IET2H7EUb6dhVJkkJ3YTnLbytrAP/bvGoDwYkEQk8JYVsrrFFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=nxncdn0S; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c277331eso3654865b3a.1
        for <linux-pwm@vger.kernel.org>; Sun, 20 Apr 2025 00:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745132720; x=1745737520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR/L1gyoefm8Vy/IlZ6zEowMZzsZMT6siW4g9DB1mYc=;
        b=nxncdn0So3axJhc7GOuMAnhXgEHSHED7TIhC3UWtNTlmZwIipQAAkGnGherAK4brSW
         8wf653hAVWmZpmnV4T6JAWTsNiNwrDUyJQyOjfbuiaD+MYz/109gwMu7CrN3spuV8o6i
         jPKn9M5k+MMDLibmS0+Qiz2grgowX9vbecBINheLvXgn1sdBQcyoqu6NHDLTFaTQLudf
         2m/NZ3w+dqp3reRHByMOqmXdiO71TSFvsMQoiLCCpHRdUkIBcDPdjngsjLLzjZ2O2rVJ
         ohnc1JLh6MVZ8FtZnuRFAPMxYs0hqq9UFGy7fsq2akeHtyeY2MZVJT1yWH0Sr6CV8/Fn
         faaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745132720; x=1745737520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR/L1gyoefm8Vy/IlZ6zEowMZzsZMT6siW4g9DB1mYc=;
        b=PpwOOJWVKQN4mO3J5qFJPRxS8QeHuAfqsHgpTWi7uW+s8pWWjJezV18toL9yb+UVj1
         AN1gw3YgK1vhqxxFxKr6dsNm93ORMtBQUY8zg1mLIzx0elLl6xvMhl8S/bpFj6/HBSVg
         s6Kw2YOdC00C5vA/p2f6BnLU+ohNSDxrwNLjzbx4wEkjbqqj4xQEaoD6rs/rsIG9PONT
         MBt4kIA9atDM4EIU3joVxGuV/70uSBYuAX7ClbEdzDoAZi0P/hRgHuN+/geTvl7sFYKW
         k1lcWmBWbKDOXW/UhdD6rVZAH8Jz/MFIHAG9lhQRyUNQg6AenLMg6a0Uq0RWWEesBifZ
         /DwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb1WBcfyl7yNpk+mrcQd0iSyfNz9xQBJ3flh9lkj1hyhlJpoopFNe5jK2Dcj3EAcKa73EMbqZAq4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVGq5vwOpMxfKjnsZNs+bw32yNnN9VeySBkRhA0jNjPOyd1dyY
	hmbz4UdAYBgydnJBydiXakjxgPTFG8cWiMhbN9XXYG+y4G9FZxON4ZQHsTYM0Nw=
X-Gm-Gg: ASbGncvIbW1PAa6uIM98ssSzk8x+Np2rB6WQfvyishUtY7HfDJfB+evW7dPYGTM8cI+
	7yRexaA1aSFcGutrPKrLQa39qUcm+7RknHjVlWEkOyGtdJjrrwecp60MyCYCNerASm0Wpq3MUSe
	HIsjYe+UAD48cIojzyhm9Cg6ieKbHzGBDpinodC54xBc8awOlDAoOIN9Xr+Umrr7lJsNMMD2n6m
	9nlUvODSFwVMWh7rhLXTE70XcFVukLWCf6C/0FwOgd03S3PrCpNN0xgMLS5SqyL6IrxWdGVwk+V
	3MK1nbjieZbiUlRLUBebzbvllZCthA==
X-Google-Smtp-Source: AGHT+IHnNcaPl5tS54vvKjk9Uw7ZX2O+/OF2CDTIslzTsPp0DLJ9kQ2Z7mF4wsGBx6AYIAiWAbiJMQ==
X-Received: by 2002:a05:6a20:c886:b0:1ee:5fae:8f6a with SMTP id adf61e73a8af0-203c94fc8bdmr15217402637.1.1745132719693;
        Sun, 20 Apr 2025 00:05:19 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::40b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db12743afsm3742626a12.16.2025.04.20.00.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 00:05:19 -0700 (PDT)
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
	spacemit@lists.linux.dev,
	guodong@riscstar.com
Subject: [PATCH v2 3/6] riscv: dts: spacemit: add PWM support for K1 SoC
Date: Sun, 20 Apr 2025 15:02:48 +0800
Message-ID: <20250420070251.378950-4-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420070251.378950-1-guodong@riscstar.com>
References: <20250420070251.378950-1-guodong@riscstar.com>
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
v2: Changed compatible string with the fallback marvell,pxa910-pwm

arch/riscv/boot/dts/spacemit/k1.dtsi | 180 +++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index c0cc4b99c935..e7dba623e877 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -556,5 +556,185 @@ sec_uart1: serial@f0612000 {
 			reg-io-width = <4>;
 			status = "reserved"; /* for TEE usage */
 		};
+
+		pwm0: pwm@d401a000 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401a000 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM0>;
+			resets = <&syscon_apbc RESET_PWM0>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@d401a400 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401a400 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM1>;
+			resets = <&syscon_apbc RESET_PWM1>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@d401a800 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401a800 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM2>;
+			resets = <&syscon_apbc RESET_PWM2>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@d401ac00 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401ac00 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM3>;
+			resets = <&syscon_apbc RESET_PWM3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@d401b000 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401b000 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM4>;
+			resets = <&syscon_apbc RESET_PWM4>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@d401b400 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401b400 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM5>;
+			resets = <&syscon_apbc RESET_PWM5>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@d401b800 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401b800 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM6>;
+			resets = <&syscon_apbc RESET_PWM6>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@d401bc00 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401bc00 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM7>;
+			resets = <&syscon_apbc RESET_PWM7>;
+			status = "disabled";
+		};
+
+		pwm8: pwm@d4020000 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4020000 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM8>;
+			resets = <&syscon_apbc RESET_PWM8>;
+			status = "disabled";
+		};
+
+		pwm9: pwm@d4020400 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4020400 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM9>;
+			resets = <&syscon_apbc RESET_PWM9>;
+			status = "disabled";
+		};
+
+		pwm10: pwm@d4020800 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4020800 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM10>;
+			resets = <&syscon_apbc RESET_PWM10>;
+			status = "disabled";
+		};
+
+		pwm11: pwm@d4020c00 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4020c00 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM11>;
+			resets = <&syscon_apbc RESET_PWM11>;
+			status = "disabled";
+		};
+
+		pwm12: pwm@d4021000 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4021000 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM12>;
+			resets = <&syscon_apbc RESET_PWM12>;
+			status = "disabled";
+		};
+
+		pwm13: pwm@d4021400 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4021400 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM13>;
+			resets = <&syscon_apbc RESET_PWM13>;
+			status = "disabled";
+		};
+
+		pwm14: pwm@d4021800 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4021800 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM14>;
+			resets = <&syscon_apbc RESET_PWM14>;
+			status = "disabled";
+		};
+
+		pwm15: pwm@d4021c00 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4021c00 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM15>;
+			resets = <&syscon_apbc RESET_PWM15>;
+			status = "disabled";
+		};
+
+		pwm16: pwm@d4022000 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4022000 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM16>;
+			resets = <&syscon_apbc RESET_PWM16>;
+			status = "disabled";
+		};
+
+		pwm17: pwm@d4022400 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4022400 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM17>;
+			resets = <&syscon_apbc RESET_PWM17>;
+			status = "disabled";
+		};
+
+		pwm18: pwm@d4022800 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4022800 0x0 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&syscon_apbc CLK_PWM18>;
+			resets = <&syscon_apbc RESET_PWM18>;
+			status = "disabled";
+		};
+
+		pwm19: pwm@d4022c00 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
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


