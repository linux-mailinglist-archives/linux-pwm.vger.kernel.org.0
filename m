Return-Path: <linux-pwm+bounces-8021-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJEnJOKjfGmMOAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8021-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 13:28:18 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1538FBA850
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 13:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7388F3058BB2
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F98376BCC;
	Fri, 30 Jan 2026 12:25:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99336E485;
	Fri, 30 Jan 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775916; cv=none; b=tlOYQtSGVfLSQcBTn40PFztebauYg1je70B1+c/Vwxi7/GV9OcqDTSoBL3hmEfbGj0cGQgrCPNrZQ4Pe+5wmfkmZiYGA1sco7JatO/z+sA40VbS/oZro82rfu0ikj4sWS9dRC0ZGePmT8rE1bq84OY1OMRShX/OvtjmdKxkhNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775916; c=relaxed/simple;
	bh=eBNmb4XwvxZEc5QzJxcUFNRYKaKGG0cTVjnmf8T2EpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYtyJ26dhdOEsPCljr/I6Vo/9jJoXcD53bSOGZip5K4vWERMd0ItHKKCRY1cOaA1UNNnGzVHUWFOuekJKZraw6lVWrjgDNQBUbeEYWm8c68Br4FAJ5Rvv5i/4BdOwtRwfSAMvktE0Hs6OUF6p38aqfUEejDIm1IxLJFNU6F8LXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: vOUo3aDmQzWM2BvYqBU99w==
X-CSE-MsgGUID: MdXTImUJTo+b8HUxOpb72Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jan 2026 21:25:14 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.78])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 65AF64177D41;
	Fri, 30 Jan 2026 21:25:10 +0900 (JST)
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
Subject: [PATCH 5/5] counter: rz-mtu3-cnt: do not use struct rz_mtu3_channel's dev member
Date: Fri, 30 Jan 2026 14:23:53 +0200
Message-ID: <20260130122353.2263273-6-cosmin-gabriel.tanislav.xa@renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8021-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[bp.renesas.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cosmin-gabriel.tanislav.xa@renesas.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: 1538FBA850
X-Rspamd-Action: no action

The counter driver can use HW channels 1 and 2, while the PWM driver can
use HW channels 0, 1, 2, 3, 4, 6, 7.

The dev member is assigned both by the counter driver and the PWM driver
for channels 1 and 2, to their own struct device instance, overwriting
the previous value.

The sub-drivers race to assign their own struct device pointer to the
same struct rz_mtu3_channel's dev member.

The dev member of struct rz_mtu3_channel is used by the counter
sub-driver for runtime PM.

Depending on the probe order of the counter and PWM sub-drivers, the
dev member may point to the wrong struct device instance, causing the
counter sub-driver to do runtime PM actions on the wrong device.

To fix this, use the parent pointer of the counter, which is assigned
during probe to the correct struct device, not the struct device pointer
inside the shared struct rz_mtu3_channel.

Cc: stable@vger.kernel.org
Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 55 +++++++++++++++++------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index a4a8ef2d88f0..7bfb6979193c 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -107,9 +107,9 @@ static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, int id)
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	unsigned long tmdr;
 
-	pm_runtime_get_sync(priv->ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-	pm_runtime_put(priv->ch->dev);
+	pm_runtime_put(counter->parent);
 
 	if (id == RZ_MTU3_32_BIT_CH && test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
 		return false;
@@ -165,12 +165,12 @@ static int rz_mtu3_count_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		*val = rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
 	else
 		*val = rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TCNT);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -187,26 +187,26 @@ static int rz_mtu3_count_write(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, val);
 	else
 		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, val);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
 }
 
 static int rz_mtu3_count_function_read_helper(struct rz_mtu3_channel *const ch,
-					      struct rz_mtu3_cnt *const priv,
+					      struct counter_device *const counter,
 					      enum counter_function *function)
 {
 	u8 timer_mode;
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	timer_mode = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TMDR1);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 
 	switch (timer_mode & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
 	case RZ_MTU3_TMDR1_PH_CNT_MODE_1:
@@ -240,7 +240,7 @@ static int rz_mtu3_count_function_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	ret = rz_mtu3_count_function_read_helper(ch, priv, function);
+	ret = rz_mtu3_count_function_read_helper(ch, counter, function);
 	mutex_unlock(&priv->lock);
 
 	return ret;
@@ -279,9 +279,9 @@ static int rz_mtu3_count_function_write(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -300,9 +300,9 @@ static int rz_mtu3_count_direction_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	tsr = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 
 	*direction = (tsr & RZ_MTU3_TSR_TCFD) ?
 		COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD;
@@ -377,14 +377,14 @@ static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	if (count->id == RZ_MTU3_32_BIT_CH)
 		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TGRALW, ceiling);
 	else
 		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, ceiling);
 
 	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
-	pm_runtime_put(ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -495,7 +495,6 @@ static int rz_mtu3_count_enable_read(struct counter_device *counter,
 static int rz_mtu3_count_enable_write(struct counter_device *counter,
 				      struct counter_count *count, u8 enable)
 {
-	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	int ret = 0;
 
@@ -505,14 +504,14 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		goto exit;
 
 	if (enable) {
-		pm_runtime_get_sync(ch->dev);
+		pm_runtime_get_sync(counter->parent);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret == 0)
 			priv->count_is_enabled[count->id] = true;
 	} else {
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
-		pm_runtime_put(ch->dev);
+		pm_runtime_put(counter->parent);
 	}
 
 exit:
@@ -544,9 +543,9 @@ static int rz_mtu3_cascade_counts_enable_get(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(priv->ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-	pm_runtime_put(priv->ch->dev);
+	pm_runtime_put(counter->parent);
 	*cascade_enable = test_bit(RZ_MTU3_TMDR3_LWA, &tmdr);
 	mutex_unlock(&priv->lock);
 
@@ -563,10 +562,10 @@ static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(priv->ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
 				      RZ_MTU3_TMDR3_LWA, cascade_enable);
-	pm_runtime_put(priv->ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -583,9 +582,9 @@ static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_device *count
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(priv->ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
-	pm_runtime_put(priv->ch->dev);
+	pm_runtime_put(counter->parent);
 	*ext_input_phase_clock_select = test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
 	mutex_unlock(&priv->lock);
 
@@ -602,11 +601,11 @@ static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device *count
 	if (ret)
 		return ret;
 
-	pm_runtime_get_sync(priv->ch->dev);
+	pm_runtime_get_sync(counter->parent);
 	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
 				      RZ_MTU3_TMDR3_PHCKSEL,
 				      ext_input_phase_clock_select);
-	pm_runtime_put(priv->ch->dev);
+	pm_runtime_put(counter->parent);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -644,7 +643,7 @@ static int rz_mtu3_action_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	ret = rz_mtu3_count_function_read_helper(ch, priv, &function);
+	ret = rz_mtu3_count_function_read_helper(ch, counter, &function);
 	if (ret) {
 		mutex_unlock(&priv->lock);
 		return ret;
-- 
2.52.0


