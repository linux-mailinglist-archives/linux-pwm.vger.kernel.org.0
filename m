Return-Path: <linux-pwm+bounces-2449-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E1F9085C4
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 10:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC28B253E3
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E106E18508A;
	Fri, 14 Jun 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vMWWzvly"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1DF1836EF
	for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352646; cv=none; b=AvbTAsPvAC3AjCbC5ZOFXI5DglMsRlkVEk5IB+LgEj4k56W2ecOOA3CZ9aD4IBicML4dV6ZqX1WLFABIJBG3NsWiAmxqzThiW6VG9eTX6HSkyXfmhUusI9myoLuW853q4Wjo7wnV5Q0srvj+UEMtOYc1tGHrR4N5ij5vtbPxm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352646; c=relaxed/simple;
	bh=faoC0aeZeNEfEVsHdHCE5eVAIcbP0yTOlxeegES5oTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOYFyRkFJzrKxTzfVvTRh0BEe+Sp3gW/y+18pIhE681Im/NB349bLbrrK6QI7H9qUuz2FhjXj6toCF2YSHeDw9NTlvYB+IqBFdgOMa+nPOWWmYfnTpT2auhnX2Oc4IDQYN/aE80mQZxdUuZh4DiagA/OgCZH6iSBiW31Fh9Wqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vMWWzvly; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so2715160a12.3
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718352643; x=1718957443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuD6ZawdHgTLobNaH080KGKIoeRkT2obaCLXk+nSsgs=;
        b=vMWWzvlymJgAZ08saseAquGCd7SisZWi7FT68xwPRt9q/X5bx5vwIH8KTi7c2iSc+e
         TMogICm/XpxWGf18RpIen1F3j4aFYQQxvtYrp/undHdZaP/Lc9VrY7EX6yrC31iPo22B
         UGOSIk2yVUD54BSfV753MYV0Gt17kozgbm/Zea9ldAoA0MhFs2KyiD0I/ztlB6EXr3a2
         NijkVbOklNvVNv4ISuSr/RmL/hqlc+UrW/EHxAlvwrHlIBeB27GRQB6mfErksBV2I4Lu
         /HAilQ9mA4/mhkCmog57SNqDy65fiOKVu3F9JIXnY1cuXqudJAyU0rLCGZtcv8hgTop1
         tQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352643; x=1718957443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuD6ZawdHgTLobNaH080KGKIoeRkT2obaCLXk+nSsgs=;
        b=TB6/iWPqvsez/P9K/b2lUQLxse7VTb3BuLFUhzjLomMqLucCXoDAgMRfyOWjjMDf+E
         pNQEl1EgI6z60CAyI5izynzxhbhekW0++yPAhQpbRqm1AtkbpBShkBv6+62NaS3esi1r
         tciq+Y3n9ZSFIIShSapUBFUX6rwqAu7Ht0eQ33ZueZgUtvWENyU5xSR529i/IrdEWhBv
         lCRASYbXSU+5e0ORyXKIfWgSQFA6nHmk0pcCE5jVVi0iJM0lmkK7KMUVDtCXmfNSEw1S
         zC+sIPMIPyEv2z7r/UcIVUtcl4B8pVN090Ec2Ed1g5AHLo0lPIjdxxCne64Njm9iNVNW
         mjHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNYCjo8VV3lv14u+my0JXcshpnBsb+zUqI60ogwwiaio9j1a7vnwoOImXOJbTbTSqG90R+WRNW7Audurb13mne9lqU+o0/w9nk
X-Gm-Message-State: AOJu0YwrdMiFzVjWcvwZHX/hs37Y5FLA0QwdLOT9FQuBjsQTY8HJXPew
	7Drhf0VSHPGrKP7NYwOkCvmqWCDGo1lgp/Ox8QtLrwITSKX8dQK64l28EW0TmEY=
X-Google-Smtp-Source: AGHT+IEMqu+7qslewN1co84cafFARFjbCnFeAoVQrrE+AEY5A7JPk+vqDfcPd1ImJxyVDUqPyuhaJA==
X-Received: by 2002:a50:a699:0:b0:574:f27a:b3ec with SMTP id 4fb4d7f45d1cf-57cbd66dedcmr1630042a12.16.1718352643400;
        Fri, 14 Jun 2024 01:10:43 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbe89005asm793351a12.10.2024.06.14.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:10:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mfd: stm32-timers: Drop TIM_DIER_CC_IE(x) in favour of TIM_DIER_CCxIE(x)
