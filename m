Return-Path: <linux-pwm+bounces-4937-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F77A38AE8
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 18:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4376188E86F
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F6C229B21;
	Mon, 17 Feb 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lr6Kiid+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74E6231A2D
	for <linux-pwm@vger.kernel.org>; Mon, 17 Feb 2025 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814598; cv=none; b=PXUEGXy9zv91BEUHo6t4D1OTiXO+OTHST3BDSQxakNMybC6muvYl6Wo524exyVZvjZ0kqjERyjLLp8Qza+ZoqW1hJJpWnoLmJa21Te1mStVePrc8uhOFWOylVT0700ooaiHHSnHKC4Dvj2bIe9b0fScB9AJbDv3Tnj5IP5MnU/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814598; c=relaxed/simple;
	bh=QccJhcy6Z2oaZ/Faej94PmyVdYB8oVeM6wRuLu0NOK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l80OlWy3oKqGf0lyrWmbie3Nz1SoTBPY5hUtfk506eUMhddZuV8gF73WBq3JLb7ZNn1fa2bmO8MSWYXZ5jhU0qA+t5piDFyXf257CGNm1CzSnfmNPze1aI2L5pMd7xFs2ukPRchwAKPhSshsGaITJHXGPxb2vzj2RNvOdMlwkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lr6Kiid+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso51039135e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 17 Feb 2025 09:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739814594; x=1740419394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYWUFX7L3xQ55tqjrfIF/T/9S+H6ZAC4k6kghP/cbS4=;
        b=lr6Kiid++hDEYN6mcIS2DCJpIZsM04T+5QRMbbJcnPGscj+rr9/vfDX9M1/lTXwg0d
         n8trv8t6nmv55R2CcR3tJdpFDQGUbsOYkAAb5PDBq1yEQFrkzwj1cH2mM7ZbjUOyJ/Sr
         hBVW752YrwlR4GmZ4LJv7oNsmS6Nuzyp8tRtaIxpUk+poDgOTMXJbnRXhjUjb2Qm2RRb
         bihCFO9m96b7T/4XQwbYGoOpLjnswCj1MMKyZI1mXrNo+tmyuWzk+lTmvTiLMoiGN5Nk
         P+21fxG4aT5xHWjvl6e5yp4ody9UhlTRe9cHEnQH4Q7/H1YdSNSPGLCvkMTJo+B/Y+2Q
         sydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739814594; x=1740419394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYWUFX7L3xQ55tqjrfIF/T/9S+H6ZAC4k6kghP/cbS4=;
        b=EtVlVnY2WqkEah7Cq1YgJJj2z5m7RO3rAjHLC2m9BWJulujARHAslgHZypnui6cgbz
         HvRol7OG+quQ2pdXcm6cBKjY70gvvZwSvahRco7ulpufNKOSCAHybcMAlywEA3E33SUv
         TOLDtZW/tDsbM7fRVGP2oOykpss4Q7tOUSiEJO+eq0END3IdBvsSIR6CmDGIWoGDdldJ
         e0hNlVrXo3lggGBFKujYhM1znt/v8rIumIdQo1p83s4IT8GdHXo7OfI2WTDiTdBCSQSn
         WUTK34u4i4WewA+KHcBKU/E7G2OVMJdFoR+GHduUkHhH8nnmzzmQQ9qW4PHDkjkSJhcI
         pfQg==
X-Forwarded-Encrypted: i=1; AJvYcCUILtOpazRnhXV/eI8wPpNVMM1UZtdsfpZd3+BSe7gwd05BZvmWjuFC87g8ibHFWtOavbfnVtln4XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsVtGs2fbWfFQwiYh2fe+jtDvdClES/IwIimomfPPWsJ9reR6
	0ZYtpTlLl4331L6M4lEh1A5XGUShMFE6WdK5mijX5ktmkJyRJ/h9GwdgSPW0hTI=
X-Gm-Gg: ASbGncv/qOufnFRFDK3FqEw3RZMG9dRTc+FA3X1nziph012ZrPzm+7tSePjTycobV+p
	gC2zDk3W2CjTkdSbPo20rnSHdvPStICtsePTxjQ8WbdT6DG6w2lutCA4WIrNo7E7pyq20Ey7BRV
	VHCp/tEiJIt80rf3233UnphPjOSRnvzs7MbC4fK2vrnrU4piqqA/AX2hOCTZoLz5Y2PcKclHWHw
	8uzKXHz8NFJKITZJke9NIjcKPKIKh4S/QwfVBHVKKEuuFD4KEl4wP+Si72BAf6ddyhw6s4E2pki
	muqSzOvgXrXLrZ3XHf7tQi4w52Iz3sTKxguEDiqeM+utebl2xtqbBweW1g==
