Return-Path: <linux-pwm+bounces-8384-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGdvIWplxmnnJgUAu9opvQ
	(envelope-from <linux-pwm+bounces-8384-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 12:09:30 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A43431E8
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85AAC303A6D4
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD063E95AE;
	Fri, 27 Mar 2026 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT4GCK+J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B23E4C9C;
	Fri, 27 Mar 2026 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609688; cv=none; b=AGhzdoMTvxx8uma6NNj0E8CCU8R+u3IHiZuCQNLoFvB9PnEPERGCsb0HQ1rg9T+CswTAeYGH/PMPHTGy3b67uxKT45yIgVXoQhwaOvY6JUhSmELB5aIC8l8mJSxcWPrakrSri+sdny9Hi1e9IPFBWMRLVeyPeYR5VfPlFcgAMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609688; c=relaxed/simple;
	bh=WVehT+IHIA/FSGO2VDSTliaZHBQNzs6pbxw+M17zNHE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SGkvaFGCKJet7345JRS6Muln2bItd6IrsHs50tIGeWNl3XSoKOTljbX4OGSHvphFYABiS/MQwCnIm6RJpSYXjETbrbSIr/VQ8IGtRdLk9+V9Lx5bwIzPZfy+9ohMXc0iuXg6XH8iXt6PcQsRwl76F7S4dY8ccRhyPQnUjrxnE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT4GCK+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3795AC2BC86;
	Fri, 27 Mar 2026 11:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774609687;
	bh=WVehT+IHIA/FSGO2VDSTliaZHBQNzs6pbxw+M17zNHE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AT4GCK+Jt4Vg2VHAGFmGQKDUmrXDcKfJ9IsS3Xb/huKx5Fk/liw2b4xRa1nlDlltT
	 MlWUD6Z5+ffoOFLibkq3ovQZjPvS7/nMSh0m0bzqJ9b/T4l1RiP0ZahPZUym2lfd8K
	 cr6T1j/ccSHldb7BgcexWJSV57F7t2zgIrRZcfCqlN9QETIvEcX501NMaZ/T1//Cvx
	 mFe+1AzfDggwKWNutEaFSa/2aWhxTAE2m+rQRghoQvqlEQ4QhUtSS0YOVmpPw8L78V
	 0ln/JCU6Vl02OnGu9ZGYSIWJtF8O2gcKUVlFqMN8aDQZ2+p08YOl9TZMDMZfbWFpmy
	 R+jm4FhsrFZTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216FE10ED64A;
	Fri, 27 Mar 2026 11:08:07 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH v5 0/4] iio: adc: ad4691: add driver for AD4691
 multichannel SAR ADC family
Date: Fri, 27 Mar 2026 13:07:56 +0200
Message-Id: <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAxlxmkC/43Oz2rDMAwG8FcpPs/DluXE2WnvUXbwH601pMmwO
 9NR8u5TCoOMXoJO34f4SXdRqWSq4u1wF4VarnmeONiXg4hnP51I5sRZgIJOGQXSJ+wGkJfv8Zr
 XjYlGWX3hPspUcqMie0eYEBNgAMHQV6HPfHscOX5wPud6ncvP42bTa/vH2z1801JJYzqAwbsUY
 //uJz/Op9c4X8TqN9iYWu0ygc00hOA8BUv62TRb0+wyDZsBk8bktNdOP5m4MWHfn8imshC1sjy
 9/2cuy/ILkPyAmdEBAAA=
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
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
 Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774609685; l=10360;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=WVehT+IHIA/FSGO2VDSTliaZHBQNzs6pbxw+M17zNHE=;
 b=F6+j2C82xzjHQhYi5aDuklQz6J3utIZOO99CHsddkQ/6q4sxYjZmPrcg2Cu3RrlCDi7Pt8hQW
 TaIPl4+o0KMDeTGFnZtmj2aAauNmcoYAGsa6UzCs9bjr+8IaCN3bYY3
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8384-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 163A43431E8
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
  - CNV Burst Mode: external PWM drives CNV independently of SPI;
                    DATA_READY on a GP pin signals end of conversion
  - Manual Mode: CNV tied to SPI CS; each SPI transfer reads
                 the previous conversion result and starts the
                 next (pipelined N+1 scheme)

A new driver is warranted rather than extending ad4695: the AD4691
data path uses an accumulator-register model — results are read from
AVG_IN registers, with ACC_MASK, ADC_SETUP, DEVICE_SETUP, and
GPIO_MODE registers controlling the sequencer — none of which exist
in AD4695. CNV Burst Mode (PWM drives CNV independently of SPI) and
Manual Mode (pipelined N+1 transfers) also have no equivalent in
AD4695's command-embedded single-cycle protocol.

The series is structured as follows:
  1/4 - DT bindings (YAML schema) and MAINTAINERS entry
  2/4 - Initial driver: register map via custom regmap callbacks,
        IIO read_raw/write_raw, both operating modes, single-channel
        reads via internal oscillator (Autonomous Mode)
  3/4 - Triggered buffer support: IRQ-driven (DATA_READY on a GP pin
        selected via interrupt-names) for CNV Burst Mode; external IIO
        trigger for Manual Mode to handle the pipelined N+1 SPI protocol
  4/4 - SPI Engine offload support: DMA-backed high-throughput
        capture path using the SPI offload subsystem

