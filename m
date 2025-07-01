Return-Path: <linux-pwm+bounces-6627-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D9AEF329
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 11:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450881BC1D04
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B2F26D4E9;
	Tue,  1 Jul 2025 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TEzv3KZx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDFE26CE0E
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361771; cv=none; b=S1m/Vxlutt2BPpg5KWK9jbsGWwj3GKOcMIctY8iIb5Tlq30zMhkYzi2BX0l7SyGQbDTuDc+g588edArMSwAE7bP8zo9EcydQw1WCjWQ2y98GYku3vhxuRqmvmmxYQUsQwtBTywJz5ST6z2U5GiHpQ7QexFbaQKWSnZ6QDVLT2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361771; c=relaxed/simple;
	bh=SvqlrEMtz9LJbvaRV1nJwjGYDMDWrjXzaQ+j9PwbG0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqOEgLc3BCmLnmp/gp5/mBNYBDYFv/dWDi8YfkJjkRMLyHcMlqZI3P4KfpqE2l4Gv8gWHS9K3ak+n//H0YJWsENmpXdIepPZKLiL5AC/pmx58ORTZijtJdbCV6mf3r5S/fl2n9nMhtall13tJoex2dO7IQt2AdqVeGVMNSaHpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TEzv3KZx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so5083445a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 01 Jul 2025 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751361768; x=1751966568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUCqoUDneJro7iETMW+UlVbrddPjh3TOFBSvfBqoW8s=;
        b=TEzv3KZxTEHzS7lqpQFWWiF/wQmrCcmuUTb+HomviDvAtAR8oTlq4dPXvAw4G6NFqv
         YYL6urn5cxMOgXPOQfQCOn5obJ8hY6U3cjtmHXfyPWL/h7JVwcGHcCe6gUtPzHSPzXEy
         9o61JB5602Clome/HwssaqIrMAWfLTY35OdoTVG6PZDmLLNI4fq5zKP5Xo4Q+aO7ko8w
         sxGp4C1XMfqzlDs8I7/mL/SdyYU4GLu1o1sMQv7Sa5DBCYES7FnBcoc7mhM1OIHcfeaH
         nHnONiBhOtIdyCcyExKOMxeRY/4C72RGsOAHFo2Xr85/iiiIPmLBjGwkMu17Rxz6iyAN
         9N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361768; x=1751966568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUCqoUDneJro7iETMW+UlVbrddPjh3TOFBSvfBqoW8s=;
        b=kHdVKgnAB4/RndRRpF7kZKxvDdnjzw/257jYqyo1Rt+2uOFTlCNpkT0EFohGSWy1M5
         iR/wmGfg7mxS7d7neMokV4t7eKIflSpXHWQV6q6YkTGObniz7Y+b+VBttsR4P1tdVEn6
         R8yCFLLK+AoC4yzbU+rB4mBbQi9kym5f+jM2KDqMfE/ewlFzvszzk4gPx3qVCVoXkR4S
         GTWQMUpuslkIUOJJxsXBvXdeR1iRDU05XptegWegvyl9XXPR4mFcF+efR1an7ljsaALL
         uAoxXXgE+r+QvgToTza4oW61hFs/03ISmvW8gOl6ULLtLEvDYc2J3cAUqOynvlricKrt
         1i7g==
X-Forwarded-Encrypted: i=1; AJvYcCVFKz1eLu6Uug3KxNsJDyFjOXWfclQzEkAhitnCMU16V1tq5rWvcwC6+/k5k4XJx16NZ9suJQ7XFco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5eS5T2KvClFvoHQIMlMx8qV3Rhill6HG0FOSszsXjDOzod7o
	dSvJSG9Rl6GVyGHPXVG9+dUI/FlYlW0mD6BmdR8uK8Fs7I5Ce+VBFuw8DHEM6NF7LBU=
X-Gm-Gg: ASbGncvHSqETv1OPh3Z/jmRgPvKHF7B0UNMbka3WHJwP0a7wYQoIYiaxEWB4Qz/BAbF
	3Os1aJ/gv3crqKsYGbls7gFZqpKRxCWTf03xH1gzp+KRJENVdJ7q2OmLjTukAzNif3rCLjyjcT2
	fen3HO/R5floPKIlPoUIEYO5baotlOOD76lGycb3vdpz2TAfD2Iude31O/ihM1gzLM2M6tksu6T
	4oDesZhY4uTZzzz1tix9yVzrikVLPROOZNErMZrJBqgCAzvbwEnUljOMAWQh1sbIC+ufnxJf/MK
	ZSihQxfNpu92Wi9uaeLhDgTw2E+w2DBTH0kXVbQHuRP2yELGytNoh8y2dc/b9/LSbwmXmOSxbZT
	m5G9dwGUICMRW2MYWeGBFo+Jysw1p08FRdP9aMNQ=
X-Google-Smtp-Source: AGHT+IGNkPdEmpZwCcvrjMGu50yM0BpyZDVCekNrVk7CymZh8/DBYnTbl8HbewnLrBo3HK0iDVXJOA==
X-Received: by 2002:a05:6402:510e:b0:602:3e3:dada with SMTP id 4fb4d7f45d1cf-60c88e5a42cmr14195974a12.25.1751361767850;
        Tue, 01 Jul 2025 02:22:47 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c828bbd34sm7180438a12.9.2025.07.01.02.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:22:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Flavio Suligoi <f.suligoi@asem.it>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 1/2] backlight: mp3309c: Drop pwm_apply_args()
Date: Tue,  1 Jul 2025 11:22:36 +0200
Message-ID:  <2d1075f5dd45c7c135e4326e279468de699f9d17.1751361465.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SvqlrEMtz9LJbvaRV1nJwjGYDMDWrjXzaQ+j9PwbG0E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoY6jeSs2B/0GJOrfWXLz92STYcWG2LA50BuCvG U8iwJaqxvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaGOo3gAKCRCPgPtYfRL+ TtCpCACgUCBjnISaJ0LkEDzhTx366kGo8zu/zHb/myUGbmjg6BgfBCJy4XZXkJDlIQBFAxZfesh PTnwXU3MU2tOeKGrPvp8LR1qJJG3Fumu4/DUeHHhGFEZtO+qTd3v+i3mHPvcSuEt84mHh6V33bP AcAN1Ztvh8XA9M5ocRF9Rm8r/CIGDjbLOtNyHdySYlv+cI3Q5VpL8YgQBTmIqHg2T+XVBDcZYAW cxQsd1vvYQswRzBzdLMLjLjWqK5hvzBN6qOES0NqnFT4XJbVjvUQPfs8uzsT4n69IrWYT4lAFqp luD1DXSLkvLh0e5U6iLEMkqIT3xAORapXP89g/Y9sG+iBpb+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

pwm_apply_args() sole purpose is to initialize all parameters specified
in the device tree for consumers that rely on pwm_config() and
pwm_enable(). The mp3309c backlight driver uses pwm_apply_might_sleep()
which gets passed the full configuration and so doesn't rely on the
default being explicitly applied.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/backlight/mp3309c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 372058e26129..bb4e85531cea 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -222,7 +222,6 @@ static int mp3309c_parse_fwnode(struct mp3309c_chip *chip,
 		if (IS_ERR(chip->pwmd))
 			return dev_err_probe(dev, PTR_ERR(chip->pwmd), "error getting pwm data\n");
 		pdata->dimming_mode = DIMMING_PWM;
-		pwm_apply_args(chip->pwmd);
 	}
 
 	/*
-- 
2.49.0


