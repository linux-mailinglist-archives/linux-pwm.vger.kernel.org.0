Return-Path: <linux-pwm+bounces-2805-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF09312E8
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 13:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E254280EE3
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3F38F86;
	Mon, 15 Jul 2024 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JCYnHOO6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF816E877
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042212; cv=none; b=mofoM86t94VBLHCVSt4hLaWDZ5jA6J7f+LyN+ZW6VJbyZBerdtgvus/RBlfixOA7x8VeaC3gIKn3N5ChVPummG7xOBsOXO3vo6l3ZkUP46oGVrFfodornXAYTlJ35CMrmKt5xkmUFteXosxsGJ6EALB/9dWG/5lv6I1wZ8wEJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042212; c=relaxed/simple;
	bh=0pN0iqor1z+DV89wl8twrhs/AG59s6z16IXryvzjYMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Brd+3M//Jm/q23UTr75xhUqJKh9tQPcsnYlMJ1hdBEVWWiJpaIFWw03AjRT8QbhR2ioMFOXEvAfnqqVizGkESWqcFSVTVidO8/gtSFs5pGO6ARGPIDPJgDDvwnczqOc1znZ0ZeYc/BVS5f9CSFqNQLMdJfFvaxCLXNpDAm8vTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JCYnHOO6; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ed741fe46so772994e87.0
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721042208; x=1721647008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXjmDPi9ij8EB3PckcTa/0hQYlCtWg50oWxnmiRrmUY=;
        b=JCYnHOO6u8zBxyGWV3s5btyQ51e3RtUctbeN0AP1VLXLaY4TZwzXQy4ojXOvIVEb9N
         AJTcYB0Gn8w5m3ktXKYMOd8WkP6hid/grNtU5ZgCPKza2Km33K1vPd93PxSzD5iMMtMg
         ufq9k5Dym6hzWJ3nmzBPZnrXGCYhgq5Y9ZwYFuQpcpMiAM6fec3Qdch/LZDkHnhQDnsc
         gxHNj5b+mDiHz+h6JuRIQDwv8tPCVZ9tU1z0ijgt+Hjokv9V/m8H6AF5ffNoqHy3LLyl
         PW8OJ/sX5Fbpcy4rvnAx4MK+RGByvM6QTZHdS+VehvhACF6cTcqotw6bWvdYCLCAfNix
         9bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042208; x=1721647008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXjmDPi9ij8EB3PckcTa/0hQYlCtWg50oWxnmiRrmUY=;
        b=f20CBDPaHlXP2JZh86DN/bHnOS/2J4do3mP+OCt8aJVr8S7zniOuUvdHs7kxITuR4W
         0ilgaiABECCyDlGOfyaLdwUP0le6ZKzeEmELXMJZcrCxppXIjbPE1hVDr5wkNmU0vuJf
         nq/UtXxPL4I+BJxfwD4gmn8tn4WWgfI5oQau9tOFhpgN5hXSq2kLFBsz3CyKsXavptth
         sp05xe8dHRgrZ/jQBoP+lQKbPQFfa4Msujz8xaNxPnoHk8k5phyKGM4DceqDsQhSn1Y0
         avzeXBwC0HpnPF0GvZtWdAvW2wsW0Mu3vib0RGtX5loOgXfM2QfJLB0HMe7kGKE5jvvZ
         o0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVyqRABlN+9MH2SxOsSxttnrKyLUrg8QgKMuC8PYVnU10bh+48K/curjhCoLL52KFXEMFimUEj2LDRx0kFV4661AFPUQs0JzY8t
X-Gm-Message-State: AOJu0YwuAMpFgEk1kf71Ck8/daYtI/arVY0MGx7JYGEg6cA/at7QWJfW
	xW5vgvGmmrc0y0F8PscZwUyt0ZV/+LlivCt7VuBI2M84GRQamGsFlvcRaCPdtJI=
