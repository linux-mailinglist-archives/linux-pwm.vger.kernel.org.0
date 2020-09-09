Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B7B262F93
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Sep 2020 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgIIOMX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Sep 2020 10:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbgIINHr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Sep 2020 09:07:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA8C061796
        for <linux-pwm@vger.kernel.org>; Wed,  9 Sep 2020 06:07:52 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kFzpB-0002t2-5r; Wed, 09 Sep 2020 15:07:45 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kFzp9-0004UA-Gv; Wed, 09 Sep 2020 15:07:43 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        michal.vokac@ysoft.com, l.majewski@majess.pl
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 0/3] PWM i.MX27 fix disabled state for inverted signals
Date:   Wed,  9 Sep 2020 15:07:36 +0200
Message-Id: <20200909130739.26717-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

this small series fixes the pwm disabled behaviour in case of an
inverted pwm signal. The current state is that in such a case the pwm
signal goes to 0V which means logical '1' for inverted pwm signals. IMO
this is wrong and should be fixed.

I've tested my patches on a custom imx6 board which uses the pwm as
backlight.

Comments and testers are welcome :)

Regards,
  Marco

Marco Felsch (3):
  pwm: imx27: track clock enable/disable to simplify code
  pwm: imx27: move static pwmcr values into probe() function
  pwm: imx27: fix disable state for inverted PWMs

 drivers/pwm/pwm-imx27.c | 119 ++++++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 40 deletions(-)

-- 
2.20.1

