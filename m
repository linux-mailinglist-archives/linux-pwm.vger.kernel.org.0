Return-Path: <linux-pwm+bounces-9701-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6pi2AOzIVGrWSwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9701-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2026 13:15:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA61574A3A2
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2026 13:15:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=c9IxelqL;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9701-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9701-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C80F300EE80
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2026 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F4C383300;
	Mon, 13 Jul 2026 11:15:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9C3630A7
	for <linux-pwm@vger.kernel.org>; Mon, 13 Jul 2026 11:15:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941353; cv=none; b=eVTULwA5/aG5d2kEpvkp3tAKEYlVffEOL39mFpWacs552dU7lALFPY1A/RcjqlfYHSxMoS6qWR/sOpNpOLZe4qMecLa3iJe23DtI8GprfWn3xmMkCegm93JXPVKXfnwG/1YJHqCC/1STQCbYBjty+uYCg87l65dimy0liroOCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941353; c=relaxed/simple;
	bh=cBx1EEL+CNvz6d4aM5+hJilvgtigJnSGqH4PY33enU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1lQwlTlfnS++AK6ZCZAsW80BT6B7RClpe7EwB4KudYoK74xRJ5KEEztKR9DoS7MXYIqFGrXqKAmDY6HUz0IKM4JoGxZtTE35FQUMErrOaLIL4D9qtGibVnBYrn3raC3/7v3BnRj/UsdAIzC5j+vpINKmmJnZ0YmUoZ2HyveetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9IxelqL; arc=none smtp.client-ip=209.85.208.179
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c62764c7cso33073821fa.0
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jul 2026 04:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783941350; x=1784546150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8FzDrRG60vMmalVmM4BYOfa6FjIC2MZZeKx4nlMzZts=;
        b=c9IxelqL0d2MTnm0ZjDA/S2tnAquSFiWsAGOciFj7mv4tjHL65z2cI29CV5DJjUveM
         CAviILT6sjMfgq2wSrU7g0pxeilxhDHcxRQD1Rpfibs7xeht8NMLah9dAt75RBRTKUsK
         NV7OoYVNF4ORgycr2RWvVEypi3nNpwXLxbqoAlPSdetqxAEBOzy9M2o4BOXuxkHH8z7+
         thOIvHvHMRFvqN97zdpsQIkBumpA7d7n+ks1xzSzMD4Yy0U4hUEBObHD9XSqX0ot26UI
         tZK7oBwvsPuE7W9gOZohBDojNwP42VmSL0I4x1f+Bf5dtx2MYlio0O1mYTSDZkfRslR0
         KqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941350; x=1784546150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8FzDrRG60vMmalVmM4BYOfa6FjIC2MZZeKx4nlMzZts=;
        b=FZ4HBocSwow9z9tFKz/cox71mBnM6XraSVAERCyImgdnSGtRiD7tNJY3AsnYMXvbI2
         VlQuU4oM+PO9sNVneCKV8UaIl7ER/3pS1eC6Uk8DCKPyVu388MivRf/ChRGXJOIMNfHn
         f1qNAxNYDdoPe7PXBgi4S9mISzJ9X2dpq8GFlWpARh4ReA2dPKiue3I1mMDJZ3+d6T/w
         D1iohZqEv/rSd792wHHjxKd/JKVM4orAFT+YWmqvD1qWiHN8lQjsSGc/g2TJDKkWP0SK
         wpV09CQm/N2CQR/wqTf8IkUINrqzV3rVh2lZCyCI66hZ2Lu0BbXGrndGBwDbcdDcWE2L
         4qGg==
X-Forwarded-Encrypted: i=1; AHgh+RpzYf0O61uZzacyLEnnQQR0j01Rq5eOFufGINM+oPvvwIZx6Tr4wZsKzgB5zr7wyzH+8KbDrnrPx0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfqzCxI58ddr22LaIMm4E4NDmB2o2x5UEWuCSXx8zn+cbb9AeN
	qi8cWSYTDu1omhhXgFVxBawzjXN5w+OeutBiaE+p8HcIrm2CMGQNrqO9
X-Gm-Gg: AfdE7cn+exlw5LStA+uPymw9tjK/GWCJJ9FCBfEojz7aaT7KD/GZrb2PcTyoWH5PmHI
	x+XLQ8QsPZ2oObn4mDDcJvYE4uxcBYr2UPUAJlFGRDZvZgq8N8mpke0Zh2AUAbAmPfokbhczrQa
	+3WgIMUIde8xYGaDHp5aIjXeJpiitxl1q8OxaX4xVhzAStGyWKEtxsqreXmcybiyxtFoxajugTm
	PJqGCZ8hdlgLZ3e6VpH1HsHYcDKK+P6uSdyMa9uy0gNaexjcsnLj0dGNyUv6XpuWv4wbkhgUEhq
	qUF/wYdqIkB4txFU8Hn7qe26vVxQHNGZeUw9c+ggPAkxumYKbW6MV3df7HhyZgN1YtmpmLjWYqo
	cZQn+0o1SraZnCrvJFatpjqtMOfnmDpCt+drJy5HMW0rGxBfXRY6wGTIF7DY9+hkVPNWsbCMwHU
	AiUooTXXBT1Rc95cV8Sb4EhCrzTmlZUwRwceVWD6Y7ZWVSbXEChbEjiJvVvIdnKPrLnsps+Gt+w
	V8R5ecOpme/QSNzgBKlTvfdvW0nVKNhJb3S5XdxBBgY+83inRyyiVw2G36z5TJeTWHAolOasje7
	lvbVtD7WAoLR
