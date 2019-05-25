Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8EA2A634
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfEYSLv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:11:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40735 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfEYSLs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:11:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id 15so12045788wmg.5;
        Sat, 25 May 2019 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ore1r+dKR4AsT7KxL88Hg8/dGPX/2Y8Acm9/4eCEojE=;
        b=nHZYDf8YaoMbqMOwxPqAgeNXKRos+cq9aefZf6p10ZPPH5Do6B89b2LgjGxiVvBQWU
         equJR9FChOuFY1BUIzW+60NrCl9iRiWpR0nFeX3lSwu4xUquFzktcMjwH052JbxmK9i8
         Fi1/FKNVoUCx5DZywgRWIgq7MLSK5srRzuOKI9fazBPplvA7T/naIrtgrDYRlF+N7Nzs
         aVLkFmy73N9q9ZE/IirHHTygjvvMinjKugjGL8ydk7hrdaJRPi3K+/CaMlfEh5dphQJZ
         QcdlMhj7/wUUAwSP7sy6w9+msWy0qEFbMkwTOO7M7e0CiiOxTI5sqNxGrA8pBLOLYMB+
         3YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ore1r+dKR4AsT7KxL88Hg8/dGPX/2Y8Acm9/4eCEojE=;
        b=KvNPbVYVl2Wv46V1tpSn1xAfHflsA5yp/pMskTO8UVpgyEwWwpUkryKT4G/vCmfQw+
         DmEjVuUp1/WTMcus1xD9VdGSpQsnNw+KT8IdyaeeQyWbsT243uNtQ5f4pa3M0JErVp/b
         1AGgZL6giIC+7AAlaIMdx8LDqHcNAIzmjl9tcA1RcqerjjFIa3Vle+zUN/BKf7ZgMqUn
         RhwmgeQb5ZR33U2rsrjRquQuxWcWnfaxc89cg+puvxqEbYLzWlTaZVxdlOYthqXiBSbC
         o1BBtI6d0tq6dfmEgWwnccV0xeFCESo5FrXzH9zXv2rmrQ3u9yHjzVALzKGdv8/XuGnN
         Exlw==
X-Gm-Message-State: APjAAAW+Of2ZfQYOrODzoGMiPgmdqsUKfJKKT1v2PDgPMRw3A05qvP64
        pVxsQwtUwNmAHcBanD7/56I=
X-Google-Smtp-Source: APXvYqy0bTm4jI4EyxEEibvtqTUC/09sCjBxlHpiBVsIbHD2fHjksgEWT1NhF5dHYSHrEwXtHO0wmw==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr7581726wmj.69.1558807906172;
        Sat, 25 May 2019 11:11:46 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 02/14] pwm: meson: use devm_clk_get_optional() to get the input clock
Date:   Sat, 25 May 2019 20:11:21 +0200
Message-Id: <20190525181133.4875-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Simplify the code which fetches the input clock for a PWM channel by
using devm_clk_get_optional().
This comes with a small functional change: previously all errors except
EPROBE_DEFER were ignored. Now all other errors are also treated as
errors. If no input clock is present devm_clk_get_optional() will return
NULL instead of an error which matches the behavior of the old code.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 3fbbc4128ce8..35b38c7201c3 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -474,14 +474,9 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 
 		snprintf(name, sizeof(name), "clkin%u", i);
 
-		channel->clk_parent = devm_clk_get(dev, name);
-		if (IS_ERR(channel->clk_parent)) {
-			err = PTR_ERR(channel->clk_parent);
-			if (err == -EPROBE_DEFER)
-				return err;
-
-			channel->clk_parent = NULL;
-		}
+		channel->clk_parent = devm_clk_get_optional(dev, name);
+		if (IS_ERR(channel->clk_parent))
+			return PTR_ERR(channel->clk_parent);
 	}
 
 	return 0;
-- 
2.21.0

