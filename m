Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD6E2CFCA2
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 19:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgLEQxl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Dec 2020 11:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgLEQtF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 11:49:05 -0500
X-Greylist: delayed 685 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Dec 2020 08:36:43 PST
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C24C02A184
        for <linux-pwm@vger.kernel.org>; Sat,  5 Dec 2020 08:36:43 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 307A9A97E5C; Sat,  5 Dec 2020 17:19:26 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Remove unused function pwmchip_add_inversed()
Date:   Sat,  5 Dec 2020 17:19:24 +0100
Message-Id: <20201205161924.3864915-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is only defined with CONFIG_PWM unset and was introduced together
with pwmchip_add_with_polarity() (which is only defined with CONFIG_PWM
enabled). I guess the series that introduced pwmchip_add_with_polarity()
had a different concept in earlier revisions and the !CONFIG_PWM part
was just not updated accordingly.

Given that there is no implementation for pwmchip_add_with_polarity()
without CONFIG_PWM, just drop pwmchip_add_inversed() instead of renaming
it to pwmchip_add_with_polarity().

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 include/linux/pwm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index a13ff383fa1d..e4d84d4db293 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -473,11 +473,6 @@ static inline int pwmchip_add(struct pwm_chip *chip)
 	return -EINVAL;
 }
 
-static inline int pwmchip_add_inversed(struct pwm_chip *chip)
-{
-	return -EINVAL;
-}
-
 static inline int pwmchip_remove(struct pwm_chip *chip)
 {
 	return -EINVAL;
-- 
2.29.2

