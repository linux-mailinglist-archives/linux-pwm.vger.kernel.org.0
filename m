Return-Path: <linux-pwm+bounces-2725-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54892A08F
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C49282AAD
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BC077F2F;
	Mon,  8 Jul 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EpsIzj9I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763A78285
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435986; cv=none; b=GZsSRjPZS7O6+RCyVNJAV5HmCK/N13MEI2ajw2LkXk/lVq4lnP8N9ezeprFRSuJ/oPI3NS33GnnUeyD6KH1u+pllJsJLz0uK8ZRADyBlT+ts1bcAB3MLO0qfiMA26/ls8ON5FavM+mcMgTHkPXSiityJvUq9rD4xHa9APxVCX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435986; c=relaxed/simple;
	bh=E4du6S52fRbYsHamOTmJy4P2wwGTiQOfVTfLt80msyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tx2fRxn4Qa2EbC4tMyj1Vn1A7NKAa9b/83iO8P3jb4kLj1J/YPCNQ4NzGUxQEvxjsx186lFNH+SVcVnrhVXYrIyT9yc5fN0WvA6xExkB7Mdd8ER3s0GL+MNVTyTS6MOL8RkKAaU4QPnZRjGid2KZJDw7tlD0F6Xo5iZgGm66dkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EpsIzj9I; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so32398445e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 03:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720435981; x=1721040781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4D/brPtHccM1xEdoPbrKHPZtT4177lAMIyHBRhH8rg=;
        b=EpsIzj9I3BFPyEhGNQwnI1of2gzB2jadRRNSfDgXoAGPbDviUai9uNS10WaSsGDgG5
         Sl396N+VYSyrbr/y8aSAKhrgsoBQkTHSpU70rUNjuoVZ9nxKCVv1cT7zS2PMY7F6boaY
         Cj1Eu8zFuwLKQHJ7Vacg+tOoSeFY4b+scxSbZ7wyq9rNR/PUEH9Rw3tPXfB/MaYZLjT3
         Ki9TlioDVwGEq9vVNyYHRSbK4z8cHgH76JGYyChIiCnyXsyBVZZROIImkEqmzrHk4Tv/
         vI+iOKNhvSC+20GNu4utsDwhsae88NCl1iqGBwkrMKaoRBCZJYs0demm+5Qyo8d/p4ZK
         R/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435981; x=1721040781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4D/brPtHccM1xEdoPbrKHPZtT4177lAMIyHBRhH8rg=;
        b=sfV+p4Rw8as3RIiKhmjOdmT9FvoGvoYnPi4Hp4fzuMk8eigqxpFNngO05czbF/SbeH
         3PRcfJaYBYC3rGEyy9iiZHyBeEhO/wM38f+X77m2KW93AKyZp5JVYZ+5ins9qGRNp435
         LLlVdFImayu869SIxsx6yI/v0UkwHgwOF+yxgiBRECtHYOP9ITj1dgSXDKDEzjpeuQ1J
         zoKzfl11qOJeoz0vvSsJOh673no+90pifmN4BFSueami0OXQN5iBIxBNV0ZUnHdqay9a
         CgS91AHFaRHsKYbPWLq+Q5NF2ENjWAXfAS9WT4396+9nmtCtzwgZkrLVhBLYqe7xGfmA
         T6GA==
X-Gm-Message-State: AOJu0Yy5FG8Bjtq1RHpB6qw0Sf67qe9gYTIB09/y020vkJqP9I1nUy8W
	xjncXfc6Jknf7ggy8GHMvtvX+JcHnJIJPPX5O4pIya1HndDBML+cfSyn1FqX5ui3cTqKcZRUHnB
	i
X-Google-Smtp-Source: AGHT+IFFsSoiSvxcSbUAHayafMd+68AqCP0R7LoEBZomzgrICTjVKAqqWfgdDIoyTMMsmvnfESX2LA==
X-Received: by 2002:a05:600c:4a24:b0:426:59d3:8cae with SMTP id 5b1f17b1804b1-42659d38d8amr68737915e9.13.1720435980681;
        Mon, 08 Jul 2024 03:53:00 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36796bae9ecsm12493683f8f.38.2024.07.08.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:53:00 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/6] pwm: Add tracing for waveform callbacks
