Return-Path: <linux-pwm+bounces-2447-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D719085BE
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A90289B77
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807151836FC;
	Fri, 14 Jun 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w36tNuUk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C818308F
	for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352645; cv=none; b=bVaVSJZTvxaDWy3+/dmxJDmjR0WI7nvTq0hO3Eozkn9drxXJsI9kuVf7t5f94Cmit+MGj0VctT4yRArK8+QBi+hDpk/gKo3vUUGyqivVY6NbhRwTgvz6Yj0SOyKLtq9Aew1A8+PY/vCmDpJTtC51UnCJWyDrHRxbEfSD7flvyKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352645; c=relaxed/simple;
	bh=rzCYE/3bk/hMF+mipoUC6ONZu29VOFN0z1zcfORBW4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuObjRf8o02LXvnqmb20YcIMqQ/PknjH1+KXwCIGjv13MrVt0LYM+0kwVC+cP3LeGDvrPpd3TuirTB1IB34yYm36HiqCqUU1Duzg5Iw/vWfxfq1yYaZuIvvdkcMBgpa+lEvSKFaKQ6Myi/lMKnxfziD39YttINZjhH9g9l4komI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w36tNuUk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso1873569a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jun 2024 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718352641; x=1718957441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDJb+30XWGo3fOOWnyAPx2kYHEfXh1qwrcJmklajAGg=;
        b=w36tNuUkjc8fjS1iVp/tbK6Lu/D8cjFXdKN4rDny27uKic/jG8kr0EXpGHTTZkvGCn
         sKlBbhtdGTIO0A6f02ZqIialCYZXeWOPXRhasoAZ8dN8pv9o6MxO3uueYGKNDdrDXIw1
         7an/qs2maw8cIstaRJNsvOANUDJGVm9hl0CG8VUnyRq/r/GjgRCPEy7fVhjXRcaaSU3q
         NVQY5qyP+AfFUuXsLqvbRDdeNynte/NIR2zpCYuZL6+SXS+zQOxFfDvwgHIPfSgWNd7L
         aFckpqiZSI5OFG+a0mRya/q5dAG7OP3WI2NSSV+SPEbJPSFtk0lOzT1g0GzX5wNWGZmY
         3W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352641; x=1718957441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDJb+30XWGo3fOOWnyAPx2kYHEfXh1qwrcJmklajAGg=;
        b=ftQ1aFMFOHV0ljaAVg95nh/J2slPMfq+In1NfZiiL1FW8jjLF2NWXig1PyuZjdeDTL
         unpDIdNDiStSKaFU/8Nb6YGHP22WLmIvpjOwZ6Cj9gYljz7TW3R3NddBHqoILm3IREmJ
         XSvOPjov9vYiw2Nh2Gg5Ff72DDGFQxsuuwzW+8zYyTv0GRYGrg6yfqOzAVsjA4oCFt+J
         A8nSz6WsQDBnbYurQczxad1DA/rQTBr4uGd5b1+G3Jee3gqnushVcL1cqQaOQmwUKkK3
         jFNIT9Q8OgHahZizHpPV3uMod6Wi5MN9pFbcLNdditItYcL3zc4InDn9yuZ0jGfFM2pM
         5OFg==
X-Forwarded-Encrypted: i=1; AJvYcCWSg7iV6x9OctXbCVbTnhMHfuAkV6d+JxQWKWjF3yog1vZThTnSWVFo+byhWfTUlPIjAj+XsZEiB/q0wqQKdPZEhcXbhSZfr9Jq
X-Gm-Message-State: AOJu0YyXNwpGei7yS4FQcDsUw9Jsd5EZTsk5bFqGVwAdeypInKRSzmfz
	eNdfuvaZ/LPNanOc8Mhb1iOYzjRRFEcP85ARYExq2v/SLzkYRN9eomvjCBg2zzs=
