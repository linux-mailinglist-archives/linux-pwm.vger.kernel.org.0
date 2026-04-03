Return-Path: <linux-pwm+bounces-8468-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MGLKbWez2kTyAYAu9opvQ
	(envelope-from <linux-pwm+bounces-8468-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 13:04:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D467D393863
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 13:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4A9A304DF0A
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2026 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FA83B0AE8;
	Fri,  3 Apr 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVnrjNHa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED423AE6E2;
	Fri,  3 Apr 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214188; cv=none; b=Qdu1s9vOnfOTifrCs6xArhEjLumrPu2rlVFJUmUM70BL8KlIvWRx17w0n2UyKIA+qLZiRJUtJh40YPjIBN7uoSSMfC9Vb0DrTDChsmqEvuP3BWTfvMCqyvPNM5CYLwfTl9EsXat/Ds5z2h0VOjPJpmOUzvyoP+oP6AAZrUhbcv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214188; c=relaxed/simple;
	bh=uhgBWfl9f8gzNv1shHuvmDDCXRFO7I7s2I3KVer6cq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNRfdDTOO2Rf4XWFPsH3TT2phKNqtARU8FgjNtglwU6afM951hBGSDtzzD6sWhpO5K1PxsgCPoIuEi8hyiD/r2k6C3j9NIeqq5OqpZpA0UADlHmVUYiv7DyUyULo7oGGVs2cUb9Fd+kUpQZv4OBifCK4GyohUPWdPYg+mzUFyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVnrjNHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E53FEC2BCB0;
	Fri,  3 Apr 2026 11:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775214188;
	bh=uhgBWfl9f8gzNv1shHuvmDDCXRFO7I7s2I3KVer6cq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cVnrjNHa+SqFqGhjHi4vZGcB830Jwkz/UII+ukAZTeaQmurjcctQLQxnLrS0+Zy6s
	 9xZ3dJo2LVOfok9GZn4QLO6IplNwPykKkvvuwV8afnyZG695Aj4E3mHQQQJIz5O19z
	 zihBInZBjPFc+khZD2i3PiqTYFP0waL3gGHL61KpJ2wrGumBW9TyHZqioL51w02Z4f
	 wbsWVrVB7H8rsVT2pGMelHUlsBHFGDxLWsjQXTRpBYjfrgWr+HBKiXT57j2jA46O0Z
	 EyX2qw4mu65Na70MHa1s+X7pKVHzSfDNoCF0NizIQz8NELNVYVM+N0cApb1ixXKEn+
	 iQaO+i37qtiyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD64CE7E371;
	Fri,  3 Apr 2026 11:03:07 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 03 Apr 2026 14:03:05 +0300
Subject: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
In-Reply-To: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775214183; l=31949;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=bJHEzsjCKXKfsUZ5HTlVDXo/fmS50jJCjI4jhbzYId4=;
 b=zzv2DNgtdYhsiwinhrqipkCtJ3ATy2iHgRL1+DzCiPSMT/3ji5JR4mSOzZKKZWb+HDIPnf4Zw
 IB8CmlzgCZ4B/v2NRuZH1DXe4pTiPzDlhYX2Sm1q+EoByM98FsWzCj+
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8468-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,analog.com:mid,analog.com:replyto,analog.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email]
X-Rspamd-Queue-Id: D467D393863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Radu Sabau <radu.sabau@analog.com>

Add SPI offload support to enable DMA-based, CPU-independent data
acquisition using the SPI Engine offload framework.

When an SPI offload is available (devm_spi_offload_get() succeeds),
the driver registers a DMA engine IIO buffer and uses dedicated buffer
setup operations. If no offload is available the existing software
triggered buffer path is used unchanged.

Both CNV Burst Mode and Manual Mode support offload, but use different
trigger mechanisms:

CNV Burst Mode: the SPI Engine is triggered by the ADC's DATA_READY
signal on the GP pin specified by the trigger-source consumer reference
in the device tree (one cell = GP pin number 0-3). For this mode the
driver acts as both an SPI offload consumer (DMA RX stream, message
optimization) and a trigger source provider: it registers the
GP/DATA_READY output via devm_spi_offload_trigger_register() so the
offload framework can match the '#trigger-source-cells' phandle and
automatically fire the SPI Engine DMA transfer at end-of-conversion.