Date: Mon,  8 Jul 2024 12:52:30 +0200
Message-ID:  <7f7ce46efc76e02a472ed52ab1fc06c3575a14e8.1720435656.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8499; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=E4du6S52fRbYsHamOTmJy4P2wwGTiQOfVTfLt80msyI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmi8T1RWmi7qeHrGKBYS6lDIT6PDW/n5kMHXOzM 0NxS3rQ1UeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZovE9QAKCRCPgPtYfRL+ TuCrB/wKT0q/JFCs8fx2iUyr42UZ8UFC6LJHw8B18+5I00kTj1P6lY4j6/XLzcL3+Sj1pzsTE1K eNh9IMF5nFRy02hNwmdPZYsiKDHK+37xhNw3mIqGa53C0xrOArf4gXy15j10mIWU0w4jN2y6SNF kaXNSxdj8S9FHSDP8vjd+W5EY3LdB0YgShX2uD+Dz6c4SRf09vOu/fmrkBndD0P8hIzEu8grqVU Fck0AwKkJ68Ab/mHVxm276DcmWCpnjXwBN/Em8FQn4mGyI7rMZ97OQDklTO2oFtrAXMgDGe8SIq hG+efSVB75zZvdGATT+FwQ8u52cUI7Q1IITqpnFjaXCAXGp0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

---
 drivers/pwm/core.c         |  68 ++++++++++++++++---
 include/trace/events/pwm.h | 134 ++++++++++++++++++++++++++++++++++---
 2 files changed, 183 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d64c033c4cb2..a2320ae77220 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -138,6 +138,52 @@ static int pwm_check_rounding(const struct pwm_waveform *wf,
 	return 0;
 }
 
+static int pwm_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *pwm,
+				   const struct pwm_waveform *wf, void *wfhw)
+{
+	const struct pwm_ops *ops = chip->ops;
+	int ret;
+
+	ret = ops->round_waveform_tohw(chip, pwm, wf, wfhw);
+	trace_pwm_round_waveform_tohw(pwm, wf, wfhw, ret);
+
+	return ret;
+}
+
+static int pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+				     const void *wfhw, struct pwm_waveform *wf)
+{
+	const struct pwm_ops *ops = chip->ops;
+	int ret;
+
+	ret = ops->round_waveform_fromhw(chip, pwm, wfhw, wf);
+	trace_pwm_round_waveform_fromhw(pwm, wfhw, wf, ret);
+
+	return ret;
+}
+
+static int pwm_read_waveform(struct pwm_chip *chip, struct pwm_device *pwm, void *wfhw)
+{
+	const struct pwm_ops *ops = chip->ops;
+	int ret;
+
+	ret = ops->read_waveform(chip, pwm, wfhw);
+	trace_pwm_read_waveform(pwm, wfhw, ret);
+
+	return ret;
+}
+
+static int pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, const void *wfhw)
+{
+	const struct pwm_ops *ops = chip->ops;
+	int ret;
+
+	ret = ops->write_waveform(chip, pwm, wfhw);
+	trace_pwm_write_waveform(pwm, wfhw, ret);
+
+	return ret;
+}
+
 #define WFHWSIZE 20
 
 static int pwm_get_waveform(struct pwm_device *pwm,
@@ -155,11 +201,11 @@ static int pwm_get_waveform(struct pwm_device *pwm,
 	if (!chip->operational)
 		return -ENODEV;
 
-	err = ops->read_waveform(chip, pwm, &wfhw);
+	err = pwm_read_waveform(chip, pwm, &wfhw);
 	if (err)
 		return err;
 
-	return ops->round_waveform_fromhw(chip, pwm, &wfhw, wf);
+	return pwm_round_waveform_fromhw(chip, pwm, &wfhw, wf);
 }
 
 /* Called with the pwmchip lock held */
@@ -180,12 +226,12 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 	     wf->duty_offset >= wf->period_length))
 		return -EINVAL;
 
