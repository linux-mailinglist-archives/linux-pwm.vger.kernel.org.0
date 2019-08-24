Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45A9B952
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 02:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfHXAKs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Aug 2019 20:10:48 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:56586 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHXAKs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Aug 2019 20:10:48 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id B8DEA77D4B2; Sat, 24 Aug 2019 02:10:46 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 0/6] Updates for the atmel PWM driver
Date:   Sat, 24 Aug 2019 02:10:35 +0200
Message-Id: <20190824001041.11007-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

this is v2 of my series to update the atmel PWM driver. (Implicit) v1
was sent on Aug 15, starting with Message-Id:
20190815214133.11134-1-uwe@kleine-koenig.org.

I updated the patches from the feedback I got in v1, see the individual
patches for the details.

Best regards
Uwe

Uwe Kleine-König (6):
  pwm: atmel: Add a hint where to find hardware documentation
  pwm: atmel: use a constant for maximum prescale value
  pwm: atmel: replace loop in prescale calculation by ad-hoc calculation
  pwm: atmel: document known weaknesses of both hardware and software
  pwm: atmel: use atmel_pwm_writel in atmel_pwm_ch_writel; ditto for
    readl
  pwm: atmel: implement .get_state()

 drivers/pwm/pwm-atmel.c | 86 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 13 deletions(-)

-- 
2.20.1

