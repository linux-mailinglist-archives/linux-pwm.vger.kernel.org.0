Return-Path: <linux-pwm+bounces-6628-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183EEAEF32A
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1DC167D0A
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E415923ABB5;
	Tue,  1 Jul 2025 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NkTYb9Gb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EC326CE39
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361772; cv=none; b=SSpRqrwOk2knFjzk4S+beQofWKU4fW9NNgyPKMMpIXmbJveh4p+WL8NFz/H96W9WwYldPbRhckGJzpIitcx3odRk8YICD39MgzoE3Spiqlo/6hmVitD81Bh0+F1t5WYmyBvNQCPzcA/QALc6ptFVNf/mfPRtUpcIivB2PcLioz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361772; c=relaxed/simple;
	bh=5agSzbXLvANUjeYbgj9vz6RxkJOxk8CMj/v7lHFWdt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=re011dnerX2KhpdA3a+/W3XD49gxcBxqpqTzZePJu+WCSkTIAR8B1pfcRQ4ceaWO3xtR0a0M+kAvGgDO1LG5MwcvjivXS7syvKBv9KKridQWg8p4te+xL+N2R9jOKQzp0CeG991FJaowOUj6CU+lKpcAAe99fkUwpfNTaQHlb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NkTYb9Gb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so10307115a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 01 Jul 2025 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751361769; x=1751966569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo/TsBTSnhnhtOzaR0L2fwad79M6B39oGRvluo5f4Vo=;
        b=NkTYb9Gbi3B65NSkFIwvhe+1zsVR+isG32rLHTB8EdsRr2ytHj5osu0YWURQA5aYIS
         NjwDNgfNsl+GjABupuFej80s4vWXzIkzTp9nH+3/yjEoFS86FP8CR5W2w6DrzlkwlLhp
         MpGmew1H9egWxFPrpdAz3/4m7FCcZuCpNVQWCf3wbRCGltwuKKZX8pHx+xweASj8NMB3
         xU2DQO9lskLeY5sMG7LPnAeCKbd6HKqHftFiBWYk/x6TUDXsZpYuyjuFSTnsoVB4TRHz
         gzrQLbB7f7dCsFNDkDqcGWM1ZYMN5DcD98SwvEHw5hn7Z8erYPamZCC1nyvwRrwPCE+Q
         4zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361769; x=1751966569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo/TsBTSnhnhtOzaR0L2fwad79M6B39oGRvluo5f4Vo=;
        b=xC2Ph/NuGTzqmOr0wptVHDtsgj9zjCpU08/h2oaiUYuYDF/Dk3RbCkW2Me8Y9PR70/
         AlJt0tkIRNvA7yPvh1O8MzN8KkcfskiM46eE5ax9Mt44du1daZntKry5e7cC+UGkb7kK
         9aGPxdatabqN6aEOksFMg3U7dpbYRTbxlmN4IoKkuXSuFJ1U+BVMTgz2QFzs28Y5MCst
         guRRp1nCIZ8FMlZa6rvEEZv642fJhX1v5VGDePmnm3MnyooSz8mExayRYSI82UZx748j
         oDWcqZFYALpKnJLvJNJbM+rv7Nf4CuczhCLcY3ohV7g9puD62Ic3QYuWBoQb2ltlmHcs
         9rjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3R93M9Iu+H2a6R2SoQfmNMLb4jwqLZSgMyR8we8GBoxSSRC9383hgflw6kNTmtAi/U+iu6gSo374=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywts2llCMs7gfIxG1ybEeUBpyjVbZe5i0KNjBU7oVBDjqSsvTPw
	wNVufCbLyj+68FqPvujKWy5JvMdshf8cz5rXxvkbG/shBX4j2DgINvUG2Q+aPUpXiLVuoU7x55X
	4qOL8
