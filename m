Return-Path: <linux-pwm+bounces-5338-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D1BA7C886
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 11:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29A2189071C
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DAF1DBB19;
	Sat,  5 Apr 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CIaqSVi6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386B1C3C04
	for <linux-pwm@vger.kernel.org>; Sat,  5 Apr 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743845262; cv=none; b=XP+Gu81qR6D6dCnWofjA7bd1AfBOKGjH1XqgnvARN5AIf2qSzhiMb/y32L6yB2lc9+3u4WB0kRiIP0Idsn2gTywjI3K8jFHx12bOqReowoSx4zM9Z1AmOb7WHbxHOrBaFyOLaP9U1wWn/XI5JJ8AvdEN56iGybMNh7+03tJcgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743845262; c=relaxed/simple;
	bh=XTHV/BxyEsvy+/e1D0B3U1SFxzinwxu6RXZECENuXK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIVDnhVXya2vMBThrUFlL1Dcdwh666xik+bf7V3V7auFS2X+sEBD9quKJ6JroansPFvr+LbQb6wXw/wUqfGqcbuu9QLfQdfaNm+ZcyCtib9FziA3X2sI/E/ei6EutylLnSioSYGFr6p57Nb5XvFhMBz4Pg1GgygA7EEoh3E8aKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CIaqSVi6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac345bd8e13so462990666b.0
        for <linux-pwm@vger.kernel.org>; Sat, 05 Apr 2025 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743845258; x=1744450058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlQ4TT3nPVoe8QQVGOI9fFCYTSHJoW/Kf2xwJnvneTw=;
        b=CIaqSVi6SYjQ7loT6hwzb+35YzMWeXsLmWmYtBRdTJfDCqj+4l7jEFOAr9/GWFOQBl
         vNr9o8qgZbvrBhJJDs3N7eB2ueRYs6rM6wXDsH8wb1WWjBPLKgXIqxT3wen9vMuVw7zq
         0I8Gy/Cx8/1OK6jWB16INU5/opIG60mp7w61xrUM2VlHx8MUxmB23aoUE/lAUk1z7uuO
         3F/WAzajgGnXbL3WNTH6a5CwpyVxjGI9hTi83tzvJsgRWFBvt14MS0sNiEb6hGfUpNu9
         IkOsXXn4+KDzYhR/nHWieOAfiC/Undo10sMYf4WHkq3X6fBA6xpz9+VN6pqbfbRWEJ5C
         q4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743845258; x=1744450058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlQ4TT3nPVoe8QQVGOI9fFCYTSHJoW/Kf2xwJnvneTw=;
        b=eqWsJf1CMaWb4gotV3DcxMzRXGeijRdpnUpVZrtdv86+Z14QThFk0r/Vit2Saqw1TS
         QaFKh8gPGTTjfDlPRFRl+SwR9MvgT0nUpPrg/YCisAePe5OwmSWnn8E9t9cJgDMf0/rF
         FPfKO3hq78yhuc41WtW64A9AoqfiX2CnXbSV7oZ2Fsoruui4fazxHerivAme8/DGEcgt
         +T6IVYCZfElqbWmn0FqAed+w6dk+Oh/eFbq4ZBbvD9JrAAKq68lH+yVvFEQWkDxZ6kMG
         HlGtHRP68f2b/eIch1LP2bJQEOk0+Eg9SAlEAJxWbmQJurLf/3ZkB1gqpK+boNyCtvW/
         ozpw==
X-Gm-Message-State: AOJu0YwUx3zYWT+FmN9DRTTKwtNmdzRGpmSRsdRFYH9/NrfTNYUQC4f2
	Sf/ilVYRD+UHAOa+iIo6zkipnGpbeQIT7DYvT03ctiSwhusbydYa1G+/qbAnGX1rTIkLn2htRp0
	N
X-Gm-Gg: ASbGnctALF6sf5T1ysWANnD3eiTCXlV7fu0IiXmvdgH28R5WtkfRk67XMa7f+fKIMbJ
	8UyIauMtVE14xJw6yK6tjeYR2Kr4AxHmC7PtHPDkxonJRRoMeJs6A/Rko99hndaMkufFh0LUDIB
	lx+/khIaD68wP/CJAzME+iZe5CT2AN0VUbSHDibzhdtAPzKrIdEDkpFz5gUQdJluDUAawy5wvx1
	8DgZpSHE8srTnuVMvTnKgPjuP3kvpN2NYuLF34ukNHN3WUcTf29vBJdZcQckV5PoWeV+v2g60E0
	SyT3gPxP9srbxx/NXqA4iTs9R7XtCrA7d7jmqRcpTeZdXWZhdA==
