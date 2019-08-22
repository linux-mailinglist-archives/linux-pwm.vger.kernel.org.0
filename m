Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0589A98C02
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Aug 2019 09:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfHVHCP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Aug 2019 03:02:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42198 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727685AbfHVHCP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Aug 2019 03:02:15 -0400
X-UUID: 63670459fc034e53b9c0bd1c8069844c-20190822
X-UUID: 63670459fc034e53b9c0bd1c8069844c-20190822
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1200625488; Thu, 22 Aug 2019 15:02:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Aug 2019 15:02:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 15:02:05 +0800
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
Subject: [PATCH v5 06/13] pwm: mediatek: update license and switch to SPDX tag
Date:   Thu, 22 Aug 2019 14:58:36 +0800
Message-ID: <1566457123-20791-7-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add SPDX identifiers to pwm-mediatek.c
Update license to GNU General Public License v2.0

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
Changes since v5:
- Follow reviewers's comments
The license stuff is a separate change

Change-Id: I8f1ff6daa76727ed203db8dc608509f1cd3b1144
---
 drivers/pwm/pwm-mediatek.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 0938beb1a3cb..290536a92a80 100644
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
@@ -359,4 +357,4 @@ static struct platform_driver pwm_mediatek_driver = {
 module_platform_driver(pwm_mediatek_driver);
 
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

