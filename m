Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267996B000B
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Mar 2023 08:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCHHkt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Mar 2023 02:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCHHkp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Mar 2023 02:40:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED0A6750
        for <linux-pwm@vger.kernel.org>; Tue,  7 Mar 2023 23:40:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOv-0007OI-Er; Wed, 08 Mar 2023 08:39:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOs-002fHz-4I; Wed, 08 Mar 2023 08:39:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOr-003ELq-EQ; Wed, 08 Mar 2023 08:39:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 00/13] backlight: Convert to platform remove callback returning void
Date:   Wed,  8 Mar 2023 08:39:32 +0100
Message-Id: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2935; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Kjy1U54JR1Ng4uZuM4V7pqtJr+R0H4clHwG62u+DoeU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCDuPukCAhVjcRmzwgXrcBiSoubLeLaBxxeYoh x6Wc4zMzfiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAg7jwAKCRDB/BR4rcrs CRLBCACJQNQt47kru3bGNV4B9ox8fV7mGMj02dY2HLiYxsld+xlpfgRAPpvg0fmaz23uvo6P3eQ FUBPMUW6gH3kqXyAWDCn1TaTKhUliLtsriFDhvGyTnf9SP6fy22JVO3L9oi/IyVwws+u1eWG7wi bK1/ntPy1ABVk2jpLNsRtMxM5iEFOXPG/r4UFrRbykVXBhMELL8EK9U0q6ksaFR/Z+IGD0LDkhc 7rj7p8Eq483P8CrtGmCI02Kv9TdUUKAQ12mGXUOSeir+/4VIUBSw2yoa1PU5D8e4XOA7uEWCM88 dGuA3tRSXPcaeyapZt5m2hmWH13PxVIAnwglEtv4CPUVkoFo
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

this patch series adapts the platform drivers below drivers/video/backlight to
use the .remove_new() callback. Compared to the traditional .remove() callback
.remove_new() returns no value. This is a good thing because the driver core
doesn't (and cannot) cope for errors during remove. The only effect of a
non-zero return value in .remove() is that the driver core emits a warning. The
device is removed anyhow and an early return from .remove() usually yields a
resource leak.

By changing the remove callback to return void driver authors cannot
reasonably assume any more that there is some kind of cleanup later.

All drivers in drivers/video/backlight returned zero unconditionally in their
remove callback, so they could all be converted trivially to .remove_new().

Note that this series depends on commit 5c5a7680e67b ("platform: Provide
a remove callback that returns no value") which is included in v6.3-rc1.

Best regards
Uwe

Uwe Kleine-König (13):
  backlight: aat2870_bl: Convert to platform remove callback returning
    void
  backlight: adp5520_bl: Convert to platform remove callback returning
    void
  backlight: cr_bllcd: Convert to platform remove callback returning
    void
  backlight: da9052_bl: Convert to platform remove callback returning
    void
  backlight: hp680_bl: Convert to platform remove callback returning
    void
  backlight: led_bl: Convert to platform remove callback returning void
  backlight: lm3533_bl: Convert to platform remove callback returning
    void
  backlight: lp8788_bl: Convert to platform remove callback returning
    void
  backlight: mt6370-backlight: Convert to platform remove callback
    returning void
  backlight: pwm_bl: Convert to platform remove callback returning void
  backlight: qcom-wled: Convert to platform remove callback returning
    void
  backlight: rt4831-backlight: Convert to platform remove callback
    returning void
  backlight: sky81452-backlight: Convert to platform remove callback
    returning void

 drivers/video/backlight/aat2870_bl.c         | 6 ++----
 drivers/video/backlight/adp5520_bl.c         | 6 ++----
 drivers/video/backlight/cr_bllcd.c           | 6 ++----
 drivers/video/backlight/da9052_bl.c          | 6 ++----
 drivers/video/backlight/hp680_bl.c           | 6 ++----
 drivers/video/backlight/led_bl.c             | 6 ++----
 drivers/video/backlight/lm3533_bl.c          | 6 ++----
 drivers/video/backlight/lp8788_bl.c          | 6 ++----
 drivers/video/backlight/mt6370-backlight.c   | 6 ++----
 drivers/video/backlight/pwm_bl.c             | 6 ++----
 drivers/video/backlight/qcom-wled.c          | 6 ++----
 drivers/video/backlight/rt4831-backlight.c   | 6 ++----
 drivers/video/backlight/sky81452-backlight.c | 6 ++----
 13 files changed, 26 insertions(+), 52 deletions(-)

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.1
