Return-Path: <linux-pwm+bounces-9538-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XdUbFxLVR2rWfwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9538-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 17:28:18 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CB5703DC7
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 17:28:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=jP75NKZs;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9538-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9538-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E97F3308C670
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE15414DF7;
	Fri,  3 Jul 2026 15:22:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E7414DF2;
	Fri,  3 Jul 2026 15:22:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092154; cv=none; b=q1DF0jhEY0beJ3CAcOrjcBVzzKKbE9NgFfCY4/8nERHzaIdT2TK2pPKJYJCQuEtRX1HfIpb5DbBmb2slR4iSgHlyoJkIy1GCFZk5T8uFkJxFB/1dIgw+zaOsJBRHTLPuatnIezTQdXFYzcqj8zN0ekdrU1XUftsqrOOsveBvndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092154; c=relaxed/simple;
	bh=o6qYyClYJFUhN8SqkfwWXv6Xh9TUxilTNZ7qbfwufLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3tVzjT24tvOUYnGN3/d79aO84+1o/tWAKOcnlWa3hFfAMu3E1hm/a/VHommCokYsS5vp+hta3ko78ubI8OOdDCVo3DxUIfX7mHalLV25/NOemy799w7BZnpeOkyZnYVUCs99ZioTj3d9HInPPgvwWYR1WVlJJkTOUtkTZZLkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jP75NKZs; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 29ACA1A0E1F;
	Fri,  3 Jul 2026 15:22:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E338160300;
	Fri,  3 Jul 2026 15:22:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58C01104C952E;
	Fri,  3 Jul 2026 17:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783092148; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=GL/PEBpDRjNofqSclIW36EdkzsUZczRz8DzmZfGvPwM=;
	b=jP75NKZsLJ/JammBfF5BPYS43hPWKLJPaZFkNZXjxuysm/XKJbVF/NG4ZawS74KU/FLxNz
	/y+4SJAEkAS4RPaEXpq47pzFmQzdR6hjaShd0I9uyfiT9jq6LexziQ/ZoyPHPinBV0EufL
	F4mDzo/w4VjAvWMkGlmopm2yk5XAwrSu7hT+J091pRkqiO8JtqkFJXT2S7kZ8UZhtw6i5y
	nRXDdgqHLfGNnkVqXHPOHbTnh6d6fBvJkUF+XFI0l9D4A3jECqWgVJCSrWUZ6atyOx6hz9
	50tEQidDdy2DZ8qiOmIyRxFj10xS7v3Xs04k3DGPxc1ug0DfuiW0iKHqKtrGng==
From: Richard Genoud <richard.genoud@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	John Stultz <jstultz@google.com>,
	Joao Schim <joao@schimsalabim.eu>,
	bigunclemax@gmail.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v7 0/4] Introduce Allwinner H616 PWM controller
Date: Fri,  3 Jul 2026 17:22:11 +0200
Message-ID: <20260703152215.192859-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9538-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:paulk@sys-base.io,m:thomas.petazzoni@bootlin.com,m:jstultz@google.com,m:joao@schimsalabim.eu,m:bigunclemax@gmail.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:richard.genoud@bootlin.com,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org,pengutronix.de,baylibre.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sys-base.io,bootlin.com,google.com,schimsalabim.eu,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75CB5703DC7

Allwinner H616 PWM controller is quite different from the A10 one.

It can drive 6 PWM channels, and like for the A10, each channel has a
bypass that permits to output a clock, bypassing the PWM logic, when
enabled.

But, the channels are paired 2 by 2, sharing a first set of
MUX/prescaler/gate.
Then, for each channel, there's another prescaler (that will be bypassed
if the bypass is enabled for this channel).

It looks like that:
            _____      ______      ________
OSC24M --->|     |    |      |    |        |
APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
           |_____|    |______|    |________|
                          ________
                         |        |
                      +->| /div_k |---> PWM_clock_x
                      |  |________|
                      |    ______
                      |   |      |
                      +-->| Gate |----> PWM_bypass_clock_x
                      |   |______|
PWM_clock_src_xy -----+   ________
                      |  |        |
                      +->| /div_k |---> PWM_clock_y
                      |  |________|
                      |    ______
                      |   |      |
                      +-->| Gate |----> PWM_bypass_clock_y
                          |______|

Where xy can be 0/1, 2/3, 4/5

As this is quite complex for a PWM, the Common Clock Framework is
leverage to deal with that and not reinvent the wheel.

