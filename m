Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B4186926
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 11:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgCPKcV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Mar 2020 06:32:21 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:54974 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbgCPKcU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 06:32:20 -0400
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id EyYH2200M5USYZQ01yYHQX; Mon, 16 Mar 2020 11:32:17 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jDn2f-0006Eo-7r; Mon, 16 Mar 2020 11:32:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jDn2f-0007ev-6i; Mon, 16 Mar 2020 11:32:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] pwm: renesas-tpu: Drop confusing registered message
Date:   Mon, 16 Mar 2020 11:32:16 +0100
Message-Id: <20200316103216.29383-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316103216.29383-1-geert+renesas@glider.be>
References: <20200316103216.29383-1-geert+renesas@glider.be>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

During device probe, the message

    TPU PWM -1 registered

is printed.

While the "-1" looks suspicious, it is perfectly normal for a device
instantiated from DT.

Remove the message, as there are no non-DT users left, and other drivers
don't print such messages neither.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/pwm-renesas-tpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 8032acc84161a9dd..81ad5a551455e4b8 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -424,8 +424,6 @@ static int tpu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
-
 	return 0;
 }
 
-- 
2.17.1

