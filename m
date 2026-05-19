Return-Path: <linux-pwm+bounces-9006-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULJlAdRVDGqUfgUAu9opvQ
	(envelope-from <linux-pwm+bounces-9006-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 14:21:40 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D9957E8DD
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 14:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8F2C302D0A6
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA54DA559;
	Tue, 19 May 2026 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu7k5ik/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E0F3A5E9F;
	Tue, 19 May 2026 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193242; cv=none; b=BFXAIp9aAtUihATMJVu9pdxqknbHm876XAvD68630PL9WNhn1/BeZJ80vQevuc2+CpgGcD0HWQd+ssPF3C/xD7VEA/veVomjk+7qGsDxP8VdLTtYiP721D9j+AwIEblAzEFw4E2HLj9BWVmX2c485jZTG7SvyBFKSZJwbKuP22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193242; c=relaxed/simple;
	bh=c1aSrKGs4jiS/VS3l//5UYP6lQRhmqFWQ2+T6vPfQMs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oJ0A0x3gaLPdu0IiNbictqn9NCq9BAGTPe/GKMUIrNeIwkLT3hkllpO4XrQ6v0tbR7liVShcpHrYbM0luHykb8xnL870BdZ/dsIxLi6lDx8mSQBQUakixP0r4dZV1/TAymBAU7MkDA+MoYRw4NaGEuc/r+psPIOu6snGfIGgRas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu7k5ik/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8FE4C2BCB3;
	Tue, 19 May 2026 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779193241;
	bh=c1aSrKGs4jiS/VS3l//5UYP6lQRhmqFWQ2+T6vPfQMs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Pu7k5ik/+f2o8CyZHgTJFDU6PNRJ7tGTpf9jzUM0Qlb2+dcrR2oeFuSsMFpS9NVvI
	 A4c1PxzBZGQEhWa9swKkh2uZzzLN7yTC1fPKeyZjLHNq4rzoLI1tUWhIKG2yEV8WTd
	 VzbgxxZz9mFmrUygnW3T9QPCSIbikARjaexKbwW29SiAL0jF9MRPDiNaCNMWCfeJ2I
	 oLyRBLOjnQ+d5Ml2eiEOcgD26Qi4NzC76LjQuZZOtXdLE79Xd4c7CaulMWFMk2jPDM
	 d64d8csjNtFHgZzf4v33NnWwzcXsq3j03mp7AP5Jx5U6vIgHS9G3Hwk/2RhH3sEXbK
	 qQg9oWNPOzxSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7EFCD5BA4;
	Tue, 19 May 2026 12:20:41 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH v12 0/6] iio: adc: ad4691: add driver for AD4691
 multichannel SAR ADC family
Date: Tue, 19 May 2026 15:20:21 +0300
Message-Id: <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIVVDGoC/43TzW7DIAwA4Fepch4TNiaQnfYe0w78OC1Sl0xJF
 22q+u4jlaYycUGcbKHPgM21W3lJvHYvh2u38JbWNE85AHw6dOHkpiOLFHOiQ4m9VBKFi9QPKD6
 +zpe075j4LFa35HwQcUkbL8JYpkgUkTx2GfpceEzf9ypv7zk+pfUyLz/3ohvs2T9et/AbCCmU6
 hEHZ2MI5tVN7jwfn8P80e3+hoUJssnEbMbBe+vYa4baVKWpmkyVTU8RKFpwYKEyqTCx7ZyUTak
 xgNR5GVeZujRNk6mzCTAaO0Qm421l9g+TZNvd+2yODp0Ep00grkxTmkOTafb3ZGV0pDhi0JVpC
 xP6JtNmMxBoHyXZ0anKHApTtfVouM8nkxqYRm/rWQL5QDVA29DnvguG0XswRKzqLgGUauNX2v8
 SO48mWo0u4D/1drv9Ajkp6eoiBAAA
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
 Radu Sabau <radu.sabau@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779193239; l=21909;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=c1aSrKGs4jiS/VS3l//5UYP6lQRhmqFWQ2+T6vPfQMs=;
 b=IiCZreUtbdfSxF9sfhQH3/PrlJzwnb1BTcwHwACntNzqHpLZ7pPbfUES2mH5uPIA2hnSS0Hfu
 Pjlz6LqLcJYAgX64WKteRyxU+m8AAaiJLhehuLOH9NwDfLxElvPJe0t
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9006-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,analog.com:url,analog.com:replyto,analog.com:mid,analog.com:email]
X-Rspamd-Queue-Id: 85D9957E8DD
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
  1/6 - DT bindings (YAML schema) and MAINTAINERS entry
  2/6 - Initial driver: register map via custom regmap callbacks,
        IIO read_raw/write_raw, both operating modes, single-channel
        reads via internal oscillator (Autonomous Mode)
  3/6 - Triggered buffer support: IRQ-driven (DATA_READY on a GP pin
        selected via interrupt-names) for CNV Burst Mode; external IIO
        trigger for Manual Mode to handle the pipelined N+1 SPI protocol
  4/6 - SPI Engine offload support: DMA-backed high-throughput
        capture path using the SPI offload subsystem
  5/6 - Per-channel oversampling ratio support for CNV Burst Mode
  6/6 - Driver documentation (Documentation/iio/ad4691.rst)

