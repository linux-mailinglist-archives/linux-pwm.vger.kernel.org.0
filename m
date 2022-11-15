Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277466296F9
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 12:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiKOLP3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 06:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiKOLO7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 06:14:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9392CE32
        for <linux-pwm@vger.kernel.org>; Tue, 15 Nov 2022 03:14:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt9-0006Wj-F7; Tue, 15 Nov 2022 12:13:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt7-004Qge-4y; Tue, 15 Nov 2022 12:13:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt6-00GmRW-H9; Tue, 15 Nov 2022 12:13:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] pwm: Use regmap_clear_bits and regmap_set_bits where applicable
Date:   Tue, 15 Nov 2022 12:13:42 +0100
Message-Id: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7rPBwJevdQ+2sW+V16c3FLA/Bg4E6IZ1UGHCHMSd8vk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjc3RT5epQS2wkIfzkgW6NZTxt/iRFvT/kHvQ+BUT0 qWOyS0eJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3N0UwAKCRDB/BR4rcrsCa65CA CgrZ341oBSYn6LOJzwyKiXyXvArhKMIm/mlz7IaIU05IabORapJOCR03zOruo/r/izutuSr5PB7jx3 jw7tox8UHFTtUKuR1Tf2MrWr6OtuD1rhLLv/Dn14BljnPaiTqyb+sfl3VfpW3UA9li6ZAh/9pnJPVp gV5uvHpBpy4mXYCYMVPhBAhvCZ6FqZYRtOYjB1KHpicInqdqY3z9W8Stv2fDcoTeO5AlxEFH9pdCbW 7hTleO/4vXUBY+MwaKdR54jGMpSdaOO2wenaWCxybhnFh8QxqhJM7yx10Cyi/PVpomL/W9cZdkxoAt uLbd2AsEG2dBZVo2727pna5u6RbCXS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

I recently learned a bit of coccinelle and triggered by Paul Cercueil's
patch that replaces regmap_update_bits() by regmap_set_bits() and
regmap_clear_bits() where applicable in the jz4740 pwm driver[1] I
created a cocci patch for such calls.

This series adapts the other drivers below drivers/pwm accordingly.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20221024205213.327001-6-paul@crapouillou.net

Uwe Kleine-König (5):
  pwm: fsl-ftm: Use regmap_clear_bits and regmap_set_bits where
    applicable
  pwm: img: Use regmap_clear_bits and regmap_set_bits where applicable
  pwm: iqs620a: Use regmap_clear_bits and regmap_set_bits where
    applicable
  pwm: stm32-lp: Use regmap_clear_bits and regmap_set_bits where
    applicable
  pwm: stm32: Use regmap_clear_bits and regmap_set_bits where applicable

 drivers/pwm/pwm-fsl-ftm.c  | 18 +++++++-----------
 drivers/pwm/pwm-img.c      | 15 +++++++--------
 drivers/pwm/pwm-iqs620a.c  |  4 ++--
 drivers/pwm/pwm-stm32-lp.c |  5 ++---
 drivers/pwm/pwm-stm32.c    | 34 ++++++++++++++++------------------
 5 files changed, 34 insertions(+), 42 deletions(-)


base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
-- 
2.38.1

