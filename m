Return-Path: <linux-pwm+bounces-3094-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544496D2BF
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7672D1C21AD2
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27E19258A;
	Thu,  5 Sep 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c/sAQubV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0F3F9D5
	for <linux-pwm@vger.kernel.org>; Thu,  5 Sep 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527221; cv=none; b=Zh+SUozIuRWFMBZt4UIUVrTIzBSHINbRySdBBbXJHzP6h4SeRqTcX4ZrRT0t9bp9Maws7Jht1/trjlFYyqE+GrScL3PwUGjXEUdcHOvmJvqR6CLiRXSm+OCZB/AksyI5Iw9L8HcTWLUl4hdzipyGReTRcwfyyGs1n0miVbpUW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527221; c=relaxed/simple;
	bh=9YAv06fWG26oklo9XdJghSD4Pq6gsCOwAPUQlIpjLWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nUwDApLXTwSEb2D+/sZKcgesdOIMBGavkG6SBkUI840QtOVC/ydRStFU+6RXCrfYIGDxu0u3daijAVSlA7d1a4syh7Zw+sjgsF+NKfH3VQ/UhI8fzYWHsQJ/vuNpt73uVdYc6nE4VaYWgP0e2V12KzM033HYmOSq/H8rvqAMKmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c/sAQubV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-535dc4ec181so450893e87.3
        for <linux-pwm@vger.kernel.org>; Thu, 05 Sep 2024 02:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725527218; x=1726132018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7a9eA0yUdZtAcxMzsuuAdHiqNG9lReTW+KBbCyW2EoM=;
        b=c/sAQubVjAL9lLuUoCQsTHxS0bgx6ieoSRxtfFz+grr9alllCewEUvo1w5eh1UE6oo
         /gxcR6jy+KaavGKAxJtUNicszLUSsjDUECIBqtSiRdq4j/co32VHvAIqZzB0bBeRupTB
         XMw02JCSmiEjwrMRKj9Z3IScBJxKQ3jtlSTt54bBGC92oUftQU328tRknxa7+cJW9eQB
         S7cGVN3GUBcC5Ndf0BcR4BoY5UGT4iTquNSpG8BZbWu/05s0Fu0n1DRDdmmOcSxGFGX8
         l7IM367AJeeeL1ewHWHLBNc+nRsqoWBql0yQIjsHvs5DkWzItWBKn8oSIFfZHBHNHUjr
         Wp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725527218; x=1726132018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7a9eA0yUdZtAcxMzsuuAdHiqNG9lReTW+KBbCyW2EoM=;
        b=rFO2FTUDJ++ulmx7iVOtV5Y61yH/lVx3lMy04L1kSMvXhH0a5biZ8oc9LS11DpJphG
         RQVy30qjVeZSj0a7EwP1kkoAlcdxHHMvCpI1YNWC0FxYdpTPAGK4tdGlrrwYn9jSB/bx
         AOM10zwUGVNV/yYapkXqTZhU6ptAebZAOXWkJbHuR51voHrUGQVIVFxeQMOSxEnGqRjj
         rBmuege6ZBG+fdlC7lKNBIZ/J9uupe7znmcAKnH9I/JRRdFQWsPqec/vboRPoB503ya7
         sQ+vRGU7WKUP0B9OtRzlxD94pAI7MQFf/Yo3cqT7kwbMHcgjcYSe5upqVWiL0ziSb44D
         MN/g==
X-Forwarded-Encrypted: i=1; AJvYcCUtkoEjk0IvUS0Ee/oyxijjsud7/ReZdP7XHl9iEMJvARPW8eAYKNaMGj2RcQeWLjOq/2RJSws8M7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlqctsy/LIjqiZklmIarqL/Zuy5TO8IcNCWTQWqCzNYlCKt/WL
	znZyZ97fNva/GB+LolSPmAz9YM+H+xeoi5iHKA1O0iv8bpu3jrrKUC5mlOj53c4=
X-Google-Smtp-Source: AGHT+IFSI5lj6rwftgWCpFh5EKDnxXc7Y6Pjuctts1dZ7WJpCwziqAL0dEhqVe5Igk8aaH8eoiJBbA==
X-Received: by 2002:a05:6512:33c8:b0:535:6bb6:e7b5 with SMTP id 2adb3069b0e04-5356bb6e93dmr1854557e87.9.1725527218002;
        Thu, 05 Sep 2024 02:06:58 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a61fbaf77sm107827666b.39.2024.09.05.02.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:06:57 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: stm32: Use the right CCxNP bit in stm32_pwm_enable()
Date: Thu,  5 Sep 2024 11:06:24 +0200
Message-ID: <20240905090627.197536-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=9YAv06fWG26oklo9XdJghSD4Pq6gsCOwAPUQlIpjLWc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm2XSTO2fuoUly3bf3CcnfPnw65cjTrC1kFih7w 70NCDxDEy+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZtl0kwAKCRCPgPtYfRL+ TkXxB/9k3jZR9QzT8q4GtLtVtIwb1PFWDvqB+N0lA5tphTB5aoqeaEuFra/CzE7hy0C0PgKPtIG 5SLugAFZukofLefe4TsoriqxVT6svyUgOSBZNUdzRpwG7QjcD1+guffh0d2L9phVROZXX+IO6PC 4/7dk8xiuP6pYqe+QVdWX1GBhQLBqbpnt95Zxvlz25khvECFI7tkU0o7bz0hBmDer71e3I/08pt p+GztrpUeY6/envxBziXn7FumPCfu8uL/VcOwQ9ytDDeNfEmKiZ6+ZtePsArEAm9Eij9wsi1o2q CICPfk/+HJnaj/hdQXj6bZia/41Z+g8HYm7TAqhngiIMuITd
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The pwm devices for a pwm_chip are numbered starting at 0, the first hw
channel however has the number 1. While introducing a parametrised macro
to simplify register bit usage and making that offset explicit, one of
the usages was converted wrongly. This is fixed here.

Fixes: 7cea05ae1d4e ("pwm-stm32: Make use of parametrised register definitions")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

during review of a patch to the stm32 pwm driver Fabrice pointed out a
wrong usage of TIM_CCER_CCxNE. While (I think) we both assumed this was
a problem in said patch, that problem existed already before and the
proposed change just moved the problem around. So instead of (only)
updating the patch later, here comes a separate fix for the driver.

I intend to send this to Linus tomorrow to get it into 6.11-rc7.

Best regards
Uwe

 drivers/pwm/pwm-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index fd754a99cf2e..f85eb41cb084 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -412,7 +412,7 @@ static int stm32_pwm_enable(struct stm32_pwm *priv, unsigned int ch)
 	/* Enable channel */
 	mask = TIM_CCER_CCxE(ch + 1);
 	if (priv->have_complementary_output)
-		mask |= TIM_CCER_CCxNE(ch);
+		mask |= TIM_CCER_CCxNE(ch + 1);
 
 	regmap_set_bits(priv->regmap, TIM_CCER, mask);
 
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.45.2


