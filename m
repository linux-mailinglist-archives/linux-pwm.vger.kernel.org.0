Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B682148C8B
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jan 2020 17:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbgAXQyP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jan 2020 11:54:15 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:38328 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387670AbgAXQyP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2020 11:54:15 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 45F658CCA2A; Fri, 24 Jan 2020 17:54:13 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Jeff LaBundy <jeff@labundy.com>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 0/3] leds: pwm: some cleanups
Date:   Fri, 24 Jan 2020 17:54:06 +0100
Message-Id: <20200124165409.12422-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

note that this series is only compile tested, as I don't have a hardware
that uses this driver.

Best regards
Uwe

Uwe Kleine-König (3):
  leds: pwm: simplify if condition
  leds: pwm: convert to atomic PWM API
  leds: pwm: don't set the brightness during .probe

 drivers/leds/leds-pwm.c | 47 ++++++++++-------------------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

-- 
2.24.0

