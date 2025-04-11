Return-Path: <linux-pwm+bounces-5454-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875DA85EA0
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 15:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5581BA720D
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1112F399;
	Fri, 11 Apr 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Wo3e4IE/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DDB127E18
	for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377388; cv=none; b=E3RCjT8Xco4HgIqHG9hL1YG4KsZleFxJ0yHl0K0i0dUmTAS9HkVlKsOdPlXJksnsNXHvIpaoFawWTMpv0V2Z5XigSBtdxuYd6++oplv3E0VOH1OoR5u5oAt3vmJ1SCW9e9qXWXQtSYJPdnZcPOkde04oxk29g7cLm3NTUYS7BGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377388; c=relaxed/simple;
	bh=Vzarm2+GocjZ5yQi5tz+9vTbULzRbJHRPSoTmN+iFLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QykyCVgENE9b5qEUqvLzSmesCQU9NGZ4uj44JZB/cH/7LgBr95orFUsPVPdh87gmTaEvGZ69ElMQpL5kXFEU5DKmBAEWfoqQxq/tC6CluBH9VZwbn32ljmz0xqzuWawSPu01FVx3cSAHVQGDqGPvfulSovQYOCAgpQFbLltuHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Wo3e4IE/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2264aefc45dso28241425ad.0
        for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744377386; x=1744982186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz09ttaY9JsJuScjIjTX5PLx95DbvCz1+uszRy+OQ8A=;
        b=Wo3e4IE/86YoQE0VoquTJdoWUdZFUEN5HUQJfHSAf25KmrWf3aPDTRurSgDVV70Gqd
         dDvo13Jzo/VLMNldp+leetcwTDZACiV7wIUsKR4xBRzPfb4AFZUprdPpCTlWu9WVkFHB
         EdDA5JoHNCis/49VRNOoGebinUhCuyD8jbF43YuAgWPRV0Di1hgKQLBVx43go96k1/G3
         6ns4EXncCYHJrqN/Z+r47/sBQROchsVlhlej+30H2fWyppEd0JCdcPjC9X7uPcXHiQZ9
         rJDH97licciLjcUbpAmTot7DOy6NEmLdhfxCdriEiGcDtl7xt+bOmsw80FfM1ZjWuz00
         IpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377386; x=1744982186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sz09ttaY9JsJuScjIjTX5PLx95DbvCz1+uszRy+OQ8A=;
        b=wIfyOx8AyHrMbIU8tklkw897cIIvYtYRAc9ym/AgW63LQyes/3vf7y8dqsIq/rJbzw
         nrIW7tk4KFPPIA5I/wQXl8LFKg46YerPV4LBIPv1XM3rEP1yDb6LhC6hnyg08/2CQV48
         mbkPXz9Z7O8SyHK9MkE/Ku++Wimfy7pXSgQVGNL6gHa0oMPFVr0KFVGQ9ORMm3+qUOdC
         eb8e4CQ4dXHdh5iVifGKv5IArXeFvfhKtWiW4GTsU3NQCrwigL8nyjQMC9UmREIVaVTr
         9C0IdpnBs2RJUK6NVmPGJnMj9Rh1ChOMunr/qgP2zr6E1oYohkvr2oigiSYSSnSOOZJG
         IAEA==
X-Forwarded-Encrypted: i=1; AJvYcCVp3ujnmOiqjzEtO81vqJqLw5nz97YS6iEbdkXT2cigdnG3AXbni0joR0GO/UXOwEAI5KDYnYZcJ14=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2z+EeLgcUr/Sty/PLMJcmaNccAGwY48UUh78KZYLN/DRow64
	A0o37e9EJui3cqqGccuVlhSqW1qLblOyycYzyeldAslOmDEvEKMv9ZH8iO2DuBY=
X-Gm-Gg: ASbGncsaby3jolh2FWwAi8B/yYS7X+XwHs9xrZm1i/O4xrMEy8dpe4KcdiazmRdxHag
	OD9TV1y7JXTg+odens2qmpZBAGHH8WQ5tgab2hUJysGkaRuTKfIQ9Sq51L/WaWXVwHGdUSbDyOe
	JB/3J3O2qyUK2DR69EO/OQcAS7hEgYgtLFdASiekUgvs4q29OaFDuk385054tehpXg3eeH5zTSD
	rkWQN7fqzi8O5mA2H+OaeR0hderqm5pITBUZKvZ7TdPu7hwkkmDDVsB1SGdj6T56apeIWQ8invE
	kgQOOtAfKjcY3AaT6S3vfM9+d3rN+M0=
X-Google-Smtp-Source: AGHT+IEMvfP6Fh97oRNaj3GVNlhjSqFygi8X/wqAMQAzRVrntdPfe+jNArlUN0+OLtqmSujGxJFQ0A==
X-Received: by 2002:a17:902:ea05:b0:223:f7ec:f834 with SMTP id d9443c01a7336-22bea4bd7damr40806085ad.31.1744377385993;
        Fri, 11 Apr 2025 06:16:25 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a305:4::308a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95cc6sm48245005ad.122.2025.04.11.06.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:16:25 -0700 (PDT)
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
Subject: [PATCH 7/9] riscv: dts: spacemit: Add PWM14 backlight support for BPI-F3
Date: Fri, 11 Apr 2025 21:14:21 +0800
Message-ID: <20250411131423.3802611-8-guodong@riscstar.com>
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

Add a PWM-based backlight node for the Banana Pi BPI-F3 board,
using PWM14. The backlight is defined as a 'pwm-backlight' device with
brightness levels and a default brightness setting. PWM14 is assigned
a period length of 2000 nanoseconds.

This configuration was used to verify PWM driver changes, with PWM14
tested and its waveform confirmed as correct.

The node status is set to "disabled", and should be enabled when the
display driver is ready.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 816ef1bc358e..d04b57ddeb46 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -28,6 +28,32 @@ led1 {
 			default-state = "on";
 		};
 	};
+
+	pwm_bl: lcd_backlight {
+		compatible = "pwm-backlight";
+
+		pwms = <&pwm14 2000>;
+		brightness-levels = <
+			0   40  40  40  40  40  40  40  40  40  40  40  40  40  40  40
+			40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40
+			40  40  40  40  40  40  40  40  40  41  42  43  44  45  46  47
+			48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63
+			64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79
+			80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95
+			96  97  98  99  100 101 102 103 104 105 106 107 108 109 110 111
+			112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
+			128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143
+			144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159
+			160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175
+			176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
+			192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207
+			208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223
+			224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239
+			240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255
+		>;
+		default-brightness-level = <100>;
+		status = "disabled";
+	};
 };
 
 &uart0 {
@@ -35,3 +61,9 @@ &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	status = "okay";
 };
+
+&pwm14 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm14_1_cfg>;
+	status = "disabled";
+};
-- 
2.43.0


