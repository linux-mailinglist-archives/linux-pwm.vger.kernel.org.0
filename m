Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDB1F99DA
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2020 16:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgFOOQQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Jun 2020 10:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOOQP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jun 2020 10:16:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0AEC061A0E;
        Mon, 15 Jun 2020 07:16:14 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so17615379ejd.8;
        Mon, 15 Jun 2020 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ML9B0Vh3wW8QO968+wMjH81XlOEJmAiEuc6FkdL3Yek=;
        b=jDt7zqb5E65vdo0XIc5HDqUXMviUtrQPxbDlrMbzPrKHhoU2IsYkqGs7JBN7CWEpNf
         4BTryf0riVYFJKIulUWD/+dbj8/q2P4RSXDqgbHjJGy8cZjbCaO6UOnZYXoQpFTdxpOr
         yCnBr5wZi+R0Q/93JbFOHM7zCd3l8KJs7W1EstZy1QWNe0uRmNkVcgSsHV0fOsxtfUM2
         6zKJ2IetNOU4ZwWerpQYt8LEsTTAvrGBJp97Q3IBohka5uZuT72qn192B1vm2JNUBc6B
         KnV7A9h4F6j63EkF+e8CGXBd20hPZG1ErUhTwVeOOnRhdlonMIL2+mmgk0x6BHSiw/lh
         XS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ML9B0Vh3wW8QO968+wMjH81XlOEJmAiEuc6FkdL3Yek=;
        b=JI5un3JefwKhcY4KPmQ2ti003e//Rba76j9rG1h5kkjN3z9MT6xm7amZOjVNj5s9YQ
         wVwI/g/sSo9VlOphuVZ4yuxTDioRALkCdKYlZAu3xyWkmiqR5u5ThW52/5KK0Q59ZSbT
         XdLnx2ZNrljHS7gJlj/tCbVOGQaIGXB5jy7sBiCMF32ynXuToTfeB25asZBn+blOspEP
         SvELMRwgu8SPJqlxmFUKn54eR1XF+6sR7fHnMVhHLq8qPgvcDLgSpUcwTPhKpF3MnDiX
         LwPcIwAKHFspBsAuaK+xjsL2psx4QB6NhGY3eKXk1Zqh/dyegVUNkjDRRekEgUBSRWJN
         u4eQ==
X-Gm-Message-State: AOAM533wqVmeEPOkxjzi4IRPd6g8IFkLpZs6ohMOoZl75FRVfEA9CyaJ
        Iqst9GfTS1JLOP8ddiweqQE=
X-Google-Smtp-Source: ABdhPJxPFp9TIHzv29kuepbE6S/+HTXmDG3s0AIfE2enGrd2uFRNWwz3EU2k08951dQpBxbh4Sl8+g==
X-Received: by 2002:a17:906:1b1b:: with SMTP id o27mr24110963ejg.264.1592230573617;
        Mon, 15 Jun 2020 07:16:13 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id k23sm9124815ejo.120.2020.06.15.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:16:12 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] video: ssd1307fb: Print PWM period using 64-bit format specifier
Date:   Mon, 15 Jun 2020 16:16:05 +0200
Message-Id: <20200615141606.2814208-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200615141606.2814208-1-thierry.reding@gmail.com>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM core will soon change the duty cycle and period of PWMs to 64
bits to allow for a broader range of values. Use a 64-bit format
specifier to avoid a warning when that change is made.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 8e06ba912d60..09425ec317ba 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -312,7 +312,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		/* Enable the PWM */
 		pwm_enable(par->pwm);
 
-		dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
+		dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.\n",
 			par->pwm->pwm, pwm_get_period(par->pwm));
 	}
 
-- 
2.24.1

