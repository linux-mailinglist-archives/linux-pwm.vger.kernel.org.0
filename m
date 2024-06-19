Return-Path: <linux-pwm+bounces-2547-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06290E7F9
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 12:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628961C21A48
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E584D2A;
	Wed, 19 Jun 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jOQFWAm/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D379824A7
	for <linux-pwm@vger.kernel.org>; Wed, 19 Jun 2024 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791933; cv=none; b=fJB6bUOikdt97pXGynK+wEOSo5w3IS1kkG4NoEAuXRZA63ObAFJ9SOK1CjrwcSawxqOZ2fmas8BzxCwUJNYR4ZLqK8eQBmvbQUa4APWgTYI6yo2UZu2WHkkfLW3hQvJ+/L2m6WHFp9IpeOmBNrAAt5Tkq8be/h7lxtcEpYtyotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791933; c=relaxed/simple;
	bh=URUfwaiOSrPZlfy433XXHQY/TFA8jECx1YrYlu6D9CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNuv0EVDSUzqyJoNueM4GjkmhYjTa19YHx5OrCR5V1I4f0jJuUNzccZ1CuhHywwkUL54V/ZQgC3M82bCWkR6qmBbMrF1XgCyL4W6aQ5rV/RiFhhJLbj67K1Wr+obJFwKGYUYcUE80OYELNCvEdzBCFXzkW+qD8jP+rys0t0Dt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jOQFWAm/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3620ee2cdf7so1117891f8f.3
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jun 2024 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718791929; x=1719396729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3xON2h2xbVG30yQyF33zsls/t9gOK/543Opt+teOpk=;
        b=jOQFWAm/5RqhE2aT2QP+7RkqqWRhLX7bqMv5MgYRUJ/n3iPvIGVApFPKSEp53+asBr
         BsIFozjmDXtZX5hVoNZ4hRHnpeaTgcRqh7Olj/vwZuK4ex4Iqvy8d/uCdr5FUgBoVzxm
         NKHNwk0ajUg06FI1D5gDXI2iz7XWVEqghoN1FdyfB0a360JS0ovUk3SuINqnMwjvy6gQ
         yWIKdGsKoKAWYLAlfmJJmFhuNxjK3wYWkKK2hq2EWf8mQ0C8EXHSMLb4iX9TPgo2KaVi
         vYr9JFB3mBZnu8mkXUmnqRdgcQnB8gYNtwNPQDIB7/qhsJd4kHrqH8va9pJQN5Uv5SL/
         esNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791929; x=1719396729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3xON2h2xbVG30yQyF33zsls/t9gOK/543Opt+teOpk=;
        b=L/yc6TLBfKV/7Seph/ylVbJf7Ph2qLtiADIEwkPdFPRtJIKHOHx8T6otWZN9M1+vAn
         279oV/FimvnPzSdQzuYOJXr8UtgCk7nYSiS2MwqtrPRbiB43UlPlhg9j1DSqidf/jQFR
         Lv/pUeMEsg0KvgeLJoRrbjjO6OvykuNZgT2WZwGdBprrVuhWT1MdGbuDDhlspdKXXMTy
         VlTJs/I6onqJ7NcXMf/BpexxTReU8bQ2ghz5uFcfxl2tZrSwpwO6DxaSGhjUWgB+pHtZ
         7iVDuiWfg1W2zga7zSSsPRLHMjy0Dsaquc3wq8DmTaldJlaIM9EBLn+gTJVFDa7ZdSbz
         FLHA==
X-Gm-Message-State: AOJu0Yx/MLU5xNs2CnJVrl/ibngqTSU6BbbDCKN9sQTErQyr7Vv8RCaO
	/lKv7YN9IcmnkR5SSkHDk8PzSqBSX+iHoBfJpYN5XJbbUAvVUzJ/wV8UlY1JYuk=
X-Google-Smtp-Source: AGHT+IG2kKR9AJ4Xve9v1M/xcezVMVRX51DSqCLtivR58CHrVK/OVUmA/K+zAtsEnUAD/1LOt9gYfg==
X-Received: by 2002:a5d:550e:0:b0:35f:2c43:8861 with SMTP id ffacd0b85a97d-3631998f664mr1605544f8f.66.1718791929293;
        Wed, 19 Jun 2024 03:12:09 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad20bsm16622708f8f.54.2024.06.19.03.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:12:08 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: [PATCH v2 1/5] mfd: stm32-timers: Unify alignment of register definition
Date: Wed, 19 Jun 2024 12:11:42 +0200
Message-ID:  <da3b7f9af5794d7463aa62cbaa7251abf1af2018.1718791090.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11404; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=URUfwaiOSrPZlfy433XXHQY/TFA8jECx1YrYlu6D9CI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmcq7hDOp2oycl/aTg79uVReGpzfgzpVnaEjxop EKtatm46oaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnKu4QAKCRCPgPtYfRL+ TtvpB/9WWbNmM+4Fh90FJ67FdiyBqJQvSzqX4/KEuhMnUeeGitAyIJDFoJLnxYk6Ne8Km2sifO0 /LddP279V3TSYUzsGFF6VYv8fFLG7RLv8VYX8Wt3VGbS+mUV26el6qeH7uAKx3qnBavujOSLKKP WmaBKGbsc8kp5NbeD5dFfvqK2uxjofFXvLbNanS9ZmP2z8xgVyqoNxkg5+AAjIuuOsN9pOAHNSM ph3Sbl9KyyWm2+dRW1Rxwr0c0uS6pIfW7k0Gy24z+5/9HIPuQG4+OJnC6Gwz+T7j9yGMh2Qfkk3 bLjt3ZqrB+Pg98Mj0eDMVHoI7JivcKzE9c2HKHfbhmPzN/cD
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Use tabs consistently for indention and properly align register names,
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


