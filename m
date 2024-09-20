Return-Path: <linux-pwm+bounces-3302-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EFE97D335
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6E41C23A37
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6350513D635;
	Fri, 20 Sep 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v2A6KZq6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A213F431
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822726; cv=none; b=mRlwld9qunLkLmwqcKQLZiLVTZYv3oDfRVEp3E63GUonNpkIfISitSv0mb7C7HgKltynnOTiJY+jRKOtIZ5ssypPrmje7URbs+hKimYDm38Xuyy10dg+1UWpa5gR8L4M5jFOjNrWKBhNaRg1K+I1HSvP468E2GupBZ6v8cTauOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822726; c=relaxed/simple;
	bh=gZdqMH8oXfOl6cq31nv02mYK0c+V0C81z1p0WR1vLy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmt2faJoo0cnVjJPuwCiDFQ7LZ+qRygBs6Lzcmcgs6Mt68HSPdhpyp/nn+PfGl3fWnAXTv+ILYtjSDZMvIlcs4BY3Gw8hnYbwbETSLqjsueWcmqW6nicdFTQmiEef3lKSBqSviIjrl5pIZDi6WErGuMk8qtXof4/dVhWPkGPlKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v2A6KZq6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so5382265e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 01:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726822722; x=1727427522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyvnzhANddz0dxiv8L9gwaZD7AX+gYVBoZw7Mny87K4=;
        b=v2A6KZq614YNDf7J+KigF1e/s0+56Ylci1XuMp3WAfLgRZ3BFN1zWmSL1YIjSMHBEz
         X3tWIvfDkOkK397yfIPL/KjDlp8yR3UFJYF8j6zb7jFRwvBljNYsV6Eifbz/gTOeHs+r
         wfC/JkncElVOt2OTQBtpvx9aCOcuG7uL+1KhIlBIzvC7xEQvBzGXfR3idoVspeo7kP/V
         jWnorDo9JV44s+fMT2xDdfZ2zrLBdJNGEHzP2zRFBJMn6u3ZSXCC1L4C56VfRHYIqB7U
         o9L7Bq0/mWg9fWqvovhs2Gc01uJn+NJ9NPEf6OyDeZLFmsUXrp+x4HxXbLpvOkJx3cP+
         ZXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726822722; x=1727427522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyvnzhANddz0dxiv8L9gwaZD7AX+gYVBoZw7Mny87K4=;
        b=NuxyeiP1D1e0KJVRhQt9y81pOqrmxfmbGQS26hCgQiKt1s/Jib+K3VQT+0UEHtzko7
         jFV1x76lIdKv04Z4rWu0GKXy1qH4+RT4hC9Qeh8b7oTB6dyQGlzLIEQrSO1ErEC4fb82
         NtjLBt2WFBQIMMR5oPOktdeZNwxFHCLwjux+Z46WRyGlUjSXCpqZ3swJRn+Gbh2923ym
         TaO3xWRzP/b9d2s3rPiYmTs17vrpWO07Eyah9RpG1vulZYHTNjeLzt9WulAmBsBpOQCz
         4RrAZR0Ly/rHJq4UqJivyCI8gvQovdGedtB7cUbhl18B38J/ztEHhiIEqdK5PBSxmntt
         QJzg==
X-Gm-Message-State: AOJu0Yy1+2A1VUaX+sXjywfVGkTCzryNC6EbYThfguoFj/WG3xO+B/r5
	MQIb+RJMAgMn/xJyvoXnA+Be1HSJ2jg6XjNb0pHAxoXJJNI6kuGYv2ejxvz018ltiW1dRrgE7Y1
	t
X-Google-Smtp-Source: AGHT+IF74IaF3BZY0zxyWctKvGK2dCFXneFIST5v5/s1RO0JPggvKTtUF0K/LiBdLiNvpPRJ5HIH7Q==
X-Received: by 2002:a5d:4e09:0:b0:376:efb7:d19a with SMTP id ffacd0b85a97d-37a4319e028mr1024284f8f.44.1726822722523;
        Fri, 20 Sep 2024 01:58:42 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75b7ac86sm42343645e9.15.2024.09.20.01.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:58:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 4/8] pwm: Add tracing for waveform callbacks
Date: Fri, 20 Sep 2024 10:58:00 +0200
Message-ID:  <1d71879b0de3bf01459c7a9d0f040d43eb5ace56.1726819463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6305; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=gZdqMH8oXfOl6cq31nv02mYK0c+V0C81z1p0WR1vLy8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm7TkgLyLkRYAJsgOfG4kjb6c/Q1+kyC0n6vV2F 5uAphHqvi2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZu05IAAKCRCPgPtYfRL+ TqlRB/44H8ZbeoTFk9KmhnAh1OhgUYlm7OkMOR7aj//nj67NTrtlJ5AYirp4wN+uzAf0fFyNzRh Db+bLmKMMKpQzbPYDmpeHfWTlSOBbzQQYhOCERh47BG/6NoAGlOSM1fQjP1YxozalocMmcVDA/F JeiZkJKhLraz7E1cA750gXGGVIWr6l+k8sAa3+ps4GXsvDfeWEMfle5cje+ktY98sJn5mDpBECy QpEDjBSibhOrWim5Ll5yhhHS5S5ynjcLnE7NOa1yoI/K8+8Yusuqi+6COnGJADvjK+7KoGbUu0I zwhXkbOq9g7NZ34bml3JwqiyyXGXvQEKQUQZ/b8NK8r27uUI
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
index 1cefc6e9c10d..b688c72aba1f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -164,30 +164,46 @@ static int __pwm_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *p
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


