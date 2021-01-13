Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1D2F4778
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 10:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbhAMJYI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 04:24:08 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:45691 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbhAMJYH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 13 Jan 2021 04:24:07 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 53CA1440458;
        Wed, 13 Jan 2021 11:23:24 +0200 (IST)
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
Subject: [PATCH v2 0/5] gpio: mvebu: pwm fixes and improvements
Date:   Wed, 13 Jan 2021 11:22:40 +0200
Message-Id: <cover.1610529002.git.baruch@tkos.co.il>
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

v2:

Address Uwe Kleine-König comments.

  * Improve patch 1/5 summary line

  * Add more information to patch 1/5 description

  * Add more information to patch 2/5 description

  * Don't round period/duty_cycle up in .apply (patch 3/5)

  * Expand the comment in path 5/5 based on RMK's analysis of hardware 
    behaviour

  * Add Uwe's Reviewed-by tags

Baruch Siach (5):
  gpio: mvebu: fix pwm .get_state period calculation
  gpio: mvebu: improve pwm period calculation accuracy
  gpio: mvebu: make pwm .get_state closer to idempotent
  gpio: mvebu: don't limit pwm period/duty_cycle to UINT_MAX
  gpio: mvebu: document zero pwm duty cycle limitation

 drivers/gpio/gpio-mvebu.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

-- 
2.29.2

