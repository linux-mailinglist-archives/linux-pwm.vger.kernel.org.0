Return-Path: <linux-pwm+bounces-6516-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A41AE6E70
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C84C97A258E
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEF826CE3F;
	Tue, 24 Jun 2025 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NTVSJeZY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9A298984
	for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788996; cv=none; b=lCI+NR00vU7mmowofibkAWVgsPUidj81nZeMvjPFN/z3P4iPjo0sIMTmN97SbKZqSPGh0CINxzX/2qDhoZScI31P0x8knhnW5nQSabO4t4RUO35e454KR+xF0ShDCkTHc0LV8kB7VFLShoptqci8FikavDZ3PW+ARoTaz6CZh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788996; c=relaxed/simple;
	bh=DO1LppBx8IVH6D+GUjvF5jlyRVSmFmRfdcql06N1lgY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0AQr++JadAVPpVpk6IDnM2To0evxSkv9wbARhlRB2lHPwdO+g6pEtUT2ekDxqPWaHxNthRmOiwBy2korqeKUJBB/3tdAcDnRr0Ty+w+UD6L4SvCp9C/QInpF89sSz6RE/xCowLOLbzKWzwl3ctisKxZ8pFvBcNqM5dPuBvve6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NTVSJeZY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-adb2e9fd208so132498966b.3
        for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750788992; x=1751393792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CncuNAFSte8Xrf31fizDhz4RiIfpYyBGmk57DMSt4s=;
        b=NTVSJeZYb4+JPmyZ6uvmzYtR3sNBMA2OtB82vlvtaF1EPF3yXpS2x1vHBMBr1zWttc
         gmkzxbPJLSOMChOYl5QwZ2iSfHkCgIffp7LmTRNPeicZjJ5nHqUNkL4CK11flc0wZBQx
         aYHQ3MWP7fnVplnP4HZFGCtXf4viIuokNyttKgfmEbJb8h6DpsSyn4OqXCTMx8GbV2rs
         1s09ikipg0vBwoUI5o7F7hWkbQlNPDosME0H7LlfBHlxyfP8ueT4ujeMturPvKYYwU8P
         Eq9woyRquv7TctgzRf+pCEuYC2BLgWc4FvrbAIdA4FzDTD8I815PyfzNSqDCOP8bl+EM
         xqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788992; x=1751393792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CncuNAFSte8Xrf31fizDhz4RiIfpYyBGmk57DMSt4s=;
        b=dFpef5m+XmTcE572l489m41lUWLEeKGqQBX3mihWDxLCGYhtpedxX5ahNsOAteGq0z
         jQ8uUfC6rEsq3HiV/GaHDIveWza3JVQMDmJt/N+GNVBn5QEqD3XAtWKbWiJKtfTI3XbK
         Vfa1wA4bPD15mPkVmUXJMHdirjMpyV2SJARK1CYq48Jes2WFhsSDHvsFvoaVZT8n2MLT
         yCklQCNLCuX+5qMHdSJM1yjpmcEX6KNhhpi6CBXmAIqIgzXSSf8tpmet8CKFE9vykglh
         jLPA9k9mA7z1bTuDkf3KORcyqgUxjerR5V9d08wf184WZRujoRd//iMxTyBuQk6zuPfm
         8agQ==
X-Gm-Message-State: AOJu0YwAN96axa55CmInnNkjiEX2CQZLpkLyxO0nwxzOOThthY60qu7O
	Jfbga8zBO/rvkmRLzsuEFYq8jUa6Celhe32/ADEuFZNHyWAt3hgDyLbmE+eT+YQoCu44QbmZ0vM
	UH7DG
X-Gm-Gg: ASbGncsII/RdDRgSKqmAEsYLVf8k/JMF3WlEeiprwJxYcZRKzpPTdJq2tNdn09ujo/f
	rucG9XS6sf1Og578yhiKJTGehA4FuY2NXQlQYzBOEHhC5AHz0Nm08xEaka0kwqwZ1L3H+VEQC7r
	BYkMeLr90VJ8fCs144C6DCvu4IG+35wdSaI+Y2Tu4TSVv1eOKybV/Fj01zmjb4Gm7gbjkivXLwW
	4NHjqr2RwBbo++ZnJB+o3Q1HIybQCdoKhViuWckQ7fTarsn6SGvFRivc33p78WlijMdo35l3wkB
	eDmPRLZjg4+4C55Sx4tXwHQrFM0rD2AY17zx7j4LGeRWvQ2RWpaQXKM8lY5MGRNOCzw=
