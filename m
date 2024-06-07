Return-Path: <linux-pwm+bounces-2378-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E98E79009D5
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C621F24CEB
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE4719A297;
	Fri,  7 Jun 2024 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iIsEQ4GG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00957168DE
	for <linux-pwm@vger.kernel.org>; Fri,  7 Jun 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776032; cv=none; b=kKxnNprci40XVOFTl6grx+2q22bFRt7QdWdXESADCL2TVzYC9eHHo6/8Hl8lOl0RR9LM9SY08MUGveB1RvAZjTj9q7gZfBpH3XSpiAVe+zbt7PINrz2iKtOC8Rm/mCs+x35fw6YJxJ7TkhFR8VxubhJRo8CwlaQV9aAfBiEMXuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776032; c=relaxed/simple;
	bh=Z2RennitJkfsLq1QTz46QemH7bW2SzVsfOpwB3Pad8I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jv5eh9iiJ3ddt9e1828ld58DIcjVcGRNoc8hKyI046/HyNpgTKnG7E3y3OdgzEOZF/0ehGAAmTRPtcqehsZzauVCdURP2JQMHx9M0bEkb3ILsHz45QJMmVCBUZFLZ9cBnI9fyFxurfK+AB7vFBIuwY8aTJS8937dpJt53TyvTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iIsEQ4GG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35ef1e928c9so2657825f8f.3
        for <linux-pwm@vger.kernel.org>; Fri, 07 Jun 2024 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717776027; x=1718380827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy3IUSmQLPdv0KLTUVaBrafm34AdVng6LP0XorDhFGg=;
        b=iIsEQ4GGEeK0tKRacMsz2JAJfjeDAisENUAvd9aq4WaYJTaX4cxXKJj7BEkEv8LAyZ
         0n3en0Jq77sX/H6T2PBpzWp0U6F2DqM8Aelr1OmCyFI38J7vKGAXl9hF1W9PqcFsDmrj
         G+YuNd4X2O5FMHeJUAwVItCbP/klE/dZDUHGMelIA/4YPNIivQTcU/ySUpIHHD44a1DY
         QX+T4LJc8i95HnfW7s4hEMwVlmbJ9KR25g9DGYVx9qNEDzbZWFUTrYlChGubKwtx4Elp
         ZRZjKk+9CJ5Or1CF4Bwvl81+0xdzL5KYNZexlZr+PqSvaRM+Wwc6Zjgdf+vD8kzgZ6Us
         VC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776027; x=1718380827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy3IUSmQLPdv0KLTUVaBrafm34AdVng6LP0XorDhFGg=;
        b=hp2FeJwvTWanWY9tOgRwEzEZts0X2C2C3rnbJETLrEkb1sp/t1TrIAXzHBz7HrbHNS
         72ye5VXByjsgRA3LDCoBrZr75mbhUmtDWsmYnls2Do/Vb8acLlrRXCYosrQraU1zo+Xq
         YtyLiMsU+5RR++yVK9ayKbJO2nEe6p3paIO7UVD+Fe1/UfzGaXkTq6x1lqwcCwiG4HZt
         6iVItWDl+lyw7iWcoyXVH45haTUaCJXrYqLT4vfbVXDE6eCSiNOcwcAYTB+t4X3JV+cz
         90Ba4DPeNd8/9Pnj98bZ5pyd2vx1/vQ4jCoEtLa0kzEsMRTqPAR2VD/+4/OSd3+4TaqT
         Vpyg==
X-Gm-Message-State: AOJu0YyfMdifP1F+REZvAmnknz8QWD/HILjcP7Plp2SibDvE1FKYQUUl
	2xpU9xxC826OoRK0ayR3bfYtJo7d8PClUrgr+Hwh+oWgBQc6ggJ2wUtvIxJOD8gjpO135dmDU+M
	TA4s=
X-Google-Smtp-Source: AGHT+IHl7QEycWrJlNLM52DG8yDZoELK9p0bWCessW5LYlnMCr1/HOTK1clGG2cDEOEEyumOEmJysw==
X-Received: by 2002:adf:f452:0:b0:354:fd10:d217 with SMTP id ffacd0b85a97d-35efee14240mr2789260f8f.63.1717776027022;
        Fri, 07 Jun 2024 09:00:27 -0700 (PDT)
Received: from localhost (p200300f65f283b0017c92b05fa289d44.dip0.t-ipconnect.de. [2003:f6:5f28:3b00:17c9:2b05:fa28:9d44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d484absm4251692f8f.30.2024.06.07.09.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:00:26 -0700 (PDT)
From: "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Make use of a symbol namespace for the core
Date: Fri,  7 Jun 2024 18:00:13 +0200
Message-ID: <20240607160012.1206874-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Z2RennitJkfsLq1QTz46QemH7bW2SzVsfOpwB3Pad8I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmYy6MwSIj1OFIyfzc4iqyJ1FAij4Udj8FXRhpr UPMgPwCbiyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmMujAAKCRCPgPtYfRL+ TnwKCACOzrSIzJZHvAX9HmF8QpoIrrAiRdFhNvM58VisgETD7tGA7fNE/TwenAUlkggLai8/V5y 7aHJ74CTqX8+nOsSNGq1ZvGVao3cSwxO39nmA4GyJIR5qZ6MHnU2SsCjRN5JySpKT5foy0bl6xr 2prgM9J9hR3INLWIu/b2Ecz3Igzu1qpsyClVUg/5WkhYMzXfooOEpQgfONbcHNoZOJiDMvde/nG jRNojezt3P9exckXlbuNnaXJI38n6XmWHCtuaGBcAtJDvJBuZWBls5umulb7pylLikEzNhHIgPB qvbnvmKUomnHWGRBtuWghJIg2VHXRLAajtWBk9KHJa9bbXlH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Define all pwm core's symbols in the namespace "PWM". The necessary
module import statement is just added to the main header, this way every
file that knows about the public functions automatically has this
namespace available.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c  | 2 ++
 include/linux/pwm.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 18574857641e..604fd9bc8f22 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2011-2012 Avionic Design GmbH
  */
 
+#define DEFAULT_SYMBOL_NAMESPACE PWM
+
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/idr.h>
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 60b92c2c75ef..21beb3663623 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -4,9 +4,12 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 
+MODULE_IMPORT_NS(USB_STORAGE);
+
 struct pwm_chip;
 
 /**
-- 
2.43.0


