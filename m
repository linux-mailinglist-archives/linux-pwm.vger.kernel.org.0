Return-Path: <linux-pwm+bounces-5331-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC9BA7BB2B
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AE017B153
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F12D101EE;
	Fri,  4 Apr 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hhvsedpg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FBA7485
	for <linux-pwm@vger.kernel.org>; Fri,  4 Apr 2025 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743763739; cv=none; b=TUJ5Wee/ahgPCtMUomd2y9rrurvIlr1AghEYCQillyEuWdsqqukrlj7A202Z9izfIXobb/mV1gFFT/3ISJAOYi8ARl0X3Ztw6PVsbbkkSQyXdhlVQeFFJh+CKS+Am3hs9vet9KVFn0sWAnre3D8iU4BXc7NllxE9OzhITHyN68Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743763739; c=relaxed/simple;
	bh=bHBKMMvcZBccc2ss9+T5ho9sPatpd0hwuGPzzj2nFZA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c3XMUeCMUua8tbk87PctgR2eyAyf38LZm3oK8Y2zY8EIVzD9WapraCCSZCGHxoDfIzSCMNwaNtYnebZWhbVrwpJaUPJRq/Z/k/by4ONPO6xx5Y+zZKUyhazrtV4nuqY/BT8gsX4X67Ie7qkFFxFsYG8fSWwfORPMV+5JwS930VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hhvsedpg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf257158fso12849005e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 04 Apr 2025 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743763734; x=1744368534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QqpgNAz1PDtznG2fqs0F1ZiIFtbeAdI1ZdnRqYb1gxg=;
        b=hhvsedpg0NL5XtO07RB+GoJ3k45FOnpuVxDPxFUrD5n/wrhHMxsuSgi3M1nqDOVeg9
         rPEyVq41JHeECzTgZXGpwoccKpijYFs3ATEB7T7x3u9p/bzV39iw2Gqqa/tFozIjv+/l
         V6ZuvcGblx50SFuejOzC+uuiA5V/1iy6OOZq0ltl1orCt+lArX1/yEkGhF2aP3ietInb
         2OdtAEmd/GrC45ZGWtSlw++VH17cjrlVCZ5iFrJg5M3US8+ZCF1pebustz8xNWdSX+VJ
         37LjQPT3r0QsIrHZiQNtL8pZkTBNVVX4QY/EUmLRV3UJ27F+0/XQrjBVgWiQRpNVJqzw
         tmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743763734; x=1744368534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqpgNAz1PDtznG2fqs0F1ZiIFtbeAdI1ZdnRqYb1gxg=;
        b=f5Yxc0wY1OwUJQPhzaUYmGsFwOt7P2IHNhRSVfpwUYDIfmU22LdeZEWqvnagvGKYmx
         a5bYdamJvNkCB3alhn8dRX4GhwZ7LiGYtzIJjdbHcNjDVtds/xry2fV1PEUd8+Zdba01
         NiZ3ztbgtwrmiubJ+F2r095OpcJ7QLx/w1PocxTHCMPyb84VmHVpvVzBexBl1idtTdU/
         e35aFMBPG9ZS2FX+KPb8UGsLNB5v8YCrr+0Yk9SuVQyctg5XZtE3BFuGbg8cU7uimc1y
         UYBGOx28+7W89EY8ZRkz3dUznsNhdlEWtJuuJVr+wwloB0+HQ8r8iXU9r6pXSUdWDiSY
         OcIA==
X-Gm-Message-State: AOJu0YxIDaGdqjXcyFwWyygNVEvVHO/QhkCrNiuNwVOVl2kPp1IARpIr
	drqytRg3rPb0QV7FWStdXy79PpccWVlF9mum+NLfvkRqm7QWfAn8kP/68Eze2lqMDStWiOULLZP
	j