Manual Mode: the SPI Engine is triggered by a periodic trigger at
the configured sampling frequency. The pre-built SPI message uses
the pipelined CNV-on-CS protocol: N+1 4-byte transfers are issued
for N active channels (the first result is discarded as garbage from
the pipeline flush) and the remaining N results are captured by DMA.

All offload transfers use 32-bit frames (bits_per_word=32, len=4) for
DMA word alignment. This patch promotes the channel scan_type from
storagebits=16 (triggered-buffer path) to storagebits=32 to match the
DMA word size; the triggered-buffer paths are updated to the same layout
for consistency. CNV Burst Mode channel data arrives in the lower 16
bits of the 32-bit word (shift=0); Manual Mode data arrives in the upper
16 bits (shift=16), matching the 4-byte SPI transfer layout
[data_hi, data_lo, 0, 0]. A separate ad4691_manual_channels[] array
encodes the shift=16 scan type for manual mode.

Add driver documentation under Documentation/iio/ad4691.rst covering
operating modes, oversampling, reference voltage, SPI offload paths,
and buffer data layout; register in MAINTAINERS and index.rst

Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 Documentation/iio/ad4691.rst | 259 ++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 drivers/iio/adc/Kconfig      |   1 +
 drivers/iio/adc/ad4691.c     | 422 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 676 insertions(+), 8 deletions(-)