Datasheets:
  https://www.analog.com/en/products/ad4691.html
  https://www.analog.com/en/products/ad4692.html
  https://www.analog.com/en/products/ad4693.html
  https://www.analog.com/en/products/ad4694.html

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
Changes in v5:
- Reorder datasheets numerically
- Fix interrupt-names: use enum with minItems/maxItems
- Remove if/then block requiring interrupts — driver detail, not hardware constraint
- Remove redundant .shift = 0 from channel macro
- Write max_rate comparison as 1 * HZ_PER_MHZ
- Invert set_sampling_freq loop to use continue
- Fix fsleep() line break; remove blank line in read_raw
- Reorder supply init: vio immediately after avdd
- Move comment rewrites and OSC_FREQ_REG condition into the base driver patch
- Add bit-15 READ comment in reg_read
- Rewrite ldo-in handling with cleaner if/else-if pattern
- Drop redundant refbuf_en = false; invert if (!rst) in reset
- Drop reset_control_assert() — GPIO already asserted at probe
- Use regmap_update_bits/assign_bits in config
- Remove tab-column alignment of state struct members
- Declare osc_freqs[] as const int, eliminating explicit casts
- Drop obvious AUTONOMOUS mode comment
- Rename ACC_COUNT_LIMIT → ACC_DEPTH_IN to match datasheet
- Use bitmap_weight()/bitmap_read() for active_scan_mask access;
  add #include <linux/bitmap.h>
- Fix channel macro line-continuation tab alignment
- Use IIO_CHAN_SOFT_TIMESTAMP(8) for 8-channel variants
- Use aligned_s64 ts in scan struct
- Add comment explaining start-index removal in set_sampling_freq
- Remove trailing comma after NULL in buffer_attrs[]
- Add IRQF_NO_AUTOEN rationale comment
- Remove unreachable manual_mode guards in sampling_frequency_show/store
- Remove st->trig; use indio_dev->trig directly
- Move max_speed_hz param to the offload patch where it is used
- Use DIV_ROUND_UP for CNV period; use compound pwm_state initializer
- Move offload fields into a separately allocated sub-struct
- Build TX words via u8* byte-fill; fixes sparse __be32 warnings
- Add three scan types (NORMAL/OFFLOAD_CNV/OFFLOAD_MANUAL) with
  get_current_scan_type; triggered buffer path uses storagebits=16
- Fix IIO_CHAN_INFO_SCALE: use iio_get_current_scan_type() for realbits
- Add MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER")
- Add Documentation/iio/ad4691.rst
- Link to v4: https://lore.kernel.org/r/20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com

Changes in v4:
- dt-bindings: add avdd-supply (required) and ldo-in-supply (optional);
  rename vref-supply → ref-supply, vrefin-supply → refin-supply;
  corrected reset-gpios polarity (active-high → active-low); remove
  clocks and pwm-names; extend interrupts to up to 4 GP pins with
  interrupt-names "gp0".."gp3"; reduce #trigger-source-cells to
  const: 1 (GP pin number); add gpio-controller / #gpio-cells = <2>;
  drop adi,ad4691.h header; update binding examples
- driver: rename CNV Clock Mode → CNV Burst Mode throughout
- driver: add avdd-supply (required) and ldo-in-supply; track ref vs.
  refin supply for REFBUF_EN; set LDO_EN in DEVICE_SETUP when ldo-in
  is present; add software reset fallback via SPI_CONFIG_A register
- driver: merge ACC_MASK1_REG / ACC_MASK2_REG into ACC_MASK_REG with
  a single ADDR_DESCENDING 16-bit SPI write
- driver: remove clocks usage; set PWM rate directly without ref clock
- driver: rename chip info structs (ad4691_chip_info etc.); rename
  *chip → *info in state struct; replace adc_mode enum with manual_mode
  bool; replace ktime sampling_period with u32 cnv_period_ns
- driver: move IIO_CHAN_INFO_SAMP_FREQ to info_mask_separate with an
  available list for the internal oscillator frequency
- driver: use regcache MAPLE instead of RBTREE
- triggered buffer: derive DATA_READY GP pin from interrupt-names in
  firmware ("gp0".."gp3") instead of assuming GP0
- triggered buffer: use regmap_update_bits for DEVICE_SETUP mode toggle
  to avoid clobbering LDO_EN when toggling MANUAL_MODE bit
- triggered buffer: split buffer setup ops into separate Manual and
  CNV Burst variants (mirrors offload path structure)
- SPI offload: promote channel storagebits from 16 to 32 to match DMA
  word size; introduce ad4691_manual_channels[] with shift=16 (data in
  upper 16 bits of the 32-bit word); update triggered-buffer paths to
  the same layout for consistency
- SPI offload: derive GP pin from trigger-source args[0] instead of
  hardcoding GP0; split offload buffer setup ops per mode
- replace put_unaligned_be32() + FIELD_PREP() with cpu_to_be32() and
  plain bit-shift ops for SPI offload message construction
- multiple reviewer-requested code style and correctness fixes
  (Andy Shevchenko, Nuno Sá, Uwe Kleine-König, David Lechner)
- Link to v3: https://lore.kernel.org/r/20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com

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
      dt-bindings: iio: adc: add AD4691 family
      iio: adc: ad4691: add initial driver for AD4691 family
      iio: adc: ad4691: add triggered buffer support
      iio: adc: ad4691: add SPI offload support

 .../devicetree/bindings/iio/adc/adi,ad4691.yaml    |  162 ++
 Documentation/iio/ad4691.rst                       |  259 +++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |    9 +
 drivers/iio/adc/Kconfig                            |   14 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4691.c                           | 1704 ++++++++++++++++++++
 7 files changed, 2150 insertions(+)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260302-ad4692-multichannel-sar-adc-driver-78e4d44d24b2

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>



