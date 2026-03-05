Return-Path: <linux-pwm+bounces-8185-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFVsK412qWl77wAAu9opvQ
	(envelope-from <linux-pwm+bounces-8185-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:26:53 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F012211994
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B41DA308BCE1
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97E39D6C8;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaER0a5f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE453988F6;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713415; cv=none; b=lftklv5ynVZ+nUOYVhVXHQKHBOwEKoe3ScaemADU4hmyt5xg7yPFQzRLgg48lqnX6ZrG3VlOp46GKp/y6QJEYpoK9wXxAInmNx9GayQ0DM4fMxxNwR1TW1Cb53/lk5NSkwL6ueum7hs58sGjuKxnP4AZ6wijouQ4kyAzAs22mPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713415; c=relaxed/simple;
	bh=GU7IYmfFkVf9LKnTBKrEhEIX0CYJNEH8lftpyqFdpwc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aLHy7zO8yLmlCHyfebKU7iVTOlMU0ZzulqeHhswEwMDV3FBsgMNbrta1FoR6b3baUx/1GhQOiiv83rkqyixdyQJ64+DK9iohELbxQo5KbarrOQ1sxHC7ObBescgHydO0uSrEceDLMjlRtLGDt5sKwKuTF7Ih0EJ48HFr3CIkIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaER0a5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BF69C116C6;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772713415;
	bh=GU7IYmfFkVf9LKnTBKrEhEIX0CYJNEH8lftpyqFdpwc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=PaER0a5fuxkTxKv14afwqvMWGPVG3SYfani77x12cJIPlU2vKiYs5zFl+QL7tEENM
	 oQXuhQlqjn3VBfVPskMjRcePQ8yNSYvqSgXJukfA5QWixXU3jAOdK+OlWeEKF+dn7B
	 R2KiV0mpyDZEpABOvcV42i0fQhq5TlrF9qpVeJJepoe8eza9r751SX6aYdJrsmXjVb
	 oj0Ny993+4G2YGfFr9YzS7dInX72KHpQOkTrCghcWR2knwfWZ3Ougs3fbgJqCdhq/1
	 xkprORX4BlDh9JIxo2z0mjXSkjKHe0hcfexqEhL3g38/SfxWDctYV1YAnLzqRqLqnz
	 lLdQvM7XWN0tQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13727F3092C;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH 0/4] iio: adc: ad4691: add driver for AD4691 multichannel
 SAR ADC family
Date: Thu, 05 Mar 2026 14:23:26 +0200
Message-Id: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL51qWkC/x2NQQ6CQAxFr0K6pslQGxSuQlyMtGoTGEhHiQnh7
 o4u38/LfztkddMMfbWD62bZllSgqSsYnzE9FE0KAwVqwykQRuG2I5zf08t+RtIJc/Syjyhumzq
 eL8rCLMQ3gnK0ut7t848M1+P4Atc0p7h0AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772713413; l=2732;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=GU7IYmfFkVf9LKnTBKrEhEIX0CYJNEH8lftpyqFdpwc=;
 b=cQc9Kvw+BUYKQkx0T+kNtJWVcKc/VF/EXt4HxpoWTyDR1r2FotoX8J8Hd6hyYwOS8F5iP0tdN
 bJ/0spzUY+5CRaDPgwA1D5pWF6s2wkkVnZX6yzo3q5fb7lZSvuDr7Wz
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: 2F012211994
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-8185-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:email,analog.com:url,analog.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series adds support for the Analog Devices AD4691 family of
high-speed, low-power multichannel successive approximation register
(SAR) ADCs with an SPI-compatible serial interface.

The family includes:
  - AD4691: 16-channel, 500 kSPS
  - AD4692: 16-channel, 1 MSPS
  - AD4693: 8-channel, 500 kSPS
  - AD4694: 8-channel, 1 MSPS

The devices support five operating modes:
  - CNV Clock Mode:    external PWM drives CNV, samples at PWM rate
  - CNV Burst Mode:    PWM triggers bursts, internal oscillator drives
                       conversions within each burst
  - Autonomous Mode:   internal oscillator drives conversions,
                       software starts/stops via register write
  - SPI Burst Mode:    similar to Autonomous Mode but optimised for
                       SPI burst reads
  - Manual Mode:       CNV tied to SPI CS; each SPI transfer triggers
                       a conversion and returns the previous result
                       (pipelined);

The series is structured as follows:

  1/4 - DT bindings (YAML schema + dt-bindings header) and
        MAINTAINERS entry
  2/4 - Initial driver: register map via custom regmap callbacks,
        IIO read_raw/write_raw, all five operating modes, direct
        single-channel reads
  3/4 - Triggered buffer support: IRQ-driven (DATA_READY / BUSY on
        GP0) for non-Manual modes; hrtimer-based trigger for Manual
        Mode to handle the pipelined SPI protocol
  4/4 - SPI Engine offload support: DMA-backed high-throughput
        capture path using the SPI offload subsystem

Datasheets:
  https://www.analog.com/en/products/ad4691.html
  https://www.analog.com/en/products/ad4692.html
  https://www.analog.com/en/products/ad4693.html
  https://www.analog.com/en/products/ad4694.html

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
Radu Sabau (4):
      dt-bindings: iio: adc: add bindings for AD4691 family
      iio: adc: ad4691: add initial driver for AD4691 family
      iio: adc: ad4691: add triggered buffer support
      iio: adc: ad4691: add SPI offload support

 .../devicetree/bindings/iio/adc/adi,ad4691.yaml    |  278 +++
 MAINTAINERS                                        |    9 +
 drivers/iio/adc/Kconfig                            |   14 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4691.c                           | 2031 ++++++++++++++++++++
 include/dt-bindings/iio/adc/adi,ad4691.h           |   13 +
 6 files changed, 2346 insertions(+)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260302-ad4692-multichannel-sar-adc-driver-78e4d44d24b2

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>



