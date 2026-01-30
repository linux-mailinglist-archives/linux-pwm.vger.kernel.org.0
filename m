Return-Path: <linux-pwm+bounces-8019-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJUdJomjfGmMOAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8019-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 13:26:49 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2952BA7DA
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 13:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B172130152F8
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 12:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5E537AA8E;
	Fri, 30 Jan 2026 12:25:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C1F3793DA;
	Fri, 30 Jan 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775907; cv=none; b=ZK1IrubF6lLq0MQsM9TO8SwXLmrjPJkWwjdoesinvtramnSgmMy/dDSMjucrxtpMqznWEhJDhg/yhXHu2eufLRluv5MVoOfWUCzOsH+tUW0oltMcYMPnK+c90AILZFEE02L7q6EIYw8xr50OBxSMyQMgCkJVnW6DruU+Vo3+k0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775907; c=relaxed/simple;
	bh=aWxSqyUwGAOoEHpdWB2kVArbfiZoKhA+/2A39gDK1eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meRASec7BTxUf3Kt1SYTpCHhGonL1pv2c+J4DG94Agsi8DTUxm9FF6LzKxe1R8iYIc1ibg/O2g5lR4avRBAoVLJ7VaZlP3vhyjnWbTvTAjNSM1pFjRnoCKoXca64KwEG97J99l3MlgmMsb+KzHawgTtWFvkjFQ0lpmS69+ZcYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: Q9ShKTg3QuC0RJlV7XeW1Q==
X-CSE-MsgGUID: BBud2CgoRF+3ZKjE0NjVxg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jan 2026 21:25:03 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.78])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 629954190888;
	Fri, 30 Jan 2026 21:25:00 +0900 (JST)
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
Subject: [PATCH 3/5] pwm: rz-mtu3: correctly enable HW channel 4 and 7
Date: Fri, 30 Jan 2026 14:23:51 +0200
Message-ID: <20260130122353.2263273-4-cosmin-gabriel.tanislav.xa@renesas.com>
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
	TAGGED_FROM(0.00)[bounces-8019-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:mid,renesas.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2952BA7DA
X-Rspamd-Action: no action

HW channels 4 and 7 require an additional bit to be set in the TOER{A,B}
registers in order to enable PWM output.

Add the necessary logic to update these bits when enabling or disabling
PWM on these channels.

Cc: stable@vger.kernel.org
Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/pwm/pwm-rz-mtu3.c   | 40 +++++++++++++++++++++++++++++++++++--
 include/linux/mfd/rz-mtu3.h |  2 ++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index 7558e28f4786..ed5fbc4015aa 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -226,10 +226,37 @@ static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_unlock(&rz_mtu3_pwm->lock);
 }
 
+static void rz_mtu3_pwm_set_toer_bit(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
+				     struct rz_mtu3_pwm_channel *priv,
+				     bool is_primary, bool set)
+{
+	u8 bitpos;
+	u16 reg;
+
+	/*
+	 * HW channels 4 and 7 require an additional register write to enable
+	 * PWM output.
+	 */
+	if (priv->mtu->channel_number == RZ_MTU3_CHAN_4)
+		reg = RZ_MTU3_TOERA;
+	else if (priv->mtu->channel_number == RZ_MTU3_CHAN_7)
+		reg = RZ_MTU3_TOERB;
+	else
+		return;
+
+	if (is_primary)
+		bitpos = 1;
+	else
+		bitpos = 4;
+
+	rz_mtu3_shared_reg_update_bit(priv->mtu, reg, bitpos, set);
+}
+
 static int rz_mtu3_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 	struct rz_mtu3_pwm_channel *priv;
+	bool is_primary;
 	u32 ch;
 	u8 val;
 	int rc;
@@ -240,10 +267,15 @@ static int rz_mtu3_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	priv = rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
 	ch = priv - rz_mtu3_pwm->channel_data;
+	is_primary = priv->map->base_pwm_number == pwm->hwpwm;
+
 	val = RZ_MTU3_TIOR_OC_IOB_TOGGLE | RZ_MTU3_TIOR_OC_IOA_H_COMP_MATCH;
 
 	rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_PWMMODE1);
-	if (priv->map->base_pwm_number == pwm->hwpwm)
+
+	rz_mtu3_pwm_set_toer_bit(rz_mtu3_pwm, priv, is_primary, true);
+
+	if (is_primary)
 		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORH, val);
 	else
 		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORL, val);
@@ -262,17 +294,21 @@ static void rz_mtu3_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 	struct rz_mtu3_pwm_channel *priv;
+	bool is_primary;
 	u32 ch;
 
 	priv = rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
 	ch = priv - rz_mtu3_pwm->channel_data;
+	is_primary = priv->map->base_pwm_number == pwm->hwpwm;
 
 	/* Disable output pins of MTU3 channel */
-	if (priv->map->base_pwm_number == pwm->hwpwm)
+	if (is_primary)
 		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORH, RZ_MTU3_TIOR_OC_RETAIN);
 	else
 		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORL, RZ_MTU3_TIOR_OC_RETAIN);
 
+	rz_mtu3_pwm_set_toer_bit(rz_mtu3_pwm, priv, is_primary, false);
+
 	mutex_lock(&rz_mtu3_pwm->lock);
 	rz_mtu3_pwm->enable_count[ch]--;
 	if (!rz_mtu3_pwm->enable_count[ch])
diff --git a/include/linux/mfd/rz-mtu3.h b/include/linux/mfd/rz-mtu3.h
index 8421d49500bf..37da5f7bb83a 100644
--- a/include/linux/mfd/rz-mtu3.h
+++ b/include/linux/mfd/rz-mtu3.h
@@ -10,6 +10,8 @@
 #include <linux/mutex.h>
 
 /* 8-bit shared register offsets macros */
+#define RZ_MTU3_TOERA	0x00A /* Timer output master enable register A */
+#define RZ_MTU3_TOERB	0x80A /* Timer output master enable register B */
 #define RZ_MTU3_TSTRA	0x080 /* Timer start register A */
 #define RZ_MTU3_TSTRB	0x880 /* Timer start register B */
 
-- 
2.52.0