PWM_clock_x/y serve for the PWM purpose.
PWM_bypass_clock_x/y serve for the clock-provider purpose.
The common clock framework has been used to manage those clocks.

This PWM driver serves as a clock-provider for PWM_bypass_clocks.
This is needed for example by the embedded AC300 PHY which clock comes
from PMW5 pin (PB12).

Usually, to get a clock from a PWM driver, we use the pwm-clock driver
so that the PWM driver doesn't need to be a clk-provider itself.
While this works in most cases, here it just doesn't.
That's because the pwm-clock request a period from the PWM driver,
without any clue that it actually wants a clock at a specific frequency,
and not a PWM signal with duty cycle capability.
So, the PWM driver doesn't know if it can use the bypass or not, it
doesn't even have the real accurate frequency information (23809524 Hz
instead of 24MHz) because PWM drivers only deal with periods.

With pwm-clock, we loose a precious information along the way (that we
actually want a clock and not a PWM signal).
That's ok with simple PWM drivers that don't have multiple input clocks,
but in this case, without this information, we can't know for sure which
clock to use.
And here, for instance, if we ask for a 24MHz clock, pwm-clock will
requests 42ns (assigned-clocks doesn't help for that matter). The logic
is to select the highest clock (100MHz) with no prescaler and a duty
cycle value of 2/4 => we have 25MHz instead of 24MHz.
And that's a perfectly fine choice for a PMW, because we still can
change the duty cycle in the range [0-4]/4.
But obviously for a clock, we don't care about the duty cycle, but more
about the clock accuracy.

And actually, this PWM is really a PWM AND a real clock when the bypass
is set.

This series is based onto v7.2-rc1

NB: checkpatch is not happy with patch 2, but it's a false positive.
It doesn't detect that PWM_XY_SRC_MUX/GATE/DIV are structures, but as
it's more readable like that, I prefer keeping it that way.

Changes since v6:
- rebase on v7.2-rc1
- Cc common clock framework maintainers, suggested by Uwe
- add missing static before SUN8I_PWM_X_BYPASS_GATE
- reorder code in probe to fix potential life cycle issues
- set pwmcc_data[i].parent_names to NULL in sun8i_pwm_unregister_clk

Changes since v5:
- remove trailing junk after commit message in patch 4
- remove Tested-by when it doesn't make sense.
(sorry for the noise)

Changes since v4:
- Fix a bug on bypass for channels greater than 1
- add colons to clarify 2 debug messages
- switch from H616 to sun8i prefix (in code, filename, module name)
- fix consistency issues in macro parameters
- rename some macros with a confusing naming
- rebase on v7.0

Changes since v3:
- gather Acked-by/Tested-by
- fix cast from pointer to integer of different size (kernel test robot
  with arc platform)
- add devm_action for clk_hw_unregister_composite as suggested by Philipp
- remove now unused pwm_remove as suggested by Philipp

Changes since v2:
- use U32_MAX instead of defining UINT32_MAX
- add a comment on U32_MAX usage in clk_round_rate()
- change clk_table_div_m (use macros)
- fix formatting (double space, superfluous comma, extra line feed)
- fix the parent clock order
- simplify code by using scoped_guard()
- add missing const in to_h616_pwm_chip() and rename to
h616_pwm_from_chip()
- add/remove missing/superfluous error messages
- rename cnt->period_ticks, duty_cnt->duty_ticks
- fix PWM_PERIOD_MAX
- add .remove() callback
- fix DIV_ROUND_CLOSEST_ULL->DIV_ROUND_UP_ULL
- add H616_ prefix
- protect _reg in macros
- switch to waveforms instead of apply/get_state
- shrink struct h616_pwm_channel
- rebase on v6.19-rc4

Changes since v1:
- rebase onto v6.19-rc1
- add missing headers
- remove MODULE_ALIAS (suggested by Krzysztof)
- use sun4i-pwm binding instead of creating a new one (suggested by Krzysztof)
- retrieve the parent clocks from the devicetree
- switch num_parents to unsigned int

Richard Genoud (4):
  dt-bindings: pwm: allwinner: add h616 pwm compatible
  pwm: sun8i: Add H616 PWM support
  arm64: dts: allwinner: h616: add PWM controller
  MAINTAINERS: Add entry on Allwinner sun8i/H616 PWM driver

 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  19 +-
 MAINTAINERS                                   |   5 +
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  47 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun8i.c                       | 938 ++++++++++++++++++
 6 files changed, 1021 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-sun8i.c

-- 
2.47.3