diff --git a/Documentation/iio/ad4691.rst b/Documentation/iio/ad4691.rst
new file mode 100644
index 000000000000..36f0c841605a
--- /dev/null
+++ b/Documentation/iio/ad4691.rst
@@ -0,0 +1,259 @@
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
+reference voltage. Each channel independently exposes:
+
+* ``in_voltageN_raw`` — single-shot ADC result
+* ``in_voltageN_sampling_frequency`` — internal oscillator frequency used for
+  single-shot reads and CNV Burst Mode buffered captures
+* ``in_voltageN_sampling_frequency_available`` — list of valid oscillator
+  frequencies
+* ``in_voltageN_oversampling_ratio`` — per-channel hardware accumulation depth
+* ``in_voltageN_oversampling_ratio_available`` — list of valid ratios
+
+
+Operating modes
+===============
+
+The driver supports two operating modes, auto-detected from the device tree at
+probe time. Both modes transition to and from an internal Autonomous Mode idle
+state when the IIO buffer is enabled and disabled.
+
+Manual Mode
+-----------
+
+Selected when no ``pwms`` property is present in the device tree. The CNV pin
+is tied to the SPI chip-select: every CS assertion both triggers a new
+conversion and returns the result of the previous one (pipelined N+1 scheme).
+
+To read N channels the driver issues N+1 SPI transfers in a single optimised
+message:
+
+* Transfers 0 to N-1 each carry ``AD4691_ADC_CHAN(n)`` in the TX byte to
+  select the next channel; the RX byte of transfer ``k+1`` contains the result
+  of the channel selected in transfer ``k``.
+* Transfer N is a NOOP (0x00) to flush the last conversion result out of the
+  pipeline.
+
+The external IIO trigger (``pollfunc_store_time``) drives the trigger handler,
+which executes the pre-built SPI message and pushes the scan to the buffer.
+
+CNV Burst Mode
+--------------
+
+Selected when a ``pwms`` property is present in the device tree. The PWM drives
+the CNV pin independently of SPI at the configured conversion rate, and a GP
+pin (identified by ``interrupt-names``) asserts DATA_READY at end-of-burst to
+signal that the AVG_IN result registers are ready to be read.
+
+The IRQ handler stops the PWM, fires the IIO trigger, and the trigger handler
+reads all active ``AVG_IN(n)`` registers in a single optimised SPI message and
+pushes the scan to the buffer.
+
+The buffer sampling frequency (i.e. the PWM rate) is controlled by the
+``sampling_frequency`` attribute on the IIO buffer. Valid values span from the
+chip's minimum oscillator rate up to its maximum conversion rate
+(500 kSPS for AD4691/AD4693, 1 MSPS for AD4692/AD4694).
+
+Autonomous Mode (idle / single-shot)
+-------------------------------------
+
+The chip idles in Autonomous Mode whenever the IIO buffer is disabled. In this
+state, ``read_raw`` requests (``in_voltageN_raw``) use the internal oscillator
+to perform a single conversion on the requested channel and read back the
+result from the ``AVG_IN(N)`` register. The oscillator is started and stopped
+for each read to save power.
+
+
+Oversampling
+============
+
+Each channel has an independent hardware accumulator (ACC_DEPTH_IN) that
+averages a configurable number of successive conversions before DATA_READY
+asserts. The result is always returned as a 16-bit mean from the ``AVG_IN``
+register, so the IIO ``realbits`` and ``storagebits`` are unaffected by the
+oversampling ratio.
+
+Valid ratios are 1, 2, 4, 8, 16 and 32. The default is 1 (no averaging).
+
+.. code-block:: bash
+
+    # Set oversampling ratio to 16 on channel 0
+    echo 16 > /sys/bus/iio/devices/iio:device0/in_voltage0_oversampling_ratio
+
+When OSR > 1 the effective conversion rate for ``read_raw`` is reduced
+accordingly, since the driver waits for 2 × OSR oscillator periods before
+reading the result.
+
+
+Reference voltage
+=================
+
+The driver supports two reference configurations, mutually exclusive:
+
+* **External reference** (``ref-supply``): a voltage between 2.4 V and 5.25 V
+  supplied externally. The internal reference buffer is disabled.
+* **Buffered internal reference** (``refin-supply``): An internal reference
+  buffer is used. The driver enables ``REFBUF_EN`` in the REF_CTRL register
+  when this supply is used.
+
+Exactly one of ``ref-supply`` or ``refin-supply`` must be present in the
+device tree.
+
+The reference voltage determines the full-scale range:
+
+.. code-block::
+
+    full-scale = Vref / 2^16  (per LSB)
+
+
+LDO supply
+==========
+
+The chip contains an internal LDO that powers part of the analog front-end.
+The LDO input can be driven externally via the ``ldo-in-supply`` regulator. If
+that supply is absent, the driver enables the internal LDO path (``LDO_EN``
+bit in DEVICE_SETUP).
+
+
+Reset
+=====
+
+The driver supports two reset mechanisms:
+
+* **Hardware reset** (``reset-gpios`` in device tree): the GPIO is already
+  asserted at driver probe by the reset controller framework. The driver waits
+  for the required 300 µs reset pulse width and then deasserts.
+* **Software reset** (fallback when ``reset-gpios`` is absent): the driver
+  writes the software-reset pattern to the SPI_CONFIG_A register.
+
+
+GP pins and interrupts
+======================
+
+The chip exposes up to four general-purpose (GP) pins that can be configured as
+interrupt outputs. In CNV Burst Mode (non-offload), one GP pin must be wired to
+an interrupt-capable SoC input and declared in the device tree using the
+``interrupts`` and ``interrupt-names`` properties.
+
+The ``interrupt-names`` value identifies which GP pin is used (``"gp0"``
+through ``"gp3"``). The driver configures that pin as a DATA_READY output in
+the GPIO_MODE register.
+
+Example device tree fragment::
+
+    adc@0 {
+        compatible = "adi,ad4692";
+        ...
+        interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gpio0>;
+        interrupt-names = "gp0";
+    };
+
+
+SPI offload support
+===================
+
+When a SPI offload engine (e.g. the AXI SPI Engine) is present, the driver
+uses DMA-backed transfers for CPU-independent, high-throughput data capture.
+SPI offload is detected automatically at probe via ``devm_spi_offload_get()``;
+if no offload hardware is available the driver falls back to the software
+triggered-buffer path.
+
+Two SPI offload sub-modes exist, corresponding to the two operating modes:
+
+CNV Burst offload
+-----------------
+
+Used when a ``pwms`` property is present and SPI offload is available.
+
+The PWM drives CNV at the configured rate. On DATA_READY the SPI offload
+engine automatically executes a pre-built message that reads all active
+``AVG_IN`` registers and streams the data directly to an IIO DMA buffer with
+no CPU involvement. A final state-reset transfer re-arms DATA_READY for the
+next burst.
+
+The GP pin used as DATA_READY trigger is supplied by the trigger-source
+consumer (via ``#trigger-source-cells``) at buffer enable time; no
+``interrupt-names`` entry is required in this path.
+
+The buffer sampling frequency is controlled by the ``sampling_frequency``
+attribute on the IIO buffer (same as the non-offload CNV Burst path).
+
+Manual offload
+--------------
+
+Used when no ``pwms`` property is present and SPI offload is available.
+
+A periodic SPI offload trigger controls the conversion rate. On each trigger
+period, the SPI engine executes an N+1 transfer message (same pipelined scheme
+as software Manual Mode) and streams the data directly to the IIO DMA buffer.
+
+The ``sampling_frequency`` attribute on the IIO buffer controls the trigger
+rate (in Hz). The default is the chip's maximum conversion rate.
+
+
+Buffer data format
+==================
+
+The IIO buffer data format (``in_voltageN_type``) depends on the active path:
+
++-------------------------+-------------+-------------+-------+
+| Path                    | storagebits | realbits    | shift |
++=========================+=============+=============+=======+
+| Triggered buffer        | 16          | 16          | 0     |
++-------------------------+-------------+-------------+-------+
+| CNV Burst offload (DMA) | 32          | 16          | 0     |
++-------------------------+-------------+-------------+-------+
+| Manual offload (DMA)    | 32          | 16          | 16    |
++-------------------------+-------------+-------------+-------+
+
+In the triggered-buffer path the driver unpacks the 16-bit result in software
+before pushing to the buffer, so ``storagebits`` is 16.
+
+In the DMA offload paths the DMA engine writes 32-bit words directly into the
+IIO DMA buffer:
+
+* **CNV Burst offload**: the SPI engine reads AVG_IN registers with a 2-byte
+  address phase followed by a 2-byte data phase; the 16-bit result lands in
+  the lower half of the 32-bit word (``shift=0``).
+* **Manual offload**: each 32-bit SPI word carries the channel byte in the
+  first byte; the 16-bit result is returned in the upper half of the 32-bit
+  word (``shift=16``).
+
+The ``in_voltageN_type`` sysfs attribute reflects the active scan type.
+
+
+Unimplemented features
+======================
+
+* GPIO controller functionality of the GP pins
+* Clamp status and overrange events
+* Raw accumulator (ACC_IN) and accumulator status registers
+* ADC_BUSY and overrun status interrupts
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
index 24e4502b8292..875ea2455d91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1490,6 +1490,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
+F:	Documentation/iio/ad4691.rst
 F:	drivers/iio/adc/ad4691.c
 
 ANALOG DEVICES INC AD4695 DRIVER
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d498f16c0816..93f090e9a562 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -144,6 +144,7 @@ config AD4691
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index f2a7273e43b9..cc2138e47feb 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/device/devres.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/math.h>
@@ -22,10 +23,14 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
 #include <linux/units.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dma.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -40,6 +45,7 @@
 #define AD4691_VREF_4P096_uV_MAX		4500000
 
 #define AD4691_CNV_DUTY_CYCLE_NS		380
+#define AD4691_CNV_HIGH_TIME_NS			430
 
 #define AD4691_SPI_CONFIG_A_REG			0x000
 #define AD4691_SW_RESET				(BIT(7) | BIT(0))
@@ -92,6 +98,8 @@
 #define AD4691_ACC_IN(n)			(0x252 + (3 * (n)))
 #define AD4691_ACC_STS_DATA(n)			(0x283 + (4 * (n)))
 
+#define AD4691_OFFLOAD_BITS_PER_WORD		32
+
 static const char * const ad4691_supplies[] = { "avdd", "vio" };
 
 enum ad4691_ref_ctrl {
@@ -109,6 +117,31 @@ struct ad4691_chip_info {
 	unsigned int max_rate;
 };
 
+enum {
+	AD4691_SCAN_TYPE_NORMAL,         /* triggered buffer:  storagebits=16, shift=0  */
+	AD4691_SCAN_TYPE_OFFLOAD_CNV,    /* CNV burst offload: storagebits=32, shift=0  */
+	AD4691_SCAN_TYPE_OFFLOAD_MANUAL, /* manual offload:    storagebits=32, shift=16 */
+};
+
+static const struct iio_scan_type ad4691_scan_types[] = {
+	[AD4691_SCAN_TYPE_NORMAL] = {
+		.sign = 'u',
+		.realbits = 16,
+		.storagebits = 16,
+	},
+	[AD4691_SCAN_TYPE_OFFLOAD_CNV] = {
+		.sign = 'u',
+		.realbits = 16,
+		.storagebits = 32,
+	},
+	[AD4691_SCAN_TYPE_OFFLOAD_MANUAL] = {
+		.sign = 'u',
+		.realbits = 16,
+		.storagebits = 32,
+		.shift = 16,
+	},
+};
+
 #define AD4691_CHANNEL(ch)						\
 	{								\
 		.type = IIO_VOLTAGE,					\
@@ -122,11 +155,9 @@ struct ad4691_chip_info {
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
 		.channel = ch,						\
 		.scan_index = ch,					\
-		.scan_type = {						\
-			.sign = 'u',					\
-			.realbits = 16,					\
-			.storagebits = 16,				\
-		},							\
+		.has_ext_scan_type = 1,					\
+		.ext_scan_type = ad4691_scan_types,			\
+		.num_ext_scan_type = ARRAY_SIZE(ad4691_scan_types),	\
 	}
 
 static const struct iio_chan_spec ad4691_channels[] = {
@@ -221,6 +252,17 @@ static const struct ad4691_chip_info ad4694_chip_info = {
 	.max_rate = 1 * HZ_PER_MHZ,
 };
 
+struct ad4691_offload_state {
+	struct spi_offload *spi;
+	struct spi_offload_trigger *trigger;
+	u64 trigger_hz;
+	struct spi_message msg;
+	/* Max 16 channel xfers + 1 state-reset or NOOP */
+	struct spi_transfer xfer[17];
+	u8 tx_cmd[17][4];
+	u8 tx_reset[4];
+};
+
 struct ad4691_state {
 	const struct ad4691_chip_info *info;
 	struct regmap *regmap;
@@ -251,6 +293,8 @@ struct ad4691_state {
 	struct spi_transfer *scan_xfers;
 	__be16 *scan_tx;
 	__be16 *scan_rx;
+	/* NULL when no SPI offload hardware is present */
+	struct ad4691_offload_state *offload;
 	/* Scan buffer: one slot per channel plus timestamp */
 	struct {
 		u16 vals[16];
@@ -273,6 +317,46 @@ static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_num)
 				  AD4691_GP_MODE_DATA_READY << shift);
 }
 
+static const struct spi_offload_config ad4691_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
+static bool ad4691_offload_trigger_match(struct spi_offload_trigger *trigger,
+					 enum spi_offload_trigger_type type,
+					 u64 *args, u32 nargs)
+{
+	return type == SPI_OFFLOAD_TRIGGER_DATA_READY &&
+	       nargs == 1 && args[0] <= 3;
+}
+
+static int ad4691_offload_trigger_request(struct spi_offload_trigger *trigger,
+					  enum spi_offload_trigger_type type,
+					  u64 *args, u32 nargs)
+{
+	struct ad4691_state *st = spi_offload_trigger_get_priv(trigger);
+
+	if (nargs != 1)
+		return -EINVAL;
+
+	return ad4691_gpio_setup(st, (unsigned int)args[0]);
+}
+
+static int ad4691_offload_trigger_validate(struct spi_offload_trigger *trigger,
+					   struct spi_offload_trigger_config *config)
+{
+	if (config->type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct spi_offload_trigger_ops ad4691_offload_trigger_ops = {
+	.match    = ad4691_offload_trigger_match,
+	.request  = ad4691_offload_trigger_request,
+	.validate = ad4691_offload_trigger_validate,
+};
+
 static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct spi_device *spi = context;
@@ -553,10 +637,17 @@ static int ad4691_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->osr[chan->scan_index];
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
+	case IIO_CHAN_INFO_SCALE: {
+		const struct iio_scan_type *scan_type;
+
+		scan_type = iio_get_current_scan_type(indio_dev, chan);
+		if (IS_ERR(scan_type))
+			return PTR_ERR(scan_type);
+
 		*val = st->vref_uV / (MICRO / MILLI);
-		*val2 = chan->scan_type.realbits;
+		*val2 = scan_type->realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -856,6 +947,213 @@ static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_ops = {
 	.postdisable = &ad4691_cnv_burst_buffer_postdisable,
 };
 
+static int ad4691_manual_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct ad4691_offload_state *offload = st->offload;
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+	};
+	unsigned int bit, k;
+	int ret;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		return ret;
+
+	memset(offload->xfer, 0, sizeof(offload->xfer));
+
+	/*
+	 * N+1 transfers for N channels. Each CS-low period triggers
+	 * a conversion AND returns the previous result (pipelined).
+	 *   TX: [AD4691_ADC_CHAN(n), 0x00, 0x00, 0x00]
+	 *   RX: [data_hi, data_lo, 0x00, 0x00]   (shift=16)
+	 * Transfer 0 RX is garbage; transfers 1..N carry real data.
+	 */
+	k = 0;
+	iio_for_each_active_channel(indio_dev, bit) {
+		offload->tx_cmd[k][0] = AD4691_ADC_CHAN(bit);
+		offload->xfer[k].tx_buf = offload->tx_cmd[k];
+		offload->xfer[k].len = sizeof(offload->tx_cmd[k]);
+		offload->xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
+		offload->xfer[k].cs_change = 1;
+		offload->xfer[k].cs_change_delay.value = AD4691_CNV_HIGH_TIME_NS;
+		offload->xfer[k].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+		/* First transfer RX is garbage — skip it. */
+		if (k > 0)
+			offload->xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		k++;
+	}
+
+	/* Final NOOP to flush pipeline and capture last channel. */
+	offload->tx_cmd[k][0] = AD4691_NOOP;
+	offload->xfer[k].tx_buf = offload->tx_cmd[k];
+	offload->xfer[k].len = sizeof(offload->tx_cmd[k]);
+	offload->xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
+	offload->xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	k++;
+
+	spi_message_init_with_transfers(&offload->msg, offload->xfer, k);
+	offload->msg.offload = offload->spi;
+
+	ret = spi_optimize_message(spi, &offload->msg);
+	if (ret)
+		goto err_exit_conversion;
+
+	config.periodic.frequency_hz = offload->trigger_hz;
+	ret = spi_offload_trigger_enable(offload->spi, offload->trigger, &config);
+	if (ret)
+		goto err_unoptimize;
+
+	return 0;
+
+err_unoptimize:
+	spi_unoptimize_message(&offload->msg);
+err_exit_conversion:
+	ad4691_exit_conversion_mode(st);
+	return ret;
+}
+
+static int ad4691_manual_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct ad4691_offload_state *offload = st->offload;
+
+	spi_offload_trigger_disable(offload->spi, offload->trigger);
+	spi_unoptimize_message(&offload->msg);
+
+	return ad4691_exit_conversion_mode(st);
+}
+
+static const struct iio_buffer_setup_ops ad4691_manual_offload_buffer_setup_ops = {
+	.postenable = &ad4691_manual_offload_buffer_postenable,
+	.predisable = &ad4691_manual_offload_buffer_predisable,
+};
+
+static int ad4691_cnv_burst_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct ad4691_offload_state *offload = st->offload;
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+	};
+	unsigned int n_active = bitmap_weight(indio_dev->active_scan_mask,
+					      iio_get_masklength(indio_dev));
+	unsigned int bit, k;
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   bitmap_read(indio_dev->active_scan_mask, 0,
+				       iio_get_masklength(indio_dev)));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
+			   ~bitmap_read(indio_dev->active_scan_mask, 0,
+				iio_get_masklength(indio_dev)) & GENMASK(15, 0));
+	if (ret)
+		return ret;
+
+	iio_for_each_active_channel(indio_dev, bit) {
+		ret = regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(bit),
+				   st->osr[bit]);
+		if (ret)
+			return ret;
+	}
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		return ret;
+
+	memset(offload->xfer, 0, sizeof(offload->xfer));
+
+	/*
+	 * N transfers to read N AVG_IN registers plus one state-reset
+	 * transfer (no RX) to re-arm DATA_READY.
+	 *   TX: [reg_hi | 0x80, reg_lo, 0x00, 0x00]
+	 *   RX: [0x00, 0x00, data_hi, data_lo]   (shift=0)
+	 */
+	k = 0;
+	iio_for_each_active_channel(indio_dev, bit) {
+		unsigned int reg = AD4691_AVG_IN(bit);
+
+		offload->tx_cmd[k][0] = (reg >> 8) | 0x80;
+		offload->tx_cmd[k][1] = reg & 0xFF;
+		offload->xfer[k].tx_buf = offload->tx_cmd[k];
+		offload->xfer[k].len = sizeof(offload->tx_cmd[k]);
+		offload->xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
+		offload->xfer[k].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		if (k < n_active - 1)
+			offload->xfer[k].cs_change = 1;
+		k++;
+	}
+
+	/* State reset to re-arm DATA_READY for the next scan. */
+	offload->tx_reset[0] = AD4691_STATE_RESET_REG >> 8;
+	offload->tx_reset[1] = AD4691_STATE_RESET_REG & 0xFF;
+	offload->tx_reset[2] = AD4691_STATE_RESET_ALL;
+	offload->xfer[k].tx_buf = offload->tx_reset;
+	offload->xfer[k].len = sizeof(offload->tx_reset);
+	offload->xfer[k].bits_per_word = AD4691_OFFLOAD_BITS_PER_WORD;
+	k++;
+
+	spi_message_init_with_transfers(&offload->msg, offload->xfer, k);
+	offload->msg.offload = offload->spi;
+
+	ret = spi_optimize_message(spi, &offload->msg);
+	if (ret)
+		goto err_exit_conversion;
+
+	ret = ad4691_sampling_enable(st, true);
+	if (ret)
+		goto err_unoptimize;
+
+	ret = spi_offload_trigger_enable(offload->spi, offload->trigger, &config);
+	if (ret)
+		goto err_sampling_disable;
+
+	return 0;
+
+err_sampling_disable:
+	ad4691_sampling_enable(st, false);
+err_unoptimize:
+	spi_unoptimize_message(&offload->msg);
+err_exit_conversion:
+	ad4691_exit_conversion_mode(st);
+	return ret;
+}
+
+static int ad4691_cnv_burst_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct ad4691_offload_state *offload = st->offload;
+	int ret;
+
+	spi_offload_trigger_disable(offload->spi, offload->trigger);
+
+	ret = ad4691_sampling_enable(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   AD4691_SEQ_ALL_CHANNELS_OFF);
+	if (ret)
+		return ret;
+
+	spi_unoptimize_message(&offload->msg);
+
+	return ad4691_exit_conversion_mode(st);
+}
+
+static const struct iio_buffer_setup_ops ad4691_cnv_burst_offload_buffer_setup_ops = {
+	.postenable = &ad4691_cnv_burst_offload_buffer_postenable,
+	.predisable = &ad4691_cnv_burst_offload_buffer_predisable,
+};
+
 static ssize_t sampling_frequency_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
