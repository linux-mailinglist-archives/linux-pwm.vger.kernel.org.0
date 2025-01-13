Return-Path: <linux-pwm+bounces-4617-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E9A0C320
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 22:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB5907A17FA
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F11FA8FD;
	Mon, 13 Jan 2025 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZV/MsMD3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA31FA154
	for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802072; cv=none; b=pqPNRqt1ZdJbrMG1lfaNaC26h3YKzadYH7Ho6oEXzJ1Si1qkoOAPCKDMtXLreKFiAux0gGANn3aZZdWQWoTcqG+eFOiBgQX3AM1A1K5YcZxTgCfgs2yUeLwwp08YdBIaBGLoWttkOdKmAluwK5ahSB7D+WrzkJZelRaOKXfx6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802072; c=relaxed/simple;
	bh=NDFiO3U0E1S/5X6Lz//TxxrYJLqr6ccKrjn8lgZTJIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=roFclJ+KbkzrxlyUz0hqb1zc03A9QVwM0rTtFrAO8xhgnwfpfRLvSB8dq32nYnohQUj2+3t5NKHUFfmvybHHhdeoL4aGNofV5Z77r5oEY9/7QymuqRGJvKcwL/Trzp9GJyE4M+zkD9YIom2jhtLZHyHIMwHgGP162Al23WjgxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZV/MsMD3; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e3167b90dso2634731a34.0
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jan 2025 13:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802067; x=1737406867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iLwNjuSq2Wrxa12NE4/8IEuSETMFdqrFjSUkFlmHIg=;
        b=ZV/MsMD3wppfisM/fhyCNo9H9dzZk+QdeAeF0QqZ3cQl3/yIb71SHDweKV01NqAQPb
         +eqqau2NMGwAipQaX2GvvAHQjMZEuKUejSpUVN52+0b9jtp+LBDd1F2mANmpyBiQd/eZ
         ZNsYqIXwEQe35cEw5+dqvGGh2XR0xIJUJaQizktFHHJbELNrmhqnSwqujzkrh6MrsbvP
         I0oqy0nW6aA/SGwD183UP4Maylkr5e0WbYVk2sMDkUhdpa/FtmJt19uuUaC/p10dIpiw
         YYKQyUcTKo3SgHwNE+x+knwwHleaeRSDfAIShHpGbWh5jFiRjDspJCzX0ZjQ3p4xxUrU
         Ui8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802067; x=1737406867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iLwNjuSq2Wrxa12NE4/8IEuSETMFdqrFjSUkFlmHIg=;
        b=NXbgv/dsNmFpeI7/wEhCFgKZFMTpuwCDq9ljT+U18Lk6F/yPBEKUsX1ivRhmLUPx4A
         NX/L+/tt3X3rMHipOpbYMIAdM9rglaWCxTAUHFdSZW1J1rB82IpVSnyYdOAIQmRl1N5L
         oPj3M784dbyrMGcEqZuUCWNvNw2FR4dqKPoo/ddXPJ+UaFskTApePs3B2sCNgfdCiL2t
         +Oba9w3DvW5bQ0v4dNOzyn40Czid1/wKAKN0YcIv8HuVa4bUth+SzJaN6zc8LSpqQdDa
         IMC0AFu/ZCe0CuiuOFCUciEiVh0cXv1cb1kEphhM1kyosI9/Dl5tCmTcRcxOgXaTQK2N
         4jNg==
X-Forwarded-Encrypted: i=1; AJvYcCUE3ojckZ5H4kGSJgJ91g2azSL6+iJ/CEPhipz6DSoQW6qDD9M6FmvkpsmIu0kMvNRPTLvG8ce21Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KwALC+wfmzT6vmJnbuymLmtE0nvxd2vjRwQqoUjm5vf6bZUa
	a0KN+E5rRnaMeF0BzZchyd+Qpb/aLPaRDry1ChUETwTROSoVO4FqK20hqEtejI8=
