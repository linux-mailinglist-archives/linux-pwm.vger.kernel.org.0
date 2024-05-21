Return-Path: <linux-pwm+bounces-2211-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA08CB46F
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 21:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651441F23642
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 19:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDFC1494D0;
	Tue, 21 May 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sEbFsUdo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2F148FF1
	for <linux-pwm@vger.kernel.org>; Tue, 21 May 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320963; cv=none; b=SR0U5M6E4dgn9q8wUvrIi+p6XykxN/Sap6exm5T9pBlfgVlhmnbcNljY48ysJdMIPnvdfxbofOAXGpBlCrWV8kNDe9YdqrjQLXcD+TpnzWhglbBsALoosMri0/KW9XCj9G07zC4/PWwRZSGsoNDvU1hLuFGkO6m4M/PzxunEXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320963; c=relaxed/simple;
	bh=8jAltw4/ZXbcJw+njVcL04mrZ7tJRL5lxZIeKt8Sevg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUeWGs7fDNFeeyypLRSvyDA5PpZc4jJi5X2YPBNB6qav8sAkFfQNcJI4urwFYZ6JDJD+1nbTsx8l4aqDrr9z19koEJ/p6zxVeSNrjTFaAB7DH49XUnKUOh7pIF0wSbMSdLaiQNfK9RHMmSt37RfpAP6kxYmlhVXpX8X8RxQ0m0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sEbFsUdo; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792bf1a4f75so378847685a.2
        for <linux-pwm@vger.kernel.org>; Tue, 21 May 2024 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716320960; x=1716925760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26sqe/9M6qKSDnSFeiksxdAuHDavgCthn7zRVCyiwkU=;
        b=sEbFsUdo/gODQJ62dTlVTn1MR8mbFJOM3HXr1aBPcUwsFr3R7wJtQs6pbr6NS7KNCb
         SAA30gMq/CU0cykp2Z6dxxfqsRSVl4F2gPNbpJVWRJS86RDySp6wNGMcJbN0YNJ33TAl
         vqIEIHf6Weh23g0OM9Yp5ZDrNmZjsHt+Hk/3jtRRwUPlvZJkkqfprQvh7+agB7K16gdc
         RtajRPSYmKjUcHgOUOKQbLaX6mijM2kBaXf3v1d89Tcvr0BjzPAGJk883PFTnr2Cdv8s
         sw+xek6K6yLxHwwGHDa6r03L7j+w2+dC2bwELsDgsLyMmwDAkfRNb+nLQDST4Ouv89UC
         kSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716320960; x=1716925760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26sqe/9M6qKSDnSFeiksxdAuHDavgCthn7zRVCyiwkU=;
        b=C/OgPX5FE1uz40w18VbkGThWZpDyrHM+N7/TFQpkjvMqXOJ4SHphbLrOwtkABt+znw
         R4qmWYkX3dioHzpyoZn4jlKxz30frp+XeUdFqCkz66Yc+XcUylOZ1ay3ILCMTXwOk8Ih
         AUcV/4XW9muKqIsegq7tB6ALylqY0hLnDbiUwjWpy1evN42rt42jl82rjg1NAnuSHi3I
         JyEBOls2Xk24FMtf5+Ru5e24tb8HgS0fJzCK4p4UIYrAxm2qaXQn3hRQwrAmQ9X153mn
         jL32fqwfm3ZHJTGWTMkIp+Azy4k+zp/Ac6lm4hP0bU2xdqs0zAAVEY5UubSeNyk3rrVy
         WM4Q==
X-Gm-Message-State: AOJu0YwWoFWPU2/eDk0O/p9g1pATJTKxaXCU/ktpfggDsW7N2/LEq3lI
	Np8t1SQXs6zWHDJ3W+1Gm+BdAAG+Zn7oCJlzmdigA0mNA4TYd99AUQyp2wusqArh8AgVYYbemXw
	4
X-Google-Smtp-Source: AGHT+IGQ4gcZx0Znofa05ILEolx2511anpSCZhpCdMX5etGrdkjYL+m4SxrtEc4Jz6F9ktiuBUoaYQ==
X-Received: by 2002:a05:620a:22eb:b0:792:7d2f:156f with SMTP id af79cd13be357-792c75ff6b5mr3158444185a.77.1716320959543;
        Tue, 21 May 2024 12:49:19 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54d85a0sm161723611cf.23.2024.05.21.12.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:49:19 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 1/2 v3] pwm: add duty offset support