Date: Fri, 14 Jun 2024 10:10:13 +0200
Message-ID:  <0735860960b1b38570bffa5b0de81a97f6e3230e.1718352022.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
References: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=faoC0aeZeNEfEVsHdHCE5eVAIcbP0yTOlxeegES5oTc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBma/rtEc7IHIN9qA4dnveZ4BER9+A4ph4YG5vIG 0BOSzwLPdiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmv67QAKCRCPgPtYfRL+ TjOfCACq2XuFlh4CnT20SjoRKQccZkfidv12GiVm+wFpwrQlC5PCRsW7L9WbNMds9LRBx5onDHh B9HwIJfTTzKlP4gcJ3NoqB6fONRz92enPgVK2EC5pzoWL5EcvhKzLJiG8qazQyqgkg1ZRn3VyU+ 3sunS2v8z2B/3ZkJ1wTHyB+AI4uI1upJvsc/zBOgomUmpXdyAd4zMLtLSH9aW/a79D7nl0ZWFxN KAk2p5c7c/G46lHyMy/Td6IXIdWg2iGloDUQkg6SPztybGlg8EMNdE/LGv+LizH1uKiRXTyCN5f Mv3ymYg98p7/bdw0r/CUZxVLyPnv5bMUM2G/y3fdCmA6MMKg
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These two defines have the same purpose and this change doesn't
introduce any differences in drivers/counter/stm32-timer-cnt.o.

The only difference between the two is that

	TIM_DIER_CC_IE(1) == TIM_DIER_CC2IE

while

	TIM_DIER_CCxIE(1) == TIM_DIER_CC1IE

. That makes it necessary to have an explicit "+ 1" in the user code,
but IMHO this is a good thing as this is the code locatation that
"knows" that for software channel 1 you have to use TIM_DIER_CC2IE
(because software guys start counting at 0, while the relevant hardware
designer started at 1).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/counter/stm32-timer-cnt.c | 4 ++--
 include/linux/mfd/stm32-timers.h  | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 0664ef969f79..186e73d6ccb4 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -465,7 +465,7 @@ static int stm32_count_events_configure(struct counter_device *counter)
 			ret = stm32_count_capture_configure(counter, event_node->channel, true);
 			if (ret)
 				return ret;
-			dier |= TIM_DIER_CC_IE(event_node->channel);
+			dier |= TIM_DIER_CCxIE(event_node->channel + 1);
 			break;
 		default:
 			/* should never reach this path */
@@ -478,7 +478,7 @@ static int stm32_count_events_configure(struct counter_device *counter)
 
 	/* check for disabled capture events */
 	for (i = 0 ; i < priv->nchannels; i++) {
-		if (!(dier & TIM_DIER_CC_IE(i))) {
+		if (!(dier & TIM_DIER_CCxIE(i + 1))) {
 			ret = stm32_count_capture_configure(counter, i, false);
 			if (ret)
 				return ret;
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 92b45a559656..f09ba598c97a 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -47,7 +47,6 @@
 #define TIM_DIER_CC2IE		TIM_DIER_CCxIE(2)			/* CC2 Interrupt Enable				*/
 #define TIM_DIER_CC3IE		TIM_DIER_CCxIE(3)			/* CC3 Interrupt Enable				*/
 #define TIM_DIER_CC4IE		TIM_DIER_CCxIE(4)			/* CC4 Interrupt Enable				*/
-#define TIM_DIER_CC_IE(x)	BIT((x) + 1)				/* CC1, CC2, CC3, CC4 interrupt enable		*/
 #define TIM_DIER_UDE		BIT(8)					/* Update DMA request Enable			*/
 #define TIM_DIER_CCxDE(x)	BIT(9 + ((x) - 1))			/* CCx DMA request Enable (x ∈ {1, .. 4})	*/
 #define TIM_DIER_CC1DE		TIM_DIER_CCxDE(1)			/* CC1 DMA request Enable			*/
-- 
2.43.0