X-Google-Smtp-Source: AGHT+IHiNHJqlR8mT3oUPl2DXV11VEvXRIIrSCzlSDJRp9d5gUXu4U7hCZmdEkhW0Ih9qriTh4EXgA==
X-Received: by 2002:a50:d5dc:0:b0:57c:a4a8:70f0 with SMTP id 4fb4d7f45d1cf-57cbd66a2cfmr1372574a12.15.1718352640890;
        Fri, 14 Jun 2024 01:10:40 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdf52sm1951298a12.8.2024.06.14.01.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:10:40 -0700 (PDT)
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
Subject: [PATCH 1/4] mfd: stm32-timers: Unify alignment of register definition
Date: Fri, 14 Jun 2024 10:10:11 +0200
Message-ID:  <4c4ca7a4c1862e4683f83d19a1e5a75526aeb501.1718352022.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11404; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=rzCYE/3bk/hMF+mipoUC6ONZu29VOFN0z1zcfORBW4g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBma/rmhVGneoP1EPjedGN408zfkOG1o5SMZfJnv utKNEnwvgmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmv65gAKCRCPgPtYfRL+ TpKwB/4yPIHwc2dPX7917hThCH8hHNruyRpk0mcw4rlG1xXA2RpQNFBfBL13KOZ8el2HUM2EZEd VvFVFyO1/5xhetCN8OuwJv8JqBlEYlS8H8Ulps1RTEuSx9iInJxzG+/r17e3U4FvyjjcCi8W9+W LeQPVJNoArgr5wPqhAb7ogU2ubt1Umus0DyIGV4dO3Uqo/XJSHie26mpFYQJ/Cida3Ztj5fhL10 W46uayni6bCMG8RkLnzjbrqpGuBSapFOCYc6GOmzQEZi6xqTMya5xsrPyvWdl87DAwmEbyIAaP0 +jRClk7kY98oMXZcs6+wXJRHFE4Cdj03naSe6fqNAUASo0YX
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Ust tabs consistently for indention and properly align register names,
values and comments. This improves readability (at least for my eyes).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/mfd/stm32-timers.h | 170 +++++++++++++++----------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 9eb17481b07f..5794110b2b28 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -12,97 +12,97 @@
 #include <linux/dma-mapping.h>
 #include <linux/regmap.h>
 
-#define TIM_CR1		0x00	/* Control Register 1      */
-#define TIM_CR2		0x04	/* Control Register 2      */
-#define TIM_SMCR	0x08	/* Slave mode control reg  */
-#define TIM_DIER	0x0C	/* DMA/interrupt register  */
-#define TIM_SR		0x10	/* Status register	   */
-#define TIM_EGR		0x14	/* Event Generation Reg    */
-#define TIM_CCMR1	0x18	/* Capt/Comp 1 Mode Reg    */
-#define TIM_CCMR2	0x1C	/* Capt/Comp 2 Mode Reg    */
-#define TIM_CCER	0x20	/* Capt/Comp Enable Reg    */
-#define TIM_CNT		0x24	/* Counter		   */
-#define TIM_PSC		0x28	/* Prescaler               */
-#define TIM_ARR		0x2c	/* Auto-Reload Register    */
-#define TIM_CCR1	0x34	/* Capt/Comp Register 1    */
-#define TIM_CCR2	0x38	/* Capt/Comp Register 2    */
-#define TIM_CCR3	0x3C	/* Capt/Comp Register 3    */
-#define TIM_CCR4	0x40	/* Capt/Comp Register 4    */
-#define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
-#define TIM_DCR		0x48	/* DMA control register    */
-#define TIM_DMAR	0x4C	/* DMA register for transfer */
-#define TIM_TISEL	0x68	/* Input Selection         */
+#define TIM_CR1		0x00			/* Control Register 1			*/
+#define TIM_CR2		0x04			/* Control Register 2			*/
+#define TIM_SMCR	0x08			/* Slave mode control reg		*/
+#define TIM_DIER	0x0C			/* DMA/interrupt register		*/
+#define TIM_SR		0x10			/* Status register			*/
+#define TIM_EGR		0x14			/* Event Generation Reg			*/
+#define TIM_CCMR1	0x18			/* Capt/Comp 1 Mode Reg			*/
+#define TIM_CCMR2	0x1C			/* Capt/Comp 2 Mode Reg			*/
+#define TIM_CCER	0x20			/* Capt/Comp Enable Reg			*/
+#define TIM_CNT		0x24			/* Counter				*/
+#define TIM_PSC		0x28			/* Prescaler				*/
+#define TIM_ARR		0x2c			/* Auto-Reload Register			*/
+#define TIM_CCR1	0x34			/* Capt/Comp Register 1			*/
+#define TIM_CCR2	0x38			/* Capt/Comp Register 2			*/
+#define TIM_CCR3	0x3C			/* Capt/Comp Register 3			*/
+#define TIM_CCR4	0x40			/* Capt/Comp Register 4			*/
+#define TIM_BDTR	0x44			/* Break and Dead-Time Reg		*/
+#define TIM_DCR		0x48			/* DMA control register			*/
+#define TIM_DMAR	0x4C			/* DMA register for transfer		*/
+#define TIM_TISEL	0x68			/* Input Selection			*/
 
