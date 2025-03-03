Return-Path: <linux-pwm+bounces-5031-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647DCA4BF6D
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 12:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510BB167C2C
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 11:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCEE20D51A;
	Mon,  3 Mar 2025 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/i2GIMn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9D20C497
	for <linux-pwm@vger.kernel.org>; Mon,  3 Mar 2025 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002796; cv=none; b=S6aeY6v/mFAPeLNoL5PLKGp2pDqL4OQh/N7nP15avqILrVfUOCP4tfh5VEFHuIp+c/Khs+DejC+h8JZV2kwzJzF1cjiFd7+hpZDoGqBJd/4VqeGRFsGkiAdlUYvK8IogcVI6Oj7ddwhHJbKNRYp16YMn0BWX39gYyprODBbpiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002796; c=relaxed/simple;
	bh=Ptm4KxIluZ+jSWtrQSjOBYj1UGbgZbWT5vsr1kgNS3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLeUrz9sVHHExtH0/xG7HQx9I0EFtLl9MGmTGnyD79yhFoFIMAGR15nn8pjqU46BpA7ZhvDTB0pWqldOjIwln+Gn8SJy7LiEdnOnBSKw4sRG5KMFBrjj+HL3QJQsvorqiEjXmQP7LXAcf2gQtS52rAuLemRwwx/Gj9dWNE2iNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p/i2GIMn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso8079920a12.3
        for <linux-pwm@vger.kernel.org>; Mon, 03 Mar 2025 03:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002792; x=1741607592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/68y9vyjJip2to2j240QGsQ8HiHsCa2cvvO8a3/jxD0=;
        b=p/i2GIMnuFKab7nrtkydtkExoEbU5sAV+TRDBGZ/oy2kd8j4Uo1QoxgkgWj9ceTv27
         PiIGH2/0vt7DBFho6GtaqYF/g0zUvtdFf+yVsPK88DbesoUIR+bYTGL5kTZpy8HDUA+o
         /ffr464boVVR5pZcInz4sA+NbWlVh9XvtedPHUWi7VlWH+8Q/mnZPLb9B8vn+FhyDAN1
         hD5uZ1NHgmXstMpBF/uD/oAR8kbNggbBsVNTRWoGviuUNgNnBmtX3NW9SWa9Zjr+TxNu
         fuHRfl5InnAbUMuF5JzvTiXA68INSjaPJI8n582SxReN1JhR8M4AOfPyFxgzdmiNvKbZ
         B0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002792; x=1741607592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/68y9vyjJip2to2j240QGsQ8HiHsCa2cvvO8a3/jxD0=;
        b=fNnX3+6TJl2dj7PzRjhHQPP8C6E0tZYSUS94J0nSekeSJM66MgfMEu08RjIheYKBXT
         Z+b2QpWE5lAnvT4VstkmWCkB+v1n6+tHN4SrjVLUYusKBD8UcLJA1+3J7WCkHU6Ba/NF
         WX4kIztGMysE3F5/DE8P9oagCbjP7ITqzCq3hQh+ZY6em4OdPYa9zDi5rXgzWvL2Zn+X
         7YbWgHexPJXljrsACmmGtF1pmf5gMlYsSXhnVQ20stMCq6m9u0bLk/b4GpuDCjkFSfgF
         4X2tBuyq9u/QDWc15tzHODtMQlwTHVXbii7FkPEKMM2E9sbNZEtVaivsrPTjR91VLenR
         P6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcMIDviuXlBEvEJsmMbGJGUKecum7Rrr7u8GhCzcQ471cGXb/mqhSrdVZr1MX5E7fvEDnJn7Irj1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXn5u7zMZMnC45FWfdb9U3Y+WZ0KGuWQF9G4UWTYn+r+ZdF+Rp
	ACatRY42ylcJgHae84eRqbR2oBBA8o3CoFP0bGIapqDaCeRe0iNwdr6yRVOswIg=
X-Gm-Gg: ASbGncueu2W8WtG+LBARTTGn2vgBdt9fxX9dSELuua8a2Xd8e9y3ey+YEuKRCXGuVs3
	ISVMF7ql3Z0Q5AtY+BfkSGkGbQlI0pHwbQs1pA1KRL8rnnVqulUAkaeQpBCuWGCcZv6wXA0DkAN
	JG1Yok/gHtt31l+sPpha3/EC8TIeHnCC1qsAcJB8sRSxTrnxv6vomQyp3QRmZrBgLBCYE3xvR5l
	EKECpQGjAiPX9BQyteBHcSallL+Ucdl0/AeiS15+SzT+FekL1nVs4lOj0S6lWaTmLGLn2RZhrSK
	xDCSLG96WLdj4xL6Y+smEDHutVmHO4Lz+G7AsZNrs28=
