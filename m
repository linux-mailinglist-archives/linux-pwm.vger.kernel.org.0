Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5677EAEBD
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 12:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjKNLUf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 06:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjKNLUe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 06:20:34 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034C189
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 03:20:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT2-0002uq-Rk; Tue, 14 Nov 2023 12:20:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT2-008yqy-7Y; Tue, 14 Nov 2023 12:20:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT1-001JwB-Un; Tue, 14 Nov 2023 12:20:27 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 0/3] pwm: Reorganize PWM identification
Date:   Tue, 14 Nov 2023 12:20:10 +0100
Message-ID: <20231114112009.340168-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=T7u3sz7qOAVqEb+xon7JzqRRMhfIYPloUwUUwL/e+K8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlU1fpwaOCFn1etJYCVvW95yDr6sqeOfzDETieO VewT+83hNiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVNX6QAKCRCPgPtYfRL+ ThsNB/4pf6LmiyoCgiuiILVsHb6yPq7fMrVoj18LRPw3j4WZ/0kAwVNwpML6LxOcq6+2TQvxuDB mEarrHeLsEXbzB7H1zY/9nLikRLM7hLDjPxdRkaXNRwxzeliW7Lf16Yii8nEeak9TsR0z3O+KqR B9HSJx0B7F2uAwvKo8TiEPIeNcKkl/h2WAlVWPN9nMO+JB0yp5gv+R8GF5HB3sJTnv4TDe0HCVO zhvELeNYhOz8z0RQerfHMKkrWYVDbQbeW9mp9jxR9JBup39sOOoPh15p/wVq3xZtuqC/CJUxUCF p28LUF29YlcTQpT0JBYurbGrz5/Whf1pumj4z4EWr1ITQW33
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
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

all these patches were already sent before. The first in
https://lore.kernel.org/linux-pwm/20230728145824.616687-4-u.kleine-koenig@pengutronix.de
and the second and third in
https://lore.kernel.org/linux-pwm/20230808165250.942396-1-u.kleine-koenig@pengutronix.de.
The patches were last in their respective series as they had some
preconditions. These are all included in v6.7-rc1. Also conceptually the
patches belong together, so I created a single series from it.

Best regards
Uwe

Uwe Kleine-König (3):
  pwm: Drop unused member "pwm" from struct pwm_device
  pwm: Replace PWM chip unique base by unique ID
  pwm: Mention PWM chip ID in /sys/kernel/debug/pwm

 drivers/pwm/core.c  | 71 +++++++++++++++++----------------------------
 drivers/pwm/sysfs.c |  2 +-
 include/linux/pwm.h |  4 +--
 3 files changed, 29 insertions(+), 48 deletions(-)

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.42.0

