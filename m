Return-Path: <linux-pwm+bounces-8608-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PdoJNfg4GkEnAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8608-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 15:15:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA740E950
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5412C30231F3
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007903BAD85;
	Thu, 16 Apr 2026 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GCn4FjX/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430FC3BB9F1
	for <linux-pwm@vger.kernel.org>; Thu, 16 Apr 2026 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345301; cv=none; b=J7C0iRddkzyq1PT72pfLKu2OdnPnf0Tebv+G8xTiidnxjTNJEANDzB0497RbrReCQDn3vkHnyh7S319rHk2Mao6k6+jLmBa/W1y3DJN49bPdDfcBOFyOuKcBLe1CDyfwvjpmBOJLbVFXuxa27e+rT57tcdD6CIepGBmkjbeV6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345301; c=relaxed/simple;
	bh=rXgfrqpU4733mB6OvSZz53FpsPgFb92n+Mm541eTv0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0D5/EYVcZNpcyqe4wt3KugTJZx5GKjL+pgixKlGsF22BZ1AlmjzHBFamgdzqkIJo+UqCPPUl4pnjGHvz/VkWBNiWi9L3tFGBfLG5Rg6LwXV0cXMLEADHQCfXgonWfCzSkWP+cb6EiXxwbqUHSjh45nfXx5wIbMFheHIUWLEJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GCn4FjX/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A7B151A3305;
	Thu, 16 Apr 2026 13:14:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 79F1B60495;
	Thu, 16 Apr 2026 13:14:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED2981046080F;
	Thu, 16 Apr 2026 15:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776345296; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=UvR1h+rn3X5IRc/Dz+AWSCwJXmM9Vu0gWqgoBEiGAKA=;
	b=GCn4FjX/7lStVc6+ObD4HiLTeKtHVhobd5/YVIf7eB69qcCVMTHJA5i+BUIST5Zrj0Sksf
	mVNU7lUTvVQEWUAxknO2tSvmlk9UzQjw3xmtJKSMKTQId5AXAKO4egg30lxWRDaamypJly
	bYyHr9tFOtwoA5xN7hHWtfGWn4nnRxXb5MP7IGZYbUVkD2QnDev+9360yNbMkJuVOXEF15
	ijmW6m028qBxXSi5MJFBTLdT7dARR7Chu7pHN5CcAH7uRcGV8Jod+Ii/vLQ+jTGYGb173Z
	Jo/Zo9kB9gLwZfCOlybvvSv64tSaUTMcFws5c7NRhbfNLnd4KxFMbYOs5Rjc8w==
From: Richard Genoud <richard.genoud@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
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
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v5 0/4] Introduce Allwinner H616 PWM controller
Date: Thu, 16 Apr 2026 15:14:15 +0200
Message-ID: <20260416131419.3152419-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[sys-base.io,bootlin.com,google.com,schimsalabim.eu,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8608-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FAA740E950
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

This series is based onto v7.0

NB: checkpatch is not happy with patch 2, but it's a false positive.
It doesn't detect that PWM_XY_SRC_MUX/GATE/DIV are structures, but as
it's more readable like that, I prefer keeping it that way.

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


base-commit: 028ef9c96e96197026887c0f092424679298aae8