Date: Tue, 21 May 2024 15:49:15 -0400
Message-ID: <20240521194916.1897909-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240521194916.1897909-1-tgamblin@baylibre.com>
References: <20240521194916.1897909-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PWM chips support a "phase" or "duty_offset" feature. This patch
continues adding support for configuring this property in the PWM
subsystem.

Functions duty_offset_show(), duty_offset_store(), and
pwm_get_duty_offset() are added to match what exists for duty_cycle.

Add a check to disallow applying a state with both inversed polarity and
a nonzero duty_offset.

Also add duty_offset to TP_printk in include/trace/events/pwm.h so that
it is reported with other properties when using the event tracing pipe
for debug.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
v3 changes:
* rebased on top of latest pwm/for-next
* removed changes related to cdev to match current pwm tree
* fixed minor whitespace issue caught by checkpatch

v2 changes:
* Address feedback for driver in v1:
  * Remove line setting supports_offset flag in pwm_chip, since that has
    been removed from the struct in core.c.

---
 drivers/pwm/core.c         | 79 +++++++++++++++++++++++++++++++++++---
 include/linux/pwm.h        | 15 ++++++++
 include/trace/events/pwm.h |  6 ++-
 3 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 18574857641e..2ebfc7f3de8a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -62,6 +62,7 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	 */
 	if (s1.enabled && s1.polarity != state->polarity) {
 		s2.polarity = state->polarity;
+		s2.duty_offset = s1.duty_cycle;
 		s2.duty_cycle = s1.period - s1.duty_cycle;
 		s2.period = s1.period;
 		s2.enabled = s1.enabled;
@@ -103,6 +104,23 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 			 state->duty_cycle, state->period,
 			 s2.duty_cycle, s2.period);
 
+	if (state->enabled &&
+	    last->polarity == state->polarity &&
+	    last->period == s2.period &&
+	    last->duty_offset > s2.duty_offset &&
+	    last->duty_offset <= state->duty_offset)
+		dev_warn(pwmchip_parent(chip),
+			 ".apply didn't pick the best available duty offset (requested: %llu/%llu, applied: %llu/%llu, possible: %llu/%llu)\n",
+			 state->duty_offset, state->period,
+			 s2.duty_offset, s2.period,
+			 last->duty_offset, last->period);
+
+	if (state->enabled && state->duty_offset < s2.duty_offset)
+		dev_warn(pwmchip_parent(chip),
+			 ".apply is supposed to round down duty_offset (requested: %llu/%llu, applied: %llu/%llu)\n",
+			 state->duty_offset, state->period,
+			 s2.duty_offset, s2.period);
+
 	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
 		dev_warn(pwmchip_parent(chip),
 			 "requested disabled, but yielded enabled with duty > 0\n");
@@ -126,12 +144,13 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	if (s1.enabled != last->enabled ||
 	    s1.polarity != last->polarity ||
 	    (s1.enabled && s1.period != last->period) ||
+	    (s1.enabled && s1.duty_offset != last->duty_offset) ||
 	    (s1.enabled && s1.duty_cycle != last->duty_cycle)) {
 		dev_err(pwmchip_parent(chip),
-			".apply is not idempotent (ena=%d pol=%d %llu/%llu) -> (ena=%d pol=%d %llu/%llu)\n",
+			".apply is not idempotent (ena=%d pol=%d %llu/%llu/%llu) -> (ena=%d pol=%d %llu/%llu/%llu)\n",
 			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
-			last->enabled, last->polarity, last->duty_cycle,
-			last->period);
+			s1.duty_offset, last->enabled, last->polarity,
+			last->duty_cycle, last->period, last->duty_offset);
 	}
 }
 
@@ -146,13 +165,24 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 	int err;
 
 	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	    state->duty_cycle > state->period ||
+	    state->duty_offset > state->period)
 		return -EINVAL;
 
 	chip = pwm->chip;
 
+	/*
+	 * There is no need to set duty_offset with inverse polarity,
+	 * since signals with duty_offset values greater than 0.5 *
+	 * period can equivalently be represented by an inverted signal
+	 * without offset.
+	 */
+	if (state->polarity == PWM_POLARITY_INVERSED && state->duty_offset)
+		return -EINVAL;
+
 	if (state->period == pwm->state.period &&
 	    state->duty_cycle == pwm->state.duty_cycle &&
+	    state->duty_offset == pwm->state.duty_offset &&
 	    state->polarity == pwm->state.polarity &&
 	    state->enabled == pwm->state.enabled &&
 	    state->usage_power == pwm->state.usage_power)
