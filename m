Return-Path: <linux-pwm+bounces-9107-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO5DHCcgFGpjKAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9107-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 12:10:47 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 750205C912C
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 12:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F5593008C88
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 10:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274D349CED;
	Mon, 25 May 2026 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrJfqANA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8DB3451B3;
	Mon, 25 May 2026 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703813; cv=none; b=HIY4YWs0JgjztyZvWRzFidoKYO0tVM+4LbDcTA6CKui7uIOOrqwsXbIlay2h/oiUNy2p0BTdms8o8goKVdsb9GXXAgU3s9pN6OYz3g4l63QFNmPT7NZ7HqoXwLxrU47OGGu3xoirZ679i37aYsmJDDkudptEN9sXwvw5+batAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703813; c=relaxed/simple;
	bh=pQNu2xlleloQc/oJIVszUd8RXaJcV1q3jy3qy+cE3Dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rOXjqNLCBV0FmrBoYwGoj2y7cYomw8GOfe0d4R9+MCXzuQjQ1L+QgYPrfiJ/oXHulhjeZlapg8+iAicHkjsZR6kjQlRk+AuRzbMfCJuzDvLauIPYtgMEo7yAjp15AXa2sCYlieT4Yxu7jVwJIpnS2HzosdQP0fJwfhUpy40MURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrJfqANA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D4D4C2BCFF;
	Mon, 25 May 2026 10:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779703813;
	bh=pQNu2xlleloQc/oJIVszUd8RXaJcV1q3jy3qy+cE3Dg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VrJfqANAQ/yYou5CZWknFH2XZqbm5TcEsMTzAiUrePvZKrkKCCEyi91Ci9t2Vs+St
	 TJMz1ridjo/67dNzl9jStiYk4bgqseJhYDUhyKBom0Wcg29QwiVJOUNQa8Vfwf6hNj
	 hFmzsD1Cs4rFInT15W2CAH0nPlSLzVxrXSDavYDaKZwgAjUC6uiEoKyBgPgT6VngWP
	 sJK+hCn/1/3U1YAFXrDELwMGwp55HGsNAIUo0SdWarq0/6Q1tHC1DulDxidDVVThuP
	 Tzz+HTVXMV2dHKLQRkiSIuoosyebzV6TPy3evKediqIUVpTelufujn7bUTjG9lSmn5
	 YaPsPqbuQzy5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424ADCD5BD0;
	Mon, 25 May 2026 10:10:13 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 25 May 2026 13:10:15 +0300
Subject: [PATCH v13 6/6] docs: iio: adc: ad4691: add driver documentation
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260525-ad4692-multichannel-sar-adc-driver-v13-6-1b7626d3b35c@analog.com>
References: <20260525-ad4692-multichannel-sar-adc-driver-v13-0-1b7626d3b35c@analog.com>
In-Reply-To: <20260525-ad4692-multichannel-sar-adc-driver-v13-0-1b7626d3b35c@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
 Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779703810; l=9992;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=ehwgFuZ34Caajsb+Ayq3e7A4CqJo1K5DtYhNAHIum9A=;
 b=7XiuaAQtr6fSwYdafQbobvWmnfaLvUoa1JZFa0MNwhRK2Xe27ZKljBzNjpSt2mn8xHOot7f/m
 4/JDFDIjdHoB0BiQ9q6RclFQEZCBkrckWh2g0Yt48wi5YPaaqGlEN+v
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9107-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 750205C912C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Radu Sabau <radu.sabau@analog.com>

Add RST documentation for the AD4691 family ADC driver covering
supported devices, IIO channels, operating modes, oversampling,
reference voltage, LDO supply, reset, GP pins, SPI offload support,
and buffer data format.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 Documentation/iio/ad4691.rst | 226 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 228 insertions(+)