X-Gm-Gg: ASbGncuz7mQFeUzjNjrxx545rgltq8U7tQJSe18LOtHhH3+H1mCn1sy5z/qiYlbn2sK
	fizM6hhq4DFoDZBeg9dl6rRIMXuwfJT/7D7uflVRIY0c+Wix2Rn3zILhE0FmMzYELdsSZGbaYV3
	roNHv2GRhU1/rSBvSc57JLH2W/9YNuSETwUJvy5TN9jYttFgwXNSHjSlBO4kE25Pgl77vO+DWJX
	FfvYdjTJ1Rbyygesq09gNcx6uoDflk6kE6AcJQJsstTYsCA0cqZ4AzTMRZ7v8Df3A0q7uIGlvir
	V5t6EaHHEevo
X-Google-Smtp-Source: AGHT+IHwosV+GBI/cwkzwbE4LHyNNp+ADMynEz2WHDKOMWlYl/AymhEUv/oaYtoR3qpdzLxjxkLsHQ==
X-Received: by 2002:a05:6830:4414:b0:71d:f762:7f97 with SMTP id 46e09a7af769-721e2e7052fmr14087686a34.17.1736802067684;
        Mon, 13 Jan 2025 13:01:07 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:01:07 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:18 -0600
Subject: [PATCH v7 13/17] dt-bindings: iio: adc: adi,ad4695: add SPI
 offload properties
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-13-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a pwms property to the adi,ad4695 binding to specify an optional PWM
output connected to the CNV pin on the ADC.

Also add #trigger-source-cells property to allow the BUSY output to be
used as a SPI offload trigger source to indicate when a sample is ready
to be read.

Macros are added to adi,ad4695.h for the cell values to help with
readability since they are arbitrary values.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Drop $ref to trigger-source.yaml
* Add maxItems to pwms property

v5 changes:
* Added macros for cell values

v4 changes: new patch in v4
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 13 +++++++++++++
 include/dt-bindings/iio/adc/adi,ad4695.h                  |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
index 7d2229dee4441e20a7bafc9165fe309ac2e9eada..cbde7a0505d2b5df22c54ca4556878bf22e9b4b1 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -84,6 +84,10 @@ properties:
     description: The Reset Input (RESET). Should be configured GPIO_ACTIVE_LOW.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     minItems: 1
     items:
@@ -106,6 +110,15 @@ properties:
       The first cell is the GPn number: 0 to 3.
       The second cell takes standard GPIO flags.
 
+  '#trigger-source-cells':
+    description: |
+      First cell indicates the output signal: 0 = BUSY, 1 = ALERT.
+      Second cell indicates which GPn pin is used: 0, 2 or 3.
+
+      For convenience, macros for these values are available in
+      dt-bindings/iio/adc/adi,ad4695.h.
+    const: 2
+
   "#address-cells":
     const: 1
 
diff --git a/include/dt-bindings/iio/adc/adi,ad4695.h b/include/dt-bindings/iio/adc/adi,ad4695.h
index 9fbef542bf670015c5b34bfbe1336e7e295bf8ab..fea4525d2710cbf58cd4236d3276bad4cb318df9 100644
--- a/include/dt-bindings/iio/adc/adi,ad4695.h
+++ b/include/dt-bindings/iio/adc/adi,ad4695.h
@@ -6,4 +6,11 @@
 #define AD4695_COMMON_MODE_REFGND	0xFF
 #define AD4695_COMMON_MODE_COM		0xFE
 
+#define AD4695_TRIGGER_EVENT_BUSY	0
+#define AD4695_TRIGGER_EVENT_ALERT	1
+
+#define AD4695_TRIGGER_PIN_GP0		0
+#define AD4695_TRIGGER_PIN_GP2		2
+#define AD4695_TRIGGER_PIN_GP3		3
+
 #endif /* _DT_BINDINGS_ADI_AD4695_H */

-- 
2.43.0


