Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44F419BC1B
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2020 08:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgDBG6y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Apr 2020 02:58:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgDBG6x (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 2 Apr 2020 02:58:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E7AF694E56D5663EE587
        for <linux-pwm@vger.kernel.org>; Thu,  2 Apr 2020 14:58:48 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 14:58:41 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-pwm@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH -next] pwm: make pwm_apply_state_debug static
Date:   Thu, 2 Apr 2020 14:57:18 +0800
Message-ID: <20200402065718.32433-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Fix the following gcc warning:

drivers/pwm/core.c:467:6: warning: symbol 'pwm_apply_state_debug' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/pwm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e9b9283cff28..9973c442b455 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -464,8 +464,8 @@ void pwm_free(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_free);
 
-void pwm_apply_state_debug(struct pwm_device *pwm,
-			   const struct pwm_state *state)
+static void pwm_apply_state_debug(struct pwm_device *pwm,
+				  const struct pwm_state *state)
 {
 	struct pwm_state *last = &pwm->last;
 	struct pwm_chip *chip = pwm->chip;
-- 
2.17.2

