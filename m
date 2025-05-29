Return-Path: <linux-pwm+bounces-6171-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01708AC7690
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 05:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F363BFFA5
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 03:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5EF247DE1;
	Thu, 29 May 2025 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="h83nGkiI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE22242905
	for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 03:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490191; cv=none; b=rN4onolupbNMe06K0MyFshq6V3TBSSDYv6r24pk27YoSMpu3mqUyJsRyW4Nr/1QLq/fsSmBh4JQm+tCIti9appXc4ej+/PH/6FQTJPLXKiAsKi9czUQy45zhPLoKeXkVPjoFoxeY6GHyMi6/gc63BR4OgZszVvUSKNux97mbw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490191; c=relaxed/simple;
	bh=plbpc31rVrOD0KMkWiMy9DSCysG2bPp4EWpOgbNVk+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+U3GPYULl5ZfpvXm49r4VHKamlwI3UnGxibPvVKJRS5XAenc1O2fuTP3grxZaSV+CepbDsIqLrYbpzDd5Hmqg7c5C+9aEZ29DaBS+ZzJXxmpAPSQrS0g+UcSOxEcP8j+VnS2CbhptzNQZ3rgtqp8ksuZgcXbc43lM2LDM5eEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=h83nGkiI; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2345c60507bso3671175ad.0
        for <linux-pwm@vger.kernel.org>; Wed, 28 May 2025 20:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1748490189; x=1749094989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3iCEA8tjYiThU7Rin4dKsTFv6XsSOzMIb0/FuGpw2E=;
        b=h83nGkiIai+kiQbWT+h25J1qPw6qQULqRx1CHFZNH2EAYzUYnFrBPkRBqZcynjt5zX
         sWunZE4UiFm7avBLJDW8AydWmHgXYJhaUlAj5N+N1pcBl/3b+HKpueujL97rCVkGtmqx
         PpCvmYS/mlBTPLoSRJrFpXc6ywGb6aLTvpiuxIenC0AVd38SjDpx+lxXHbom7h5OCQgP
         4IbRErIZNQw9vio4jCPw7lZagHEorEY33Mxsout32e93lzNtunfuMl5rX4Vyi4O7BgEj
         inx8wQ/rF/8MnZdf8apVvRgflW2KYIrUrAR0uCpa6pW83cCaLNa+YDEB2EMqwW1u1NrH
         E1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748490189; x=1749094989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3iCEA8tjYiThU7Rin4dKsTFv6XsSOzMIb0/FuGpw2E=;
        b=q63FLXPA+UTf1SUpnrzzOHjE0gCqH6iImoDCTqNHOGLqWAAZoD/YXIcPPDCJnnBZ62
         kbGTAWUZA3IKky8BXcAsYO5/E4exkTIoG+RetnhNxHiqgsdy0iNOC5eP9YB+REyP8dAD
         70ISRcfWxBrIf14plBF9UN7DwN6H6fjt9jWsiHS0JuqdlaJa59v42mFKl70U0AKfENN/
         tTMGH3b6EbigaMHg9SyBIslw98iSY/tj9zmmiWtjPXTzMT8YOk124cZKWLsadnidUfUm
         NjIJj9+ySgHNyfE/paukrD3fOkqqvGzdHVjpb+WGw38sivGbUwbC2CU8MKfVMLIpNtXw
         S1qg==
X-Forwarded-Encrypted: i=1; AJvYcCX93oQyj2WsIZAWAUg3s7+r4o8poQ/QBGUqGABR17vh14BBOqr3AR0xr2B4Txcj1e1P9MixcyW0K9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHYcos/7TL9cdNrfr6bELIysSOzFBwfQ6lct3oRhfs7w3TvRow
	TEjfOKVf2iKT+owEq+HtF3fbJgCFvii9qCxQdnc8eiOXeu+wZ5IIwGahu1jm5/eiFi4=
X-Gm-Gg: ASbGncub+WdwajLGaFyhee0Xmvti/Klu5oVq94loy7YOzFkUpLswCbkWYie3rmYyN3E
	Zbffq+OQZIScnUQ8xGsr8IBkyNu8pVS/VxiaEKqNYKDS/uPEoXYsYQJHesYT5hEth8QEjsygsFI
	Jfvcsl6Kxn/pQrGgfiodmRukUlqb/lt9AasSBFZMoCBj1Je3/vv+IfiKspTQpge7nLIPz7f3L0S
	IeYT1oZ8ad3llufgpUgSuLpxHH2t2BM+21i9f5IC+Lvn2gKpiGIfqK+2pF1+ujkqEsiGUvyoQ4v
	OG+wwHbw/ash/U4U/Chi+3aoWBEzQqYXrlH+V2TihRVG7eGEUWOOPeeFgOgqr4H7h4cUQ7iN0I0
	7oe/WLS5hGmC3Wr8P3QmoFeM=
X-Google-Smtp-Source: AGHT+IFstNcuVP7w227xN/FD2B4edFkQaofadttJziWx+bPq+XVZnP4+BnZFowLiEIahUkjeG851Gw==
X-Received: by 2002:a17:902:ceca:b0:234:cc7c:d2fc with SMTP id d9443c01a7336-234cc7cd589mr68462635ad.27.1748490189449;
        Wed, 28 May 2025 20:43:09 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd92c7sm3425905ad.62.2025.05.28.20.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 20:43:08 -0700 (PDT)
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
Subject: [PATCH v15 1/3] riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's active-low properties
Date: Thu, 29 May 2025 11:53:39 +0800
Message-Id: <20250529035341.51736-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529035341.51736-1-nylon.chen@sifive.com>
References: <20250529035341.51736-1-nylon.chen@sifive.com>
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


