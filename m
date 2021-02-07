Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1742D3123BC
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Feb 2021 12:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhBGLN1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 7 Feb 2021 06:13:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12081 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGLN0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 7 Feb 2021 06:13:26 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYRKY3MdlzMWRN;
        Sun,  7 Feb 2021 19:10:57 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 19:12:37 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <thierry.reding@gmail.com>, <lee.jones@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH] hwmon: (npcm750-pwm-fan): replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Sun, 7 Feb 2021 19:12:13 +0800
Message-ID: <1612696333-50502-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The code has been in a irq-disabled context since it is hard IRQ. There
is no necessity to do it again.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/hwmon/npcm750-pwm-fan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 11a2860..6c27af1 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -481,12 +481,11 @@ static inline void npcm7xx_check_cmp(struct npcm7xx_pwm_fan_data *data,
 static irqreturn_t npcm7xx_fan_isr(int irq, void *dev_id)
 {
 	struct npcm7xx_pwm_fan_data *data = dev_id;
-	unsigned long flags;
 	int module;
 	u8 flag;
 
 	module = irq - data->fan_irq[0];
-	spin_lock_irqsave(&data->fan_lock[module], flags);
+	spin_lock(&data->fan_lock[module]);
 
 	flag = ioread8(NPCM7XX_FAN_REG_TICTRL(data->fan_base, module));
 	if (flag > 0) {
@@ -496,7 +495,7 @@ static irqreturn_t npcm7xx_fan_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	spin_unlock_irqrestore(&data->fan_lock[module], flags);
+	spin_unlock(&data->fan_lock[module]);
 
 	return IRQ_NONE;
 }
-- 
2.7.4

