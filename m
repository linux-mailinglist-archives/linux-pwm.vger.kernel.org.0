Return-Path: <linux-pwm+bounces-8017-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFzBAHGjfGmMOAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8017-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 13:26:25 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A250BA7AB
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 13:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E47C73040332
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6510379999;
	Fri, 30 Jan 2026 12:25:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C1627703E;
	Fri, 30 Jan 2026 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775903; cv=none; b=p8WU5XUtWga9xYvY3A8Xs8LHtTpz308cD+18ESuPrZ55Zxppv7IaDRskdxbXqQrKYaM7Nc3UvEX9X5lkYqAuzr5BRZdq8LPXhlEikcnO0NZhubmZOlDAdYKPdg0nk9iKg9wEpOWeLphdDvA+EMPQIuwUugSuKNV8WAugTfG7uZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775903; c=relaxed/simple;
	bh=UCnersT8IzdlengUOQCVxr4bmPM5TvftAlC9gzv+n9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeEVT52kjYuqWf6kAim4+39d2cxhhe/2whu/KvbWoMeWu8S00jPLvaoXBQYu/KXRODL0jjwWvfD8f5vkIvyuQ0ceZ8f8O8GNx4wXxZ2FTiU+a8vw9fyhOi6ss6B6faDN/HrJLddGPg/b1R7JEu+5fkBeENNVtJ/VqbPX+uSEg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: DuDAgcJJQ9WiR5gqxtAtRQ==
X-CSE-MsgGUID: 0QgbC7VoTISaoYFjLhwfJw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Jan 2026 21:24:54 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.78])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C799C419087D;
	Fri, 30 Jan 2026 21:24:50 +0900 (JST)
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
Subject: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd channel
Date: Fri, 30 Jan 2026 14:23:49 +0200
Message-ID: <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8017-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:mid,renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A250BA7AB
X-Rspamd-Action: no action

enable_count is only incremented after rz_mtu3_pwm_config() is called
for the current PWM channel, causing prescale to not be checked if one
PWM channel is enabled and we're enabling the second PWM channel of the
same HW channel.

To handle this edge case, if the user_count of the HW channel is larger
than 1 and the sibling PWM channel is enabled, check that the new
prescale is not smaller than the sibling's prescale.

If the new prescale is larger than the sibling's prescale, use the
sibling's prescale.

The user_count check is ensures that we are indeed dealing with a HW
channel that has two IOs.

Cc: stable@vger.kernel.org
Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/pwm/pwm-rz-mtu3.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index ab39bd37edaf..f6073be1c2f8 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -142,6 +142,14 @@ rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 hwpwm)
 	return priv;
 }
 
+static u32 rz_mtu3_sibling_hwpwm(u32 hwpwm, bool is_primary)
+{
+	if (is_primary)
+		return hwpwm + 1;
+	else
+		return hwpwm - 1;
+}
+
 static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 				      u32 hwpwm)
 {
@@ -322,6 +330,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct rz_mtu3_pwm_channel *priv;
 	u64 period_cycles;
 	u64 duty_cycles;
+	bool is_primary;
 	u8 prescale;
 	u16 pv, dc;
 	u8 val;
@@ -329,6 +338,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	priv = rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
 	ch = priv - rz_mtu3_pwm->channel_data;
+	is_primary = priv->map->base_pwm_number == pwm->hwpwm;
 
 	period_cycles = mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
 					NSEC_PER_SEC);
@@ -340,11 +350,15 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * different settings. Modify prescalar if other PWM is off or handle
 	 * it, if current prescale value is less than the one we want to set.
 	 */
-	if (rz_mtu3_pwm->enable_count[ch] > 1) {
-		if (rz_mtu3_pwm->prescale[ch] > prescale)
-			return -EBUSY;
+	if (rz_mtu3_pwm->user_count[ch] > 1) {
+		u32 sibling_hwpwm = rz_mtu3_sibling_hwpwm(pwm->hwpwm, is_primary);
 
-		prescale = rz_mtu3_pwm->prescale[ch];
+		if (rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, sibling_hwpwm)) {
+			if (rz_mtu3_pwm->prescale[ch] > prescale)
+				return -EBUSY;
+
+			prescale = rz_mtu3_pwm->prescale[ch];
+		}
 	}
 
 	pv = rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);
@@ -371,7 +385,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (rz_mtu3_pwm->prescale[ch] != prescale && rz_mtu3_pwm->enable_count[ch])
 		rz_mtu3_disable(priv->mtu);
 
-	if (priv->map->base_pwm_number == pwm->hwpwm) {
+	if (is_primary) {
 		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
 				      RZ_MTU3_TCR_CCLR_TGRA | val);
 		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRA, pv,
-- 
2.52.0


