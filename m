Return-Path: <linux-pwm+bounces-6898-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116EFB13F5B
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jul 2025 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277E2189AA2B
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jul 2025 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294525771;
	Mon, 28 Jul 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JkmF3bo7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EE8479
	for <linux-pwm@vger.kernel.org>; Mon, 28 Jul 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718437; cv=none; b=IVFDt43bzZ0Z2bZt4bmZWIw3Ji9ehuAH2AHu9klCNYUuitZ9KQl/E3vEivMzGpWfMkBD+wDx5w8mrdZ/3Z2tda639WQB0WbfNUYCKbl0dnhs+qCH3kG6YCdbwX+rSI6lhjf1ekdLTw9zAXc89BaHWZfIT2WzyLYIMSWP9C1KGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718437; c=relaxed/simple;
	bh=fZtYDGMtNy+jMvHxxhEnc/USL2rISQ+e6krsDxkJqDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXXEpMxjVKfvitBLXVmhhiLyqO38XmGqpyFvnrLIz/+0BoU/Akj8vy5Z855EgPSqpOJB7DF3AXZZrb3n2PmgOmoZxpCPDXYdwJfpkdRrV2lLMoycKfjt6oGFuxRH0WscNuj3A4L1v8ir0DBOX6OQyrTCiMDjm5xVM4ZioMgYHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JkmF3bo7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aec5a714ae9so663207366b.3
        for <linux-pwm@vger.kernel.org>; Mon, 28 Jul 2025 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753718432; x=1754323232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVUxNp3pKPg0niLZHyJSf/h8YmI8EwmCwtNqXZm01O4=;
        b=JkmF3bo77NcO6iUF0SuPnVPzrXTxLT6J7jlGDIOU+jPFcyo2zo2n7EXDbt6sE27ilL
         bpiE0YwbiUDviHwEEPOy9Q5mDB8M8C2IVsTyneqyWDJkZt66yThLHXu0wibvqZqe1W9S
         ECXBXrRoJ9dtYaytF689yQZblgIOg3bRcD8maQM2mgfyQgdELzs67Mf3NVmx8cA/4ymF
         v6AlbagHoWioWW/ndX2EX4vOrPugImqKcOww5Os6gCY+JWcDfbVf3tn8on8rldMVrCwh
         6RndJ+Vg2JLQ+JQOJZ8KEu7553MfKyYPBGXHY8La5tb7tWs/hiaSyGp1STG+bTOl2UC1
         ng9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718432; x=1754323232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVUxNp3pKPg0niLZHyJSf/h8YmI8EwmCwtNqXZm01O4=;
        b=QIzkni4vc2FXlMGXGTC9H2u/Mvihgf96wrXxyB8KFncxuzH4oUEL0/7BVZLOwTe/ia
         S6g6SRUpEOOJrQRocTt3UjCIRxpdC7aisvQSyGDDNRZK5WaWv/Dacv5vJuqPX1atYZ2S
         VK44kYcE3TMXwX21rPd7hQlQPw79bYG1al+ty/X2cM/EVjgk66mEXvkZVP7iIzXXPgE+
         NEKdx3zlK+V7AfvrRFNgMdWIKAWbVIr0itLP7+M/rUOeTfZ1YjBM3EigGt+DRntRU4NQ
         HwznhX25yecS94jzptsgE9/irkKtzIYDiAdg2bapbMu1g5v3PdFf4Ygr48PphE+AN593
         ZAZw==
X-Gm-Message-State: AOJu0YwejjXO5vYRZWzWZO2u0buKK8WvVnblK/ohPBRv+aOtU8+PdWIk
	2ViUvri+mXSGRAwOJQF2Wt4zzFiDF5bISWzItfHVR805uwXmPNuHPkBnVmWaiTQEAT+qqYYSOJH
	H5JZ9
X-Gm-Gg: ASbGncs5PgjFGLqIqWpHKSSDSO4x7o3jVhUq0fOF2ig+UeJEWWCR3uMx5EODt+tsuXy
	MngJhjth5cUK60erney/f7afYh9+xKhqbVEHI+pkrHvZne3heeF5hVKK1hjaGY8MTAARMcciBIQ
	X9xzVlYqOglZfe7H92kVhMunpCVsZ0xNJP6XzY8aSssz21kfvPek9A6p4oNmSR51bo0bfoNuSC8
	oNeprortVJ0SYLgAk7kwef08nv7BcBBeWoAXMpsEfV51TN8iLkla7YWUXVaPzH6uXTz+bB+ZVky
	FUaOaoOTcxj7a1sY8ndp9uzxxkebwOauILUlvh8zOzV9wD6ywKge9oiI+J1dRIoQV4LJdlIl4wL
	8VuA/UtioqPdPRNS6XCncFRuS7Lf2WHkVAkPFsLKDIkLYCquMWgtiGnVwFqRE7iRG
