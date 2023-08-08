Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C753774916
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjHHTsl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHHTsc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:48:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CC24DEA8
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 09:52:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTPx1-0002f3-KZ; Tue, 08 Aug 2023 18:52:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTPx0-0021Yo-WA; Tue, 08 Aug 2023 18:52:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTPx0-00BSfh-8k; Tue, 08 Aug 2023 18:52:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Lee Jones <lee@kernel.org>
Subject: [PATCH 0/2] pwm: Use an idr to assign pwm_chip IDs
Date:   Tue,  8 Aug 2023 18:52:48 +0200
Message-Id: <20230808165250.942396-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3Z2hy3DxkgNGb5Bn4H8WyCBXudXTBFZpaNfnCKnhPVg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nLccYFZntp89KsA73SDV5GVXlZBfbRg7dFQL Y8cUW8bfuCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJy3AAKCRCPgPtYfRL+ TsZJB/9EVsg4xhWUDG6ZoLxgNnBRqOkYGDamIPw5uHDE+neqF2IK7RreW8s1E4SteXIk4QF22Bw fEId1N8P4AFckLDrv56J+2sMlUErHWt/ScWcSUTuzYlkLFTWYG47x7B7xhY0ugCodivpObK6pWZ 25iLNxRfLY58WbapJq8XE7EEGhamiIxYDmK80DlIi4Lo+T4snZVYF2/+FJU7Godnphm57DDuyNE fK5ZOlOLRCd+RMAp90CEoyeAmdACW9qxhTDWmunxI0cK/8BkJuK7pJ/Ex0Ix3l844YTaOncuFxM zWxwRbRXw9WkNcDGnvJMkCy6SPbnMl4W1CkrI0gPJ+uY787B
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

this series depend on patch "leds: qcom-lpg: Drop assignment to struct
pwmchip::base" which Lee already claimed to have applied in
https://lore.kernel.org/linux-leds/169054337847.351209.7864098481511406737.b4-ty@kernel.org/,
but it didn't made it into next yet.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: Change how pwm_chip IDs are determined
  pwm: Mention PWM chip ID in /sys/kernel/debug/pwm

 drivers/pwm/core.c  | 70 +++++++++++++++++----------------------------
 drivers/pwm/sysfs.c |  2 +-
 include/linux/pwm.h |  3 +-
 3 files changed, 29 insertions(+), 46 deletions(-)


base-commit: 3ccb179aa40d931eb00ef8910d7b812a95659563
prerequisite-patch-id: cc42495033fc6c784c3139f92610cc9deeb2d87e
-- 
2.40.1

