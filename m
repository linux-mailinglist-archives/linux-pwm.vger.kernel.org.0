Return-Path: <linux-pwm+bounces-5729-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF867A9E388
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Apr 2025 16:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F003E17A326
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Apr 2025 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543DA1D54E2;
	Sun, 27 Apr 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDzG7LKq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3EF1CEADB;
	Sun, 27 Apr 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745763936; cv=none; b=chvJi8FpIiVYvURkJdVbLkYQx/p04/ofaUtjRVlpjIskiZDl1BVwkXLGvRUnExglkXl8qEn2ZfurYm/uMJ/ylhaA0Txnd5ULVoY31OHgypLZHgmdB6BDn57lHcJaxJbiQgGZqUPpkmmWdLxhMXL8hOMiMIkduAqnvPeDQjacUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745763936; c=relaxed/simple;
	bh=h43/JFNo6LCvxmTnoJsqQ2wSk+f2aaZbipXz39J4cxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jI9xM1uvhZpsfWv0RU/LkS9suPHymMv2HHFtDs60YPICPL9QvYT/Polod7zPKRs+FFdI0NxnoxdMQ7YQV+lqXskwIYpA7lCcO+b7J2JUNKe3YMqg+zGMOdl8f3STV+gQVMDG3USYTjFZmVZJntqUUcjE2EO/fyKRt8c3r9lxd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDzG7LKq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bef9b04adso39047001fa.1;
        Sun, 27 Apr 2025 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745763932; x=1746368732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehkKd/S9OU9qUgpjp1lZbmN7V0G9VzQJCuY2t4gA7ss=;
        b=WDzG7LKqlm1aC91YO1QmKiNIJzzfh5XW8F+m3WEAZvL0X5PylSvo0KTXo6kOjb9dJ0
         s7KPUsT32B5n3yRnu8votFrKyuhO8ycnW72qH/P4OXOHxy0YSSZIUgbIAija9u/mLCAt
         Mdv9qGVwFiWYdKgYsKWN1ArhAssUO83VL85H04LlR9B9WUBbl7RGGFpDQGeH/maydM7E
         R0GnXGCPsKzFEoyevOUixmdGDHodPaKy2ZcGIr/E5M+8C/DPpNcdvai26/DO91xcp26N
         /8MplRDVTfp/WFAGudx1XBZp5B4j2QOraQGWqUFT7T+YVLSMu/RgrmDk5ip9ufMhxrgn
         jGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745763932; x=1746368732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehkKd/S9OU9qUgpjp1lZbmN7V0G9VzQJCuY2t4gA7ss=;
        b=VFuGjr8f3fU/9c/u1ezeix682GQ+msZuWLn1CkmSkKgDLhzOZZnCIW6yxGUdrqhZvx
         m4rlw2b7EXPSRCyuFdPOThwBPCiLIj9bPmIYGEJIm4ZR3/nfKzjNkU9uThpKsCpI7TOn
         yzIVyAo35WtB/KkNZd9FDXKyDk8FfNUerFCEhvp1ZNbzJvHymx39kxBfnnxuCQQ5rpQA
         h+RWGp8w9XNZFkclzUzlYvkia7kvmWjk8n4ChwKC8oxRzOs+LP123VciCAHYMs2BtY15
         FIhou/RYKDV8HvV6XrktQ3UTbk472DnWu/9TEwRDDrqUq5nUj9odFqln9UZRk8FSHN1U
         BBiw==
X-Forwarded-Encrypted: i=1; AJvYcCUnn+6+uI7m/Mjp5dOiUka0gOvjkc188psvf8OmMteSSm+gfK8WiL6jP41UIKwXj76N7ToqYyiqFcz5@vger.kernel.org, AJvYcCXyur4as+H5D9gWXRUa20o5hytUy7/exxqcgbh9+cUKhI00I+y8E3EHF1tLlBGvF4tBxVzvU/dY+5+W@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRh1siyw6Y29yBDgFjREu41m8qPa5VEQ7IddeGgvsQN6cUn94
	HfZW8bloMGxcm/kngPfrSPc1MTJSnuLgJyCqnhoZHWUMUM2SzVgcwBQovHpmqzTk
X-Gm-Gg: ASbGnct5la/aFGivJ975aAdxBHUrA/a3ou91jWdfVtA2LLWBTMVYMoSONU0G727sy8Q
	8G0SeKdT2PCx4rExWacgpU21bfrtILJC1JlAvATI13WQ5ZhwxowGTlJ3u2436azRad5Mq+kxamf
	Wpy4PYEEQxeGRrgTomIexBFoJVsJ94VWCkve489GMTFy6bNh9nP4K4/1IIPvYbjQ+Ok33uUnX+4
	NcB2y/KDbracbEPTKKiGwBLaEqdpn8EmgeILrDyiV3UFoMkSuXb8xaC4mI7jfOFKt9LUoZXemHw
	lMplzNTvD/iXKr804qy/LOQGti7nMUteIrcWrNUghptqCZq1+Tdk0S+C
X-Google-Smtp-Source: AGHT+IGLFpAqg2RLvOpyGg3GqdGLS7yvAzNGtXYHl5esGTKNk58qPrWitKbJKkJMbZDpUAYewQ6wGA==
X-Received: by 2002:a05:651c:12c9:b0:30b:e983:9ba0 with SMTP id 38308e7fff4ca-31907022667mr27391711fa.23.1745763932152;
        Sun, 27 Apr 2025 07:25:32 -0700 (PDT)
Received: from localhost.localdomain ([178.176.177.108])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cfb482b1sm17659191fa.29.2025.04.27.07.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 07:25:31 -0700 (PDT)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v12 3/3] riscv: dts: allwinner: d1: Add pwm node
Date: Sun, 27 Apr 2025 17:24:55 +0300
Message-Id: <20250427142500.151925-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250427142500.151925-1-privatesub2@gmail.com>
References: <20250427142500.151925-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

D1 and T113s contain a pwm controller with 8 channels.
This controller is supported by the sun20i-pwm driver.

Add a device tree node for it.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index e4175adb028d..2c26cb8b2b07 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -145,6 +145,18 @@ uart3_pb_pins: uart3-pb-pins {
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
+		};
+
 		ccu: clock-controller@2001000 {
 			compatible = "allwinner,sun20i-d1-ccu";
 			reg = <0x2001000 0x1000>;
-- 
2.25.1


