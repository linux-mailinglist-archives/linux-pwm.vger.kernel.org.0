Return-Path: <linux-pwm+bounces-888-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3465083873D
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jan 2024 07:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE1D1F23C5A
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jan 2024 06:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B452F6A;
	Tue, 23 Jan 2024 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aphb7JZz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FE951C4C
	for <linux-pwm@vger.kernel.org>; Tue, 23 Jan 2024 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990680; cv=none; b=OYa78C3hyAK9spgMjf/Vx2wuyn5Q0Vys2IXs/C2S30j9K8VFpF6M+ylADvKuxEX4xQX8aVGCV+KIJeTbINpe3Bwu+Hqk++59aS+Yf7DrS6TzWBrMuvOsMjp2Zhrk6LgswxDHjefBm4HeWWavAxsa5Y81wRVFoFu5nzcQDX5j7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990680; c=relaxed/simple;
	bh=1bu5VdLVFE0vJHO/4YwoTnP20DXloan9l7QgOTTeZVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GD9WTmK1YsPG/1gkM58Tn2XTxvm2DoheEonW/lLm5mQ1j/WXhcVB7WbJQygJyOAUVVpnBPBRlcH6xzM0coJaJWK3zZ/EYcKcSz2K9R2Z/r5f4lj8bTQzpF/EsMTnvB6toi7zFzLFW+Up5hFjJPgxZDQdi9YJDqMbP9Y54wAuEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aphb7JZz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dbcfef55dcso2477830b3a.1
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jan 2024 22:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705990678; x=1706595478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ME8YwPbdKoUEBb8pwsupWQGlI6P3cfXncKX/A/ie+p0=;
        b=aphb7JZzFwmTJdMlCCY9FGsd4ysrwgqQduQH5NJHxM4CgLKK6OMz2vPSKuCstyuvdb
         0eReCnXKNP4CMjxslc7efJa7lXUxDG5AG2XEHZGsK1G3yRdi+nMjPImW5M12iaSmYDnS
         Vn9CpWmvGE+XZSkh7NnnimZP1lz+JCxhxBVN8nr9ujj65yl1x37wCBW4XZ4fQeFyQ+fu
         +gSykohJ3A1qjL1T0SaaGUnaL95uTj4HkdZxOuGoJrgNzQe2E8pXOZSQvr8v8QVkbyVg
         sHWAHfrHuPq2Ai281voMCEHDUCzuIG/xn6Rmo5h/wIQS+hkMV4Nrh9ljRQFT2YlDzDoa
         EAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990678; x=1706595478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ME8YwPbdKoUEBb8pwsupWQGlI6P3cfXncKX/A/ie+p0=;
        b=hNdMBnSrgGU/dXmdXJV7W7r3wuajT3ipC5EPE2/sXPrVvCgWuP0XNx9uc8ZqaNqorK
         G04mHKGJAP+fkgtuZp9kbzjY3WT6xvLuvKIHqbWL5lzrAVg4q8dBGANuhNtGVygxsph+
         V2hlSAIsUXkT7MbXnW8XxSwyo/yV+nukDojqrgG8J7rBp1i2kuuBbDoP4paU7sr9mdkr
         1xnlKgryJX8oY4qW2S79yRGkIoo3RJN6Ia3bF8MoINz0REQGUBWkB8AMnEa9RQYd/zv+
         7++U9onsuZxHPbJW9MyRp7jxLoRbyj18LvtB9JtcVavQ3h9nijk6uSWnIiaJVZAlFHeK
         +Bkg==
X-Gm-Message-State: AOJu0Yw42t+SbWCL6sL1yrcUhJHIlT9fRLNIYvtKYyLnfIFAA6de5s+w
	izof/0k8EVcl0gOgvn5FsLKyfIAhqkgUfsWWqjpKtIJQ9ha/cGVklLTVFV2tPvI=
X-Google-Smtp-Source: AGHT+IGilp1NHJ+bOxCNhyXEG/4JAD2rrjQuIW5uobXx3C9HXC0+T93+AoaL+nis4sBdTei7ICbDBA==
X-Received: by 2002:a05:6a20:4387:b0:19c:4fcd:fab6 with SMTP id i7-20020a056a20438700b0019c4fcdfab6mr1483066pzl.40.1705990678572;
        Mon, 22 Jan 2024 22:17:58 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902b08700b001d733c88646sm4425376plr.216.2024.01.22.22.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:17:58 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de
Cc: vincent.chen@sifive.com,
	zong.li@sifve.com,
	nylon.chen@sifive.com,
	nylon7717@gmail.com
Subject: [PATCH v7 1/3] riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's active-low properties
Date: Tue, 23 Jan 2024 14:17:46 +0800
Message-ID: <20240123061748.8844-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123061748.8844-1-nylon.chen@sifive.com>
References: <20240123061748.8844-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes the active-low properties of the PWM-controlled LEDs in
the HiFive Unmatched device tree.

The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf [1]

Co-developed-by: Zong Li <zong.li@sifve.com>
Signed-off-by: Zong Li <zong.li@sifve.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 12 ++++--------
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 900a50526d77..06731b8c7bc3 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -49,32 +49,28 @@ led-controller {
 		compatible = "pwm-leds";
 
 		led-d1 {
-			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 0 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d1";
 		};
 
 		led-d2 {
-			pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 1 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d2";
 		};
 
 		led-d3 {
-			pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 2 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d3";
 		};
 
 		led-d4 {
-			pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 3 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d4";
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 07387f9c135c..b328ee80693f 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -51,8 +51,7 @@ led-controller-1 {
 		compatible = "pwm-leds";
 
 		led-d12 {
-			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 0 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d12";
@@ -68,20 +67,17 @@ multi-led {
 			label = "d2";
 
 			led-red {
-				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 2 7812500 0>;
 				color = <LED_COLOR_ID_RED>;
 			};
 
 			led-green {
-				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 1 7812500 0>;
 				color = <LED_COLOR_ID_GREEN>;
 			};
 
 			led-blue {
-				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 3 7812500 0>;
 				color = <LED_COLOR_ID_BLUE>;
 			};
 		};
-- 
2.42.0


