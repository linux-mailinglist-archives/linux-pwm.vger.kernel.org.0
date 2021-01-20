Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945192FD55F
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Jan 2021 17:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403766AbhATQT3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Jan 2021 11:19:29 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:55070 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391451AbhATQRk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 20 Jan 2021 11:17:40 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 6A0C444056C;
        Wed, 20 Jan 2021 18:16:37 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/4] gpio: mvebu: pwm fixes and improvements
Date:   Wed, 20 Jan 2021 18:16:24 +0200
Message-Id: <cover.1611128398.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series adds a few related fixes to the pwm .apply and .get_state
callbacks.

The first patch was originally part of the series adding Armada 8K/7K pwm
support. I split it out to a separate series following review comments from
Uwe Kleine-König who spotted a few more issues. There is no dependency between
this and the Armada 8K/7K series.

v5:

  * Drop a patch applied to the gpio tree

  * Fix patch 4/4 description typo (Uwe)

  * Reduce the number of multiplications (Uwe)

  * Add spaces around '+' (Uwe)

  * Use '1ULL' instead of explicit cast to reduce verbosity

  * Add Linus' Reviewed-by tags to patches that are unchanged since v2

v4:

  * Take advantage of zero value being treated as 2^32 by hardware. Rewrite
    patch 5/5 (Uwe).

v3:

  * Improve patch 3/5 description (Uwe)

  * Add more Reviewed-by tags from Uwe

v2:

Address Uwe Kleine-König comments.

  * Improve patch 1/5 summary line

  * Add more information to patch 1/5 description

  * Add more information to patch 2/5 description

  * Don't round period/duty_cycle up in .apply (patch 3/5)

  * Expand the comment in path 5/5 based on RMK's analysis of hardware
    behaviour

  * Add Uwe's Reviewed-by tags

Baruch Siach (4):
  gpio: mvebu: improve pwm period calculation accuracy
  gpio: mvebu: make pwm .get_state closer to idempotent
  gpio: mvebu: don't limit pwm period/duty_cycle to UINT_MAX
  gpio: mvebu: improve handling of pwm zero on/off values

 drivers/gpio/gpio-mvebu.c | 47 +++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

-- 
2.29.2

