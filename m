Return-Path: <linux-pwm+bounces-4095-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D99CF5E5
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 21:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA08728AB8A
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5701FA273;
	Fri, 15 Nov 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2qOSNTK+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A91F9408
	for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701952; cv=none; b=ieMAkst7CB68amn7TDb5VIONZMnPk3Z2PFpZZTJitXqy797pVackTfrEHAzq/HbK4pgDl8BeKJml4YF4HMD8Bo3UT87APq5fgXwN8f8h4CKzjD/WfBhqtkoaGYq9aof5qMsZKWjX5EOSjkgnExe1FXmY1IIFg/4pcuAf5r+5MJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701952; c=relaxed/simple;
	bh=S/ZB5G447JrD+Sj23MWpY7n93070DqnmYQOxfSZ5VDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jdfeUGUf0wJyCM9OawkBxKYuGbitDygdlnCrWHjJNLhxeUGRK/X4HF4wCtu0ba5EOtf6CEIROxpCjgLlUYUnIx9CKz+zSad8vV7FKBgwareHtY8w7xUqQ90XcAHXlM+ZjXWFQ5COC8f0BQWQJOdwFhEmJy+19IuUluTbBnP4wV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2qOSNTK+; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-288b392b8daso4528fac.2
        for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 12:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701949; x=1732306749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZDnLi74GMbcbXDL9gHZvGllU4Iq2w9PER/wlLwda4Y=;
        b=2qOSNTK+ZdWud8H4mHw9PaZ+HHyD6VIedYFPEMmTh/h+bdW24SxtzUNkoCCAy7l1cR
         DkN9bdW8PIezIyDxHzG6L7oCaaJpQ3d28KvAwhQ8tZ7Wg7pFySN9W8ujAbUjfVxGNRTU
         HtblVt/burP9cVxHWDwvmdJGYSGw786hwPnXbV1f+El0+qgJBbs/Km0psT9ZF9hshpnP
         9h7QnhLlcGUVCfeXhE6xlCRwPGcKdQGnExFPLXuuKFZ12vYY1Z9VNHfYITG+G6zoL2Vb
         77iTLnFW/FTOXORJx+FGJiHa8uL/YJEYpcuXnbbbbsDvSm/b8xml8TOqG0AK5xCNNXiF
         XJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701949; x=1732306749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZDnLi74GMbcbXDL9gHZvGllU4Iq2w9PER/wlLwda4Y=;
        b=WX1Aye4uvvbEctv+oXWtL+BCipeMLTpUJdPMgP9m3BmshoXVJjdyHucszHHcWGL2qX
         kBNpLnKUnBiTE82ceaEj6bGD6X9Dtt5Osp0DYUfQVvwHxwPwwo/X1y09qpejGMjvgi3/
         W1urkXfEbLi+5f3rsowC7ygLIRejItxFL3HA1S/XiCAuBQQLdl9jEqBI2FAywseHwzLd
         zdnklHKTZFkcv5664LYSSrZht/+1wRCzCUnMRkjwiAoEeQEXswolX8yEHYyeUyMc9CAB
         +q03gKuuwBTrGD6Caok1ho/+jopo3i77SGnE8OHbnYgjtBo8Jc8zLK8szhkVXCGJHQGR
         oriw==
X-Forwarded-Encrypted: i=1; AJvYcCWYcNBA9VA1FmGKRQvlIyzyPTIXamgYJ6gTrAZIoqtpdEK3FB1n/JQ7YlZyfxC1cLioLWkXKsuVcc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguU4vlhKCFWnsP9ZSWb3Mdy9C84TJ9QTzR14SzDMIH6taLnWI
	VUu8a1Ldeo6PfxsMhSFc8VCsRFnij/QPAtRRdcdEvS3ULTcxzV/Fxuqn6tIPNQI=
X-Google-Smtp-Source: AGHT+IEAilK2ZOpQfbXmxKo0iagU/D0Z/JRkDI6Rf6wF0ylOLjKlbR82USKYPG9tkrONhOjTLTEPXA==
X-Received: by 2002:a05:6870:7a08:b0:26f:ddfa:3564 with SMTP id 586e51a60fabf-2962dcca0d7mr4563036fac.6.1731701949133;
        Fri, 15 Nov 2024 12:19:09 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:19:08 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:53 -0600
Subject: [PATCH v5 14/16] dt-bindings: iio: adc: adi,ad4695: add SPI
 offload properties
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-14-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
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
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add a pwms property to the adi,ad4695 binding to specify an optional PWM
output connected to the CNV pin on the ADC.

Also add #trigger-source-cells property to allow the BUSY output to be
used as a SPI offload trigger source to indicate when a sample is ready
to be read.

Macros are added to adi,ad4695.h for the cell values to help with
readability since they are arbitrary values.

The $ref for spi-peripheral-props.yaml is moved to keep similar $refs
grouped together.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
* Added macros for cell values

v4 changes: new patch in v4
---
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml          | 16 ++++++++++++++--
 include/dt-bindings/iio/adc/adi,ad4695.h                 |  7 +++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
index 7d2229dee444..c0d4e4ff62a4 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -18,8 +18,6 @@ description: |
   * https://www.analog.com/en/products/ad4697.html
   * https://www.analog.com/en/products/ad4698.html
 
-$ref: /schemas/spi/spi-peripheral-props.yaml#
-
 properties:
   compatible:
     enum:
@@ -84,6 +82,9 @@ properties:
     description: The Reset Input (RESET). Should be configured GPIO_ACTIVE_LOW.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+
   interrupts:
     minItems: 1
     items:
@@ -106,6 +107,15 @@ properties:
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
 
@@ -166,6 +176,8 @@ required:
   - vio-supply
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/spi/trigger-source.yaml#
   - oneOf:
       - required:
           - ldo-in-supply
diff --git a/include/dt-bindings/iio/adc/adi,ad4695.h b/include/dt-bindings/iio/adc/adi,ad4695.h
index 9fbef542bf67..fea4525d2710 100644
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


