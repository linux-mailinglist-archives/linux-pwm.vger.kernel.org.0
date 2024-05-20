Return-Path: <linux-pwm+bounces-2188-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615528CA224
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933F51C2142B
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F202D139562;
	Mon, 20 May 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAHNpXOf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E41386B5;
	Mon, 20 May 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230597; cv=none; b=YgGEa8v19Ag4XpEqeWcCQVaBHJWFZtVV9JxIrGt3e/c0uicNXrpwO6bmWblfAxv4EPCKiguMPMv2vL8UeyS/6H75Q3Se6svJwN8lVsLyD9LWhpk6O4UR1Sm/EK0+X5DeBDaFNEy245dgJId5fco2+nMsFDh7gpEvAqnGHXOsB6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230597; c=relaxed/simple;
	bh=HnSg3+8yvYDWyM1nLfi8rFvp5yUPrPDHA9iB7+b6vZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhCC7ceaeaXeorGY0kAn+o9AbXr6nolviQ/MeLxW/r/aJPmYSCIo6vuIPGeAKzxqSAN0qnOE3q2PrbJYDMok1CmiFjcWEGAh27es2nLI0YgV/yRuryeAmEKWVrL6jvEgqu7tZUHwMilgKmZHUKLUJNPotc1xJhpekydrakPiuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAHNpXOf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ff65b1e14so5236972e87.2;
        Mon, 20 May 2024 11:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716230594; x=1716835394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0OurAq4gNaktjTguChGRH09zP44yFK+BI9ZEKeRFnI=;
        b=OAHNpXOf2C7pVLjV7VfDXmZjO3H1RNqJs6j53Cd18695AXq0knY8SKK9z7udK7SCFq
         6PBCgCQ9QECVhTxDKtUHMfvHLrsFOz+xhZM2cLdeQ1Tp8kjvYsEiQup/aaZRN/5hZup0
         zNcIha06ZYWKGCrIegs/thR/WtlybOubr4/P6Giw8xMfWD0Ph6/wKHkWH07Ymceis8ZT
         Iyy9khpTuOiJ+YvSviJS0hoXWL8jopv3R1qNQONYfcBGgZQ0VatmkIy70NUfdRoxYS2I
         vt/yl7hMbnT2Q8jbQjdtf22RNT8XzW8ZyQSbm7OSqQe+hlM4GYk+f0zvUAs1ooifWp79
         seFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716230594; x=1716835394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0OurAq4gNaktjTguChGRH09zP44yFK+BI9ZEKeRFnI=;
        b=QP2fEPV60evUpvsCAeCkuUMU1e+8/XgoA/0bsHeZxPWmiO3canps0N5ewAUxgtvasE
         c2B0yEQF43HiVBmHlhQeEuwLH12/zEuBnrN38ax5l9c1p81t97D3UvjPFu1w4qrbltYN
         JryEDNwNWYV5IWtNFIpU5P5TyH+R7GNZ3a+Drx7MlYhgc47RbPyHaCOvneCUX1NFxNlP
         GF65PQyZaSfqrrMynbcoG49/Bkg3WbIudTOoqoNxd4FPM9HLraWvZzDVwWF3f+qgKQla
         i5vQ5UCeEAK6kAqfZkLUkBAMzdAu85/qbTVO2kbkao/ix14TNcTTx0BFdV5qTslgmdwE
         /pQw==
X-Forwarded-Encrypted: i=1; AJvYcCVleUlrxndptw9UV2mcOl9rszNHZjSxCfnrzoImSuSIOV+nazzY8GLB1d9UuOqjg/iPkeBU2MzkW0pjyCknI3T8BNtPuRTo7a9TL7palZiXnn4x9P1uzVt1giwB2WEiNpjwzx9RkA==
X-Gm-Message-State: AOJu0Yzqlz4F/fSORCAzeFX6swQw2iQ5X5VzcBf/958dSJmJnwl1fIrE
	BFvB0EuAXlortH5a8SFv/8iX0LDc5RGRrON5mFTrGqlR1GRtqgpQx3gqgXUPh4G0
X-Google-Smtp-Source: AGHT+IES9MWPihMjZ9PvkU27cNvcpSz1C7H99avkgVPdGIM5+InFmh0mxe8lkpqCAW7BOcWJa45LqQ==
X-Received: by 2002:a05:6512:3a83:b0:51e:7fa6:d59f with SMTP id 2adb3069b0e04-52210074380mr22923108e87.53.1716230593937;
        Mon, 20 May 2024 11:43:13 -0700 (PDT)
Received: from localhost.localdomain ([188.162.49.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d335csm4368967e87.125.2024.05.20.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 11:43:13 -0700 (PDT)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	John Watts <contact@jookia.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v9 3/3] riscv: dts: allwinner: d1: Add pwm node
Date: Mon, 20 May 2024 21:42:21 +0300
Message-Id: <20240520184227.120956-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520184227.120956-1-privatesub2@gmail.com>
References: <20240520184227.120956-1-privatesub2@gmail.com>
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

Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 5a9d7f5a75b4..22821b21b9a2 100644
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