diff --git a/Documentation/iio/ad4691.rst b/Documentation/iio/ad4691.rst
new file mode 100644
index 000000000000..362baabed6b3
--- /dev/null
+++ b/Documentation/iio/ad4691.rst
@@ -0,0 +1,226 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4691 driver
+=============
+
+ADC driver for Analog Devices Inc. AD4691 family of multichannel SAR ADCs.
+The module name is ``ad4691``.
+
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD4691 <https://www.analog.com/en/products/ad4691.html>`_ — 16-channel, 500 kSPS
+* `AD4692 <https://www.analog.com/en/products/ad4692.html>`_ — 16-channel, 1 MSPS
+* `AD4693 <https://www.analog.com/en/products/ad4693.html>`_ — 8-channel, 500 kSPS
+* `AD4694 <https://www.analog.com/en/products/ad4694.html>`_ — 8-channel, 1 MSPS
+
+
+IIO channels
+============
+
+Each physical ADC input maps to one IIO voltage channel. The AD4691 and AD4692
+expose 16 channels (``voltage0`` through ``voltage15``); the AD4693 and AD4694
+expose 8 channels (``voltage0`` through ``voltage7``).
+
+All channels share a common scale (``in_voltage_scale``), derived from the
+reference voltage. Each channel exposes:
+
+* ``in_voltageN_raw`` — single-shot ADC result
+
+The following attributes are shared across all channels:
+
+* ``in_voltage_sampling_frequency`` — effective output rate, defined as the
+  internal oscillator frequency divided by the oversampling ratio. Writing this
+  attribute selects the nearest achievable rate for the current OSR; the value
+  read back reflects the actual rate after snapping to the closest valid
+  oscillator entry.
+* ``in_voltage_sampling_frequency_available`` — list of achievable effective
+  rates for the current oversampling ratio. The list updates dynamically when
+  the oversampling ratio changes.
+
+The following attributes are shared across all channels and only available in
+CNV Burst Mode:
+
+* ``in_voltage_oversampling_ratio`` — hardware oversampling depth applied to
+  all channels; see `Oversampling`_ below.
+* ``in_voltage_oversampling_ratio_available`` — valid ratios: 1, 2, 4, 8, 16,
+  32.
+
+
+Operating modes
+===============
+
+The driver supports two operating modes, selected automatically from the
+device tree at probe time.
+
+Manual Mode
+-----------
+
+Selected when no ``pwms`` property is present in the device tree. The CNV pin
+is tied to the SPI chip-select: every CS assertion triggers a conversion and
+returns the previous result. A user-defined IIO trigger (e.g. hrtimer trigger)
+drives the buffer.
+
+Oversampling is not supported in Manual Mode.
+
+CNV Burst Mode
+--------------
+
+Selected when a ``pwms`` property is present in the device tree. A PWM drives
+the CNV pin at the configured conversion rate. A GP pin wired to the SoC and
+declared in the device tree signals DATA_READY at the end of each burst,
+triggering a readout of all active channel results into the IIO buffer.
+
+The buffer output rate is controlled by the ``sampling_frequency`` attribute
+on the IIO buffer. In practice the PWM rate should be set low enough to allow
+the SPI readout to complete before the next conversion burst begins.
+
+Autonomous Mode (idle / single-shot)
+-------------------------------------
+
+When the IIO buffer is disabled, ``in_voltageN_raw`` reads perform a single
+conversion on the requested channel using the internal oscillator. The
+oscillator is started and stopped around each read to save power.
+
+
+Oversampling
+============
+
+In CNV Burst Mode a shared hardware accumulator averages a configurable number
+of successive conversions across all active channels. The result is always a
+16-bit mean, so the buffer data type (shown in ``buffer0/in_voltageN_type``)
+is unaffected by the oversampling ratio. Valid ratios are 1, 2, 4, 8, 16 and
+32; the default is 1 (no averaging). Oversampling is not supported in Manual
+Mode.
+
+.. code-block:: bash
+
+    # Set oversampling ratio to 16 (shared across all channels)
+    echo 16 > /sys/bus/iio/devices/iio:device0/in_voltage_oversampling_ratio
+
+    # Read the resulting effective sampling frequency
+    cat /sys/bus/iio/devices/iio:device0/in_voltage_sampling_frequency
+
+Writing ``in_voltage_oversampling_ratio`` stores the new shared depth and snaps
+the internal oscillator to the largest valid table entry that is both less than
+or equal to ``old_effective_rate × new_osr`` and evenly divisible by
+``new_osr``. This preserves an integer read-back of
+``in_voltage_sampling_frequency`` after the change and keeps the oscillator as
+close as possible to the previous effective rate.
+
+
+Reference voltage
+=================
+
+The driver supports two reference configurations, mutually exclusive:
+
+* **External reference** (``ref-supply``): a voltage between 2.4 V and 5.25 V
+  supplied externally.
+* **Buffered internal reference** (``refin-supply``): an internal reference
+  buffer is enabled by the driver.
+
+Exactly one of ``ref-supply`` or ``refin-supply`` must be present in the
+device tree. The reference voltage determines the full-scale range reported
+via ``in_voltage_scale``.
+
+
+LDO supply
+==========
+
+The chip contains an internal LDO that powers part of the analog front-end.
+The supply configuration is mutually exclusive:
+
+* **External VDD** (``vdd-supply``): an external 1.8 V supply is used directly;
+  the internal LDO is disabled.
+* **Internal LDO** (``ldo-in-supply``): the internal LDO is enabled and fed
+  from the ``ldo-in`` regulator. Use this when no external 1.8 V VDD is present.
+
+Exactly one of ``vdd-supply`` or ``ldo-in-supply`` must be provided.
+
+
+Reset
+=====
+
+The driver supports two reset mechanisms:
+
+* **Hardware reset** (``reset-gpios`` in device tree): the GPIO line is
+  asserted for at least 300 µs then deasserted at probe.
+* **Software reset** (fallback when ``reset-gpios`` is absent): written
+  automatically at probe.
+
+
+GP pins and interrupts
+======================
+
+The chip exposes up to four general-purpose (GP) pins. In CNV Burst Mode
+(non-offload), one GP pin must be wired to an interrupt-capable SoC input and
+declared in the device tree using the ``interrupts`` and ``interrupt-names``
+properties. The ``interrupt-names`` value identifies which GP pin is used
+(``"gp0"`` through ``"gp3"``).
+
+Example device tree fragment::
+
+    adc@0 {
+        compatible = "adi,ad4692";
+        ...
+        interrupt-parent = <&gpio0>;
+        interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "gp0";
+    };
+
+
+SPI offload support
+===================
+
+When a SPI offload engine (e.g. the AXI SPI Engine) is present, the driver
+uses DMA-backed transfers for CPU-independent, high-throughput data capture.
+SPI offload is detected automatically at probe; if no offload hardware is
+available the driver falls back to the software triggered-buffer path.
+
+Two SPI offload sub-modes exist:
+
+CNV Burst offload
+-----------------
+
+Used when a ``pwms`` property is present and SPI offload is available. The PWM
+drives CNV at the configured rate; on DATA_READY the offload engine reads all
+active channel results and streams them directly to the IIO DMA buffer with no
+CPU involvement. The GP pin used as DATA_READY trigger is supplied by the
+trigger-source consumer at buffer enable time; no ``interrupt-names`` entry is
+required.
+
+Manual offload
+--------------
+
+Used when no ``pwms`` property is present and SPI offload is available. A
+periodic SPI offload trigger controls the conversion rate and the offload engine
+streams results directly to the IIO DMA buffer.
+
+The ``sampling_frequency`` attribute on the IIO buffer controls the trigger
+rate (in Hz). The initial rate is 100 kHz.
+
+Oversampling is not supported in Manual Mode.
+
+
+Buffer data format
+==================
+
+The sample format in the IIO buffer depends on whether SPI offload is in use.
+
+Software triggered-buffer path (no SPI offload)
+------------------------------------------------
+
+Each active channel occupies one 16-bit big-endian slot (``storagebits=16``,
+``endianness=be``). Active channels are packed densely in scan-index order,
+followed by a 64-bit software timestamp appended by the IIO core.
+
+SPI offload path
+----------------
+
+Each active channel occupies one 16-bit CPU-native slot (``storagebits=16``,
+``endianness=cpu``). The SPI offload engine streams 16-bit words directly from
+the SPI Engine into the DMA buffer; no software timestamp is appended.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index ba3e609c6a13..007e0a1fcc5a 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -23,6 +23,7 @@ Industrial I/O Kernel Drivers
    ad4000
    ad4030
    ad4062
+   ad4691
    ad4695
    ad7191
    ad7380
diff --git a/MAINTAINERS b/MAINTAINERS
index 020c1ffae31b..3fbac296b667 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1488,6 +1488,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
+F:	Documentation/iio/ad4691.rst
 F:	drivers/iio/adc/ad4691.c
 
 ANALOG DEVICES INC AD4695 DRIVER

-- 
2.43.0