X-Google-Smtp-Source: AGHT+IErxoCrIU2R1yZszII3GJHpNQelDYR3jhTxYYW1Pc1yGBLd8/zjIyAuHQmCs6GYrJKlqbIJLg==
X-Received: by 2002:a17:907:7f06:b0:abc:b8c:7b2d with SMTP id a640c23a62f3a-abf261f2f71mr1397972566b.32.1741002792270;
        Mon, 03 Mar 2025 03:53:12 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1de83fa49sm86833866b.158.2025.03.03.03.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:53:11 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 03 Mar 2025 13:52:51 +0200
Subject: [PATCH v3 2/3] leds: rgb: leds-qcom-lpg: Fix pwm resolution max
 for Hi-Res PWMs
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-2-62703c0ab76a@linaro.org>
References: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
In-Reply-To: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Ptm4KxIluZ+jSWtrQSjOBYj1UGbgZbWT5vsr1kgNS3Q=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnxZghnLOYgNBsNjRIrX52QXGpjisNrc6qKtqD+
 3XbN92qtFSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8WYIQAKCRAbX0TJAJUV
 Vn5eEACc13uyB6gVqJz93ceCHPyd7qK1dCWoROUTsWftQMYJEpYnDQ2LXOrJb+iwsCeu5jnbKc8
 ixLFD5CPi0hyIvdkg+MJ9EaWBodou0bjYSc57jGfS+W30oNtlDsiaRfUBhiACMlA1cMeyYnz9pD
 cFcFsBvsnJDhFCtrJTtzEEyQdFCVPfe0DJYMgZa0SGEJL+2r5cXMzzK++7JfIIaQClzrEDz/qKX
 z0YvOFvvnGChNBr5zWDvKO2sH5F42o8zHwAljoPnUMHd4xD9RzXfxp9M6OPX5wmh5DM4r7B0e6q
 rCfMMQUvijXvfwWJ5d5C9Z9Iz+26gpvjeEKVJI8VeNxo/xDnAVP8C1KBJSwPosNV9stJvOHViEd
 s8B6WTyRvSRMZ6bhcHnSvmCs/JQzgkhX0vHUIi28ypxBTPwvcwA/rRC1pZX8XwFkn2OGBE5bOBw
 ry8AgBsS3lTaIuiCovwKb+SP5tIIco4QX0o9fv6eVPsWdUtkmSYPmcB9Vx8wDfRMs4q36SQL9sD
 8pM+zVDN/y/pClLltTWcYbzaissXYwIVQ9HKYLvZE/jBJ3c1Ho9zDS25ju7Vwm8tE5ngfTrKN/E
 gYGE4SNV/S3s+at9BiALOutUOk/M251kWjcVV4e2dBtTcFNbf8v9vzMG/rTpIS+B/fY3QYUjrxy
 Aqic7HReleXfSHA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Ideally, the requested duty cycle should never translate to a PWM
value higher than the selected resolution (PWM size), but currently the
best matched period is never reported back to the PWM consumer, so the
consumer will still be using the requested period which is higher than
the best matched one. This will result in PWM consumer requesting
duty cycle values higher than the allowed PWM value.

In case of Hi-Res PWMs, the current implementation is capping the PWM
value at a 15-bit resolution, even when the lower resolutions are
selected.

Fix the issue by capping the PWM value to the maximum value allowed by
the selected resolution.

Cc: stable@vger.kernel.org    # 6.4
Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 4454fc6a38480b61916318dd170f3eddc32976d6..0b6310184988c299d82ee7181982c03d306407a4 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -530,7 +530,7 @@ static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
 	unsigned int clk_rate;
 
 	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
-		max = LPG_RESOLUTION_15BIT - 1;
+		max = BIT(lpg_pwm_resolution_hi_res[chan->pwm_resolution_sel]) - 1;
 		clk_rate = lpg_clk_rates_hi_res[chan->clk_sel];
 	} else {
 		max = BIT(lpg_pwm_resolution[chan->pwm_resolution_sel]) - 1;

-- 
2.34.1


