Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFECE27CBC6
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbgI2Mah (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Sep 2020 08:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732940AbgI2Mad (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Sep 2020 08:30:33 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Sep 2020 05:30:32 PDT
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8DBC061755
        for <linux-pwm@vger.kernel.org>; Tue, 29 Sep 2020 05:30:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 2D39823F719;
        Tue, 29 Sep 2020 14:20:47 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.959
X-Spam-Level: 
X-Spam-Status: No, score=-2.959 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.059, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aMnj5Bosl1_X; Tue, 29 Sep 2020 14:20:45 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id A1EAE23F113;
        Tue, 29 Sep 2020 14:20:45 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH] pwm: sysfs: Set class on pwm devices
Date:   Tue, 29 Sep 2020 14:19:53 +0200
Message-Id: <20200929121953.2817843-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This adds a class to exported pwm devices.
Exporting a pwm through sysfs did not yield udev events. The
dev_uevent_filter function does filter-out devices without a bus or
class.
This was already addressed in commit
commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
but this did cause problems and the commit got reverted with
commit c289d6625237 ("Revert "pwm: Set class for exported channels in
sysfs"")

pwm's have to be local to its pwmchip, so we create an individual class
for each pwmchip and assign this class to the pwm belonging to the
pwmchip. This does better map to structure that is also visible in
sysfs.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/pwm/sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 449dbc0f49ed..e2dfbc335366 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -259,7 +259,7 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	export->child.release = pwm_export_release;
 	export->child.parent = parent;
 	export->child.devt = MKDEV(0, 0);
-	export->child.groups = pwm_groups;
+	export->child.class = parent->class;
 	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
 
 	ret = device_register(&export->child);
@@ -499,6 +499,9 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
 		dev_warn(chip->dev,
 			 "device_create failed for pwm_chip sysfs export\n");
 	}
+
+	parent->class = class_create(THIS_MODULE, parent->kobj.name);
+	parent->class->dev_groups = pwm_groups;
 }
 
 void pwmchip_sysfs_unexport(struct pwm_chip *chip)
@@ -518,6 +521,7 @@ void pwmchip_sysfs_unexport(struct pwm_chip *chip)
 			pwm_unexport_child(parent, pwm);
 	}
 
+	class_destroy(parent->class);
 	put_device(parent);
 	device_unregister(parent);
 }
-- 
2.28.0

