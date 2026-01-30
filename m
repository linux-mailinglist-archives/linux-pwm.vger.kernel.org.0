Return-Path: <linux-pwm+bounces-8018-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK2JD3yjfGmMOAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8018-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 13:26:36 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0237BA7BA
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 13:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 648D43013DEF
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B2337A4BE;
	Fri, 30 Jan 2026 12:25:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC50137A486;
	Fri, 30 Jan 2026 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775906; cv=none; b=eNEFBZmY/7Xh3YNzitMiije/OPGOMyi7UvVhw275aWWe3d6xSuI9L/33wxE2+4GWlhSGfyMgSM6vaigfb4s+NBWHua6P0oy5YvRLbA4M0bo2pgtWMFuDmXSVc60iJVTMdGc23Zly9UeR1b7fbdimVnJatAdeZB6urCN5vOjvsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775906; c=relaxed/simple;
	bh=3HLy3NLYhHfGM1yhkdhqvvH3wJsXKlhu/Cs2/PJAsPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nj1jNSeN5ivYDyRoUc6R8+b/aVV+9258HBM9EbOOIj2Qs6pBv7s9qXhNV6W+aMDiyZsR6qFCBiP1fHPsNOaEz6KAIWBpFe6MGxOOkQy6/QHoCtrV8xDNgk0ssYCdX7IFIV36DwV4x2I5mOFxYCCOV3KfaeRe+QMYj0IFZk05ibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: +ddeJPQMTJSSbb0AxMA1jg==
X-CSE-MsgGUID: A48i6VkFRJ+juLR/m06Tfw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Jan 2026 21:24:59 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.78])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A2B334190888;
	Fri, 30 Jan 2026 21:24:55 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] pwm: rz-mtu3: impose period restrictions
Date: Fri, 30 Jan 2026 14:23:50 +0200
Message-ID: <20260130122353.2263273-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8018-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: A0237BA7BA
X-Rspamd-Action: no action

The counter is shared by all IOs of a HW channel, and we cannot clear
it from multiple sources, as the TCR register for each HW channel can
only select one clearing source between TGRA, TGRB, TGRC, and TGRD, or
the counter being cleared in another channel when synchronous clearing is
enabled.

Because of this hardware limitation, both IOs of a HW channel must share
the same period.

To provide some flexibility, allow setting different periods on each PWM
channel, with the following restrictions.

If the requested period is smaller than the already programmed period of
the sibling PWM channel, return -EBUSY.

Otherwise, if the requested period is larger to the already programmed
period of the sibling PWM channel, adjust the requested period to match
the already programmed period, and adjust the duty cycle to not exceed
the already programmed period.

Since only one period is being used, always use TGRA for resetting the
counter, and program TGRA for secondary IOs too.

Cc: stable@vger.kernel.org
Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/pwm/pwm-rz-mtu3.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index f6073be1c2f8..7558e28f4786 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -18,6 +18,13 @@
  * - MTU{1, 2} channels have a single IO, whereas all other HW channels have
  *   2 IOs.
  * - Each IO is modelled as an independent PWM channel.
+ * - Sibling IOs must use the same period as they share a common counter.
+ *   The counter can be reset on one of the following conditions: TGRA or TGRB
+ *   or TGRC or TGRD compare match, or when the counter is cleared in another
+ *   channel when synchronous clearing is enabled.
+ *   The driver always uses TGRA compare match to reset the counter.
+ *   The driver adjusts the period and duty cycle of the sibling IO when
+ *   appropriate.
  * - rz_mtu3_channel_io_map table is used to map the PWM channel to the
  *   corresponding HW channel as there are difference in number of IOs
  *   between HW channels.