X-Google-Smtp-Source: AGHT+IEXvmhmbIbbkjCi3hawdQL0SQlUYAdL8aKJgHcQ+8J2SwQbWTSlVJxLO/kiivFzTBaI65uI9g==
X-Received: by 2002:a17:906:6a14:b0:ac3:3f84:4055 with SMTP id a640c23a62f3a-ac7e71702ddmr207332466b.4.1743845257710;
        Sat, 05 Apr 2025 02:27:37 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7bfee46f0sm387214566b.86.2025.04.05.02.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:27:37 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] pwm: Let pwm_set_waveform() succeed even if lowlevel driver rounded up
Date: Sat,  5 Apr 2025 11:27:12 +0200
Message-ID:  <353dc6ae31be815e41fd3df89c257127ca0d1a09.1743844730.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=XTHV/BxyEsvy+/e1D0B3U1SFxzinwxu6RXZECENuXK0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn8Pdz3lV+2k9YVQCgxCIptG5ZhxMNDMRXIKrKY 3z+g/Apcb2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ/D3cwAKCRCPgPtYfRL+ TtBdCACRYlwLk+xNAXLqrPUvRBo6pclQCBurf1hke0ta+7+zwB7BVif1PatD0/kS7Xk5+O5w30C qGmVK/j6sOMwbZKTp/4NpShPKxrrNrX2TKaME8TMF9BiriX0ajcXjzE/X6+Z6l7NGj6catNNtYY l+c3+Guh/ahSK63PUoUvlNKvw3Bbtvbc1Z8XtAatQ40q83aHlYO7yJPNPk9ry+o1E/yMLfrERqU 9tQvsv95BamFNcffLLGerow5gJlZoij+3e/WgKFo9B66REBHOZfDReREAa2HjXmjevAYR1jgQRN tVmBliqVOI/g1CaPIJqvi6hPeG2WlQqxuL5LRLchLZR5TRi6
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Waveform parameters are supposed to be rounded down to the next value
possible for the hardware. However when a requested value is too small,
.round_waveform_tohw() is supposed to pick the next bigger value and
return 1. Let pwm_set_waveform() behave in the same way.

This creates consistency between pwm_set_waveform_might_sleep() with
exact=false and pwm_round_waveform_might_sleep() +
pwm_set_waveform_might_sleep() with exact=true.

The PWM_DEBUG rounding check has to be adapted to only trigger if no
uprounding happend.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a40c511e0096..0387bd838487 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -322,7 +322,7 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 	const struct pwm_ops *ops = chip->ops;
 	char wfhw[WFHWSIZE];
 	struct pwm_waveform wf_rounded;
-	int err;
+	int err, ret_tohw;
 
 	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
@@ -332,16 +332,16 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 	if (!pwm_wf_valid(wf))
 		return -EINVAL;
 
-	err = __pwm_round_waveform_tohw(chip, pwm, wf, &wfhw);
-	if (err)
-		return err;
+	ret_tohw = __pwm_round_waveform_tohw(chip, pwm, wf, &wfhw);
+	if (ret_tohw < 0)
+		return ret_tohw;
 
 	if ((IS_ENABLED(CONFIG_PWM_DEBUG) || exact) && wf->period_length_ns) {
 		err = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
 		if (err)
 			return err;
 
-		if (IS_ENABLED(CONFIG_PWM_DEBUG) && !pwm_check_rounding(wf, &wf_rounded))
+		if (IS_ENABLED(CONFIG_PWM_DEBUG) && ret_tohw == 0 && !pwm_check_rounding(wf, &wf_rounded))
 			dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
 				wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
 				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns);
@@ -382,7 +382,8 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns,
 				wf_set.duty_length_ns, wf_set.period_length_ns, wf_set.duty_offset_ns);
 	}
-	return 0;
+
+	return ret_tohw;
 }
 
 /**
-- 
2.47.2


