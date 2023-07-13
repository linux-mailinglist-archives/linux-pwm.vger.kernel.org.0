Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85837527B7
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jul 2023 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjGMPvy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Jul 2023 11:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGMPvx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jul 2023 11:51:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73222117
        for <linux-pwm@vger.kernel.org>; Thu, 13 Jul 2023 08:51:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJybd-0004ij-9i; Thu, 13 Jul 2023 17:51:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJybb-00E9K5-Nf; Thu, 13 Jul 2023 17:51:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJyba-004abb-R2; Thu, 13 Jul 2023 17:51:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] pwm: stm32: A (small) fix and a cleanup
Date:   Thu, 13 Jul 2023 17:51:40 +0200
Message-Id: <20230713155142.2454010-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=468; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=//lOGqdNdXNCdEeL8d8m/BvDxCXBlJuLn/WpNm1m1/k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksB2Lt1WziiSIi+81Xpx9JCYCfHe3gdspXzrYC DWnPfcd3O6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLAdiwAKCRCPgPtYfRL+ TqqaB/0fRuKIFfsar/dMe4rsZk4UX+K/D47KCukO7yjzAtpiAX2EM4ji7eLGM3PM5ufJfY/Be9o PbDwdJ6fBnJqYY/wdI/cXUS6b2omSti7pTTg9vtqVRlHih72jmXEDK9D4xkR29NOU0BQsGWlnAs d3204t079pt0TTwb4VJRVct3mte+Ae9x9GkpzB798mcEmedTKef7V2t8vVwk+FxLIg71eJ/gZB3 5Qh7AjY3qFVGHnWcadm1wWNJiNY6qiIVR27SBh/x7QbUKPl0zjJuksJLl+MKa0nBsXJLBKO7T6O i9UOpDlYX80/OtXjQzAw4Ukcf8Vq4CrOO/OKcgQxga6khjNL
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

I was surprised when I spotted the stm32 calling pwm_disable() in the
remove callback. I thought I fixed all drivers in this regard.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: stm32: Don't modify HW state in .remove() callback
  pwm: stm32: Simplify using devm_pwmchip_add()

 drivers/pwm/pwm-stm32.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2

