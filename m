Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBA2B6C61
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Nov 2020 18:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgKQRzF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Nov 2020 12:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgKQRzF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Nov 2020 12:55:05 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ECFC0613CF;
        Tue, 17 Nov 2020 09:55:04 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t8so1476377pfg.8;
        Tue, 17 Nov 2020 09:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uhyLHwpbsyME5LkYkNpSVqv4MkcAmSRgTObHS1dyZ50=;
        b=kJ15ahOxZWO5BriZH67oGM8ZH3pCxo6h80tRyv59Ej5nWGlPm79XDSpApd+6BdZpIg
         2M6qJSe1gUT8w09U6cH/2arRHsXVkXS7VG7psqZYOAPNmXfmSNqzkm9FlUO1G8XH3YJM
         0zube0AM8EYwziXHUmcWXKWo/zvom2M2ErYyDyrqwJ41ALGGYX8FhRwXkN7oZstBz9PA
         yqEZ9+B8zyqKLlwWyocgSD64fa4vUAZRHP5c+97UAIFJMHGEkGki0SPvO8AG40vp4ibD
         GS5XkXjA5WxiCmnh65zxlSPKt5hodWot7nuSrliQnDp2PXf+zpwWhLUve6vw4Q/EllJQ
         CBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uhyLHwpbsyME5LkYkNpSVqv4MkcAmSRgTObHS1dyZ50=;
        b=P+5bZsN15lYIsH899WhvsgPD33bc3SIUsl7Bqxd7WfzepDvRo4RDMM8sDu0jm919bn
         gQNSACgSNqiTfTbN7zkMEXnyYr1i9QKD4DCzEMPPP3zphugZttbTMKeQwTBIsXcvYwcD
         mJUUHQLvmdn7bt/tuHAP/wAnL74/jyKSfIW/43fyDX/dUJIbJf1Cw+/liCOSqDHbL40B
         m/hFpLyRHrU/6LVMxwTaQt7iDuBTZmIKUbtquc1Q8anNgycp8tkIu7hCOaeVWUYavpG+
         3S7teOKpJV5zF/VZFeiIfFTpWBTkPpDCsiGfVCeDvz/AcaPjBhaUBdXQU1hGA8Md1h7U
         +esA==
X-Gm-Message-State: AOAM532ctsgEteUcO8+sK3nWjI7ze4g3PKh//MTb+BmHzG89EzhFJV3r
        5je3ulm0ePf2RTHOrAbmvYb1VuePa04ddrsY
X-Google-Smtp-Source: ABdhPJy0EbydG/ia89pTIzK7Cghr0k36U7UuBPsqxpeY/ui8LIV9xQvNJMQzCQ3KlOZMvvbrL1E1fQ==
X-Received: by 2002:a63:5421:: with SMTP id i33mr4626506pgb.316.1605635703590;
        Tue, 17 Nov 2020 09:55:03 -0800 (PST)
Received: from manjaro.domain.name ([202.142.93.91])
        by smtp.gmail.com with ESMTPSA id 21sm22446764pfv.122.2020.11.17.09.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:55:02 -0800 (PST)
From:   Soham Biswas <sohambiswas41@gmail.com>
To:     thierry.reding@gmail.com
Cc:     lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Soham Biswas <sohambiswas41@gmail.com>
Subject: [PATCH] pwm: core: Use octal permission
Date:   Tue, 17 Nov 2020 23:24:52 +0530
Message-Id: <20201117175452.26914-1-sohambiswas41@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Fixed Warning.
Replaced symbolic permission 'S_IRUGO' with octal permission '0444'.

Signed-off-by: Soham Biswas <sohambiswas41@gmail.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1f16f5365d3c..a8eff4b3ee36 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1338,7 +1338,7 @@ DEFINE_SEQ_ATTRIBUTE(pwm_debugfs);
 
 static int __init pwm_debugfs_init(void)
 {
-	debugfs_create_file("pwm", S_IFREG | S_IRUGO, NULL, NULL,
+	debugfs_create_file("pwm", S_IFREG | 0444, NULL, NULL,
 			    &pwm_debugfs_fops);
 
 	return 0;
-- 
2.29.2

