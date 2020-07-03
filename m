Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8280B213F97
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgGCSqm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgGCSql (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:41 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB3C061794;
        Fri,  3 Jul 2020 11:46:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f5so22207155ljj.10;
        Fri, 03 Jul 2020 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lVGBtlKGV7mdea3qCpDAmIlkL+A1oTLOm9ndlSKSYE=;
        b=ZIwE1w1Ghx/3tjTG+wWLdg1TLz4DCo7E7vGxFhkIbmVtSA4a3WjTgV2QLaq4v6iYPs
         rJH2NSWw4cwTu6I109t15wwb+yZDIG2EE2PGAZB32JlOO2Z6y5DM6qQDP4tecxbnFmWw
         1u8su0FG/qdwH/YNq8J+hQNaQkKjlxkQ0uuwySNCYmXbXsZtsbzDBfPBRI+7cG5ZLEsQ
         0B0Gxz9/XyRl2XSFGkC194VTypSXzD+TJbgUrJHvHddFMEY6naI7207I4hsezHVN5phY
         CsYcfAD9A1rBYyCIgJ24hn7Ge0Ngc8uilgeIvtZ5v3JpDtZDCT6ch4vQaLc5yYtJJyRt
         5f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0lVGBtlKGV7mdea3qCpDAmIlkL+A1oTLOm9ndlSKSYE=;
        b=TQl7i5hhLHfsgr/TbhOFvaVpFXcB3LVxgg/tC/M/G4CYvlb/pQFIFUfTR/UKwCKqwB
         YCHRIshClUKGmStEVGgeQaFWLg9xGQG3RzdoJ5I8TnQmrCRSuATgUPWwy6CCjKkgkT3E
         Ls3FfDQRX+5tPkTSVRPs9+24bGuiHNB7m6FG+14WftmaL2T4RuzU6S59NCXAFvQgF6ye
         84BlYRJ+uM97KIsjrGYFOEf4Jutrx9HcOrw+d+QCSSdTa43uEoVHBOUCE4n92XxofORj
         T0scDCwEI3ACaYlzgc4oZkmgau9N+dhq0I43YkjAWhTd9Xre0cN3pny71hGSurvaoeIw
         PN/w==
X-Gm-Message-State: AOAM530SS1/PphtRuTks89bVat8iNW4spAW4ofs0zjTd0w1G1zZkC1t2
        t8AxtPl65vXTtI/T5AzHLw4=
X-Google-Smtp-Source: ABdhPJyj54hLQtM3LIea5xG6yd7fVGh0vAlECmdYKX5F8gkkwLsjofvTh3sUVDiGYYetSfgISEkpmA==
X-Received: by 2002:a2e:161a:: with SMTP id w26mr20539700ljd.216.1593802000116;
        Fri, 03 Jul 2020 11:46:40 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:39 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 18/20] backlight: drop backlight_put()
Date:   Fri,  3 Jul 2020 20:45:44 +0200
Message-Id: <20200703184546.144664-19-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no external users of backlight_put().
Drop it and open code the two users in backlight.c.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c |  7 +++++--
 include/linux/backlight.h           | 10 ----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index db8717581ec5..099023771ab1 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -717,7 +717,10 @@ EXPORT_SYMBOL(of_find_backlight);
 
 static void devm_backlight_release(void *data)
 {
-	backlight_put(data);
+	struct backlight_device *bd = data;
+
+	if (bd)
+		put_device(&bd->dev);
 }
 
 /**
@@ -745,7 +748,7 @@ struct backlight_device *devm_of_find_backlight(struct device *dev)
 		return bd;
 	ret = devm_add_action(dev, devm_backlight_release, bd);
 	if (ret) {
-		backlight_put(bd);
+		put_device(&bd->dev);
 		return ERR_PTR(ret);
 	}
 	return bd;
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 38db67588b16..f3b484c99789 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -388,16 +388,6 @@ static inline int backlight_disable(struct backlight_device *bd)
 	return backlight_update_status(bd);
 }
 
-/**
- * backlight_put - Drop backlight reference
- * @bd: the backlight device to put
- */
-static inline void backlight_put(struct backlight_device *bd)
-{
-	if (bd)
-		put_device(&bd->dev);
-}
-
 /**
  * backlight_is_blank - Return true if display is expected to be blank
  * @bd: the backlight device
-- 
2.25.1

