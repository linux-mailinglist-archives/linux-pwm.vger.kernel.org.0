Return-Path: <linux-pwm+bounces-5339-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D373EA7C889
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 11:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298FD1895892
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717531DEFEA;
	Sat,  5 Apr 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ohe4PiYD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA321D9A50
	for <linux-pwm@vger.kernel.org>; Sat,  5 Apr 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743845264; cv=none; b=OMOSXAnXvjJpfUl+UprIEA3WVj8XVqAudMIjOyvCIbiPrUB+oH/BY2alBYs2zb6b7PJAgNVB6pmDdwBZy+gUWJkG1VyL7rRyWVdfMcdPxP3DZh19Xc7zV63iRJLHRKyau1FaO+B3RHWT9lvU3I8F/+cx6KinenFXlkKncy4iTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743845264; c=relaxed/simple;
	bh=kHydnSM0ULFQvWKEWgBJvoEZ4DMOWEDjsKpnVZckxBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvR9ldXIzlzxkn2/uDpwScFi+NeMLG1EPXw2NqCl67hwVbGvbE1lMT8YSsStXShEy5r3oelPClAbOTZNVDlrk1NjHQjs+TXWY8Om4PRsQBK/MhMh0ALufac8I2PB4uJ3ZA2uAVuGr1FVRLZxbk6ASSK1xK7OhfR88zOTYPBo3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ohe4PiYD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac25d2b2354so500445066b.1
        for <linux-pwm@vger.kernel.org>; Sat, 05 Apr 2025 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743845260; x=1744450060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vhjgPM25WIrJtvsOvWD9TP3Lhl6m8KVBdL4zwgprPU=;
        b=ohe4PiYDgrpsxz/DY/y3mtxo4mL1h2T3OXdq97MP28DcryLF766hIKN//ZuSzUygVA
         nRoFH/6Xd1a/C388HOKA4DKWYxCnMPGUByACZHwt587DxmNAgSHvu85vaumu5eYTrPk1
         900FXqLQVolycSABeOrubG2zdvLSNSoIm+T20GhG3W2xIcUHsoudMzkIJN6R6PXoRXwV
         MLauL9QjaWsJrCIOSyM5/Q151BtOffcTXdPuM5Pe0xOHgVU1WxeqNMFfB2Vidp/eVgsh
         ArlXnpB3vv/CTIFRJiwfZX7/KKbVgqB3VcXB+lpOwbiOGowgDb8H4++k9EWsKSkz3oQ5
         VZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743845260; x=1744450060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vhjgPM25WIrJtvsOvWD9TP3Lhl6m8KVBdL4zwgprPU=;
        b=eo0hWEXnRj91QqvHKjTlBOY96pFMj/Hxb9UPz2Yu345YDBFhJLz8v8qbHFzbtRTjeW
         CUrrGgn0i9YbsoU+w+DCreBKWpjiYQvXCE2DkbZaUuBdArmdNxAWcPpQ3pi+j9OiYn3h
         gp2sLMbDzlaEOhYznpIGXvF0641zmS5bRdLrDqs03xDaavFJBrHrOgw9sgcwYGrBn6AD
         V5wlOxZts8J3UEBTSQtcCIuG9L11ZZhk996aOo4ZhXaVKuHpkljooBJjvjHTpGJWiMKB
         MWjsi+1ptDC5Zg67jaS//8OYL22TflTIeELoZO1aqGNygOohUnSZhWlbbu8o0JoTyLGF
         QBGw==
X-Gm-Message-State: AOJu0YzVdJtlExrssUEKCL4aa0KxRUzcxgTq68yJ/6tgvu0NUoapNvVk
	xxmtNv1xX88pS7CA6KowZRnBOB1llYNTSR1Dd8NI9/Az1lWYFVI9VNcLl7797GEru6ddGJaSNF8
	r