@@ -863,6 +1161,9 @@ static ssize_t sampling_frequency_show(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad4691_state *st = iio_priv(indio_dev);
 
+	if (st->manual_mode && st->offload)
+		return sysfs_emit(buf, "%llu\n", st->offload->trigger_hz);
+
 	return sysfs_emit(buf, "%u\n", (u32)(NSEC_PER_SEC / st->cnv_period_ns));
 }
 
@@ -883,6 +1184,20 @@ static ssize_t sampling_frequency_store(struct device *dev,
 	if (iio_buffer_enabled(indio_dev))
 		return -EBUSY;
 
+	if (st->manual_mode && st->offload) {
+		struct spi_offload_trigger_config config = {
+			.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+			.periodic = { .frequency_hz = freq },
+		};
+
+		ret = spi_offload_trigger_validate(st->offload->trigger, &config);
+		if (ret)
+			return ret;
+
+		st->offload->trigger_hz = config.periodic.frequency_hz;
+		return len;
+	}
+
 	ret = ad4691_set_pwm_freq(st, freq);
 	if (ret)
 		return ret;
@@ -968,10 +1283,23 @@ static irqreturn_t ad4691_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int ad4691_get_current_scan_type(const struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	if (!st->offload)
+		return AD4691_SCAN_TYPE_NORMAL;
+	if (st->manual_mode)
+		return AD4691_SCAN_TYPE_OFFLOAD_MANUAL;
+	return AD4691_SCAN_TYPE_OFFLOAD_CNV;
+}
+
 static const struct iio_info ad4691_info = {
 	.read_raw = &ad4691_read_raw,
 	.write_raw = &ad4691_write_raw,
 	.read_avail = &ad4691_read_avail,
+	.get_current_scan_type = &ad4691_get_current_scan_type,
 	.debugfs_reg_access = &ad4691_reg_access,
 };
 
@@ -1195,9 +1523,75 @@ static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
 					       &ad4691_manual_buffer_setup_ops);
 }
 