Datasheets:
  https://www.analog.com/en/products/ad4691.html
  https://www.analog.com/en/products/ad4692.html
  https://www.analog.com/en/products/ad4693.html
  https://www.analog.com/en/products/ad4694.html

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
Changes in v12:
- IIO_DEV_ACQUIRE_DIRECT_MODE moved from set_sampling_freq into write_raw
- enum ad4691_ref_ctrl: remove explicit values
- .sign = 'u' → .format = 'u' throughout — the field has a new name
- device_property_present(dev, "vdd-supply") / device_property_present(dev, "ref-supply")
  pattern instead of handling -ENODEV
- AD4691_STATE_RESET_ALL 0x01 → BIT(0)
- spi_device_id: use named initializers instead of (kernel_ulong_t)&... cast
- ad4691_reset: 300 µs sleep belongs after reset_control_deassert, not
  between assert and deassert — actual RESETL minimum time (~10 ns) is
  covered by overhead; add post-deassert sleep
- Add guard(mutex)(&st->lock) in get_sampling_freq
- Don't register or attach iio_trigger in manual mode
- Remove the if (i >= indio_dev->num_channels - 1) break guards
- ad4691_read_scan return type → void
- Remove (u16) cast: st->scan_tx[k] = AD4691_ADC_CHAN(bit) << 8
- sizeof(st->scan_tx[k]) → sizeof(*st->scan_tx)
- Remove & from iio_buffer_setup_ops in offload structs
- Add args[0] <= 3 check in ad4691_offload_trigger_request
- Embed offload, offload_trigger, trigger_hz directly in struct ad4691_state
- Link to v11: https://lore.kernel.org/r/20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com

Changes in v11:
- initial driver: fix commit message — IIO_CHAN_INFO_SAMP_FREQ is
  info_mask_separate throughout the series, not info_mask_shared_by_all
- initial driver: readable_reg / volatile_reg: replace open switch ranges
  for multi-byte sparse arrays with stride checks; intermediate (unaligned)
  addresses are now excluded so debugfs cannot trigger cross-boundary reads
- initial driver: add comment in ad4691_get_sampling_freq noting that
  AD4691_OSC_FREQ_REG is non-volatile and served from regcache; no lock
  is needed
- triggered buffer: restore .endianness = IIO_BE on AD4691_CHANNEL
  scan_type; accidentally dropped in v10
- triggered buffer: add early break in both iio_for_each_active_channel
  loops to skip the soft timestamp scan index; prevents out-of-bounds
  writes into scan_tx[] and scan_xfers[]
- triggered buffer: fix DMA aliasing in manual mode preenable — set
  rx_buf = NULL for the first transfer (pipeline residual) instead of
  aliasing it to vals[0] alongside the second transfer
- triggered buffer: add cs_change_delay of 430 ns on channel transfers
  to satisfy the minimum CNV high time requirement
