Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718933B8ECD
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 10:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbhGAIaa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbhGAIaa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 04:30:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174ACC061756
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 01:28:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3C-0000nA-E2; Thu, 01 Jul 2021 10:27:58 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3B-00028M-Gh; Thu, 01 Jul 2021 10:27:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Baolin Wang <baolin.wang@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH 0/5] pwm: Ensure configuring period and duty_cycle isn't wrongly skipped
Date:   Thu,  1 Jul 2021 10:27:50 +0200
Message-Id: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Uwe Kleine-König <uwe@kleine-koenig.org>

Hello,

Geert Uytterhoeven found a regression in one of my patches. The same
problem exists in several further commits. The respective drivers are
fixed in this series.

The affected commits for the first patch is already in v5.4, so this
patch should maybe backported to stable.
The others are in Thierry's for-next branch only.

Uwe Kleine-König (5):
  pwm: sprd: Ensure configuring period and duty_cycle isn't wrongly
    skipped
  pwm: spear: Ensure configuring period and duty_cycle isn't wrongly
    skipped
  pwm: tiecap: Ensure configuring period and duty_cycle isn't wrongly
    skipped
  pwm: berlin: Ensure configuring period and duty_cycle isn't wrongly
    skipped
  pwm: ep93xx: Ensure configuring period and duty_cycle isn't wrongly
    skipped

 drivers/pwm/pwm-berlin.c |  9 ++---
 drivers/pwm/pwm-ep93xx.c | 85 +++++++++++++++++++---------------------
 drivers/pwm/pwm-spear.c  |  9 ++---
 drivers/pwm/pwm-sprd.c   | 11 ++----
 drivers/pwm/pwm-tiecap.c | 15 +++----
 5 files changed, 56 insertions(+), 73 deletions(-)


base-commit: 96e45e5202377da39d086ec19f8934ebcc5b0fd6
-- 
2.30.2

