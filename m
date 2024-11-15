Return-Path: <linux-pwm+bounces-4097-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D219CF5ED
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 21:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1FF1F23720
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 20:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BDD1FB3D2;
	Fri, 15 Nov 2024 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xOyyUJxh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28561FAC5E
	for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701957; cv=none; b=M2uv2ERohWyrRl1m1H/OEBJGdgrtYV7N7IE9tg4TUptgYpQotGIPu+SedYhk+fyvB63dZ+wvlZj74exHmZMfwH1Sgdnw08YQf7iKyi394gAL1hDr9k1wrEe/5/KmcjpUPPkTR+HrhkoSfPoSCD2eHvPAbM0xdaRBWTVuP2rvT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701957; c=relaxed/simple;
	bh=Hk8RC/iufxLD2a+ydJA5dpksupb3CS/GNCxUZjKmAHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6mOCc9PWycxgcESJBEFp+LGrvazF1ug63AY3bTSkeRqmTYSBdpaZtM7fnOswlTxgF1f4r6AxLxsOgTF4PrlzrQNLBbj89ROaZFR65TkgyByZMR56EDmSQLIah+eqm8orHWU8RjLx9wuJm42nl6xNvCec8GFmPKfzDDgHb3fggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xOyyUJxh; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ee645cf763so1181213eaf.2
        for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 12:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701953; x=1732306753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6w6V24uqzrq77Vph3I2ahD02yEXC9JX57Vqpm9P42UI=;
        b=xOyyUJxhxgZd6Q6GZohN9F1v2IpE+n7woi4+cr95f24s7g/EWkYF8JM/S0bxg+2ies
         79ZL8dz3MXx00RbAemQ72Y4RjR6HwA5lfB94HkHIq9HpMaEjmMNV4OKGXhAgfaRTi25p
         7i0SW3A0U7hA1rVuT+JiLW1lHGq03mbL9dpTcGP7HD8TEhcRpojFnVDohP3HDNSarHhJ
         8DphJpHaXd1+7DRvomaxOjAyU7HhU/PJh2glFcdu8KvMi1U27lHZyrWXqfzIOGZsYHHl
         X/BSBct/TCGBTimZDIABQ3TN3uYQ+tityGl0N65no+iEqzH4wncG/QpCXXrTdu/XGbQ0
         H2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701953; x=1732306753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6w6V24uqzrq77Vph3I2ahD02yEXC9JX57Vqpm9P42UI=;
        b=GBnHBtbflT1qFOUzRdK381Ts1CW9G3ZrCEzH7El7rW5egnBWHEqM5KnBeRUDpwODZA
         i0yuSXXebiT6KWbA2HQ3GiskZRDO0FIeDNUAVIslD1MtSmQPUxrBaDQVQ1AUvoM07oXb
         w1ELflB3OYTB2hAXTVeKpzxvmnSfdyJ2U8auqzTTz8jkfYEcFjpeECc9ovZSlFZDMUbr
         A8DAsTKIhE6Iqkv/Ww07lEhxW9LduKusIROuYTR87K7sem/0N81faY1KpDAo/ZYz2a4L
         +xrm8qRPXgYSxjvSLI8CPPB7lHQZEHnMuayQPMUABYZKyCoraLeazhJMDZU0tG4ZwWzv
         sTgA==
X-Forwarded-Encrypted: i=1; AJvYcCXYRAhzXcxxt8wNSbeAiWGJbAmpk7fyUcADanJ0zYyDBfpDm4wVsXN2TLvOU2AjLlNnR1hcv0UNPfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuEQFa8IRzMZnRVOuMOhJMNq0B1B/+ChobMDhF3Ycpimfveg3T
	FMLlYkIIqKDMJ7mc8pfqp+TDcPZTXCfW+ENyLP3h7GqpnWccKcCrAfe6PoDEQLc=
X-Google-Smtp-Source: AGHT+IFO2Tmuu3SXBwdN6noWGmFoRzGeGSqPwhckywErQbXZsu+Ra0D/gCw1hGXbt0rPUVfh6B5vqg==
X-Received: by 2002:a05:6820:1a0a:b0:5ec:c22c:72db with SMTP id 006d021491bc7-5eeab29e337mr4710916eaf.2.1731701953013;
        Fri, 15 Nov 2024 12:19:13 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:19:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:55 -0600
Subject: [PATCH v5 16/16] doc: iio: ad4695: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-16-bea815bd5ea5@baylibre.com>
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

Document SPI offload support for the ad4695 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes: new patch in v5
---
 Documentation/iio/ad4695.rst | 68 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
index 9ec8bf466c15..8009a0c272bc 100644
--- a/Documentation/iio/ad4695.rst
+++ b/Documentation/iio/ad4695.rst
@@ -47,6 +47,36 @@ In this mode, CNV and CS are tied together and there is a single SDO line.
 To use this mode, in the device tree, omit the ``cnv-gpios`` and
 ``spi-rx-bus-width`` properties.
 
+SPI offload wiring
+^^^^^^^^^^^^^^^^^^
+
+When used with a SPI offload, the supported wiring configuration is:
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |    GP0/BUSY |-------->| TRIGGER     |
+    |          CS |<--------| CS          |
+    |             |         |             |
+    |     ADC     |         |     SPI     |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    |             |         |             |
+    |             |         +-------------+
+    |         CNV |<-----+--| PWM         |
+    |             |      +--| GPIO        |
+    +-------------+         +-------------+
+
+In this case, both the ``cnv-gpios`` and  ``pwms`` properties are required.
+The ``#trigger-source-cells = <2>`` property is also required to connect back
+to the SPI offload. The SPI offload will have ``trigger-sources`` property
+with cells to indicate the busy signal and which GPx pin is used, e.g
+``<&ad4695 AD4695_TRIGGER_EVENT_BUSY AD4695_TRIGGER_PIN_GP0>``.
+
+.. seealso:: `SPI offload support`_
+
 Channel configuration
 ---------------------
 
@@ -158,6 +188,27 @@ Unimplemented features
 - GPIO support
 - CRC support
 
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
+
+.. seealso:: `SPI offload wiring`_
+
+When SPI offload is being used, some attributes will be different.
+
+* ``trigger`` directory is removed.
+* ``in_voltage0_sampling_frequency`` attributes are added for setting the sample
+  rate.
+* ``in_voltage0_sampling_frequency_available`` attributes are added for querying
+  the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``in_voltage0_type`` attribute.
+
 Device buffers
 ==============
 
@@ -165,3 +216,20 @@ This driver supports hardware triggered buffers. This uses the "advanced
 sequencer" feature of the chip to trigger a burst of conversions.
 
 Also see :doc:`iio_devbuf` for more general information.
+
+Effective sample rate for buffered reads
+----------------------------------------
+
+When SPI offload is not used, the sample rate is determined by the trigger that
+is manually configured in userspace. All enabled channels will be read in a
+burst when the trigger is received.
+
+When SPI offload is used, the sample rate is configured per channel. All
+all channels will have the same rate, so only one ``sampling_frequency``
+attribute needs to be set. Since this rate determines the delay between each
+individual conversion, the effective sample rate for each sample is actually
+the sum of the periods of each enabled channel in a buffered read. In other
+words, it is the value of the ``sampling_frequency`` attribute divided by the
+number of enabled channels. So if 4 channels are enabled, with the
+``sampling_frequency`` attributes set to 1 MHz, the effective sample rate is
+250 kHz.

-- 
2.43.0