X-Gm-Gg: ASbGncsZhHLBZnQ/mPatJAE0kIQBF63nb0AJZKPW6qN1ZacY5VoNxCjGreLRe76hzvT
	HjlsD4munvSp7Xa4CaJ36exERAY47zFiNxUB1x8ssq0VaiatZvUSMqo0NE/uistBeKKU+gJbf2A
	N5NSXkbZV+l44DjORS1IsRi2xffif0P/+CRLFWweWqVEbqheIzJ/lVD2/b2vWsCPzGsdeKC1Y3/
	ZNK2ogVA/myJXvt3DP3Obfy+NJzgvsxgxudKA+sCy3sZFT9KnFUsYm6c9TNV0YXsjRlbJdoJPbu
	fDMDoRJJW8aXRJ31GS4DU+oBwNrZGbnjjKyp9r5ObRKA3WNW9Q==
X-Google-Smtp-Source: AGHT+IGxU6AQk/lGxA5BuJalTi4YDJdWHCrI3Gxv3qwNMs4ENzrJKR1Xxmjq53bryBeUQ1gqPpBg8A==
X-Received: by 2002:a17:906:f588:b0:ac7:7526:46a7 with SMTP id a640c23a62f3a-ac7d6c9f9f8mr456183566b.1.1743845259603;
        Sat, 05 Apr 2025 02:27:39 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7bfe5d3d8sm392574566b.31.2025.04.05.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:27:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] pwm: stm32: Search an appropriate duty_cycle if period cannot be modified
Date: Sat,  5 Apr 2025 11:27:13 +0200
Message-ID:  <f0c50df31daa3d6069bfa8d7fb3e71fae241b026.1743844730.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
References: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=kHydnSM0ULFQvWKEWgBJvoEZ4DMOWEDjsKpnVZckxBc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn8Pd1OuSd8laVmWsGMsZDQ3jElzoOQdmOU0iVj Pfwnc8P+kaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ/D3dQAKCRCPgPtYfRL+ Tkw/B/9jCyatQhCnULqdSAYE6atXCRb8xNFBivDhozOExipctqkbMkUxZN9AKJ1YgwFfWHLNl0z PUSP8gpGwtEQUxTzzp2s5toba5GXknwV0rO6+9YdTjf5SlLRVO9Vuru9m3Z6I67iUD7FG+8/20T hftKLgmwm1MFOxcN1nEr+5L9o9Il8jAkXqLMNWPtkiKBFDz3s4WDY6Utex2YaiDmbUdYGJTUOuM 3kXU1Dbmc9xQDzmoJPIU+ivoT7mGih87U1/i4W7s2iaJbgDM7KXly4D591nvm3oGGu9BMh4DKEn 9z21R0ghSUi0Z2k+g2BOV3Esx3ZQWrT//64X88x1buPhHoD6
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If another channel is already enabled period must not be modified. If
the requested period is smaller than this unchangable period the driver
is still supposed to search a duty_cycle according to the usual rounding
rules.

So don't set the duty_cycle to 0 but continue to determine an
appropriate value for ccr.

Fixes: deaba9cff809 ("pwm: stm32: Implementation of the waveform callbacks")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a59de4de18b6..ec2c05c9ee7a 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -103,22 +103,16 @@ static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
 		if (ret)
 			goto out;
 
-		/*
-		 * calculate the best value for ARR for the given PSC, refuse if
-		 * the resulting period gets bigger than the requested one.
-		 */
 		arr = mul_u64_u64_div_u64(wf->period_length_ns, rate,
 					  (u64)NSEC_PER_SEC * (wfhw->psc + 1));
 		if (arr <= wfhw->arr) {
 			/*
-			 * requested period is small than the currently
+			 * requested period is smaller than the currently
 			 * configured and unchangable period, report back the smallest
-			 * possible period, i.e. the current state; Initialize
-			 * ccr to anything valid.
+			 * possible period, i.e. the current state and return 1
+			 * to indicate the wrong rounding direction.
 			 */
-			wfhw->ccr = 0;
 			ret = 1;
-			goto out;
 		}
 
 	} else {
-- 
2.47.2


