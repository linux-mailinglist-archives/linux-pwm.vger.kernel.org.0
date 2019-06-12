Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D4643090
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbfFLT7f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46877 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388979AbfFLT7f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so18182404wrw.13;
        Wed, 12 Jun 2019 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObC610o5hWHINu0uTU3Hl+oLxvUvo9xNqJSdPceiF2s=;
        b=PV/Myi90oQwUTv4MltNi3KCGMwomtwtY01yXOejDgDqhUB5Q2M/JwPLZN2xZopb6Lk
         XxuGNpC58jARbYUyu/JPaQpJgHW6l3NCECEzHBd56a+m23TqtFzbWFpPb2c3gtJ6s/g0
         M97J9Tb9p+OMt5NBMXVQlboMuNSmeCrg+9SeBABw87oyZZictQLdfyZvleUDl00Ve1o/
         FOrGNyN8ZKM6bWhda7VR75zR2eH7rigUAWnDS7Y6VPLjUZYa1Rc2lt2O17CSYbUo9G5j
         7iDEANSmpkZ4rFYxcIcgkKRu/VADET92ufk6D2iCY5gFDDRiEy6Dm+Etg5XTaBdF9o0h
         EGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObC610o5hWHINu0uTU3Hl+oLxvUvo9xNqJSdPceiF2s=;
        b=gj2hCMsDYDHLuHSBePQdIXlO23GZ7wApI1NtPV9F1ENj8O9jN3+7J6Dfwi0MEuqhX6
         KsC7X6cGR5rYBqRK4FcztBatlzPGY029zyaxGQ6AUdq+xvGgXRwsr3Pggj8Sq+WgRtxa
         lT/P22WwYCbaVTv+o0SLhl/UEGK2RbNaK7iT95Usehri1FEyChqUVtFMk7bgs+c2lDWb
         5ZRKYW87kosho1VyPjzj/eeNowQDGOu3laeOp6xox84Sh9I0hfWm/QJmn8k4I0CsI5un
         /rbeHawV+0ecKC7IzqMuoMkKV0T61CYcpkl7jL0jDS8P4POJVxQmDoHc1pVem1CcxtY4
         jOng==
X-Gm-Message-State: APjAAAX4OXZh3QlvN3KskAfbIw6zvfcIqnifyRD/AzXgDv0MD48/AkDs
        ct9e7Qie1vS1+pq0ukYb7j8=
X-Google-Smtp-Source: APXvYqz0QFlGb11jXCoLBy5+7zRsUxelrr5LALZaZMvlKNJXCARUiloBFYpkdMQQg2ZBXsJ0hdCGmA==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr16900316wrv.132.1560369572747;
        Wed, 12 Jun 2019 12:59:32 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:31 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 02/14] pwm: meson: use devm_clk_get_optional() to get the input clock
Date:   Wed, 12 Jun 2019 21:58:59 +0200
Message-Id: <20190612195911.4442-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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
2.22.0

