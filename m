Return-Path: <linux-pwm+bounces-4319-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845789ED7A8
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2024 21:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D626188A668
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2024 20:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA48231A52;
	Wed, 11 Dec 2024 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X2g7Dsu+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BA22A7FE
	for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2024 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950509; cv=none; b=EcFuNYWAVxf+RiEQSd7ApJWxn/OGcNUAgFq8lDqdORrZ//23YcJl9xLotJLc9Di9WYkN2oVULAI8elsQwmvcWVDTTMuUMVMf+O4KkXmIGVXOR+s9u3E9bR2x+h3bVYDndJvKcHgTy05+6sjnn1dM0hCOx/n6+fSTUZQm0EFdEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950509; c=relaxed/simple;
	bh=PkYEy8W3qU8V9csF0JVOTalpjuV6bmYTlDhdHrSYDI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWRkFCtzqxDxciH27S2FrnVBquEFPOrauiUqetbfoY7ZBISmLvYxY9lwP52ZWnamqSCTJRXMYpYQLUGv14YxQuiTMltHn7nW8FbZWpQWVImlRx5qLEB+f4KoCRdQ5CvdbsQHIPSdnjMlf+K0vIeKA/cnbj474X+CiCKevlVRHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X2g7Dsu+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e2a32297dso143566a34.0
        for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2024 12:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950506; x=1734555306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2NU0YpND/hng9o8TUN/QGgKagZ6a+sKTcyn80Z9iVA=;
        b=X2g7Dsu+w9mHbxAxzhh04HkGt28jDTvC2quVQMrgdmDT+anAO5bl8ToflD5W9Z/b9Q
         9lb15akFFHCq+3MspzxZBtcP6fz2xLB4W56LiNcaonoPVg7NPw+P8EdR5oAqZdXfO0hD
         GhKAzgADOtab+3zr8suYUFP3QoDuaD3Rr8sky4TRnK2vFGcnmLpltc1aUV67ucn1X25s
         QmB9Z7Bd4sYJr60mdpOOTw318S4HdqgNyL4U75NDo+kbFeEYzpsYRvRxr5n/iBFNyjox
         Gt0GoUn3LCBEL7fL1TX4yE4FoUvdaNHO7G/sfgkTiJzYZvUhldXkUMXwfhFNPPfKlXgl
         eqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950506; x=1734555306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2NU0YpND/hng9o8TUN/QGgKagZ6a+sKTcyn80Z9iVA=;
        b=ke1cr9MJZUICSGtn2iTUVCR6ssBrrHo32kTRmdCdgiijK5RTs1eUBMjdamwkxFVHi1
         QHglTRfNtrRYFI5GGIg2GePG+g7/8FDsLpQcEW09zd1St9RqWG6NdQqJIHpLgizMkTvu
         ZJIzL4wwSqtCwzy+vcrVuAZXEMNHDSGy0ZjraknQMxE1hrqsZxOOyJ0NXYcCP7d+6iIE
         Q+XmnaZQiLJlgOEzW5EBZL9bc2VltBNcHkPmfAPzEvGxQXg6NGOEaklDB30GMozb8+sy
         7ZL8zUHO79XaBRcI2I5QvOmIpa2CD6pc/3UEQmknTTHGFhyNEOMVJsymzPjXRvNp55XJ
         hXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb0XwvM5Nm5uKjwIo39B2u+Sx3woJQNIM4WjgDmbW/pbefCGcEnvOoEobFoxVACw148IGZueDrqsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrSUj6y7xHQoYRpH+isfBe1b2J6i0zh/5zt61thOQAnXujRd8
	WVDRs++s5J87bK6JrcyUqgU/U+uboq+EHPaxCSPRfrFxwm3qdJJlhwtQ2UQvlLM=
X-Gm-Gg: ASbGncsh5a5yB5bUT8n9Xkvv8IuhK95G0GeXGNLORfhvKVToHzlwxy/yuxvouykrNHd
	0l/lGEw8M9ROCIdo/tjapki6GDlPvWVTNuGf5jt42jmJbY4ZngKqTh0fDya1YHcowQC4vAYB0PN
	m31kaUmCZSeaTMYM4E5gDF2oZMYVKz9xsorDAVmVRIzcRhkszYvzatuVFm++KiVXSsyFLFGX1Ah
	qYqGviBeMBA8eNEJxTgcIkKRo1UTMP20G0VQ0LY4JQH+Oe+pKaWCifPxTHoMN7thq81ZUZKnyUH
	Xr7viYsYNA==
X-Google-Smtp-Source: AGHT+IEXamWkp1IJKOlBWkyVrBkRh+PaayE68aT0KYJIBOQLD11i0mCFT2dxy0dDOLt/sHxuio6W/w==
X-Received: by 2002:a05:6830:7317:b0:71d:fc70:d69f with SMTP id 46e09a7af769-71e2a7cf272mr283948a34.8.1733950506629;
        Wed, 11 Dec 2024 12:55:06 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:55:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:43 -0600
Subject: [PATCH v6 06/17] spi: dt-bindings: axi-spi-engine: add SPI offload
 properties
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-6-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
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
X-Mailer: b4 0.14.2

The AXI SPI Engine has support for hardware offloading capabilities.
This includes a connection to a DMA controller for streaming RX or TX
data and a trigger input for starting execution of the SPI message
programmed in the offload. It is designed to support up to 32 offload
instances.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
* Drop type $ref for trigger-sources property since it is defined
  elsewhere now
* Undo v5 changes that limited the number of offloads to 1

v5 changes:
* Also document offload0-tx DMA names since the hardware can support
  that now.
* Limit the number of offloads to 1 for now since it would require
  significant hardware changes to actually support more than that.

v4 changes:
* Dropped #spi-offload-cells property.
* Changed subject line.

v3 changes:
* Added #spi-offload-cells property.
* Added properties for triggers and RX data stream connected to DMA.

v2 changes:
* This is basically a new patch. It partially replaces "dt-bindings:
  iio: offload: add binding for PWM/DMA triggered buffer".
* The controller no longer has an offloads object node and the
  spi-offloads property is now a standard SPI peripheral property.
---
 .../bindings/spi/adi,axi-spi-engine.yaml           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
index d48faa42d025b07d72baa61f8946f42acbaf47dc..4b3828eda6cb4c5524570f00033b081a6e027b09 100644
--- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
@@ -41,6 +41,26 @@ properties:
       - const: s_axi_aclk
       - const: spi_clk
 
+  trigger-sources:
+    description:
+      An array of trigger source phandles for offload instances. The index in
+      the array corresponds to the offload instance number.
+    minItems: 1
+    maxItems: 32
+
+  dmas:
+    description:
+      DMA channels connected to the input or output stream interface of an
+      offload instance.
+    minItems: 1
+    maxItems: 32
+
+  dma-names:
+    items:
+      pattern: "^offload(?:[12]?[0-9]|3[01])-[tr]x$"
+    minItems: 1
+    maxItems: 32
+
 required:
   - compatible
   - reg
@@ -59,6 +79,10 @@ examples:
         clocks = <&clkc 15>, <&clkc 15>;
         clock-names = "s_axi_aclk", "spi_clk";
 
+        trigger-sources = <&trigger_clock>;
+        dmas = <&dma 0>;
+        dma-names = "offload0-rx";
+
         #address-cells = <1>;
         #size-cells = <0>;
 

-- 
2.43.0


