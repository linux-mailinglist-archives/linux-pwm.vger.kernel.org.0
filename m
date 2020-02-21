Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862C31677E0
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Feb 2020 09:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgBUIpB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Feb 2020 03:45:01 -0500
Received: from inva021.nxp.com ([92.121.34.21]:60604 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbgBUHvd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 21 Feb 2020 02:51:33 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63C7F206D67;
        Fri, 21 Feb 2020 08:51:31 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 24676206D6C;
        Fri, 21 Feb 2020 08:51:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8EE1040246;
        Fri, 21 Feb 2020 15:51:19 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] pwm: mxs: Remove unused include of of_address.h
Date:   Fri, 21 Feb 2020 15:45:29 +0800
Message-Id: <1582271129-13589-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582271129-13589-1-git-send-email-Anson.Huang@nxp.com>
References: <1582271129-13589-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There is nothing in use from of_address.h, remove it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-mxs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index f2e57fc..7ce6169 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
-- 
2.7.4

