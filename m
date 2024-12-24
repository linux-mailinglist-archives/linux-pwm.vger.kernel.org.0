Return-Path: <linux-pwm+bounces-4488-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E069FBB1E
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 10:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2042D1635D4
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65991AB6D4;
	Tue, 24 Dec 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QiKoTtqC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E31A8F95
	for <linux-pwm@vger.kernel.org>; Tue, 24 Dec 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032490; cv=none; b=fvoE7PPsXDlTXrUvnJplO9OJ07G00Y23FwA7f/i6Yxc470G3lIKyLIOGS9iDVYBZIXpJHuDlF9bU8nO698JxKcKhDvqRvH4PqOqSK+hKHNMqXrIZZvy8Pj3SC/Fm6mLXRBMah2uRJ/I8BaVnbv13B09DdLks8N3q+xw3l7wO4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032490; c=relaxed/simple;
	bh=plbpc31rVrOD0KMkWiMy9DSCysG2bPp4EWpOgbNVk+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxhzdvDXwWnFXgjcFV4m91X2YnTd5dlcQoZZ91b2nUtvqN5UdOD1E9aA2Zg/LpunOlc/ByiL5jbRwEGoQxVT+wiIDpeowzYcNlCKQ834e0z+N9xbEzSU34RgkiqF4YKTlbTdOYoN/fQ69k3JGmybuVLRBARQ/jkGWHxD+K116HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QiKoTtqC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b1f05caso49139875ad.3
        for <linux-pwm@vger.kernel.org>; Tue, 24 Dec 2024 01:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1735032488; x=1735637288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3iCEA8tjYiThU7Rin4dKsTFv6XsSOzMIb0/FuGpw2E=;
        b=QiKoTtqC9kMqg3tB3bIGrAoICqNG+kJmYEbY4Mn7IHSnt+2A/g0KiFfPaE8m6qr/yR
         54qvanbB8k1zd23kGfe4x4fgQB5fmM2c1ARtHzrJGkg203nXV4J7wir3YVMcL9rmkfEg
         U8fTw2s5pMhWM81bT67nRdIJZ9vvRqQ3QMhBbIGjG4eu4OoxnMP+KCzP+Odz/IqGuekm
         I0JsfXErH0rIPymgrVIcJyHcDml1jptwWvxfxyTIX3haY5gaKRxP1cQOihRSlTRz3QtL
         qrMWGjTl0kGB7ulPtpiQcqW5gTX0aYy3FizrNjVVoA4lawTGxZrBPt1KR3el2BBc8xnq
         whsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735032488; x=1735637288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3iCEA8tjYiThU7Rin4dKsTFv6XsSOzMIb0/FuGpw2E=;
        b=rikF4EriC+vvmB1QSW3cuZIf80GuzjIP2Q8rKbJHZAIZ++/avlp1QMsMdEdgX2dOew
         PToTA1YsqpmA9PaDBMfJkx0gDVkCz8Mq0Nh4Hm7raPllB1IIe/q9g/0kOcf4R6+9+Zif
         QP6KZdE1dyrTF1BoU8BKzIX+y1hp4CKO9XlovjbGEHyswuRd1H2aGGjlAiDYMOu1BMgG
         l6JbXcyD2Qy/ctpbfYoIh711b+cuIoP3vKif1/Yd8E2XUjQg7Qbec3KWknNTtkNE+yQC
         RA1CWYiJ5As8GnBKVWSG7/z1yYAOEezXCfUtdV6GxcNHd8L/VBul5hodqWHZ3F/MIaab
         B6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWiHpAkZhNNn5Ou+I6Xrfr1pKjhCtKIEb2Rai/E0cdpthmkxlnj+h+x63e64szKaC9b/vIg6/WDrGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtoN94j2InC8kQwTN+PzwHeAJ0qR1oILo38S7qCEO5Y8U9Lcn
	BBfnWnTW/l3IvqKnm5CrTC7WEqMlaCY+GWEmxjpcWrr0uhCgOa6Rv/Eyo+rj/GQ=
X-Gm-Gg: ASbGncvH8QGXvl1L2mZUDp/lGdo1ABaB3NMzSJ68syQgErXlclQFsnut2e6yvrsw9kE
	i0T9g3dmhczQtpF1VgV47fHvDAzub8gXvoghaQvUAZHAHVfKhMMqjkQhLr9poPL8v7pP40FOUrb
	brOAFreRY/Hsxetpl47VllRgn+XTiqgBKnIGPp42kortwXnHkfkzLdcIo0aqS/EdhhVvoKFPmc7
	VOQLtrhidRdCbui8JShV6ki9J4oJLzKe+bylxDIST1tbvMpYrBD8KNebe6Nljc2t6f7WFZNVATu
	k9BJsiQWKV8GvVzjbg==
X-Google-Smtp-Source: AGHT+IF0zLvXg0En0J308WC3QLi6iR0zwk8h6v6PO7AKPZZqdQ2DFuER2UQDgneMceWfSmVNHYy5yA==
X-Received: by 2002:a05:6a00:4485:b0:725:c8ea:b320 with SMTP id d2e1a72fcca58-72abde0f951mr22397563b3a.14.1735032488180;
        Tue, 24 Dec 2024 01:28:08 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72af8dcff60sm516341b3a.152.2024.12.24.01.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 01:28:07 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Nylon Chen <nylon.chen@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 1/3] riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's active-low properties
Date: Tue, 24 Dec 2024 17:38:59 +0800
Message-Id: <20241224093902.1632627-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224093902.1632627-1-nylon.chen@sifive.com>
References: <20241224093902.1632627-1-nylon.chen@sifive.com>
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


