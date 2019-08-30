Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22FA2DE4
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Aug 2019 05:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfH3D6T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Aug 2019 23:58:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8311 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727216AbfH3D6S (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Aug 2019 23:58:18 -0400
X-UUID: 9a7ec19b40a9406a9d9f559db93ed169-20190830
X-UUID: 9a7ec19b40a9406a9d9f559db93ed169-20190830
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 120867575; Fri, 30 Aug 2019 11:58:11 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 11:58:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 11:58:09 +0800
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
Subject: [PATCH v7 06/11] pwm: mediatek: update license and switch to SPDX tag
Date:   Fri, 30 Aug 2019 11:57:12 +0800
Message-ID: <1567137437-10041-7-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567137437-10041-1-git-send-email-sam.shih@mediatek.com>
References: <1567137437-10041-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-SNTS-SMTP: 8A5EF332AAA6BD51547AACC505FBF03FAC0D16D5028FAD19DBE63BD311DCB28C2000:8
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
index 11f9cc446f14..9a61829766fc 100644
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
@@ -331,4 +329,4 @@ static struct platform_driver pwm_mediatek_driver = {
 module_platform_driver(pwm_mediatek_driver);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