@@ -246,10 +276,11 @@ int pwm_adjust_config(struct pwm_device *pwm)
 	 * been configured.
 	 *
 	 * In either case, we setup the new period and polarity, and assign a
-	 * duty cycle of 0.
+	 * duty cycle and offset of 0.
 	 */
 	if (!state.period) {
 		state.duty_cycle = 0;
+		state.duty_offset = 0;
 		state.period = pargs.period;
 		state.polarity = pargs.polarity;
 
@@ -555,6 +586,41 @@ static ssize_t duty_cycle_store(struct device *pwm_dev,
 	return ret ? : size;
 }
 
+static ssize_t duty_offset_show(struct device *pwm_dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return sysfs_emit(buf, "%llu\n", state.duty_offset);
+}
+
+static ssize_t duty_offset_store(struct device *pwm_dev,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
+{
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.duty_offset = val;
+	ret = pwm_apply_might_sleep(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
 static ssize_t enable_show(struct device *pwm_dev,
 			   struct device_attribute *attr,
 			   char *buf)
@@ -669,6 +735,7 @@ static ssize_t capture_show(struct device *pwm_dev,
 
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
+static DEVICE_ATTR_RW(duty_offset);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
 static DEVICE_ATTR_RO(capture);
@@ -676,6 +743,7 @@ static DEVICE_ATTR_RO(capture);
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
 	&dev_attr_duty_cycle.attr,
+	&dev_attr_duty_offset.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
@@ -1639,6 +1707,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 
 		seq_printf(s, " period: %llu ns", state.period);
 		seq_printf(s, " duty: %llu ns", state.duty_cycle);
+		seq_printf(s, " duty_offset: %llu ns", state.duty_offset);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 60b92c2c75ef..03e3fc00d236 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -50,6 +50,7 @@ enum {
  * struct pwm_state - state of a PWM channel
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
+ * @duty_offset: PWM duty offset (in nanoseconds)
  * @polarity: PWM polarity
  * @enabled: PWM enabled status
  * @usage_power: If set, the PWM driver is only required to maintain the power
@@ -60,6 +61,7 @@ enum {
 struct pwm_state {
 	u64 period;
 	u64 duty_cycle;
+	u64 duty_offset;
 	enum pwm_polarity polarity;
 	bool enabled;
 	bool usage_power;
@@ -129,6 +131,15 @@ static inline u64 pwm_get_duty_cycle(const struct pwm_device *pwm)
 	return state.duty_cycle;
 }
 
+static inline u64 pwm_get_duty_offset(const struct pwm_device *pwm)
+{
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return state.duty_offset;
+}
+
 static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
@@ -160,6 +171,9 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
  * ->duty_cycle value exceed the pwm_args->period one, which would trigger
  * an error if the user calls pwm_apply_might_sleep() without adjusting ->duty_cycle
  * first.
+ *
+ * ->duty_offset is likewise set to zero to avoid inconsistent default
+ *  states.
  */
 static inline void pwm_init_state(const struct pwm_device *pwm,
 				  struct pwm_state *state)
@@ -175,6 +189,7 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
 	state->period = args.period;
 	state->polarity = args.polarity;
 	state->duty_cycle = 0;
+	state->duty_offset = 0;
 	state->usage_power = false;
 }
 
diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
index 12b35e4ff917..2d25ac5de816 100644
--- a/include/trace/events/pwm.h
+++ b/include/trace/events/pwm.h
@@ -18,6 +18,7 @@ DECLARE_EVENT_CLASS(pwm,
 		__field(struct pwm_device *, pwm)
 		__field(u64, period)
 		__field(u64, duty_cycle)
+		__field(u64, duty_offset)
 		__field(enum pwm_polarity, polarity)
 		__field(bool, enabled)
 		__field(int, err)
@@ -27,13 +28,14 @@ DECLARE_EVENT_CLASS(pwm,
 		__entry->pwm = pwm;
 		__entry->period = state->period;
 		__entry->duty_cycle = state->duty_cycle;
+		__entry->duty_offset = state->duty_offset;
 		__entry->polarity = state->polarity;
 		__entry->enabled = state->enabled;
 		__entry->err = err;
 	),
 
-	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
-		  __entry->pwm, __entry->period, __entry->duty_cycle,
+	TP_printk("%p: period=%llu duty_cycle=%llu duty_offset=%llu polarity=%d enabled=%d err=%d",
+		  __entry->pwm, __entry->period, __entry->duty_cycle, __entry->duty_offset,
 		  __entry->polarity, __entry->enabled, __entry->err)
 
 );
-- 
2.45.1


