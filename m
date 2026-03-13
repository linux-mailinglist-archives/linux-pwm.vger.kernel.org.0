Return-Path: <linux-pwm+bounces-8246-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLJFBvPhs2ktcQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8246-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:07:47 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FC1281162
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42E943010237
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46A388E68;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOQJrMbC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759B336E498;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773396461; cv=none; b=iFBXBUnwWNYbEki0jdsUvHTedyg2bVTqKPJMalfFZT1+cKwpKu+NZhsT5MjQEGNeSWgmkxTDvex/s0KqRqzpUfIvDwcq3H3sY3Kg193fKP+eRJtsof+Ws4RKm4zNQtBUxk6oPtFqDrRVs+EAmmNBqa6B3U+xHI3A2DHA/NxGuP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773396461; c=relaxed/simple;
	bh=OAr7/fKhE1uq3enpjNws49qkwM8Ys9veoC9OX+TLv3E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R3wV2za+3kLTMMfQnmYLc6xCPGaInfk2udfA3pcowFm8Crzwm0ssCofMlW8M7NxUU/ktqzleOZoSJaMlbhE5UI09TY6m3J2Fzbwz4Oh75wRYO+Kp6Ey+T/sDBMwVkwCButexMWXzLRCdOyW3wNaLUV1/wb/WWmvFgK6X71NLMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOQJrMbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 189A6C19424;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773396461;
	bh=OAr7/fKhE1uq3enpjNws49qkwM8Ys9veoC9OX+TLv3E=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tOQJrMbCB2uzv2mH5QR1EcncN4YwuUzR3wz3vwsbOyv0W0Wh1+U13MTjqR1bCBwdJ
	 YK7igwFQTlYILi01ZxpSJRJf53fWz1yqAMpkh3bTbG5+QJTtTH/YkeFrZKzMYGx3M4
	 8eFgQppyjYcHH8yh7j3QCUzRHrIWT0eMKy2HjLl9XXIIhE9az7/va57p0ANEq7K4+y
	 z1kOXiIakTbsslvmNKWw/AJzfMHFEBuk/4pKPLO6vgfVqbcchUnA07PeJhCvV+ixzL
	 qtYUaZ6Wr5dDMEyzC1S9lSLFZtq7pCk5BIYTct6kRZ8jigc7IN1qTZDS3rlECI+pIk
	 ovHf8coEUZrVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B55105F78C;
	Fri, 13 Mar 2026 10:07:41 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH v3 0/4] iio: adc: ad4691: add driver for AD4691
 multichannel SAR ADC family
Date: Fri, 13 Mar 2026 12:07:24 +0200
Message-Id: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANzhs2kC/43NywrCMBQE0F8pWRtJbtKXK/9DXORxbQO1kaQGp
 fTfTQuC7rqcYTgzk4jBYSSnYiYBk4vOjzmIQ0FMr8YOqbM5E2BQMcGAKiurFuj9OUxuXYw40Kh
 C7g21wSUMtG5QWiktSA0kQ4+AN/faTi7XnHsXJx/e22fia/vlyz184pRRISqAVjXWmPqsRjX47
 mj8nax+gh+Ts10mZNO2WjcKdYn831yW5QMkPimZKQEAAA==
