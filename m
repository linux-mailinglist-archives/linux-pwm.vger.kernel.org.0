Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F02023A8
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jun 2020 14:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgFTMTO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 08:19:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728085AbgFTMTL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 20 Jun 2020 08:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592655550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4g2+V5TcJHXgErFsppORwNNUdAdaFJfxwB69IXzmmg=;
        b=X4EizIoXutzAZyS+NNmJSsC0HE3jSPl4Sm4WcLbX8u3Cepy1IYrjOYKfFQogIngRFGAuLj
        2R+8FAqWYV2Sd1CFdHe0BU/aceD+7DhayaH4bhsm+/104zL9NsD3MnuL43r/KDWmUe9DJl
        DglCHSL3ao3v8vSlcraszyglDx7SlIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-qed7Yk6oPCOI8e7pW76UAQ-1; Sat, 20 Jun 2020 08:19:06 -0400
X-MC-Unique: qed7Yk6oPCOI8e7pW76UAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 357D8100AA2C;
        Sat, 20 Jun 2020 12:19:04 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-42.ams2.redhat.com [10.36.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB998101E67A;
        Sat, 20 Jun 2020 12:19:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 09/15] pwm: crc: Enable/disable PWM output on enable/disable
Date:   Sat, 20 Jun 2020 14:17:52 +0200
Message-Id: <20200620121758.14836-10-hdegoede@redhat.com>
In-Reply-To: <20200620121758.14836-1-hdegoede@redhat.com>
References: <20200620121758.14836-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pwm-crc code is using 2 different enable bits:
1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
2. bit 0 of the BACKLIGHT_EN register

So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
this commit makes crc_pwm_disable() clear it on disable and makes
crc_pwm_enable() set it again on re-enable.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Remove paragraph about tri-stating the output from the commit message,
  we don't have a datasheet so this was just an unfounded guess
---
 drivers/pwm/pwm-crc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 81232da0c767..b72008c9b072 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -54,7 +54,9 @@ static int crc_pwm_calc_clk_div(int period_ns)
 static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
+	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
 
+	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div | PWM_OUTPUT_ENABLE);
 	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
 
 	return 0;
@@ -63,8 +65,10 @@ static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
 static void crc_pwm_disable(struct pwm_chip *c, struct pwm_device *pwm)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
+	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
 
 	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
+	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div);
 }
 
 static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
-- 
2.26.2

