Return-Path: <linux-pwm+bounces-3133-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D896F886
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC52283503
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74781D2F61;
	Fri,  6 Sep 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qc2lHf4n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FFF1D2F67
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637421; cv=none; b=Zc97Sbpx/oybIF3vcU+6C8l6qlV9QQghcXcsWxjVusYVrL1MPl52ncQaJwPgw6jjD8K542OSSwpTlyAO+/MH0LexupiTPw6xHSWJEejVcDMdpHsIfMMP1NSIuiCWKcV/Wr1DzMogYVucb1sQgwzKcFxxNGXKyyPBjVKgpW6l64A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637421; c=relaxed/simple;
	bh=0lhKsC6PAK0yWbkqMl0Cs8Xin5eJnmMcxurW1r1zin4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qk0iDtLWQwz6PCMl2JPybESKGZmEneBmwhtEqvnoPZFqNwlXu5F4vTxWrXotoJxIt8q3b5KpbLVCQ00y90/8Lx4+ltdow7n4Z+5FbadZ9llSOEnN820qzTCJDV6D7g5YR3tCyngKuA43xaS8DlFDKTnl/5qT8jjgJkbQcxCdIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qc2lHf4n; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86e9db75b9so274652166b.1
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725637418; x=1726242218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb9iQRGEXaHrFOsWlt0MrM/KOYCkZ0LIeqvtu3kK9IM=;
        b=qc2lHf4n5eJn9qwOnwoqjy3CeXMRFuo12W/RiHh99uEBZugrJJ7a18M8BZkxy9d7RC
         3B2O3DTy2q1cFTlJErztQWCE5cMaVlPiEn+1+Gd4e1tHZ8WgKqiHPysn513lfJmlxX5p
         YrtEc0DosJ4Yt+IOhtzC6gvtMAtCieHg88hdN07xLUiCspOHELw08ztB/jtyqG9kmud2
         xYyi8JzLinEJkdimdPVnLormgsf5Vir6N+Cyz8KNMw9Xq9zmcxGY6cGaQssLvBLNednS
         SMJbv4YbiJ206JjnbmQg+yrIRryf4C3RCNRm+QunTpr/svBYcNZvxfwUtAIrU6izO2ed
         vO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637418; x=1726242218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jb9iQRGEXaHrFOsWlt0MrM/KOYCkZ0LIeqvtu3kK9IM=;
        b=YAllhUv5AaA92a43MNbIGdL28Xdih56eVa7O1mTi6zlLSQ7CcjO8geGnpsvBVh4cpA
         P/8UkFlZatw02/mOXVCQLIHVBt3MxOyE1uxerb6QXaGCpIgusp+pEAF6G/tOwdliu5s/
         vP3z4whB8T4Yqb0SjHUSSnehhg7DLg6ULngqnVLPhO7pO4SdHUS5UmEHlug9sSCgeYCZ
         zI9dN7ofmLl3sI1RJJY8Q8ix3d9zXCm8NK++OlClBvbJD0UAzpR1/8d3k6dUa5km5+FW
         a0tJJ3aLLRQ13JKiMuZWkpQuSrZOEfK+LoglTcTi6qtPNL0+Oaom6eAbV7+ttmDkzqMJ
         fHGA==
X-Gm-Message-State: AOJu0YwP4wqSnXO+LEfeVGVn98eZrQYWhLcae5c6jFy/ZHahjyyHZkgo
	wVOTqo5LkpIUQGd952Q9u0n0iQl68truUN+hy/V9u5kw8u9bFehlhnAotNHzprcrIvXFyKucxg8
	x
X-Google-Smtp-Source: AGHT+IGfL0g9FoUtO6uuMIwM+SQAXJZQcNX84rXNTtyuRxtatS92d/wbU9aoeb+/NTK0jR14bKx9VQ==
X-Received: by 2002:a17:907:3687:b0:a8a:78b3:a291 with SMTP id a640c23a62f3a-a8a885bfdd5mr260820566b.7.1725637418100;
        Fri, 06 Sep 2024 08:43:38 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a61fbb088sm290608466b.7.2024.09.06.08.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:43:37 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Kent Gibson <warthog618@gmail.com>,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 5/7] pwm: Add tracing for waveform callbacks
Date: Fri,  6 Sep 2024 17:43:01 +0200
Message-ID:  <25699fb377f5eeeb4ffbc08fa590655c427d075a.1725635013.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6305; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=0lhKsC6PAK0yWbkqMl0Cs8Xin5eJnmMcxurW1r1zin4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrTbynwz/tfVcqQFsibO3cGsKbJOPeSfpqxiwOQDM7vN3 l/1luXsZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiDP/Y/7tz9ody5j7XSNS8 8Dv67Ypf6ozKP63Kfpt4HWFa+MMuKedUA7uP49w2xg9eL15ZRvV3sjwSPXmEibfpRhxn3dJM+Yu JRex1Acd7joQ8nSqn0/eed6n1kduZYfGTvia7f5kc5KbAl/1y2b1QLWvevzm7Pt9f7hbVqJDfFn MhMM/Fj9sz4NjPuS39Qn25lYWsfPE65VcX86++e6Ft6jrHHJ6fypmvblmJ/RbMrPi+4eu/nkOij kENhlUHuIqTn67nvDZ94gbxTtvTmtuWeqqxfqvJ+5zjsvEV05aaF9YLJzxa+OBkVsCioIc/Hvwv 9NaWYP96XMfLRUpm+Z2IyWJRT1uY57r1KhTYefbbrpoDAA==
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
index 16615a4673ef..7bc536b98d18 100644
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
index 8022701c446d..8ba898fd335c 100644
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
+	__field(u64, wf ## _period_length_ns)					\
+	__field(u64, wf ## _duty_length_ns)					\
+	__field(u64, wf ## _duty_offset_ns)					\
+
+#define fast_assign_pwmwf(wf)							\
+	__entry->wf ## _period_length_ns = wf->period_length_ns;		\
+	__entry->wf ## _duty_length_ns = wf->duty_length_ns;			\
+	__entry->wf ## _duty_offset_ns = wf->duty_offset_ns
+
+#define printk_pwmwf_format(wf)							\
+	"%lld/%lld [+%lld]"
+
+#define printk_pwmwf_formatargs(wf)						\
+	__entry->wf ## _duty_length_ns, __entry->wf ## _period_length_ns, __entry->wf ## _duty_offset_ns
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
2.45.2