X-Change-ID: 20260302-ad4692-multichannel-sar-adc-driver-78e4d44d24b2
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
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396456; l=5626;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=OAr7/fKhE1uq3enpjNws49qkwM8Ys9veoC9OX+TLv3E=;
 b=gmtQ0ppWkV5rnMisa38VpDqrJfXrxTPsSM0gQs7fHEjsKFaCxH19pKTRd6+5oXLDFsfckceiR
 bSlmr/QducdDreghb59a+XKP2IMJoFHfjYWzwe0m7MfTifoUXSTSMk4
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
	TAGGED_FROM(0.00)[bounces-8246-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,analog.com:mid,analog.com:replyto,analog.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23FC1281162
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for the Analog Devices AD4691 family of
high-speed, low-power multichannel successive approximation register
(SAR) ADCs with an SPI-compatible serial interface.

The family includes:
  - AD4691: 16-channel, 500 kSPS
  - AD4692: 16-channel, 1 MSPS
  - AD4693: 8-channel, 500 kSPS
  - AD4694: 8-channel, 1 MSPS

The devices support two operating modes, auto-detected from the device
tree:
  - CNV Clock Mode: external PWM drives CNV independently of SPI;
                    DATA_READY on GP0 signals end of conversion
  - Manual Mode: CNV tied to SPI CS; each SPI transfer reads
                 the previous conversion result and starts the
                 next (pipelined N+1 scheme)

A new driver is warranted rather than extending ad4695: the AD4691
data path uses an accumulator-register model — results are read from
AVG_IN registers, with ACC_MASK, ADC_SETUP, DEVICE_SETUP, and
GPIO_MODE registers controlling the sequencer — none of which exist
in AD4695. CNV Clock Mode (PWM drives CNV independently of SPI) and
Manual Mode (pipelined N+1 transfers) also have no equivalent in
AD4695's command-embedded single-cycle protocol.

The series is structured as follows:
  1/4 - DT bindings (YAML schema + dt-bindings header) and
        MAINTAINERS entry
  2/4 - Initial driver: register map via custom regmap callbacks,
        IIO read_raw/write_raw, both operating modes, single-channel
          reads via internal oscillator (Autonomous Mode)
  3/4 - Triggered buffer support: IRQ-driven (DATA_READY on GP0) for
        CNV Clock Mode; hrtimer-based trigger for Manual Mode to
        handle the pipelined N+1 SPI protocol
  4/4 - SPI Engine offload support: DMA-backed high-throughput
        capture path using the SPI offload subsystem

Datasheets:
  https://www.analog.com/en/products/ad4691.html
  https://www.analog.com/en/products/ad4692.html
  https://www.analog.com/en/products/ad4693.html
  https://www.analog.com/en/products/ad4694.html

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
Changes in v3:
- Replace GPIO reset handling with reset controller framework
- Replace two regmap_write() calls for ACC_MASK1/ACC_MASK2 with regmap_bulk_write()
- Move conv_us declaration closer to its first use
- Derive spi_device/dev from regmap instead of storing st->spi
- ad4691_trigger_handler(): use guard(mutex)() and iio_for_each_active_channel()
- ad4691_setup_triggered_buffer(): return -ENOMEM/-ENOENT directly instead of
  wrapping in dev_err_probe(); fix fwnode_irq_get() check (irq <= 0 → irq < 0)
- Add GENMASK defines for SPI offload 32-bit message layout; replace manual
  bit-shifts with put_unaligned_be32() + FIELD_PREP()
- Use DIV_ROUND_CLOSEST_ULL() instead of div64_u64()
- ad4691_set_sampling_freq(): fix indentation; drop unnecessary else after return
- ad4691_probe(): use PTR_ERR_OR_ZERO() for devm_spi_offload_get()
- Link to v2: https://lore.kernel.org/r/20260310-ad4692-multichannel-sar-adc-driver-v2-0-d9bb8aeb5e17@analog.com

Changes in v2:
- Drop adi,spi-mode DT property; operating mode now auto-detected
  from pwms presence (CNV Clock Mode if present, Manual Mode if not)
- Reduce from 5 operating modes to 2 (CNV Clock Mode, Manual Mode);
  Autonomous, SPI Burst and CNV Burst modes removed as user-selectable
  modes; Autonomous Mode is now the internal idle/single-shot state
- Single-shot read_raw always uses internal oscillator (Autonomous
  Mode), independent of the configured buffer mode
- Replace bulk regulator API with devm_regulator_get_enable() and
  devm_regulator_get_enable_read_voltage()
- Use guard(mutex) and IIO_DEV_ACQUIRE_DIRECT_MODE scoped helpers
- Replace enum + indexed chip_info array with named chip_info structs
- Remove product_id field and hardware ID check from probe
- Factor IIO_CHAN_INFO_RAW body into ad4691_single_shot_read() helper
- Use fwnode_irq_get(dev_fwnode(dev), 0); drop interrupt-names from
  DT binding
- Use devm_clk_get_enabled(dev, NULL); drop clock-names from DT
  binding
- Use spi_write_then_read() for DMA-safe register writes
- Use put_unaligned_be16() for SPI header construction
- fsleep() instead of usleep_range() in single-shot path
- storagebits 24->32 for manual-mode channels (uniform DMA layout)
- Collect full scan into vals[16], single iio_push_to_buffers_with_ts()
- Use pf->timestamp instead of iio_get_time_ns() in trigger handler
- Remove IRQF_TRIGGER_FALLING (comes from firmware/DT)
- Fix offload xfer array size ([17]: N channels + 1 state reset)
- Drop third DT binding example per reviewer request
- Link to v1: https://lore.kernel.org/r/20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com

---
Radu Sabau (4):
      dt-bindings: iio: adc: add bindings for AD4691 family
      iio: adc: ad4691: add initial driver for AD4691 family
      iio: adc: ad4691: add triggered buffer support
      iio: adc: ad4691: add SPI offload support

 .../devicetree/bindings/iio/adc/adi,ad4691.yaml    |  180 +++
 MAINTAINERS                                        |    9 +
 drivers/iio/adc/Kconfig                            |   14 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4691.c                           | 1505 ++++++++++++++++++++
 include/dt-bindings/iio/adc/adi,ad4691.h           |   13 +
 6 files changed, 1722 insertions(+)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260302-ad4692-multichannel-sar-adc-driver-78e4d44d24b2

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>