@@ -64,6 +71,7 @@ struct rz_mtu3_pwm_channel {
  * @clk: MTU3 module clock
  * @lock: Lock to prevent concurrent access for usage count
  * @rate: MTU3 clock rate
+ * @period_cycles: MTU3 period cycles
  * @user_count: MTU3 usage count
  * @enable_count: MTU3 enable count
  * @prescale: MTU3 prescale
@@ -74,6 +82,7 @@ struct rz_mtu3_pwm_chip {
 	struct clk *clk;
 	struct mutex lock;
 	unsigned long rate;
+	u64 period_cycles[RZ_MTU3_MAX_HW_CHANNELS];
 	u32 user_count[RZ_MTU3_MAX_HW_CHANNELS];
 	u32 enable_count[RZ_MTU3_MAX_HW_CHANNELS];
 	u8 prescale[RZ_MTU3_MAX_HW_CHANNELS];
@@ -333,7 +342,6 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	bool is_primary;
 	u8 prescale;
 	u16 pv, dc;
-	u8 val;
 	u32 ch;
 
 	priv = rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
@@ -342,29 +350,31 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	period_cycles = mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
 					NSEC_PER_SEC);
-	prescale = rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles);
 
 	/*
-	 * Prescalar is shared by multiple channels, so prescale can
-	 * NOT be modified when there are multiple channels in use with
-	 * different settings. Modify prescalar if other PWM is off or handle
-	 * it, if current prescale value is less than the one we want to set.
+	 * The counter is shared by all IOs of a HW channel, and we cannot clear
+	 * it from multiple sources, as the TCR register for each HW channel can
+	 * only select one clearing source between TGRA, TGRB, TGRC, and TGRD.
+	 * Enforce that all IOs use the same period cycle.
 	 */
 	if (rz_mtu3_pwm->user_count[ch] > 1) {
 		u32 sibling_hwpwm = rz_mtu3_sibling_hwpwm(pwm->hwpwm, is_primary);
 
 		if (rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, sibling_hwpwm)) {
-			if (rz_mtu3_pwm->prescale[ch] > prescale)
+			if (rz_mtu3_pwm->period_cycles[ch] > period_cycles)
 				return -EBUSY;
 
-			prescale = rz_mtu3_pwm->prescale[ch];
+			period_cycles = rz_mtu3_pwm->period_cycles[ch];
 		}
 	}
 
+	prescale = rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles);
 	pv = rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);
 
 	duty_cycles = mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
 				      NSEC_PER_SEC);
+	if (duty_cycles > period_cycles)
+		duty_cycles = period_cycles;
 	dc = rz_mtu3_pwm_calculate_pv_or_dc(duty_cycles, prescale);
 
 	/*
@@ -379,20 +389,19 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			return rc;
 	}
 
-	val = RZ_MTU3_TCR_CKEG_RISING | prescale;
-
 	/* Counter must be stopped while updating TCR register */
 	if (rz_mtu3_pwm->prescale[ch] != prescale && rz_mtu3_pwm->enable_count[ch])
 		rz_mtu3_disable(priv->mtu);
 
+	rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA |
+			      RZ_MTU3_TCR_CKEG_RISING | prescale);
+
 	if (is_primary) {
-		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
-				      RZ_MTU3_TCR_CCLR_TGRA | val);
 		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRA, pv,
 						RZ_MTU3_TGRB, dc);
 	} else {
-		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
-				      RZ_MTU3_TCR_CCLR_TGRC | val);
+		/* TGRA is used to reset the counter for both IOs. */
+		rz_mtu3_16bit_ch_write(priv->mtu, RZ_MTU3_TGRA, pv);
 		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRC, pv,
 						RZ_MTU3_TGRD, dc);
 	}
@@ -409,6 +418,8 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			rz_mtu3_enable(priv->mtu);
 	}
 
+	rz_mtu3_pwm->period_cycles[ch] = period_cycles;
+
 	/* If the PWM is not enabled, turn the clock off again to save power. */
 	if (!pwm->state.enabled)
 		pm_runtime_put(pwmchip_parent(chip));
-- 
2.52.0


