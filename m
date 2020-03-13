Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E6183FC4
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2020 04:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgCMDmw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 23:42:52 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37054 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCMDmw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 23:42:52 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A4BD08365A;
        Fri, 13 Mar 2020 16:42:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1584070969;
        bh=jiMFXGvBhCI5xK4iuBLsegdABOplq4HGKYU6z5QIHQ0=;
        h=From:To:Cc:Subject:Date;
        b=oZng4u7mbjanyfvvbVMxgRn36M0EK+F19nclv9E1iLkTJzBqhjryAFiVZdtD2bA5K
         c4cjOKED4cnG4wBxEzOZ6giitHAaURPpNOZIPg104yfb/gQPoAWXu6i8gl88tgzMOx
         V40BsAIxvVX7dcExkN170vWWv+dJTOiG5WCcJfgRLxWx2humBzvmbQ6udyD8ON41av
         95fHQLrFbz6qd0tcpMhsgvTF68+35gVDrhxFMWdoUbtKj91xw8wRy4zKG7Hu3JIBvD
         Xq0BVNXkjfEm0tUBOIVPUzp4nIg5mpdmuTO7vMSeA1iu9Q4VWkRxr3KTjRjKMhmuhg
         n25ZiKgPpNQsg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e6b01370000>; Fri, 13 Mar 2020 16:42:49 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 1F15C13EED5;
        Fri, 13 Mar 2020 16:42:47 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 2F9A628006E; Fri, 13 Mar 2020 16:42:47 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] gpio: mvebu: avoid error message for optional IRQ
Date:   Fri, 13 Mar 2020 16:42:44 +1300
Message-Id: <20200313034244.26336-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

platform_get_irq() will generate an error message if the requested irq
is not present

  mvebu-gpio f1010140.gpio: IRQ index 3 not found

use platform_get_irq_optional() to avoid the error message being
generated.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/gpio/gpio-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index d2b999c7987f..3c9f4fb3d5a2 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1247,7 +1247,7 @@ static int mvebu_gpio_probe(struct platform_device =
*pdev)
 	 * pins.
 	 */
 	for (i =3D 0; i < 4; i++) {
-		int irq =3D platform_get_irq(pdev, i);
+		int irq =3D platform_get_irq_optional(pdev, i);
=20
 		if (irq < 0)
 			continue;
--=20
2.25.1