X-Google-Smtp-Source: AGHT+IG1rd3O5pizwMiHE9SYqTKOMkfSVa0XrUYnIHIn6DQgnAbQZzm2vcJ76EJK7tFIn3+s+PzTPw==
X-Received: by 2002:a17:907:1c89:b0:ad5:42bd:dfab with SMTP id a640c23a62f3a-ae0bf1542abmr19683166b.30.1750788992165;
        Tue, 24 Jun 2025 11:16:32 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae09d8eb43bsm272036866b.78.2025.06.24.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 11:16:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 6/8] pwm: sti: Drop driver local locking
Date: Tue, 24 Jun 2025 20:15:42 +0200
Message-ID:  <7ad150e40b45d6cb16fee633dcd6390a49a327a1.1750788649.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
References: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=DO1LppBx8IVH6D+GUjvF5jlyRVSmFmRfdcql06N1lgY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoWute1t5CLBg3gSjLwgMlqxmABQ+BT2zL5wE+H MfumF9WNbWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaFrrXgAKCRCPgPtYfRL+ Thz9B/4s/nfqUs9frvY/c9vcEparT710WnequTjqW0miVxm2tv9Pg34+ljAWvsOCDnbE+8TpRtf vb38dg4ZiZtZ4jiubK5/lUlbPfVwa+B8y4/hYphiwfdpKCyECzsPpTEFDd7HjhfJeTeYOF6rlyy RllJMILwkfYtUHWOrYVa1kxf+Yn3e4U0lJDrPlZT8B4bLQVroy3NVBD5OWD7yagA8xBrY5X2phV zK6yb37d4ouWqEvWoieTS3zayV3qUBrxPK+Usdheo9tNw2/NGwgbfaACxL+5G/Oa47qopLlCpj+ sWfb+0Jr8nmW7MajmR/1ldTwbOXSsySl6TTOp+rPnqzGLOWq
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The pwm core already serializes calls to .apply(), so the driver local
mutex adds no protection and can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-sti.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 396b52672ce0..3b702b8f0c7f 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -92,7 +92,6 @@ struct sti_pwm_chip {
 	struct pwm_device *cur;
 	unsigned long configured;
 	unsigned int en_count;
-	struct mutex sti_pwm_lock; /* To sync between enable/disable calls */
 	void __iomem *mmio;
 };
 
@@ -244,55 +243,46 @@ static int sti_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 	struct device *dev = pc->dev;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * Since we have a common enable for all PWM devices, do not enable if
 	 * already enabled.
 	 */
-	mutex_lock(&pc->sti_pwm_lock);
 
 	if (!pc->en_count) {
 		ret = clk_enable(pc->pwm_clk);
 		if (ret)
-			goto out;
+			return ret;
 
 		ret = clk_enable(pc->cpt_clk);
 		if (ret)
-			goto out;
+			return ret;
 
 		ret = regmap_field_write(pc->pwm_out_en, 1);
 		if (ret) {
 			dev_err(dev, "failed to enable PWM device %u: %d\n",
 				pwm->hwpwm, ret);
-			goto out;
+			return ret;
 		}
 	}
 
 	pc->en_count++;
 
-out:
-	mutex_unlock(&pc->sti_pwm_lock);
-	return ret;
+	return 0;
 }
 
 static void sti_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 
-	mutex_lock(&pc->sti_pwm_lock);
-
-	if (--pc->en_count) {
-		mutex_unlock(&pc->sti_pwm_lock);
+	if (--pc->en_count)
 		return;
-	}
 
 	regmap_field_write(pc->pwm_out_en, 0);
 
 	clk_disable(pc->pwm_clk);
 	clk_disable(pc->cpt_clk);
-
-	mutex_unlock(&pc->sti_pwm_lock);
 }
 
 static void sti_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -594,7 +584,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	pc->dev = dev;
 	pc->en_count = 0;
-	mutex_init(&pc->sti_pwm_lock);
 
 	ret = sti_pwm_probe_regmap(pc);
 	if (ret)
-- 
2.49.0


