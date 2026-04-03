Return-Path: <linux-pwm+bounces-8466-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPQ9JHCez2kTyAYAu9opvQ
	(envelope-from <linux-pwm+bounces-8466-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 13:03:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 453EF3937AA
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 13:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4B8E3022F4F
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2026 11:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3677E3AE1BC;
	Fri,  3 Apr 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGRY/D5+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9137CD3A;
	Fri,  3 Apr 2026 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214188; cv=none; b=NKbbKlnyecNOHH1p2xJqeVtY019iddX2/alakY3xnsRw2L7AZD8dsY92qrdKmzV4oPSSV8/pCmkD9iRT7wZN0iLZ2ebY6dp48YqxJ9v1/qVVBhiiM+3fJAUKfAbLH8ZM5LjH7Mgk+PJbM1IJJC4lAvckG8j2Wq5QoPtyzkvw7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214188; c=relaxed/simple;
	bh=e8UCeVlyE7LiPTUQG7GWYv5hsUN5zhmvmrFc6kisRRg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iMViMwPVJwo7G2N9K52PXEPpJraeEwrZBkOFaeAeh+/ue2yllUb02efrc06BKT5yYBNQRygBm3TdPWmNNee7r8SuOh0lMdhWXO4zpncYjYjhIjj6jRaGIDgZQj5PqOrJDU7mbIPygmZrpP85bIhOvItyBKO0bRS+O7fFfc6iFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGRY/D5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 878A7C4CEF7;
	Fri,  3 Apr 2026 11:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775214187;
	bh=e8UCeVlyE7LiPTUQG7GWYv5hsUN5zhmvmrFc6kisRRg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DGRY/D5+l/D1FvlBzaQpn4+1oDbTXs8ArT6B9TaEmhaXx5+ikP0KYOy2GqsP/LAiz
	 TZCpRD9sempIlhAHMcOHHhTqaHTw6C66R5KSxcGzP7qsmV70DcWxPKFboUaEBo+aja
	 9md+Kx7tFaFhbDbzObC0YS5MKz394uBlgmGAoWocZNewAGGEivGuM9Tpk5tvo2XpzE
	 t7fIMk0alcJIey9PbKtVHvwLQ2QHQXevEg4K7M4NSDPM+XKbe3a6i/8YxI3mKPY6M3
	 YP308kQL/YKESxEIux0Xnd+f4Rn19eHftVWEvUrXvTFlGlr1HotZkhKPDbYVDe3bQY
	 SCyvu8mbg/jzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701E5E7E370;
	Fri,  3 Apr 2026 11:03:07 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH v6 0/4] iio: adc: ad4691: add driver for AD4691
 multichannel SAR ADC family
Date: Fri, 03 Apr 2026 14:03:01 +0300
Message-Id: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGaez2kC/43OTWrDMBAF4KsErauiGUmW3FXvUbLQzyQROHaQU
 pESfPfKgYKLN2ZW7zF8M09WKCcq7OPwZJlqKmkaW+jeDixc3HgmnmLLDAV2QgrkLqquR379Hu5
 p2Rhp4MXl1gcec6qUubGkolIRlUfWoFumU3q8jnwdW76kcp/yz+tmhaX94/UevgIXXMoOsXc2h
 mA+3eiG6fwepitb/IorE8QuE5sZe++tI68JtqZcm3KXKZvpVQQVLTiwsDHVysR9f6pmCo0BhG5
 j3MbUa9PsMnUzAU7G9pGU8fafOc/zL3WTeSwlAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775214183; l=11808;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=e8UCeVlyE7LiPTUQG7GWYv5hsUN5zhmvmrFc6kisRRg=;
 b=yDO84jXBRZUJFy3+VsC/jXtXAxgYjxFTUkc/0fmsLyob66sCxcan3Vgo2RH28Nzl2QStFh4Ft
 Bjzb1TMMcGTBJU1QHwkikxWlkid10T7aajbTtb+afeO3CUAaLrVyYn7
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8466-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 453EF3937AA
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
Changes in v6:
- Replace device.h with dev_printk.h + device/devres.h; add array_size.h
- Rename osc_freqs[] → osc_freqs_Hz[] with explicit [0xN] index designators
- Move loop variable into for() declaration in set_sampling_freq
- Convert multi-line block comment to single-line in single_shot_read
- Replace (u16)~ cast with ~BIT() & GENMASK(15, 0) for ACC_MASK_REG write;
  GENMASK(15, 0) is still needed, otherwise maximum value condition line
  in reg_write() would fail.
- Extract osc_idx/period_us temporaries in single_shot_read; add comment
- Use devm_regulator_bulk_get_enable() for avdd + vio supplies
- Reformat reset_gpio_probe() comment; remove (GPIOD_OUT_HIGH) detail
- Extract REF_CTRL value into temporary before regmap_update_bits
- Use regmap_assign_bits for OSC_FREQ_REG in config
- Remove ad4691_free_scan_bufs NULL assignments; they are not checked.
- Replace indio_dev->masklength with iio_get_masklength() throughout
- Fix spi_optimize_message error path to use goto err in preenable
- Add iio_buffer_enabled() guard in sampling_frequency_store and
  set_oversampling_ratio
- Move ad4691_gpio_setup call from ad4691_config into
  setup_triggered_buffer after IRQ lookup; remove duplicate
  fwnode_irq_get_byname loop
- Replace oversampling ratio search loop with is_power_of_2 + ilog2
- Link to v5: https://lore.kernel.org/r/20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com

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
 drivers/iio/adc/ad4691.c                           | 1685 ++++++++++++++++++++
 7 files changed, 2131 insertions(+)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260302-ad4692-multichannel-sar-adc-driver-78e4d44d24b2

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>



