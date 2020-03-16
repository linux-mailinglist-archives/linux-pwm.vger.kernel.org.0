Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E74186923
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 11:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgCPKcT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Mar 2020 06:32:19 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:54982 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgCPKcT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 06:32:19 -0400
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id EyYH2200J5USYZQ01yYHQT; Mon, 16 Mar 2020 11:32:17 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jDn2f-0006Ei-53; Mon, 16 Mar 2020 11:32:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jDn2f-0007en-2R; Mon, 16 Mar 2020 11:32:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] pwm: Renesas R-Car and TPU fixes
Date:   Mon, 16 Mar 2020 11:32:13 +0100
Message-Id: <20200316103216.29383-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

	Hi all,

This patch series contains two Runtime PM-related fixes for the Renesas
R-Car and Timer Pulse Unit PWM drivers, and a small fix for the TPU
driver.

This has been tested on r8a7791/koelsch.

Thanks for your comments!

Geert Uytterhoeven (3):
  pwm: rcar: Fix late Runtime PM enablement
  pwm: renesas-tpu: Fix late Runtime PM enablement
  pwm: renesas-tpu: Drop confusing registered message

 drivers/pwm/pwm-rcar.c        | 10 +++++++---
 drivers/pwm/pwm-renesas-tpu.c | 11 ++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
