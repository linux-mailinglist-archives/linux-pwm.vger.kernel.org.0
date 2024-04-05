Return-Path: <linux-pwm+bounces-1864-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43508992A0
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Apr 2024 02:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69811C219CC
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Apr 2024 00:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF41B67E;
	Fri,  5 Apr 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RTXSzEYr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876585221
	for <linux-pwm@vger.kernel.org>; Fri,  5 Apr 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712277034; cv=none; b=A4uhv4fEZvwqOuguyhP0SGGMR7Xug4Z3Nu8s23u4SuV/TkGavvp/t198ySICSsHJAckFUPmINw+hLLfxJXnAeT4Wkf4ItyoYbH3NrDUweVuwJf/D3+9dQzrqjRAE7XsFtpNq2E48bow58QEw/8DJ1RlMw7qaLBjVd7D6nUcPdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712277034; c=relaxed/simple;
	bh=BTYBKY7/0T17C/Uz4+eZw1Bz3APXr+o6lqJ6srlxLh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BA05HBlwkQDFjwJle4A31v0NYPq+xhJfiTcZJ38I/qRz2Fnc8XfctzuR/uyNN2kI9K3FkBOdScrixdEjgi8ZvPbiDThU5LCtw7QLrUlnSeR532xGStGHvqcDPXhxAX9+9Y82DC/7+sxjGI7RwWeMdwLKHlEOUxv+SW7VtdfuHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RTXSzEYr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61518d33293so18467247b3.2
        for <linux-pwm@vger.kernel.org>; Thu, 04 Apr 2024 17:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712277031; x=1712881831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx5GqimBqgoxRtDb4HVslENXxE3yEwOSa53ix8sBFFY=;
        b=RTXSzEYrTxabVpZfl6T62D8Q1k+niCTZ9Kb2rscLkDPejaZkdqqud10005edKx+0P8
         qS1rrogzrNK1JMXzpw9TSU43PGUJvoWh07KIxd5+9pcLI1if8MiOBTV+Y02xAyuWotIm
         jIPoCfhxt9apM4MI9Xt2RaP4Ga8vj73lWo5v+jH46L03tZJKC7dIm0JdbOKO6MJCmZ5h
         83NL3w75qvoJsKwT7A4nTz9ujCNWrrk+spF1J4HorodsKNBiHCiQtv0LeiWkS8ROEmcz
         Qhnw1xvIh7xeHunboqo1IHFBiiJbjx8xfV79bQqcNG/iBeXM1o5/tmenUwS7yIVwVQhp
         oH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712277031; x=1712881831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx5GqimBqgoxRtDb4HVslENXxE3yEwOSa53ix8sBFFY=;
        b=UNPPX9Gg3iePFcRzd7k42ZEgCgUhAZN9hvyQLzr/pfOt1VVd4b0oEC/Wk5La5kfExj
         6/hAGXC8BEmT/nOL8g9h7KgOyyVASagqDR6Pjl4ESAdAiN0sDE/1774u+IOCHpCVsW+5
         LXnBUOn3SV6HLDtmNCOBhWHc8Y4oDNMq7cSv8/CMPA4+Rzl5suBB0W6hrmkXoo4ULTFb
         nBiaFyJrhw8SGJp4o9f43+VVencvHGZjD6GL49k9qiFAMhPWeL2pKRVEOkP30Pe3g2+0
         hyYQrFmF/WPDIeB3Xrs607iUWFw4blY6ylCBn3GXPNirJpprP6RZo3yqN/qhiUDSeD3r
         8Jtg==
X-Gm-Message-State: AOJu0YxFGOQ34WDN0rAiAQPoJ0BzaCr7mkcgeiC7+jnKVuougIz/64y+
	iIvYNx+6U1bLWlRCmB8SwoAx6O3QDBRi80nXp2Ya+dqneg3ZSURUWKajfSiLcRfaN5FWGzutseN
	MWeM=
X-Google-Smtp-Source: AGHT+IHs3gngUHw+CwSkJUZTlJ+6mEDrxlOE7X4g8tSplLT8zaqzOgjvQ/enLCKFueM09BlvER07kw==
X-Received: by 2002:a25:69c2:0:b0:dd0:471:712 with SMTP id e185-20020a2569c2000000b00dd004710712mr4151943ybc.33.1712277031320;
        Thu, 04 Apr 2024 17:30:31 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id o4-20020ac86d04000000b00432feda5986sm232728qtt.35.2024.04.04.17.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:30:31 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [RFC PATCH 3/3] pwm: add pwm_config_full to pwm.h
Date: Thu,  4 Apr 2024 20:30:25 -0400
Message-ID: <20240405003025.739603-4-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405003025.739603-1-tgamblin@baylibre.com>
References: <20240405003025.739603-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function that performs the old pwm_config operations while also
handling duty_offset. Change pwm_config to use pwm_config_full with the
duty_offset_ns argument set to 0.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 include/linux/pwm.h | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e0e5960f91ba..eb018f11a48f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -347,33 +347,51 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
 /**
- * pwm_config() - change a PWM device configuration
+ * pwm_config_full() - change a PWM device configuration, including duty
+ * offset
  * @pwm: PWM device
  * @duty_ns: "on" time (in nanoseconds)
+ * @duty_offset_ns: offset (in nanoseconds) of "on" pulse
  * @period_ns: duration (in nanoseconds) of one cycle
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
-			     int period_ns)
+static inline int pwm_config_full(struct pwm_device *pwm, int duty_ns,
+				  int duty_offset_ns, int period_ns)
 {
 	struct pwm_state state;
 
 	if (!pwm)
 		return -EINVAL;
 
-	if (duty_ns < 0 || period_ns < 0)
+	if (duty_ns < 0 || period_ns < 0 || duty_offset_ns < 0)
 		return -EINVAL;
 
 	pwm_get_state(pwm, &state);
-	if (state.duty_cycle == duty_ns && state.period == period_ns)
+	if (state.duty_cycle == duty_ns && state.period == period_ns &&
+	    state.duty_offset == duty_offset_ns)
 		return 0;
 
 	state.duty_cycle = duty_ns;
+	state.duty_offset = duty_offset_ns;
 	state.period = period_ns;
 	return pwm_apply_might_sleep(pwm, &state);
 }
 
+/**
+ * pwm_config() - change a PWM device configuration
+ * @pwm: PWM device
+ * @duty_ns: "on" time (in nanoseconds)
+ * @period_ns: duration (in nanoseconds) of one cycle
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
+			     int period_ns)
+{
+	return pwm_config_full(pwm, duty_ns, 0, period_ns);
+}
+
 /**
  * pwm_enable() - start a PWM output toggling
  * @pwm: PWM device
@@ -480,6 +498,13 @@ static inline int pwm_adjust_config(struct pwm_device *pwm)
 	return -EOPNOTSUPP;
 }
 
+static inline int pwm_config_full(struct pwm_device *pwm, int duty_ns,
+				  int duty_offset_ns, int period_ns)
+{
+	might_sleep();
+	return -EINVAL;
+}
+
 static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
 			     int period_ns)
 {
-- 
2.44.0


