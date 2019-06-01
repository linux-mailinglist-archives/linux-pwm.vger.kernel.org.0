Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDB31969
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Jun 2019 05:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfFADtH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 23:49:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbfFADtH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 31 May 2019 23:49:07 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D27372D7FDA04B78A18B;
        Sat,  1 Jun 2019 11:49:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sat, 1 Jun 2019 11:48:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>,
        <andriy.shevchenko@linux.intel.com>, <thesven73@gmail.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-pwm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] pwm: pca9685: Remove set but not used variable 'pwm'
Date:   Sat, 1 Jun 2019 03:57:09 +0000
Message-ID: <20190601035709.85379-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/pwm/pwm-pca9685.c: In function 'pca9685_pwm_gpio_free':
drivers/pwm/pwm-pca9685.c:173:21: warning:
 variable 'pwm' set but not used [-Wunused-but-set-variable]

It's not used since commit e926b12c611c ("pwm: Clear chip_data in pwm_put()")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pwm/pwm-pca9685.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 567f5e2771c4..d16215c276bd 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -170,12 +170,10 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
 static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 {
 	struct pca9685 *pca = gpiochip_get_data(gpio);
-	struct pwm_device *pwm;
 
 	pca9685_pwm_gpio_set(gpio, offset, 0);
 	pm_runtime_put(pca->chip.dev);
 	mutex_lock(&pca->lock);
-	pwm = &pca->chip.pwms[offset];
 	mutex_unlock(&pca->lock);
 }



