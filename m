Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35F9213F72
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgGCSqR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgGCSqQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:16 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94797C061794;
        Fri,  3 Jul 2020 11:46:16 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so19059399lfm.1;
        Fri, 03 Jul 2020 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76GYwHJgmpg1D+ufO0JSzMv0fcAJAUH2Ai/nlDiORJQ=;
        b=XCwWqqKaoJ9GY8XfUndqUq6Vjy5mVIvp/JQIsd3c2s3e/DFaT4x1RYdECZ7hADeg7A
         XD8laph6i7Omw2sMJacDaEjBVaFGHcr/slybT0ZO0RnOSo9URXZvOUVPaV1taIp3wbZK
         5wZX2gjTq2EzzilQDlzx4HPYwgU9eeuXla+wjfnbjR2+O6ftUdKY8FLGMAy5xcMJfdZH
         K/jqmptdwiGN8U5ZCBkrBiu/38Wu0RD5rAaO385T2OezFvo0ZPFMk6lnVSgeabIKkxqG
         BKEPdzsLnJTfZ5h8shP7CucATIIXQOm3BLcJFMYZIYK8EUn1jPHlJBnegoWDh/3Hzr3p
         vtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=76GYwHJgmpg1D+ufO0JSzMv0fcAJAUH2Ai/nlDiORJQ=;
        b=NqKM1FpC0E5dbAqWriJ/Vt7ljPKbljECghP9btfVzSH18NAD1kTXMK36lBcONOO2mi
         K7DSR4cSJXT2uYH/tm6pCw3KtqWHJdVmlipcMkB231ktyA6ObRU8ACUwV4KZAVXwmrVa
         VjtQidhFpnHfVMVt6PK3jq5BrD1FBNYExa74LOMIRjose9yvzWYJINNcMm6X4lmeDIlY
         iIKMlTtr0VI3XzQHq71+fuDwK0Z3RCS0exEfviwQKYgsgEZDgpaOezzvj2r55Y1CIOoL
         v1xzgT3DLBsrtyRhH7sIrT7kmlDk1Z+053nz069dUPgb7RENc7JAZlxDVLzPMlyAgHo4
         wSMQ==
X-Gm-Message-State: AOAM533g9BFL9gDMzCiS8sE6MzJ9AW4q+SqkfGkDKHurQvmN2OlrVOfG
        KDLM98qnJOUcEGeYlmKGGGs=
X-Google-Smtp-Source: ABdhPJz8bmVRIrBKTzOJ3rIl6mEq0ud3DW6wn671IW0G6f34jg/y3QlzvCxFFE92mpTId7a05bIO+Q==
X-Received: by 2002:a19:ad41:: with SMTP id s1mr6607452lfd.191.1593801975119;
        Fri, 03 Jul 2020 11:46:15 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:14 -0700 (PDT)
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
Subject: [PATCH v4 06/20] backlight: document inline functions in backlight.h
Date:   Fri,  3 Jul 2020 20:45:32 +0200
Message-Id: <20200703184546.144664-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add documentation for the inline functions in backlight.h

v2:
 - Fix spelling (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 7654fe5f1589..7d6cb61e10f5 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -268,6 +268,10 @@ struct backlight_device {
 	int use_count;
 };
 
+/**
+ * backlight_update_status - force an update of the backlight device status
+ * @bd: the backlight device
+ */
 static inline int backlight_update_status(struct backlight_device *bd)
 {
 	int ret = -ENOENT;
@@ -361,6 +365,18 @@ extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
+/**
+ * bl_get_data - access devdata
+ * @bl_dev: pointer to backlight device
+ *
+ * When a backlight device is registered the driver has the possibility
+ * to supply a void * devdata. bl_get_data() return a pointer to the
+ * devdata.
+ *
+ * RETURNS:
+ *
+ * pointer to devdata stored while registering the backlight device.
+ */
 static inline void * bl_get_data(struct backlight_device *bl_dev)
 {
 	return dev_get_drvdata(&bl_dev->dev);
-- 
2.25.1