X-Gm-Gg: ASbGncsBUX10K/MshayYtduvqBXY3MXs6Er7B2SX1S1tk+NtwLByZsEuVw23465eAQ+
	rVUnvlccnmuFbNB29MHBYkkMyD+MWAVQ80OZaciY9bVz02wDbowa5rl6pn8PJ441rPBJktsl1p0
	seImy9XTJR8fyguTEC+C3EY0cbOkfT0bM76CgQ1uqcUMzYEXYltv7XN97tRq/7PTlPxMad2zT62
	Rl6lL883iYS9pJ6qjg1Wlf1MoTvsIhBjulgOPopW2j4mUGEIBbIyv51ex8CvgmZ5JdvB2aTZq9J
	BCAaUlwp+pFahxVoynfF+jpPWwWP5PmxPwUjQRqnrHhoj+kMkoBua1Xb6KR9/ohQEwE/YeUqnki
	orNzZk87Nfw1p4Prc2oL6zMHrgemX
X-Google-Smtp-Source: AGHT+IEP2MB6PmcecA+vSBxvN/masCQ3N4UCTqJS/cDNcu9bjsD9JeRomQ0HDPukLAFStOZO3Om4Tw==
X-Received: by 2002:a05:6402:4412:b0:60b:fb2c:b789 with SMTP id 4fb4d7f45d1cf-60c88ddd1fcmr12936963a12.21.1751361769148;
        Tue, 01 Jul 2025 02:22:49 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c8320b592sm7195568a12.75.2025.07.01.02.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:22:48 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Flavio Suligoi <f.suligoi@asem.it>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 2/2] backlight: mp3309c: Initialize backlight properties without memset
Date: Tue,  1 Jul 2025 11:22:37 +0200
Message-ID:  <14514a1b0d3df6438aa10bb74f1c4fc2367d9987.1751361465.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1573; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=5agSzbXLvANUjeYbgj9vz6RxkJOxk8CMj/v7lHFWdt8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoY6jgBvBEU9XlWZGFkK/ttXFd/DcPA1cEI1DbW 3sCHBUZ4buJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaGOo4AAKCRCPgPtYfRL+ Tvq7B/0TX3Aaz+14n37ZHEmP5rNiPkBkauLgV6PlfScVDkZtCJOzdS073lgqm54H6V/oTMtQEID zpgPjaUcTO+NJ8nkulWdGhIhhVG16ApKKJEMuNr5NWKqg5fyv/Y/jsp20kgk9pBMhXe6S9kahPd HWTN18Yp8cH3IsB21UXjApAvwcMIUcyqtbrzkXvQhJLZT87Mv09DxpXSYRpuYHc6gf3J1KvcOfS e9BJvTwcb8ooxa79xZlNsSV5tJFRA874qsjdA+jzTgZA20FnclMw9gNmNR8Wo6HJqHRJfxE/VKW C9jsBd+RSW7yBLqJmbTr3WNOQWrjLpkzJMRdydd6aOt8I/t7
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Assigning values to a struct using a compound literal (since C99) also
guarantees that all unspecified struct members are empty-initialized, so
it properly replaces the memset to zero.

The code looks a bit nicer and more idiomatic (though that might be
subjective?). The resulting binary is a bit smaller. On ARCH=arm with
an allnoconfig + minimal changes to enable the mp3309c driver the
difference is 12 bytes.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/backlight/mp3309c.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index bb4e85531cea..9337110ce6e5 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -352,12 +352,13 @@ static int mp3309c_probe(struct i2c_client *client)
 	chip->pdata = pdata;
 
 	/* Backlight properties */
-	memset(&props, 0, sizeof(struct backlight_properties));
-	props.brightness = pdata->default_brightness;
-	props.max_brightness = pdata->max_brightness;
-	props.scale = BACKLIGHT_SCALE_LINEAR;
-	props.type = BACKLIGHT_RAW;
-	props.power = BACKLIGHT_POWER_ON;
+	props = (typeof(props)){
+		.brightness = pdata->default_brightness,
+		.max_brightness = pdata->max_brightness,
+		.scale = BACKLIGHT_SCALE_LINEAR,
+		.type = BACKLIGHT_RAW,
+		.power = BACKLIGHT_POWER_ON,
+	};
 	chip->bl = devm_backlight_device_register(dev, "mp3309c", dev, chip,
 						  &mp3309c_bl_ops, &props);
 	if (IS_ERR(chip->bl))
-- 
2.49.0


