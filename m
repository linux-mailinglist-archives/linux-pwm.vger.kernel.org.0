Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103B62E1F14
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Dec 2020 17:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgLWQCS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Dec 2020 11:02:18 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:57902 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgLWQCS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Dec 2020 11:02:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id C95FBC0DA8;
        Wed, 23 Dec 2020 16:01:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uKgByDVzA3i5; Wed, 23 Dec 2020 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 87DBBC0CDA;
        Wed, 23 Dec 2020 16:01:16 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v3 0/7] pwm: rockchip: Eliminate potential race condition when probing
Date:   Wed, 23 Dec 2020 11:01:02 -0500
Message-Id: <cover.1608735481.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series aims to eliminate the race condition Trent Piepho
identified[0] in the Rockchip PWM driver's rockchip_pwm_probe()
function, by moving code that checks whether a device is enabled ahead
of the code that registers it via pwmchip_add().

It has grown to include a number of other small fixes and improvements
to the driver. It now also

- Fixes a potential kernel hang introduced by my earlier commit
  457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
  probing") by ensuring a device's APB clock is enabled before its
  registers are accessed;

- Removes a superfluous call to clk_unprepare() that could result in
  warnings from the kernel;

- Clarifies the driver's error messages by replacing "bus clk" with
  "PWM clk";

- Removes the now-unneeded goto targets from rockchip_pwm_probe();

- Tries to improve rockchip_pwm_probe() by having it enable the signal
  clock of only PWM devices that are already running; and

- Ensures the driver enables a clock before querying its rate with
  clk_get_rate(), as stated as a requirement in that function's
  documentation.

The first patch ("Enable APB clock...") is unchanged from version 2.

New in version 3 are

- Finer patch granularity, with patches 2 and 5 added to clarify
  changes included with others in v2;

- A rewritten patch 6 ("Enable PWM clock...") with a smaller change
  and the use of if...else in place of a ternary operator;

- Patches 3 and 7 with fixes suggested by Robin Murphy and Uwe
  Kleine-König; and

- Rewritten and (hopefully) more accurate commit messages.

I've tested these changes on my (RK3399-based) Pinebook Pro with its
screen backlight enabled by U-Boot and each one appears to work fine.

I'd (still) be grateful for help with testing on other devices,
particularly those with SoCs like the RK3328 that use separate bus and
signal clocks for their PWM devices. (My ROCK64 uses its PWM-output
pins for other purposes and wasn't of help here.)

[0] https://www.spinics.net/lists/linux-pwm/msg14611.html

--
Simon South
simon@simonsouth.net


Simon South (7):
  pwm: rockchip: Enable APB clock during register access while probing
  pwm: rockchip: rockchip_pwm_probe(): Remove superfluous
    clk_unprepare()
  pwm: rockchip: Replace "bus clk" with "PWM clk"
  pwm: rockchip: Eliminate potential race condition when probing
  pwm: rockchip: rockchip_pwm_probe(): Remove unneeded goto target
  pwm: rockchip: Enable PWM clock of probed device only if running
  pwm: rockchip: Enable clock before calling clk_get_rate()

 drivers/pwm/pwm-rockchip.c | 64 ++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 24 deletions(-)

-- 
2.29.2

