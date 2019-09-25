Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50CABE039
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2019 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407923AbfIYOeU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Sep 2019 10:34:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50487 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732601AbfIYOeT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Sep 2019 10:34:19 -0400
X-UUID: 90c362b4455244e1a6d64314c151ffd5-20190925
X-UUID: 90c362b4455244e1a6d64314c151ffd5-20190925
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1042634555; Wed, 25 Sep 2019 22:34:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Sep 2019 22:34:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Sep 2019 22:34:10 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v10 06/12] pwm: mediatek: update license and switch to SPDX tag
Date:   Wed, 25 Sep 2019 22:32:31 +0800
Message-ID: <1569421957-20765-7-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
References: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-SNTS-SMTP: 3E4F8C870E90298AF62DE37F255470808000A3985B52E8EF9B09DD71C35E63862000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add SPDX identifiers to pwm-mediatek.c
Update license to GNU General Public License v2.0

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since v6:
Add a Reviewed-by tag

Changes since v5:
- Follow reviewers's comments
The license stuff is a separate change

---
 drivers/pwm/pwm-mediatek.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 2db17d6b6ae1..ce7525d8d71b 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Mediatek Pulse Width Modulator driver
+ * MediaTek Pulse Width Modulator driver
  *
  * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
  * Copyright (C) 2017 Zhi Mao <zhi.mao@mediatek.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/err.h>
@@ -329,4 +327,4 @@ static struct platform_driver pwm_mediatek_driver = {
 module_platform_driver(pwm_mediatek_driver);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