X-Google-Smtp-Source: AGHT+IE2m/y5YsvXxKsv3Wzx+KzkXhhlReDwoumM4ckLj1b9VNhPYa2XZvG9v46RJP16guMIDyVnPA==
X-Received: by 2002:a05:6000:2c1:b0:38f:474f:f3f3 with SMTP id ffacd0b85a97d-38f474ff5bdmr4444095f8f.13.1739814594019;
        Mon, 17 Feb 2025 09:49:54 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987396d3dsm26816265e9.36.2025.02.17.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:49:53 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Douglas Anderson <dianders@chromium.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Check for CONFIG_PWM using IS_REACHABLE()
Date: Mon, 17 Feb 2025 18:49:36 +0100
Message-ID: <20250217174936.758420-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=QccJhcy6Z2oaZ/Faej94PmyVdYB8oVeM6wRuLu0NOK8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBns3awgzmekCOlrZnw4HPWH/Y5c+jEquMdixst0 Z17rvwjAcqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7N2sAAKCRCPgPtYfRL+ TugSB/4p2IgLfab2Psw2xdOK7TWzjyvsJw1tJe/0PYfhxueK3o9PqysJJZ4v+fLI7//NLNCTWzA FAnCUV1eWscA1dXxjtaHc6sHUk06xIhDXTb7RayMaGKGy9IpdFGQCF8pEvYeK1aQklMxDAlE0wm h6pg4uiTxqedf8BBldGpEfmm/6Foblj5/dll//cpKCcI3rwaQXwtYPKd9fipYMJUIPxribAKyCv je9u9+Av+wdHxVDUbzN4+fIw6Z8hHB7tfEEQHBXkr78InWnvAzYBWGV0yrTb4ZImHMISvXUPwJa 0+sda87KyFI4/iPigTULuXaFOa3GNmVYav5cmTOYclOIipUx
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Currently CONFIG_PWM is a bool but I intend to change it to tristate. If
CONFIG_PWM=m in the configuration, the cpp symbol CONFIG_PWM isn't
defined and so the PWM code paths in the ti-sn65dsi86 driver are not
used.

The correct way to check for CONFIG_PWM is using IS_REACHABLE which does
the right thing for all cases
CONFIG_DRM_TI_SN65DSI86 ∈ { y, m } x CONFIG_PWM ∈ { y, m, n }.

There is no change until CONFIG_PWM actually becomes tristate.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

even without the change to make CONFIG_PWM tristate using IS_REACHABLE()
is the more idiomatic way to check for CONFIG_PWM.

Note that IS_ENABLED() is wrong in the case CONFIG_DRM_TI_SN65DSI86=y +
CONFIG_PWM=m.

Best regards
Uwe

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index e4d9006b59f1..c84976db9ba5 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -196,7 +196,7 @@ struct ti_sn65dsi86 {
 	struct gpio_chip		gchip;
 	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
 #endif
-#if defined(CONFIG_PWM)
+#if IS_REACHABLE(CONFIG_PWM)
 	struct pwm_chip			*pchip;
 	bool				pwm_enabled;
 	atomic_t			pwm_pin_busy;
@@ -1361,7 +1361,7 @@ static struct auxiliary_driver ti_sn_bridge_driver = {
 /* -----------------------------------------------------------------------------
  * PWM Controller
  */
-#if defined(CONFIG_PWM)
+#if IS_REACHABLE(CONFIG_PWM)
 static int ti_sn_pwm_pin_request(struct ti_sn65dsi86 *pdata)
 {
 	return atomic_xchg(&pdata->pwm_pin_busy, 1) ? -EBUSY : 0;
@@ -1955,7 +1955,7 @@ static int ti_sn65dsi86_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	if (IS_ENABLED(CONFIG_PWM)) {
+	if (IS_REACHABLE(CONFIG_PWM)) {
 		ret = ti_sn65dsi86_add_aux_device(pdata, &pdata->pwm_aux, "pwm");
 		if (ret)
 			return ret;

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.47.1