- triggered buffer: remove cs_change=1 from the state-reset transfer;
  must not be set on the final transfer of a SPI message
- triggered buffer: move enable_irq() from the trigger handler into a
  reenable callback on ad4691_trigger_ops, closing the race between
  enable_irq and iio_trigger_notify_done; fix reenable return type
  (void, not int)
- triggered buffer: use two separate iio_info structs so that
  validate_trigger (iio_validate_own_trigger) is enforced only in CNV
  burst mode; manual mode must accept external triggers
- triggered buffer: add comment explaining STATE_RESET_ALL sequencing
  in CNV burst mode
- triggered buffer: fix STD_SEQ_CONFIG write in both preenable paths —
  apply & GENMASK(15, 0) to strip the soft timestamp bit before writing,
  matching the existing acc_mask computation
- oversampling: fix commit message — writing oversampling_ratio snaps
  target_osc_freq_Hz to preserve integer sampling_frequency read-back;
  the two attributes are not orthogonal
- docs: add missing Buffer data format section covering the __be16
  software path and the CPU-native offload DMA path
- Link to v10: https://lore.kernel.org/r/20260511-ad4692-multichannel-sar-adc-driver-v10-0-e1fbb1744e38@analog.com

Changes in v10:
- initial driver: depends on REGULATOR || COMPILE_TEST
- triggered buffer: fix vals[] layout — index vals[] with slot counter k,
  not channel index i; fixes sparse active_scan_mask producing garbage in
  userspace buffer
- triggered buffer: add comment to cnv_burst_buffer_postenable explaining
  why sampling_enable()/enable_irq() cannot be called from preenable
- triggered buffer + offload: scan_tx changed from __be16 to u16;
  non-offload path uses put_unaligned_be16() (bits_per_word=8); offload
  path uses plain native u16 assignments (bits_per_word=16); also fixes
  byte-order bug in manual preenable: command byte was in the low byte,
  now correctly shifted to the high byte
- oversampling: remove incorrect iio_for_each_active_channel() timestamp
  guards; active_scan_mask never includes the timestamp channel
- Link to v9: https://lore.kernel.org/r/20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com

Changes in v9:
- devm_regulator_get_enable() → devm_regulator_get_enable_optional() for
  vdd-supply. The non-optional variant silently returns a dummy regulator
  (ret=0) when the supply is absent from DT, so st->ldo_en was never set
  and the internal LDO was never enabled when only ldo-in-supply was provided.
- struct ad4691_channel_info (factoring channels + num_channels out of
  struct ad4691_chip_info into a sw_info pointer) is now introduced in
  commit 1 instead of commit 2. It is a pure struct cleanup with no
  relation to triggered buffers.
- channels and manual_channels fields in struct ad4691_channel_info
  are now annotated with __counted_by_ptr(num_channels).
- Link to v8: https://lore.kernel.org/r/20260416-ad4692-multichannel-sar-adc-driver-v8-0-c415bd048fa3@analog.com

Changes in v8:
- dt-bindings: add commit message note explaining why four separate
  compatible strings are required (channel count and max rate both
  differ between variants);
- initial driver: sizeof(tx) instead of literal 2 in ad4691_reg_read;
  U8_MAX/U16_MAX instead of 0xFF/0xFFFF in ad4691_reg_write
- initial driver: extract ad4691_samp_freq_start() helper
- initial driver: fix regulator model — vdd-supply (external 1.8V,
  internal LDO disabled) and ldo-in-supply (feeds internal LDO) are
  mutually exclusive; add vdd-supply to binding and driver
- initial driver: add comment in ad4691_reset explaining why
  devm_reset_control_get_optional_exclusive_deasserted() cannot be
  used (datasheet requires ≥300 µs reset pulse)
- initial driver: REF_CTRL and OSC_FREQ_REG: regmap_update_bits /
  regmap_assign_bits → regmap_write (reserved bits are 0 at reset)
- initial driver: use dev instead of &spi->dev in devm_iio_device_alloc
- triggered buffer: scan_tx: add __aligned(IIO_DMA_MINALIGN);
  scan struct: IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, vals, 16)