X-Google-Smtp-Source: AGHT+IEGF1ItvOY6GGrUkAR7Qd0sme7zsV46UvWdWtAr4CkLeiv0GjNYRtz1B5xQhic43rbFMeLbCg==
X-Received: by 2002:a17:907:72ce:b0:ae0:de30:8569 with SMTP id a640c23a62f3a-af61c4bd9damr1504131966b.1.1753718431532;
        Mon, 28 Jul 2025 09:00:31 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af635ad6132sm435214766b.120.2025.07.28.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:00:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	John Crispin <john@phrozen.org>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/2] pwm: mediatek: Handle hardware enable and clock enable separately
Date: Mon, 28 Jul 2025 18:00:17 +0200
Message-ID:  <55c94fe2917ece152ee1e998f4675642a7716f13.1753717973.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753717973.git.u.kleine-koenig@baylibre.com>
References: <cover.1753717973.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3131; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=fZtYDGMtNy+jMvHxxhEnc/USL2rISQ+e6krsDxkJqDg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoh56Uj6Oi+9KhddNiomFo+ycjNuYPpvKgaT5At kGuj3HWo4GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIeelAAKCRCPgPtYfRL+ TvClB/4l4gylRaW/aRQaWgzol9iAARH0zJHVFndca9/Pq5xTDTgQRsiu30b6utvGzzraxqc9DeN xloMWp217+IcFSI041/BTbDGDCI46DrsnI3z9ZQ+ElfEPuIjNP0DHwdXWbl/keQiR5XHbXfFI7/ 8gQYBtRon4QMg1f9tAi6Ys7vxusFF1+fLkiGvGFaj4f61DrDrIei0/PG8hEZF43WKjDIM6xnI87 qXgydKJ3fFqyjKTxkh/uEWxnOvvmNkHlYwBA2gPKn1ogNzpHOQKppZWOQWOnZ1QFAsHw/Panrwy vv+1fWTy4sce+smXVZrJrXmdC05lfxp8VGxm8mCQseP/Ee5V
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Stop handling the clocks in pwm_mediatek_enable() and
pwm_mediatek_disable(). This is a preparing change for the next commit
that requires that clocks and the enable bit are handled separately.

Also move these two functions a bit further up in the source file to
make them usable in pwm_mediatek_config(), which is needed in the next
commit, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 60 ++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 6777c511622a..b6560e52c803 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -121,6 +121,26 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
 	writel(value, chip->regs + chip->soc->reg_offset[num] + offset);
 }
 
+static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value |= BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
+static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value &= ~BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -183,35 +203,6 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
-static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-	int ret;
-
-	ret = pwm_mediatek_clk_enable(chip, pwm);
-	if (ret < 0)
-		return ret;
-
-	value = readl(pc->regs);
-	value |= BIT(pwm->hwpwm);
-	writel(value, pc->regs);
-
-	return 0;
-}
-
-static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-
-	value = readl(pc->regs);
-	value &= ~BIT(pwm->hwpwm);
-	writel(value, pc->regs);
-
-	pwm_mediatek_clk_disable(chip, pwm);
-}
-
 static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const struct pwm_state *state)
 {
@@ -221,8 +212,10 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		if (pwm->state.enabled)
+		if (pwm->state.enabled) {
 			pwm_mediatek_disable(chip, pwm);
+			pwm_mediatek_clk_disable(chip, pwm);
+		}
 
 		return 0;
 	}
@@ -231,8 +224,11 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (err)
 		return err;
 
-	if (!pwm->state.enabled)
-		err = pwm_mediatek_enable(chip, pwm);
+	if (!pwm->state.enabled) {
+		err = pwm_mediatek_clk_enable(chip, pwm);
+		if (!err)
+			pwm_mediatek_enable(chip, pwm);
+	}
 
 	return err;
 }
-- 
2.50.0