+static int ad4691_setup_offload(struct iio_dev *indio_dev,
+				struct ad4691_state *st,
+				struct spi_offload *spi_offload)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct ad4691_offload_state *offload;
+	struct dma_chan *rx_dma;
+	int ret;
+
+	offload = devm_kzalloc(dev, sizeof(*offload), GFP_KERNEL);
+	if (!offload)
+		return -ENOMEM;
+
+	offload->spi = spi_offload;
+	st->offload = offload;
+
+	if (st->manual_mode) {
+		offload->trigger =
+			devm_spi_offload_trigger_get(dev, offload->spi,
+						     SPI_OFFLOAD_TRIGGER_PERIODIC);
+		if (IS_ERR(offload->trigger))
+			return dev_err_probe(dev, PTR_ERR(offload->trigger),
+					     "Failed to get periodic offload trigger\n");
+
+		offload->trigger_hz = st->info->max_rate;
+	} else {
+		struct spi_offload_trigger_info trigger_info = {
+			.fwnode = dev_fwnode(dev),
+			.ops    = &ad4691_offload_trigger_ops,
+			.priv   = st,
+		};
+
+		ret = devm_spi_offload_trigger_register(dev, &trigger_info);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to register offload trigger\n");
+
+		offload->trigger =
+			devm_spi_offload_trigger_get(dev, offload->spi,
+						     SPI_OFFLOAD_TRIGGER_DATA_READY);
+		if (IS_ERR(offload->trigger))
+			return dev_err_probe(dev, PTR_ERR(offload->trigger),
+					     "Failed to get DATA_READY offload trigger\n");
+	}
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, offload->spi);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "Failed to get offload RX DMA channel\n");
+
+	if (st->manual_mode)
+		indio_dev->setup_ops = &ad4691_manual_offload_buffer_setup_ops;
+	else
+		indio_dev->setup_ops = &ad4691_cnv_burst_offload_buffer_setup_ops;
+
+	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							  IIO_BUFFER_DIRECTION_IN);
+	if (ret)
+		return ret;
+
+	indio_dev->buffer->attrs = ad4691_buffer_attrs;
+
+	return 0;
+}
+
 static int ad4691_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct spi_offload *spi_offload;
 	struct iio_dev *indio_dev;
 	struct ad4691_state *st;
 	int ret;
@@ -1232,6 +1626,13 @@ static int ad4691_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	spi_offload = devm_spi_offload_get(dev, spi, &ad4691_offload_config);
+	ret = PTR_ERR_OR_ZERO(spi_offload);
+	if (ret == -ENODEV)
+		spi_offload = NULL;
+	else if (ret)
+		return dev_err_probe(dev, ret, "Failed to get SPI offload\n");
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &ad4691_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1239,7 +1640,10 @@ static int ad4691_probe(struct spi_device *spi)
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
 
-	ret = ad4691_setup_triggered_buffer(indio_dev, st);
+	if (spi_offload)
+		ret = ad4691_setup_offload(indio_dev, st, spi_offload);
+	else
+		ret = ad4691_setup_triggered_buffer(indio_dev, st);
 	if (ret)
 		return ret;
 
@@ -1277,3 +1681,5 @@ module_spi_driver(ad4691_driver);
 MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4691 Family ADC Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMA_BUFFER");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

-- 
2.43.0