- triggered buffer: full memset of scan_xfers and scan_tx in both
  preenable functions; move buffer-dma.h / buffer-dmaengine.h to
  commit 4; spi_optimize_message fail path: return ret directly in
  cnv_burst_buffer_preenable; reduce devm_iio_trigger_alloc wrapping
- SPI offload: drop AD4691_OFFLOAD_BITS_PER_WORD; use local
  bpw = channels[0].scan_type.realbits; num_channels: ARRAY_SIZE - 1
- SPI offload: rename offload_state.spi → .offload; remove spurious
  STD_SEQ_CONFIG write from cnv_burst_offload predisable; extract
  local acc_mask variable for ACC_MASK_REG write
- SPI offload: sampling_frequency_store: IIO_DEV_ACQUIRE_DIRECT_MODE
  for auto-release; remove explicit iio_device_release_direct calls
- oversampling: in_voltageN_sampling_frequency now represents the
  effective output rate (osc_freq / osr[N]), matching ad4695
- oversampling: in_voltageN_sampling_frequency_available computed
  dynamically from the channel's current OSR; only oscillator entries
  divisible by osr[N] shown as effective rates; list becomes sparser
  as OSR increases, capping at max_rate / osr[N]
- oversampling: writing sampling_frequency snaps down to the largest
  oscillator entry ≤ freq * osr[N] that is divisible by osr[N],
  guaranteeing integer read-back; writing oversampling_ratio stores
  the new depth only — target_osc_freq_Hz unchanged; the two
  attributes are orthogonal
- oversampling: ad4691_write_osc_freq() called from
  ad4691_enter_conversion_mode() after manual mode early return,
  covering all CNV burst buffer enable paths
- oversampling: (osr + 1) oscillator period wait in single_shot_read
  (osr for accumulation, +1 pipeline margin)
- docs: new commit — Documentation/iio/ad4691.rst, userspace-facing
  only; oversampling section describes effective-rate SF semantics;
  LDO supply section corrected (vdd-supply vs ldo-in-supply)
- Link to v7: https://lore.kernel.org/r/20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com

Changes in v7:
- Fix CNV burst triggered-buffer preenable: the state-reset value
  transfer had tx_buf assigned the return value of cpu_to_be16()
  (an integer) instead of a pointer to a buffer, which would cause
  a kernel oops on buffer enable; extend scan_tx[] from 17 to 18
  entries to hold the extra slot and fix the pointer assignment
- Extend memset in ad4691_cnv_burst_buffer_preenable to cover the
  two state-reset transfer slots (previously left with stale data
  across buffer enable/disable cycles if the active channel count
  changed)
- Fix format specifier %u -> %lu for NSEC_PER_SEC in
  sampling_frequency_show (NSEC_PER_SEC is unsigned long on 32-bit)
- Fix missing iio_device_release_direct() on spi_offload_trigger_-
  validate() error path in sampling_frequency_store
- Correct SPI offload commit message: the implementation uses 16-bit
  SPI frames (bits_per_word=16, len=2), not 32-bit; storagebits
  remains 16 (not promoted to 32); there is no shift=16 for manual
  mode; ad4691_manual_channels[] hides IIO_CHAN_INFO_OVERSAMPLING_-
  RATIO (not applicable in manual mode), not encodes shift=16
- Link to v6: https://lore.kernel.org/r/20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com

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
Radu Sabau (6):
      dt-bindings: iio: adc: add AD4691 family
      iio: adc: ad4691: add initial driver for AD4691 family
      iio: adc: ad4691: add triggered buffer support
      iio: adc: ad4691: add SPI offload support
      iio: adc: ad4691: add oversampling support
      docs: iio: adc: ad4691: add driver documentation

 .../devicetree/bindings/iio/adc/adi,ad4691.yaml    |  180 ++
 Documentation/iio/ad4691.rst                       |  226 +++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |    9 +
 drivers/iio/adc/Kconfig                            |   16 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4691.c                           | 2099 ++++++++++++++++++++
 7 files changed, 2532 insertions(+)
---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260302-ad4692-multichannel-sar-adc-driver-78e4d44d24b2

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>