X-Received: by 2002:ac2:4bd3:0:b0:5b0:22e1:3452 with SMTP id 2adb3069b0e04-5b023d0bbc7mr1923590e87.9.1783941349910;
        Mon, 13 Jul 2026 04:15:49 -0700 (PDT)
Received: from ola-desktop.tail7f4623.ts.net (184.89-11-176.customer.lyse.net. [89.11.176.184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b023b59381sm2009339e87.41.2026.07.13.04.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:15:48 -0700 (PDT)
From: "Ola Chr. Vaage" <o.c.vage@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: [PATCH] pwm: tegra: fix doubled output frequency due to divider truncation
Date: Mon, 13 Jul 2026 13:15:41 +0200
Message-ID: <20260713111541.473547-1-o.c.vage@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-9701-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ola.christoffer.vage@scoutdi.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ocvage@gmail.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ocvage@gmail.com,linux-pwm@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA61574A3A2

From: "Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>

The PWM_SCALE frequency divider is computed by rounding down

	clk_rate * period_ns / (NSEC_PER_SEC << PWM_DUTY_WIDTH)

With dynamic clock scaling (Tegra186 and later), the driver doubles its
clock-rate request when the provider cannot meet it. The provider then
typically grants slightly less than the doubled request, the exact
divider lands just below 2, and the round-down truncates it to 1: the
output runs at double the requested frequency. On Tegra234 the BPMP
grants PWM clock rates as 408 MHz / N, so nearly every requested period
is affected: requesting 40000 ns produces 20078 ns, 100000 ns produces
50195 ns. The duty ratio is computed independently and stays correct,
which hides the problem from duty-only consumers such as backlights;
frequency-sensitive loads break.

Measured on a Jetson Orin NX board with the 45334 ns fan period used in
NVIDIA device trees:

	required_clk_rate = ceil((1e9 << 8) / 45334) = 5646977
	clk_round_rate() = 5589041 (408 MHz / 73) -> request doubled
	dev_pm_opp_set_rate(11293954) grants 11027028 (408 MHz / 37)
	divider = trunc(1.953) = 1 -> output period 23217 ns, 43.07 kHz

43 kHz is outside the 21-28 kHz band that 4-wire fan PWM inputs are
designed for. The fan on this board cannot start below duty 110/255 and
stalls below 88/255, so closed-loop fan control oscillates between a
stalled fan and full speed.

Round the divider to the closest integer instead. This bounds the
period error to half a divider step rather than a full one, and
restores what this configuration did before commit 8c193f4714df
("pwm: tegra: Optimize period calculation") switched the rounding from
closest to down: divider round(0.99) = 1 on the undoubled 5589041 Hz
grant, period 45802 ns, +1.0%. Between that commit and commit
5eccd0d9fabc ("pwm: tegra: Ensure the clock rate is not less than
needed") the same request failed with -EINVAL instead. Verified on the
Orin NX with this patch applied: PWM_SCALE reads 1 (21.54 kHz, +2.4%
period), the fan starts at duty <= 50/255 and sustains 80/255, and
closed-loop control is stable. There is no round-closest variant of
mul_u64_u64_div_u64(), so compute twice the quotient and round up the
halving.

Fixes: 5eccd0d9fabc ("pwm: tegra: Ensure the clock rate is not less than needed")
Signed-off-by: Ola Chr. Vaage <ola.christoffer.vage@scoutdi.com>
---
 drivers/pwm/pwm-tegra.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 172063b51d4..a5adc4f3ce6 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -163,9 +163,15 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		pc->clk_rate = clk_get_rate(pc->clk);
 	}
 
-	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
-	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
+	/*
+	 * Consider precision in PWM_SCALE_WIDTH rate calculation. Round to
+	 * the closest integer: there is no round-closest variant of
+	 * mul_u64_u64_div_u64(), so compute twice the quotient and round up
+	 * the halving.
+	 */
+	rate = mul_u64_u64_div_u64(pc->clk_rate, 2 * (u64)period_ns,
 				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
+	rate = DIV_ROUND_UP_ULL(rate, 2);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
-- 
2.54.0


