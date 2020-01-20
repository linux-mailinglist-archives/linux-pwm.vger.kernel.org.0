Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07159142EC8
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 16:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgATPci (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 10:32:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39512 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATPci (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 10:32:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so16021433pfs.6;
        Mon, 20 Jan 2020 07:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMUb4UT/Nl0RzRD4JMm3uMZnqeQJo9tO8hkOnDtEC4E=;
        b=cYm/xAnit5duDUrZSNf5yHb7/qxcY/IrwZeBIy3HMsoMwNutZ1Ymjyaen3DtT7upag
         njR79D7Z9FSCPH4zqy/H5Fb4I/ALvyCHbyq2jzPOB/d29VlOmQtMTcCb6HBVB+OxEFf4
         Gp3ZmeUpSr+An+Xb7npriQ4rs8Pl+yMpcFxuGAFcaZWEt6y2tDAj0syBEwskWcxVNlqw
         2IDWGieJt6JFVOKvehbmZ/BypL0n1eSGyEjV6P82rqqAFkYETS+mDLYk9jOA3G6ku8o1
         7upu/wkVirWlO1EaCx9puwyhpwHbFVccKLPnzzFKVQYLv8CXLiV2QSCYrMx0VqeOr0hl
         eazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMUb4UT/Nl0RzRD4JMm3uMZnqeQJo9tO8hkOnDtEC4E=;
        b=FJndGZoD0OZ0UAAEqBx4nN9+ivt7nBAJHm0Y9MJCA2VJHCqeq8qSmEGpJACmdl+1O/
         0ukQlnR2wwpC+Ar4OkAokiZsbjo/SFve/9PnX1TQ756S3bOGB4jJTUqV3mr7DMMOoFPa
         VFop62yGdjbjdy/JHg55Rz04j3RP5FfT1h3PomdaX+q3t2M/0X7Oy2S1lhqb5QsBxdas
         ndUsPgET9ylIyzDfewwe2dUuANebMHNsd9QGv+2eawfnMio2oYDfOiKYI3RMsXcHnEna
         oUw+aXwU4+2ya3B5qQHWvzjkxPzaPLDOTenQo8HWdm3i8n74lZ7GS+eMsuMo0HRIlh/F
         KXRQ==
X-Gm-Message-State: APjAAAVv+3ERdV+CtjzTiv5x7My5wDXH0qAqNmhrOlSF6k3YeyJ5x7mX
        ZzcBLr5NvrGZlsIUeWkzsjA65ca8
X-Google-Smtp-Source: APXvYqyRwVEaP9FNuLh2ezzOsX6H++Q0GymMPS7gp2wSbOwXC2/UDID7l0ZpJ+TUMM9K3qzsv7mTUA==
X-Received: by 2002:a63:1b0a:: with SMTP id b10mr227445pgb.56.1579534357126;
        Mon, 20 Jan 2020 07:32:37 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:25f1:5a01:f589:2cf2])
        by smtp.gmail.com with ESMTPSA id q199sm41037797pfq.163.2020.01.20.07.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Jan 2020 07:32:35 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] hwmon: (pwm-fan) stop fan on shutdown
Date:   Tue, 21 Jan 2020 00:32:24 +0900
Message-Id: <1579534344-11694-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pwm-fan driver stops the fan in suspend but leaves the fan on in
shutdown.  It seems strange to leave the fan on in shutdown because there
is no use case in my mind and the gpio-fan driver on the other hand stops
in shutdown.

This change turns off the fan in shutdown.  If anyone complains then we'll
add an optional property to switch the behavior.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kamil Debski <kamil@wypas.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- remove optional property and just turn off the fan in shutdown

 drivers/hwmon/pwm-fan.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 42ffd2e..30b7b3e 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -390,8 +390,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pwm_fan_suspend(struct device *dev)
+static int pwm_fan_disable(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
 	struct pwm_args args;
@@ -418,6 +417,17 @@ static int pwm_fan_suspend(struct device *dev)
 	return 0;
 }
 
+static void pwm_fan_shutdown(struct platform_device *pdev)
+{
+	pwm_fan_disable(&pdev->dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int pwm_fan_suspend(struct device *dev)
+{
+	return pwm_fan_disable(dev);
+}
+
 static int pwm_fan_resume(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
@@ -455,6 +465,7 @@ MODULE_DEVICE_TABLE(of, of_pwm_fan_match);
 
 static struct platform_driver pwm_fan_driver = {
 	.probe		= pwm_fan_probe,
+	.shutdown	= pwm_fan_shutdown,
 	.driver	= {
 		.name		= "pwm-fan",
 		.pm		= &pwm_fan_pm,
-- 
2.7.4

