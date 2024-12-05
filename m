Return-Path: <linux-pwm+bounces-4244-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CF9E4D32
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 06:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EF528540E
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 05:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D24193429;
	Thu,  5 Dec 2024 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQmwUZPP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8218FC74;
	Thu,  5 Dec 2024 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733375670; cv=none; b=jmsTS0Ceu3BxyXx4pDKMj8J4Tq66BIh31XzGYRZ++kE9kwELPA/2YHHCr+ReGFy3JnwQ6YTf9YJ+PY2eSGSa77ru3hb/4XSIw2TBSPBgy0j2qFS99pTsDL8h//wi+PYi2oHv5cDnMwJKfl6wHRMouqJ6kkjSulTnpyY52w3YTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733375670; c=relaxed/simple;
	bh=0v8WWRMuzt6FX0RhGjXlqLu6ssQtFHNHoGbnrfzaxIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YWI2MZwTg46anEMKNnKNMKkoIWCVMQlhmIS+OgO7OEkcZZsNa6AYWbqej9nRVkZBy41FMy2WjTjHyv6F2564Qq3uDLm8jMq+ix8Dtnlf7p5WTJFlMBMyp7E3x9WUGc34z1NAwuWsFbuG9uKNfYT+WZFwQr+cu8nEmq7C9J4Ak4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQmwUZPP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4667931f14bso7396591cf.2;
        Wed, 04 Dec 2024 21:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733375668; x=1733980468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zqIsEszztQaofpg7Apmowpob1qU+kHY4W1kZzuvfgdE=;
        b=aQmwUZPPNkyeMHl4N8JQs87avGSDR+QhGmIrRkUh6WckGAZhbuADJ02Sj/6bJpP2W3
         2F4iPKMPtkEi0AuXCkl0TD2CEjuE1gQXEy00lBX6rdPPvg4cg/tP1stY38R8uRsncycg
         q13bj1YElq3aE/dqn3AC70H8JGz4q0fAZpql2OT+W2qkkISB4YZhnfPikgT2dK3H5ylo
         d5x4ioBPyAbVC5+R0p60ZZijrtt49Wk01l0A8zGS1CFv5CNEQQxHSS40/QFUF05v2R+6
         la3mX6o35JJg2zQMdhy+ImGq1si51dBT9HTEAYVJQBu+VyUPNaEeZJwjcqY3QPx5+7US
         qb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733375668; x=1733980468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqIsEszztQaofpg7Apmowpob1qU+kHY4W1kZzuvfgdE=;
        b=tOcxE6DyVk+4qrehaccsDABX0zpLkksmjX6H7QFIB1QwGhfA2CAWxLwUturcXW6asT
         xS80TmRfqjk3qoQ7zFMZZ4rR04VY0rhGDQkCDnopQMqAk+6BQUNYfOz580vEbXTm+PRb
         s8BgS1bgn/cvhTiwesiywTRwDar3TrKI4hPkoHYlyico66nSO7uiWBE/kJai78cdvSk5
         jmEUAArHW6VdtxknOCWnpfpx93OBHiK/Ncs6hUBA94qNBHyVuefPz7kDKIuQCYCtPy36
         /nmei32tj4+eptpZns6KUnER7Oe68MxErICLQjYxKXvA9bbxvJ0/4Fos5LTYhJx/OyjH
         TAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4a4m6+xwm/WspNLX6hmXo7GgxPoV5zQlgAHt9e3mAjjPsyrMzDXhdbe70NmWFJnRjh9v8HWMMDQ6vjvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1VjgKfjLThH5w946Nahy3HiKWVpVAbQtn7rtU4xaippcRaXh
	XfYZyupsqCUj4V3wrNWCOaCZayvBPzIXR3WBxCcyNRjAPe+Qz7r/
X-Gm-Gg: ASbGncsHrfwXI7ipLwI9WN31Y43sbR+TctCtQ2p2b6hT0WgK/p1MkdhUv2sIuayRCrE
	Bzj2+7pY+DunvTKI0nzWd6q/DMan3WMEKjx4/hKKPnJs2pn0tzbP/a84y7ekczUCYpzoZ8Wx3WI
	xlxCRGvtp9aH9/jGRJmPoO/ypHA1XHeWmP8DXlUr+ftxwJ93YdX/LGsaJyMLRbnatng9/5pJxRn
	OAcaELeIaUYWwGFvXyk7Sw0Hr8SjqSFbf4R2xgWE+ANF+//VwbI5WTYHShJJQ==
X-Google-Smtp-Source: AGHT+IHzGOaqKMeldKYNCc7I7mqnuoEWuHAjvkW6hiehdx/v3xwHIV4vK2uaIYyHVBgVn+HHe4JCfw==
X-Received: by 2002:a05:622a:1992:b0:463:5bd4:59b8 with SMTP id d75a77b69052e-4670c712e88mr150275551cf.40.1733375667946;
        Wed, 04 Dec 2024 21:14:27 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467297c239dsm4041821cf.77.2024.12.04.21.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 21:14:26 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: fabrice.gasnier@foss.st.com,
	ukleinek@kernel.org,
	coquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thierry.reding@gmail.com,
	lee@kernel.org
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] pwm: stm32-lp: Add check for clk_enable()
Date: Thu,  5 Dec 2024 00:17:46 -0500
Message-Id: <20241205051746.2465490-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: e70a540b4e02 ("pwm: Add STM32 LPTimer PWM driver")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/pwm/pwm-stm32-lp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 989731256f50..4abef304417d 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -163,12 +163,16 @@ static int stm32_pwm_lp_get_state(struct pwm_chip *chip,
 	unsigned long rate = clk_get_rate(priv->clk);
 	u32 val, presc, prd;
 	u64 tmp;
+	int ret;
 
 	regmap_read(priv->regmap, STM32_LPTIM_CR, &val);
 	state->enabled = !!FIELD_GET(STM32_LPTIM_ENABLE, val);
 	/* Keep PWM counter clock refcount in sync with PWM initial state */
-	if (state->enabled)
-		clk_enable(priv->clk);
+	if (state->enabled) {
+		ret = clk_enable(priv->clk);
+		if (ret)
+			return ret;
+	}
 
 	regmap_read(priv->regmap, STM32_LPTIM_CFGR, &val);
 	presc = FIELD_GET(STM32_LPTIM_PRESC, val);
-- 
2.34.1


