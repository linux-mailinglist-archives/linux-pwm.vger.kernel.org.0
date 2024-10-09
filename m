Return-Path: <linux-pwm+bounces-3556-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9C996501
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 11:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3405C2839D8
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D6B190685;
	Wed,  9 Oct 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1OQkTSKI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C618E03D
	for <linux-pwm@vger.kernel.org>; Wed,  9 Oct 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465590; cv=none; b=VbwcdM+ZQd9crrjbSCVFxz6gmCciTlr2QixRi6W1UkXgQsTLPl51nH358EZVjDwKYm9VUzcbccTyQyC1I4NFOCMMAVea/MDrZXXyreUAke4dR5sqhHt8dsRKLBrGTSuE3M2E58u7nNO/VXLXFWy6VuekttYCwzoQZr9phXYNwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465590; c=relaxed/simple;
	bh=issnyYMdCERRxnBv+UMpQ1OQfEwMp1TWqu/h+AKGhdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZACLHrKWCLLO/703G7lpB2k4nF3f2zJlV5ClgpOT8c+VFDG2awtfV0y2hA3AfI5jtFT7iiuCHkQT1BSSa3qIMsse0sLeju7YYBbukqyZXeKWcBGVGAW6voVKg3DMk30eviA8TDkJJ6iXxfo7FQjv/emmubuomxYvk3xm7kxvM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1OQkTSKI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so3278135e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2024 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728465585; x=1729070385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLAaXmEjWpRQwLJ98ZnYGrLU5C7IB5VjlX8gFYsob8k=;
        b=1OQkTSKI3NQF+XdbCG+ITEeI9zOSmzAW6IQ+SGwj8/SvJnSr7LY7dOeZ/GZfM0r4dS
         xNPEEkSq10T06pPvpFGxrE8DEsgqba76K/S8c0qbX47KVYEJbPXLolkGLFWrVEYIwc07
         floBt3BG1q5AaEV6ugX7JXuV53pihjJq9VV019iUrpxAM2izPYc2hf21Cn6errR2KS+K
         9wZhUP3MAD/Hd6j6DV4lZMIbJ0tDsm1HWG9ub3eekg4PCuAIg6QcKp8sIFTJiH9RWKf/
         SWS191BHVtbnuQUutaIIakbFHZRAEk/d2eZ4PeKkVf724qzCk4VJCj7A1E+LRtfvO6aE
         vlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728465585; x=1729070385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLAaXmEjWpRQwLJ98ZnYGrLU5C7IB5VjlX8gFYsob8k=;
        b=VMIt7gQGkWOwxwSdPIJDQqii9R/mGK2W1fy84v2wJirPeJZfbS1KGDecPhuVxK5d5y
         4HXHFn+fajANZ1oiolrwgR2qy+ahJLMzxyTib2QIxihKdfOhvBSrwdTshJUtSjJyepSf
         TGQJaFdHkRDjEP7r9dDiCWdGnYqg5IEVjd3KJSPWBPev/HyEmflxIbD0vVam+Hv9k3wI
         zMNiivhB+xb1OOliLVeH6VzYvw3nzVGvyJYj/0VF5WzHnB2xFDKp2nBHB2ev89H8RRLf
         zVSlhX9ryCJ6i00cffCI0wJZsLkbezf1n9yBeHXzA2JB1v/N/2Y0P9iBzk0yax52SKUB
         uVKw==
X-Gm-Message-State: AOJu0YwjLzPPnBsbC7/h8qApnJ04kZXAy9t7E7aaMD8FoUqCQdg25y+Z
	PaO4oE7JWa5w4PXrM1AhtJ3qolb3q2NebJfabCgRjgsqelmJCOp7ZT4nwS68u4k=
X-Google-Smtp-Source: AGHT+IGUlTEo7sclngMsjwjSVZGdoDLFF1EJ5qnB7fwjfP/3CKVPQ73LhZMLC32PTpf9nOijZ0bB/A==
X-Received: by 2002:a05:600c:3b9f:b0:42c:a6da:a149 with SMTP id 5b1f17b1804b1-430d6faa3cdmr11805775e9.25.1728465584877;
        Wed, 09 Oct 2024 02:19:44 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d59b1207sm13892765e9.31.2024.10.09.02.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:19:44 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Wed, 09 Oct 2024 09:19:34 +0000
Subject: [PATCH v4 3/8] Documentation: iio: Document ad7606 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-ad7606_add_iio_backend_support-v4-3-6971a8c0f1d5@baylibre.com>
References: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
In-Reply-To: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728465581; l=6859;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=issnyYMdCERRxnBv+UMpQ1OQfEwMp1TWqu/h+AKGhdM=;
 b=oTelQqwe4mpz3ws8GkoaPtVhvqWQ1G957SfIfa2zt56bvDBFx/qm6KcZO1cYhCuj52My7ijVt
 N0TUyY6v8CmC9aF2clnzwh68lxWDijqY21Y9Lcb/3jByy9xXgLPGfg8
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

The Analog Devices Inc. AD7606 (and similar chips) are complex ADCs that
will benefit from a detailed driver documentation.

This documents the current features supported by the driver.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/iio/ad7606.rst | 145 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 147 insertions(+)