-#define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
-#define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */
-#define TIM_CR1_ARPE	BIT(7)	/* Auto-reload Preload Ena */
-#define TIM_CR2_MMS	(BIT(4) | BIT(5) | BIT(6)) /* Master mode selection */
-#define TIM_CR2_MMS2	GENMASK(23, 20) /* Master mode selection 2 */
-#define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
-#define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
-#define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
-#define TIM_DIER_CC1IE	BIT(1)  /* CC1 Interrupt Enable    */
-#define TIM_DIER_CC2IE	BIT(2)  /* CC2 Interrupt Enable    */
-#define TIM_DIER_CC3IE	BIT(3)  /* CC3 Interrupt Enable    */
-#define TIM_DIER_CC4IE	BIT(4)  /* CC4 Interrupt Enable    */
-#define TIM_DIER_CC_IE(x)	BIT((x) + 1) /* CC1, CC2, CC3, CC4 interrupt enable */
-#define TIM_DIER_UDE	BIT(8)  /* Update DMA request Enable */
-#define TIM_DIER_CC1DE	BIT(9)  /* CC1 DMA request Enable  */
-#define TIM_DIER_CC2DE	BIT(10) /* CC2 DMA request Enable  */
-#define TIM_DIER_CC3DE	BIT(11) /* CC3 DMA request Enable  */
-#define TIM_DIER_CC4DE	BIT(12) /* CC4 DMA request Enable  */
-#define TIM_DIER_COMDE	BIT(13) /* COM DMA request Enable  */
-#define TIM_DIER_TDE	BIT(14) /* Trigger DMA request Enable */
-#define TIM_SR_UIF	BIT(0)	/* Update interrupt flag   */
-#define TIM_SR_CC_IF(x)	BIT((x) + 1) /* CC1, CC2, CC3, CC4 interrupt flag */
-#define TIM_EGR_UG	BIT(0)	/* Update Generation       */
-#define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
-#define TIM_CCMR_M1	(BIT(6) | BIT(5))  /* Channel PWM Mode 1 */
-#define TIM_CCMR_CC1S		(BIT(0) | BIT(1)) /* Capture/compare 1 sel */
-#define TIM_CCMR_IC1PSC		GENMASK(3, 2)	/* Input capture 1 prescaler */
-#define TIM_CCMR_CC2S		(BIT(8) | BIT(9)) /* Capture/compare 2 sel */
-#define TIM_CCMR_IC2PSC		GENMASK(11, 10)	/* Input capture 2 prescaler */
-#define TIM_CCMR_CC1S_TI1	BIT(0)	/* IC1/IC3 selects TI1/TI3 */
-#define TIM_CCMR_CC1S_TI2	BIT(1)	/* IC1/IC3 selects TI2/TI4 */
-#define TIM_CCMR_CC2S_TI2	BIT(8)	/* IC2/IC4 selects TI2/TI4 */
-#define TIM_CCMR_CC2S_TI1	BIT(9)	/* IC2/IC4 selects TI1/TI3 */
-#define TIM_CCMR_CC3S		(BIT(0) | BIT(1)) /* Capture/compare 3 sel */
-#define TIM_CCMR_CC4S		(BIT(8) | BIT(9)) /* Capture/compare 4 sel */
-#define TIM_CCMR_CC3S_TI3	BIT(0)	/* IC3 selects TI3 */
-#define TIM_CCMR_CC4S_TI4	BIT(8)	/* IC4 selects TI4 */
-#define TIM_CCER_CC1E	BIT(0)	/* Capt/Comp 1  out Ena    */
-#define TIM_CCER_CC1P	BIT(1)	/* Capt/Comp 1  Polarity   */
-#define TIM_CCER_CC1NE	BIT(2)	/* Capt/Comp 1N out Ena    */
-#define TIM_CCER_CC1NP	BIT(3)	/* Capt/Comp 1N Polarity   */
-#define TIM_CCER_CC2E	BIT(4)	/* Capt/Comp 2  out Ena    */
-#define TIM_CCER_CC2P	BIT(5)	/* Capt/Comp 2  Polarity   */
-#define TIM_CCER_CC2NP	BIT(7)	/* Capt/Comp 2N Polarity   */
-#define TIM_CCER_CC3E	BIT(8)	/* Capt/Comp 3  out Ena    */
-#define TIM_CCER_CC3P	BIT(9)	/* Capt/Comp 3  Polarity   */
-#define TIM_CCER_CC3NP	BIT(11)	/* Capt/Comp 3N Polarity   */
-#define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
-#define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
-#define TIM_CCER_CC4NP	BIT(15)	/* Capt/Comp 4N Polarity   */
-#define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
-#define TIM_BDTR_BKE(x)	BIT(12 + (x) * 12) /* Break input enable */
-#define TIM_BDTR_BKP(x)	BIT(13 + (x) * 12) /* Break input polarity */
-#define TIM_BDTR_AOE	BIT(14)	/* Automatic Output Enable */
-#define TIM_BDTR_MOE	BIT(15)	/* Main Output Enable      */
-#define TIM_BDTR_BKF(x)	(0xf << (16 + (x) * 4))
-#define TIM_DCR_DBA	GENMASK(4, 0)	/* DMA base addr */
-#define TIM_DCR_DBL	GENMASK(12, 8)	/* DMA burst len */
+#define TIM_CR1_CEN		BIT(0)					/* Counter Enable				*/
+#define TIM_CR1_DIR		BIT(4)					/* Counter Direction				*/
+#define TIM_CR1_ARPE		BIT(7)					/* Auto-reload Preload Ena			*/
+#define TIM_CR2_MMS		(BIT(4) | BIT(5) | BIT(6))		/* Master mode selection			*/
+#define TIM_CR2_MMS2		GENMASK(23, 20)				/* Master mode selection 2			*/
+#define TIM_SMCR_SMS		(BIT(0) | BIT(1) | BIT(2))		/* Slave mode selection				*/
+#define TIM_SMCR_TS		(BIT(4) | BIT(5) | BIT(6))		/* Trigger selection				*/
+#define TIM_DIER_UIE		BIT(0)					/* Update interrupt				*/
+#define TIM_DIER_CC1IE		BIT(1)					/* CC1 Interrupt Enable				*/
+#define TIM_DIER_CC2IE		BIT(2)					/* CC2 Interrupt Enable				*/
+#define TIM_DIER_CC3IE		BIT(3)					/* CC3 Interrupt Enable				*/
+#define TIM_DIER_CC4IE		BIT(4)					/* CC4 Interrupt Enable				*/
+#define TIM_DIER_CC_IE(x)	BIT((x) + 1)				/* CC1, CC2, CC3, CC4 interrupt enable		*/
+#define TIM_DIER_UDE		BIT(8)					/* Update DMA request Enable			*/
+#define TIM_DIER_CC1DE		BIT(9)					/* CC1 DMA request Enable			*/
+#define TIM_DIER_CC2DE		BIT(10)					/* CC2 DMA request Enable			*/
+#define TIM_DIER_CC3DE		BIT(11)					/* CC3 DMA request Enable			*/
+#define TIM_DIER_CC4DE		BIT(12)					/* CC4 DMA request Enable			*/
+#define TIM_DIER_COMDE		BIT(13)					/* COM DMA request Enable			*/
+#define TIM_DIER_TDE		BIT(14)					/* Trigger DMA request Enable			*/
+#define TIM_SR_UIF		BIT(0)					/* Update interrupt flag			*/
+#define TIM_SR_CC_IF(x)		BIT((x) + 1)				/* CC1, CC2, CC3, CC4 interrupt flag		*/
+#define TIM_EGR_UG		BIT(0)					/* Update Generation				*/
+#define TIM_CCMR_PE		BIT(3)					/* Channel Preload Enable			*/
+#define TIM_CCMR_M1		(BIT(6) | BIT(5))			/* Channel PWM Mode 1				*/
+#define TIM_CCMR_CC1S		(BIT(0) | BIT(1))			/* Capture/compare 1 sel			*/
+#define TIM_CCMR_IC1PSC		GENMASK(3, 2)				/* Input capture 1 prescaler			*/
+#define TIM_CCMR_CC2S		(BIT(8) | BIT(9))			/* Capture/compare 2 sel			*/
+#define TIM_CCMR_IC2PSC		GENMASK(11, 10)				/* Input capture 2 prescaler			*/
+#define TIM_CCMR_CC1S_TI1	BIT(0)					/* IC1/IC3 selects TI1/TI3			*/
+#define TIM_CCMR_CC1S_TI2	BIT(1)					/* IC1/IC3 selects TI2/TI4			*/
+#define TIM_CCMR_CC2S_TI2	BIT(8)					/* IC2/IC4 selects TI2/TI4			*/
+#define TIM_CCMR_CC2S_TI1	BIT(9)					/* IC2/IC4 selects TI1/TI3			*/
+#define TIM_CCMR_CC3S		(BIT(0) | BIT(1))			/* Capture/compare 3 sel			*/
+#define TIM_CCMR_CC4S		(BIT(8) | BIT(9))			/* Capture/compare 4 sel			*/
+#define TIM_CCMR_CC3S_TI3	BIT(0)					/* IC3 selects TI3				*/
+#define TIM_CCMR_CC4S_TI4	BIT(8)					/* IC4 selects TI4				*/
+#define TIM_CCER_CC1E		BIT(0)					/* Capt/Comp 1  out Ena				*/
+#define TIM_CCER_CC1P		BIT(1)					/* Capt/Comp 1  Polarity			*/
+#define TIM_CCER_CC1NE		BIT(2)					/* Capt/Comp 1N out Ena				*/
+#define TIM_CCER_CC1NP		BIT(3)					/* Capt/Comp 1N Polarity			*/
+#define TIM_CCER_CC2E		BIT(4)					/* Capt/Comp 2  out Ena				*/
+#define TIM_CCER_CC2P		BIT(5)					/* Capt/Comp 2  Polarity			*/
+#define TIM_CCER_CC2NP		BIT(7)					/* Capt/Comp 2N Polarity			*/
+#define TIM_CCER_CC3E		BIT(8)					/* Capt/Comp 3  out Ena				*/
+#define TIM_CCER_CC3P		BIT(9)					/* Capt/Comp 3  Polarity			*/
+#define TIM_CCER_CC3NP		BIT(11)					/* Capt/Comp 3N Polarity			*/
+#define TIM_CCER_CC4E		BIT(12)					/* Capt/Comp 4  out Ena				*/
+#define TIM_CCER_CC4P		BIT(13)					/* Capt/Comp 4  Polarity			*/
+#define TIM_CCER_CC4NP		BIT(15)					/* Capt/Comp 4N Polarity			*/
+#define TIM_CCER_CCXE		(BIT(0) | BIT(4) | BIT(8) | BIT(12))
+#define TIM_BDTR_BKE(x)		BIT(12 + (x) * 12)			/* Break input enable				*/
+#define TIM_BDTR_BKP(x)		BIT(13 + (x) * 12)			/* Break input polarity				*/
+#define TIM_BDTR_AOE		BIT(14)					/* Automatic Output Enable			*/
+#define TIM_BDTR_MOE		BIT(15)					/* Main Output Enable				*/
+#define TIM_BDTR_BKF(x)		(0xf << (16 + (x) * 4))
+#define TIM_DCR_DBA		GENMASK(4, 0)				/* DMA base addr				*/
+#define TIM_DCR_DBL		GENMASK(12, 8)				/* DMA burst len				*/
 