X-Google-Smtp-Source: AGHT+IFvKMk67EcvYekQZXklX7aY4+vWHclvWx7Lm5Q8yKtltrJNIdjj7j8FetoCeP4ARmMuuFFclA==
X-Received: by 2002:a05:6512:1285:b0:52c:818c:13b8 with SMTP id 2adb3069b0e04-52eb998fc87mr13299942e87.4.1721042208456;
        Mon, 15 Jul 2024 04:16:48 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e994c6sm82660115e9.26.2024.07.15.04.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:16:48 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-pwm@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 6/8] pwm: Add tracing for waveform callbacks
Date: Mon, 15 Jul 2024 13:16:11 +0200
Message-ID:  <c4de1cbc52b96d08629abba2c2cf6f4480c55820.1721040875.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6271; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=0pN0iqor1z+DV89wl8twrhs/AG59s6z16IXryvzjYMo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmlQUF/fXSQoQV5iaz16ddPf5W129RboRjpXwGm a70YAbhTdGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZpUFBQAKCRCPgPtYfRL+ Ts0UB/0TwVKwrb/aPggwL5QFfSwq0/OYITCHRXxJFIRp07UYWsgIyHjnOYJ2DxcisYW7gq88u5O LEJUUQ1QKGXCHiu6I39sZxDO/qYYb34kWErs2dnyooPozu9ZTDAk3kqOiQruO98QuM4gNdtBNYr XqqmlOeK5laRkMM60jidARFB/wJEETjDtWYkshGCzn0lzhfq2VAZ6lxJF7oGXKNJLrwAtsh4nzU sOjf/39WwjPWVcOZSDqgqB5zPsxWlqDNJ5jq0mS9c+NDPyQe+/jIIIbv4gSZJmdRSyybomxsaws jFCgN32tKY9wkrlirrRYiRELfeL68kWDmfKCkChf8h0aVq6C
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This adds trace events for the recently introduced waveform callbacks.
With the introduction of some helper macros consistency among the
different events is ensured.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c         |  24 +++++--
 include/trace/events/pwm.h | 134 ++++++++++++++++++++++++++++++++++---
 2 files changed, 146 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 918915563606..21fca27bb8a3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -166,30 +166,46 @@ static int __pwm_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *p
 				     const struct pwm_waveform *wf, void *wfhw)
 {
 	const struct pwm_ops *ops = chip->ops;
+	int ret;
 
-	return ops->round_waveform_tohw(chip, pwm, wf, wfhw);
+	ret = ops->round_waveform_tohw(chip, pwm, wf, wfhw);
+	trace_pwm_round_waveform_tohw(pwm, wf, wfhw, ret);
+
+	return ret;
 }
 
 static int __pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
 				       const void *wfhw, struct pwm_waveform *wf)
 {
 	const struct pwm_ops *ops = chip->ops;
+	int ret;
 
-	return ops->round_waveform_fromhw(chip, pwm, wfhw, wf);
+	ret = ops->round_waveform_fromhw(chip, pwm, wfhw, wf);
+	trace_pwm_round_waveform_fromhw(pwm, wfhw, wf, ret);
+
+	return ret;
 }
 
 static int __pwm_read_waveform(struct pwm_chip *chip, struct pwm_device *pwm, void *wfhw)
 {
 	const struct pwm_ops *ops = chip->ops;
+	int ret;
 
-	return ops->read_waveform(chip, pwm, wfhw);
+	ret = ops->read_waveform(chip, pwm, wfhw);
+	trace_pwm_read_waveform(pwm, wfhw, ret);
+
+	return ret;
 }
 
 static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, const void *wfhw)
 {
 	const struct pwm_ops *ops = chip->ops;
+	int ret;
 
-	return ops->write_waveform(chip, pwm, wfhw);
+	ret = ops->write_waveform(chip, pwm, wfhw);
+	trace_pwm_write_waveform(pwm, wfhw, ret);
+
+	return ret;
 }
 
 #define WFHWSIZE 20
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