diff --git a/Documentation/iio/ad7606.rst b/Documentation/iio/ad7606.rst
new file mode 100644
index 000000000000..a1173708b489
--- /dev/null
+++ b/Documentation/iio/ad7606.rst
@@ -0,0 +1,145 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD7606 driver
+=============
+
+ADC driver for Analog Devices Inc. AD7606 and similar devices. The module name
+is ``ad7606``.
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD7605 <https://www.analog.com/en/products/ad7605.html>`_
+* `AD7606 <https://www.analog.com/en/products/ad7606.html>`_
+* `AD7606B <https://www.analog.com/en/products/ad7606b.html>`_
+* `AD7616 <https://www.analog.com/en/products/ad7616.html>`_
+
+Supported features
+==================
+
+SPI wiring modes
+----------------
+
+These ADCs can output data on several SDO lines (1/2/4/8). The driver
+currently supports only 1 SDO line.
+
+Parallel wiring mode
+--------------------
+
+There is also a parallel interface, with 16 lines (that can be reduced to 8 in
+byte mode). The parallel interface is selected by declaring the device as
+platform in the device tree (with no io-backends node defined, see below).
+
+IIO-backend mode
+----------------
+
+This mode allows to reach the best sample rates, but it requires an external
+hardware (eg HDL or APU) to handle the low level communication.
+The backend mode is enabled when through the definition of the "io-backends"
+property in the device tree.
+
+The reference configuration for the current implementation of IIO-backend mode
+is the HDL reference provided by ADI:
+https://wiki.analog.com/resources/eval/user-guides/ad7606x-fmc/hdl
+
+This implementation embeds an IIO-backend compatible IP (adi-axi-adc) and a PWM
+connected to the conversion trigger pin.
+
+.. code-block::
+
+    +---+                                       +----------------------------
+    |   |               +-------+               |AD76xx
+    | A |  controls     |       |               |
+    | D |-------------->|  PWM  |-------------->| cnvst
+    | 7 |               |       |               |
+    | 6 |               +-------+               |
+    | 0 | controls  +-----------+-----------+   |
+    | 6 |---------->|           |           |<--| frstdata
+    |   |           | Backend   |  Backend  |<--| busy
+    | D |           | Driver    |           |   |
+    | R |           |           |           |-->| clk
+    | I |  requests |+---------+| DMA       |   |
+    | V |----------->|  Buffer ||<----      |<=>| DATA
+    | E |           |+---------+|           |   |
+    | R |           +-----------+-----------+   |
+    |   |-------------------------------------->| reset/configuration gpios
+    +---+                                       +-----------------------------
+
+
+Software and hardware modes
+---------------------------
+
+While all the AD7606/AD7616 series parts can be configured using GPIOs, some of
+them can be configured using register.
+
+The chips that support software mode have more values available for configuring
+the device, as well as more settings, and allow to control the range and
+calibration per channel.
+
+The following settings are available per channel in software mode:
+ - Scale
+
+Also, there is a broader choice of oversampling ratios in software mode.
+
+Conversion triggering
+---------------------
+
+The conversion can be triggered by two distinct ways:
+
+ - A GPIO is connected to the conversion trigger pin, and this GPIO is controlled
+   by the driver directly.  In this configuration, the driver sets back the
+   conversion trigger pin to high as soon as it has read all the conversions.
+
+ - An external source is connected to the conversion trigger pin. In the
+   current implementation, it must be a PWM. In this configuration, the driver
+   does not control directly the conversion trigger pin. Instead, it can
+   control the PWM's frequency. This trigger is enabled only for iio-backend.
+
+Reference voltage
+-----------------
+
+2 possible reference voltage sources are supported:
+
+ - Internal reference (2.5V)
+ - External reference (2.5V)
+
+The source is determined by the device tree. If ``refin-supply`` is present,
+then the external reference is used, otherwise the internal reference is used.
+
+Oversampling
+------------
+
+This family supports oversampling to improve SNR.
+In software mode, the following ratios are available:
+1 (oversampling disabled)/2/4/8/16/32/64/128/256.
+
+Unimplemented features
+----------------------
+
+- 2/4/8 SDO lines
+- CRC indication
+- Calibration
+
+Device buffers
+==============
+
+IIO triggered buffer
+--------------------
+
+This driver supports IIO triggered buffers, with a "built in" trigger, i.e the
+trigger is allocated and linked by the driver, and a new conversion is triggered
+as soon as the samples are transferred, and a timestamp channel is added to make
+up for the potential jitter induced by the delays in the interrupt handling.
+
+IIO backend buffer
+------------------
+
+When IIO backend is used, the trigger is not needed, and the sample rate is
+considered as stable. There is no timestamp channel. The communication is
+delegated to an external logic, called a backend, and the backend's driver
+handles the buffer. When this mode is enabled, the driver cannot control the
+conversion pin, because the busy pin is bound to the backend.
+
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index dfcf9618568a..88bc36326b74 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -21,6 +21,7 @@ Industrial I/O Kernel Drivers
    ad4000
    ad4695
    ad7380
+   ad7606
    ad7944
    adis16475
    adis16480
diff --git a/MAINTAINERS b/MAINTAINERS
index 6011af70c12e..e5e52cfd5fe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1561,6 +1561,7 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
 F:	Documentation/devicetree/bindings/iio/*/adi,*
 F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
 F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+F:	Documentation/iio/ad7606.rst
 F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc249*
 F:	drivers/iio/amplifiers/hmc425a.c

-- 
2.34.1