X-Gm-Gg: ASbGncvJ72FC+Vboou3zhO09LkbIuu6ZWInTljIAsXgRVJTsOInHwTbucgKDUt08BWA
	eqhnSozE8RUUco+Dpq+wczvhGEvFxeuZYHDW2uuZ2/j4yz8rLRel49ytmcGJO1vtDMSm4tqhehY
	7Wy9sW/ARtJR7rfTQYqt0W/0JaRvP0yI9r9JOb8yb6pzt7Me6TikJRFKMk2Y+6xYBKTolsFTSEd
	CjX+0zLajLCsgebeApzfkTQU+OZzEySaCdYx7G14hRa7Z/QTwRGHHHdU8Fd2BHW1XyoRDdRmi3d
	lZJG6yIJ55OnaQfAE7kh/q8oF4BcMZM/y4uddwOg73WOvljIxcEdpRUq2J3qx7ZpWXkzE9V7lJs
	+q80rzGVpl7Q=
X-Google-Smtp-Source: AGHT+IFqORZphhUcwrZvlfNjm3gDNY7Zaiywn8CqACRkHrXgUWpTEs7VmzcDndAU1j56LwgkyByAbg==
X-Received: by 2002:a05:600c:1382:b0:43c:f8fc:f69a with SMTP id 5b1f17b1804b1-43ecf8231a8mr24403515e9.4.1743763733530;
        Fri, 04 Apr 2025 03:48:53 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c302269a2sm4082417f8f.91.2025.04.04.03.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 03:48:53 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Add actual hardware state to pwm debugfs file
Date: Fri,  4 Apr 2025 12:48:42 +0200
Message-ID: <20250404104844.543479-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=bHBKMMvcZBccc2ss9+T5ho9sPatpd0hwuGPzzj2nFZA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn77kMNd3ath4U5LJNSSMb2S2foeCCFQFi1GUFL cT8eAJnNlKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ++5DAAKCRCPgPtYfRL+ Tu33CACtYjKqnmMBulj4G+4wo1wmKDBSrBZZOcb0mlsr6H6iwKUY9PeBrX/yogYUceuk0K5RUjF kWdqVNxIFgNaTGavwjXtp5fFtFttpUZ7dHmDwSMm66NHfMEf5l9Z5lRDG7O8h2h/iFV9WUs8bJG 2DvFMwNFH5vXVt2OLvoHVTuLeiYrDpiHtKBQTvGvgU4OfURITDD/PHzta2bdMXzjtCgkQ3FQ6Wi TS7nF4T7HFQxvempkEgwK6Mxu0HwgG5nXyFgGjdWQzsGCrdF3PlfjF3X1vFHXpmfb0W7eZuA13n jG2a3EIKnbiVgM75d4mFF/rDrosIT7xhGxzriB8VTHOIQ8wT
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Traditionally /sys/kernel/debug/pwm only contained info from pwm->state.
Most of the time this data represents the last requested setting which
might differ considerably from the actually configured in hardware
setting.

Expand the information in the debugfs file with the actual values.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a40c511e0096..4df6407e1c4d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2220,25 +2220,28 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
-		struct pwm_state state;
+		struct pwm_state state, hwstate;
 
 		pwm_get_state(pwm, &state);
+		pwm_get_state_hw(pwm, &hwstate);
 
 		seq_printf(s, " pwm-%-3d (%-20.20s):", i, pwm->label);
 
 		if (test_bit(PWMF_REQUESTED, &pwm->flags))
 			seq_puts(s, " requested");
 
-		if (state.enabled)
-			seq_puts(s, " enabled");
+		seq_puts(s, "\n");
 
-		seq_printf(s, " period: %llu ns", state.period);
-		seq_printf(s, " duty: %llu ns", state.duty_cycle);
-		seq_printf(s, " polarity: %s",
+		seq_printf(s, "  requested configuration: %3sabled, %llu/%llu ns, %s polarity",
+			   state.enabled ? "en" : "dis", state.duty_cycle, state.period,
 			   state.polarity ? "inverse" : "normal");
-
 		if (state.usage_power)
-			seq_puts(s, " usage_power");
+			seq_puts(s, ", usage_power");
+		seq_puts(s, "\n");
+
+		seq_printf(s, "  actual configuration:    %3sabled, %llu/%llu ns, %s polarity",
+			   hwstate.enabled ? "en" : "dis", hwstate.duty_cycle, hwstate.period,
+			   hwstate.polarity ? "inverse" : "normal");
 
 		seq_puts(s, "\n");
 	}

base-commit: a2cc6ff5ec8f91bc463fd3b0c26b61166a07eb11
-- 
2.47.2


