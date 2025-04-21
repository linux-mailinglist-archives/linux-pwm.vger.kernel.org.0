Return-Path: <linux-pwm+bounces-5609-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D6A94EE3
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CBA87A73CC
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E4E339A1;
	Mon, 21 Apr 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QpTS3Jx0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE986259CAC
	for <linux-pwm@vger.kernel.org>; Mon, 21 Apr 2025 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228642; cv=none; b=RcO4eIX7wVbZFpoLk7Q/i1eTrNSP4HAAWKtdz73YiZvjHojSvoGSIAbKKvvnJqxWuQCC7UHcTU8t2/pIsrtAGLHLkTJjyaB5oTH/y684IH9c8Ninlw3S8/N/XS5XCvMuf1HaT5EiS/ADc9LJmMhvbtgnT6cim7ENI7uhzP4c65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228642; c=relaxed/simple;
	bh=plbpc31rVrOD0KMkWiMy9DSCysG2bPp4EWpOgbNVk+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTa7xOW9NqSdQFys3IS//EPynNBWKUqxPNj40qyvwnJMRFBGeK4ZF4Xsp3yB0NPY1OQ0TAjU1UYKmtN5uQUuX82cHJ9Rsb7TBMlSEPQHQInnpbuk9o+5zHu3k64A8PW8u4YjWgPEDLopjfvG5cdvfPghHNSITv/xUijzrjlBxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QpTS3Jx0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3312579b3a.2
        for <linux-pwm@vger.kernel.org>; Mon, 21 Apr 2025 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745228640; x=1745833440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3iCEA8tjYiThU7Rin4dKsTFv6XsSOzMIb0/FuGpw2E=;
        b=QpTS3Jx0AQQtvw0bUms0dxP5nQxsRQKGIU9irI+BeDdQvsuv0t8ePG+62pwA2v0iAd
         mbJKOWdFkzNHw2akVdROo0XNxCvINnTEXP29aXJUsnP6yE5Jnd4bcitmOAq2/HXBgNph
         Jkfx7kWsvfvIM+CnyUSzST/EOiwSo+pKvIEkco7OWadpiEEI0p/86DbTUCNeg4LldiX/
         3WHTZVBx1Am6tfA3iVpyuO+QctECz3cv+SfwnMl4/li4YliPvWX43ZkXcLEkiAX+rdd4
         u9FK2AfCwN6I0q51QMJbPEbplwmDiUN/d+mxOs0heCuXC7B1Gh6awcFHv6N2WiKhVAUP
         6kBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745228640; x=1745833440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3iCEA8tjYiThU7Rin4dKsTFv6XsSOzMIb0/FuGpw2E=;
        b=VuBHaThI9o1dIxwwMpSwsXTUSvjKHR+q1Vu+muXYA0mxIJmiXwsrQy1mKBFVuYe9pt
         OuPU0hIhezdEq6mHgkBCGk+Q3x1Ua9X1CoR2od15R5u7P0ys54Zu4R7h3WnFXK1DvLy5
         HXeE+rSL0eCOKo7GXRAXi2W2l6VvdqHz4yvmDOLPnQ1pQosvidFIBNgfTTFxqGJltBmm
         0lUzICMiHANhX0BoE4GGcIHM/6J6cMGWRw9v7P9DWP6rHMjmIsr+FEzoeJm3wb844bpK
         2yIbjZ0joSoEtvhRVgRCQfnE4FEvA8JP9fwVTItBY0cnlNufoSlH1KLRKr1fNYVGQZ1t
         CsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4ad5X4zGVloWOhuxHA4+heuX3nGZaYZSL1OqxUD/OwgkZjeJBUnqZZ+C0E2BZWkS86Asb2wGWV7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZB1sE7Eh85HSGTFo59Lr3r3HExJeybfRJ4DltNrOf5WlkAsSF
	5GJkVQC6RWR5fj/yTiOiLYeVQO6DGTYsL9nGzvUsdRkRTN3A6VyrrFYiA3DYFDs=
X-Gm-Gg: ASbGncsxuCBD6lQga89d+6vb31vgZt9WJgX/3lg6T+iiobW8wzsMktJi68ftm1nKoLn
	c1EgbJgzzOtcWvyiHdqNJu1LwbU107NJk2UFoHOuIUCBN6mI7tDK+1lYJyPGqsDiy9zVJQiW5he
	f0FNdJtAlve81Q++0t7gn6ttvqnJ9igom2dJ22ErZTDhiHXUmNMtqEB3hKsgna7q8DQ2nYlPzMI
	XQ90HQJ5pYIAksJa0yxUUpFW3cZ2AwDy4/8KTxpKel2OxJazIOmBhHk7AHh2SSQScISS2EV24jn
	rlcPsV5duAZYLaQv180nTi3Vb6Ppg/IW9r5lpcYzSYSw+eDpNAZM6CqCCy0Xp4GtRfobF4IS39U
	xzmnaC9EiyJLZ
X-Google-Smtp-Source: AGHT+IGhAPqW9k+zFC8QWowxPP2G8A2KzR14N1unikrdNvLboUqrU7XV7viGFBw04x6asP4GUxLZ8g==
X-Received: by 2002:a05:6a20:158c:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-203cbc74cdbmr17237282637.24.1745228640076;
        Mon, 21 Apr 2025 02:44:00 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaacf32sm6371965b3a.142.2025.04.21.02.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 02:43:59 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v11 1/5] riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's active-low properties
Date: Mon, 21 Apr 2025 17:55:17 +0800
Message-Id: <20250421095521.1500427-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250421095521.1500427-1-nylon.chen@sifive.com>
References: <20250421095521.1500427-1-nylon.chen@sifive.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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
index 72b87b08ab44..03ce2cee4e97 100644
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
2.34.1