-	err = ops->round_waveform_tohw(chip, pwm, wf, &wfhw);
+	err = pwm_round_waveform_tohw(chip, pwm, wf, &wfhw);
 	if (err)
 		return err;
 
 	if ((IS_ENABLED(CONFIG_PWM_DEBUG) || exact) && wf->period_length) {
-		err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
+		err = pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
 		if (err)
 			return err;
 
@@ -203,7 +249,7 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 		}
 	}
 
-	err = ops->write_waveform(chip, pwm, &wfhw);
+	err = pwm_write_waveform(chip, pwm, &wfhw);
 	if (err)
 		return err;
 
@@ -213,12 +259,12 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ops->read_waveform && wf->period_length) {
 		struct pwm_waveform wf_set;
 
-		err = ops->read_waveform(chip, pwm, &wfhw);
+		err = pwm_read_waveform(chip, pwm, &wfhw);
 		if (err)
 			/* maybe ignore? */
 			return err;
 
-		err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_set);
+		err = pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_set);
 		if (err)
 			/* maybe ignore? */
 			return err;
@@ -443,11 +489,11 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 		 * high.
 		 */
 
-		err = ops->round_waveform_tohw(chip, pwm, &wf, &wfhw);
+		err = pwm_round_waveform_tohw(chip, pwm, &wf, &wfhw);
 		if (err)
 			return err;
 
-		err = ops->write_waveform(chip, pwm, &wfhw);
+		err = pwm_write_waveform(chip, pwm, &wfhw);
 		if (err)
 			return err;
 
@@ -548,11 +594,11 @@ static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
 
 		scoped_guard(pwmchip, chip) {
 
-			ret = ops->read_waveform(chip, pwm, &wfhw);
+			ret = pwm_read_waveform(chip, pwm, &wfhw);
 			if (ret)
 				return ret;
 
-			ret = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf);
+			ret = pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
 			if (ret)
 				return ret;
 		}
diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
index 8022701c446d..3b5b20d2aff0 100644
--- a/include/trace/events/pwm.h
+++ b/include/trace/events/pwm.h
@@ -8,15 +8,135 @@
 #include <linux/pwm.h>
 #include <linux/tracepoint.h>
 
