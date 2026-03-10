Return-Path: <linux-pwm+bounces-8218-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP3fAwI+sGmohQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8218-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Mar 2026 16:51:30 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF14253FA4
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Mar 2026 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D94AF302AAC0
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Mar 2026 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C10A2E542C;
	Tue, 10 Mar 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avH+gqML"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660EA2DEA74;
	Tue, 10 Mar 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153149; cv=none; b=LtMjY2qUiIMAUa/DpVaS+tzIT/EtBW+qYE96TyCzQy47HPPVHAXw6dCl5HVX+hRSilYaDNLOpvzU7dhP+TCCKbsmduY92xX4yuq+Hue6bfm8S0NInVZydKJ+Vq3H+A7CdQO1UNHSOex5bestRcRED/ksN9qEYTaYoYPlwqlfqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153149; c=relaxed/simple;
	bh=XTq5FgDyNYGygpAXS2p6lA78kmdruf68ktHuf78FsKs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HfwbEeL+EUNJjx6p7xZkxD91WINu7ajZjoGcNjcSKsyoKHqTosPuX77mUVw77C4h6TTw1T5d2WbC2QhsilrjeojrTtKnIRqy5VP4dCmZjFUObL3yacVRZraFrq/oHzsNkxL8K8iDp+HFFqYUjwKcZ5oS6bNrw4lhGlTANvJCrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avH+gqML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4AE0C19423;
	Tue, 10 Mar 2026 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773153149;
	bh=XTq5FgDyNYGygpAXS2p6lA78kmdruf68ktHuf78FsKs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=avH+gqMLqVtrjIHeG5PSIK0HeFZIFjURCotvcA9TbspCOAWi/EwTvZ/DFX7zj+/KC
	 FRLzxygzmmO+2bXY1aCzMOkuOPCVH6UA//53DLHHSJyeH0QExz8+FDtbfAq/xLnJ8s
	 BMuF35Q+hk757FFnhTfXOaQa2pkLjOFG1KlPBstcPZvhfioDsbvw7ogowSVylAPiAV
	 lKTfxR+ziz+sfNArztCthEUU31c0zwdju9Sm1gwJ28d01zRlUq4Ks2Uuha1WqJ/b+y
	 tNdcyRyRCEmsTOr3j1i1tNEaBxc21niemJW5uCpWKtWBj9kIT8CPSvKFgIbWhl0920
	 5D+VySEpOMfqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34A1EB1050;
	Tue, 10 Mar 2026 14:32:28 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH v2 0/4] iio: adc: ad4691: add driver for AD4691
 multichannel SAR ADC family
Date: Tue, 10 Mar 2026 16:32:21 +0200
Message-Id: <20260310-ad4692-multichannel-sar-adc-driver-v2-0-d9bb8aeb5e17@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHUrsGkC/42Nyw6CMBBFf4V07Zg6VB6u/A/DorYjTAKtabHRE
 P7dQuLe5Tm5OXcRkQJTFJdiEYESR/YuAx4KYQbtegK2mQVKrGQpEbRVVYswvcaZt4WjEaIO2Ru
 wgRMFqBtSVimL6o4ih56BHvzeT25d5oHj7MNn/0ynzf7y53/y6QQSyrJCbHVjjamv2unR90fjJ
 9Gt6/oFOR1Og9UAAAA=
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
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773153147; l=4650;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=XTq5FgDyNYGygpAXS2p6lA78kmdruf68ktHuf78FsKs=;
 b=x1E7WWZUZ65zsrrNWOv6MlXJa/IPNwEbX7I95ZE44HRrO75ksj0VJW8l4zwTrYKyuwsKHuaPw
 d9Ax+bMZc86DTRZ8UTTLlQieRve2uESbRFMwjNgp/v96vHHqT5WQSc7
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: 3AF14253FA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8218-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
 drivers/iio/adc/ad4691.c                           | 1506 ++++++++++++++++++++
 include/dt-bindings/iio/adc/adi,ad4691.h           |   13 +
 6 files changed, 1723 insertions(+)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260302-ad4692-multichannel-sar-adc-driver-78e4d44d24b2

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>



