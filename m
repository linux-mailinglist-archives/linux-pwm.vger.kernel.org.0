Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99963142D98
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 15:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgATOcN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 09:32:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53079 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATOcM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 09:32:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so14729805wmc.2
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jan 2020 06:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBfE0rmIu/FSUJN4p4CePAsqkWjdbYzEzxaRDLfRmmE=;
        b=ccacutXTN3UM1ZElXF22VF1gII/g384omL6Xj5L7Qdqx8ADH/Jrh8Xk+b2bkAaYBZ8
         Nss5GZ/2dUNcccqaxuin5/1l0PS3tL1QDxXcm6izcY8UCSaRRtATi5NXX32K0HH/rRC7
         15Q9UWX5eqAQI6NNnYRpq/sm/MdhlwXQkY6rhG32ii4kWKzd4X7AFlAGe1cSkyioQ5s+
         +LQpteLd5oR9vZr5Vn0p8Cizs0k95eZUrGbDwrsCOhz8tgzwjVdIzSI4dCjq6QFODEnJ
         d7gpB0h9lNyYnrMTHXojgefBAoHoMJGEVnIHuZDOpNFczrOwvd6X5YMmMo/GxNV4adQQ
         HOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBfE0rmIu/FSUJN4p4CePAsqkWjdbYzEzxaRDLfRmmE=;
        b=lvGevA5iun8WTtMTJLH7AIKxAwIJziMqWX06q6VB1HsewkaTFaORzBzbmJHJ3ULKv2
         9sJOKmr5NzeIoh4rb9FQOmlP8jx0Fv7khga5uP/+AVlpQTAqUXcK8dmV0XWjv8rY2wjn
         lqP//nFp88WyDF3MTWGDbjSOjVmOPZs1CSkmznWSdrFLZpriRHCoLvLMVsU3esLBgg/M
         1/sDWcDEyM/FMDLDRnCE/o7+JI+cOanRokDAXUAHsFRN7G21jWFFJ2LOad0S/HKlQwX8
         8nw3bwbsc5YwUu3aFteIGLxzGUMy8KEHz6A6Pqmkm+ebqUInQzbI22/eW3S+D1tFMktg
         ArGQ==
X-Gm-Message-State: APjAAAX5GTSqPvUGPv8xUFcgTKZse0ZfItM1JHgtg51WxoiEXaY+S8m+
        BwB27uGA9Wfxt+Dasxh16OI=
X-Google-Smtp-Source: APXvYqyn7HKOlw7Kw1sNJKhXeN7RvYG2rSk5+OaTpWv3AhzsvQx/3L2FofSJqCc+XJ0rng0nczP7Fg==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr19192303wmi.15.1579530731099;
        Mon, 20 Jan 2020 06:32:11 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id q15sm47843518wrr.11.2020.01.20.06.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 06:32:10 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: sun4i: Initialize variables before use
Date:   Mon, 20 Jan 2020 15:32:06 +0100
Message-Id: <20200120143206.710666-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

GCC can't always determine that the duty, period and prescaler values
are initialized when returning from sun4i_pwm_calculate(), so help out a
little by initializing them to 0.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 0decc7cde133..3e3efa6c768f 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -234,9 +234,9 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	struct pwm_state cstate;
-	u32 ctrl, duty, period, val;
+	u32 ctrl, duty = 0, period = 0, val;
 	int ret;
-	unsigned int delay_us, prescaler;
+	unsigned int delay_us, prescaler = 0;
 	unsigned long now;
 	bool bypass;
 
-- 
2.24.1