+#define TP_PROTO_pwm(args...)							\
+	TP_PROTO(struct pwm_device *pwm, args)
+
+#define TP_ARGS_pwm(args...)							\
+	TP_ARGS(pwm, args)
+
+#define TP_STRUCT__entry_pwm(args...)						\
+	TP_STRUCT__entry(							\
+		__field(unsigned int, chipid)					\
+		__field(unsigned int, hwpwm)					\
+		args)
+
+#define TP_fast_assign_pwm(args...)						\
+	TP_fast_assign(								\
+		__entry->chipid = pwm->chip->id;				\
+		__entry->hwpwm = pwm->hwpwm;					\
+		args)
+
+#define TP_printk_pwm(fmt, args...)						\
+	TP_printk("pwmchip%u.%u: " fmt, __entry->chipid, __entry->hwpwm, args)
+
+#define __field_pwmwf(wf)							\
+	__field(u64, wf ## _period_length)					\
+	__field(u64, wf ## _duty_length)					\
+	__field(u64, wf ## _duty_offset)					\
+
+#define fast_assign_pwmwf(wf)							\
+	__entry->wf ## _period_length = wf->period_length;			\
+	__entry->wf ## _duty_length = wf->duty_length;				\
+	__entry->wf ## _duty_offset = wf->duty_offset
+
+#define printk_pwmwf_format(wf)							\
+	"%lld/%lld [+%lld]"
+
+#define printk_pwmwf_formatargs(wf)						\
+	__entry->wf ## _duty_length, __entry->wf ## _period_length, __entry->wf ## _duty_offset
+
+TRACE_EVENT(pwm_round_waveform_tohw,
+
+	TP_PROTO_pwm(const struct pwm_waveform *wf, void *wfhw, int err),
+
+	TP_ARGS_pwm(wf, wfhw, err),
+
+	TP_STRUCT__entry_pwm(
+		__field_pwmwf(wf)
+		__field(void *, wfhw)
+		__field(int, err)
+	),
+
+	TP_fast_assign_pwm(
+		fast_assign_pwmwf(wf);
+		__entry->wfhw = wfhw;
+		__entry->err = err;
+	),
+
+	TP_printk_pwm(printk_pwmwf_format(wf) " > %p err=%d",
+		printk_pwmwf_formatargs(wf), __entry->wfhw, __entry->err)
+);
+
+TRACE_EVENT(pwm_round_waveform_fromhw,
+
+	TP_PROTO_pwm(const void *wfhw, struct pwm_waveform *wf, int err),
+
+	TP_ARGS_pwm(wfhw, wf, err),
+
+	TP_STRUCT__entry_pwm(
+		__field(const void *, wfhw)
+		__field_pwmwf(wf)
+		__field(int, err)
+	),
+
+	TP_fast_assign_pwm(
+		__entry->wfhw = wfhw;
+		fast_assign_pwmwf(wf);
+		__entry->err = err;
+	),
+
+	TP_printk_pwm("%p > " printk_pwmwf_format(wf) " err=%d",
+		__entry->wfhw, printk_pwmwf_formatargs(wf), __entry->err)
+);
+
+TRACE_EVENT(pwm_read_waveform,
+
+	TP_PROTO_pwm(void *wfhw, int err),
+
+	TP_ARGS_pwm(wfhw, err),
+
+	TP_STRUCT__entry_pwm(
+		__field(void *, wfhw)
+		__field(int, err)
+	),
+
+	TP_fast_assign_pwm(
+		__entry->wfhw = wfhw;
+		__entry->err = err;
+	),
+
+	TP_printk_pwm("%p err=%d",
+		__entry->wfhw, __entry->err)
+);
+
+TRACE_EVENT(pwm_write_waveform,
+
+	TP_PROTO_pwm(const void *wfhw, int err),
+
+	TP_ARGS_pwm(wfhw, err),
+
+	TP_STRUCT__entry_pwm(
+		__field(const void *, wfhw)
+		__field(int, err)
+	),
+
+	TP_fast_assign_pwm(
+		__entry->wfhw = wfhw;
+		__entry->err = err;
+	),
+
+	TP_printk_pwm("%p err=%d",
+		__entry->wfhw, __entry->err)
+);
+
+
 DECLARE_EVENT_CLASS(pwm,
 
 	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state, int err),
 
 	TP_ARGS(pwm, state, err),
 
-	TP_STRUCT__entry(
-		__field(unsigned int, chipid)
-		__field(unsigned int, hwpwm)
+	TP_STRUCT__entry_pwm(
 		__field(u64, period)
 		__field(u64, duty_cycle)
 		__field(enum pwm_polarity, polarity)
@@ -24,9 +144,7 @@ DECLARE_EVENT_CLASS(pwm,
 		__field(int, err)
 	),
 
-	TP_fast_assign(
-		__entry->chipid = pwm->chip->id;
-		__entry->hwpwm = pwm->hwpwm;
+	TP_fast_assign_pwm(
 		__entry->period = state->period;
 		__entry->duty_cycle = state->duty_cycle;
 		__entry->polarity = state->polarity;
@@ -34,8 +152,8 @@ DECLARE_EVENT_CLASS(pwm,
 		__entry->err = err;
 	),
 
-	TP_printk("pwmchip%u.%u: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
-		  __entry->chipid, __entry->hwpwm, __entry->period, __entry->duty_cycle,
+	TP_printk_pwm("period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
+		  __entry->period, __entry->duty_cycle,
 		  __entry->polarity, __entry->enabled, __entry->err)
 
 );
-- 
2.43.0


