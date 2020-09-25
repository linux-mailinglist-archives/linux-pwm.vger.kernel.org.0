Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF02278D39
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgIYPxm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgIYPxm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Sep 2020 11:53:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BB0C0613CE
        for <linux-pwm@vger.kernel.org>; Fri, 25 Sep 2020 08:53:42 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kLq2S-0000oP-Kd; Fri, 25 Sep 2020 17:53:36 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kLq2Q-0008QA-SM; Fri, 25 Sep 2020 17:53:34 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        michal.vokac@ysoft.com, l.majewski@majess.pl
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/5] PWM i.MX27 fix disabled state for inverted signals
Date:   Fri, 25 Sep 2020 17:53:25 +0200
Message-Id: <20200925155330.32301-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
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

Each patch has a dedicated changelog so I skip it here.

Comments and testers are welcome :)

Regards,
  Marco

Marco Felsch (5):
  pwm: imx27: enable clock unconditional for register access
  pwm: imx27: move constant PWMCR register values into probe
  pwm: imx27: reset the PWM if it is not running
  pwm: imx27: fix disable state for inverted PWMs
  pwm: imx27: wait till the duty cycle is applied

 drivers/pwm/pwm-imx27.c | 166 +++++++++++++++++++++++++++++-----------
 1 file changed, 120 insertions(+), 46 deletions(-)

-- 
2.20.1