-#define MAX_TIM_PSC		0xFFFF
-#define MAX_TIM_ICPSC		0x3
-#define TIM_CR2_MMS_SHIFT	4
-#define TIM_CR2_MMS2_SHIFT	20
+#define MAX_TIM_PSC				0xFFFF
+#define MAX_TIM_ICPSC				0x3
+#define TIM_CR2_MMS_SHIFT			4
+#define TIM_CR2_MMS2_SHIFT			20
 #define TIM_SMCR_SMS_SLAVE_MODE_DISABLED	0 /* counts on internal clock when CEN=1 */
 #define TIM_SMCR_SMS_ENCODER_MODE_1		1 /* counts TI1FP1 edges, depending on TI2FP2 level */
 #define TIM_SMCR_SMS_ENCODER_MODE_2		2 /* counts TI2FP2 edges, depending on TI1FP1 level */
 #define TIM_SMCR_SMS_ENCODER_MODE_3		3 /* counts on both TI1FP1 and TI2FP2 edges */
-#define TIM_SMCR_TS_SHIFT	4
-#define TIM_BDTR_BKF_MASK	0xF
-#define TIM_BDTR_BKF_SHIFT(x)	(16 + (x) * 4)
+#define TIM_SMCR_TS_SHIFT			4
+#define TIM_BDTR_BKF_MASK			0xF
+#define TIM_BDTR_BKF_SHIFT(x)			(16 + (x) * 4)
 
 enum stm32_timers_dmas {
 	STM32_TIMERS_DMA_CH1,
-- 
2.43.0


