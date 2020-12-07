Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B92D126A
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 14:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLGNqk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 08:46:40 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:57370 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLGNqk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 08:46:40 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 65754A9D7CC; Mon,  7 Dec 2020 14:45:58 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org
Subject: [PATCH v2 0/3] pwm: get rid of pwmchip_add_with_polarity()
Date:   Mon,  7 Dec 2020 14:45:53 +0100
Message-Id: <20201207134556.25217-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

in the (implicit) v1 of this series (starting with Message-Id:
20201205165146.3866846-1-uwe@kleine-koenig.org) I forget to include the
change to drivers/pwm/core.c. This is fixed here.

IMHO It would be good to cook this in next for some time to make it (a
bit more) sure it doesn't introduce a regression.

Best regards
Uwe

Uwe Kleine-König (3):
  pwm: bcm-kona: Use pwmchip_add() instead of
    pwmchip_add_with_polarity()
  pwm: atmel-hlcdc: Use pwmchip_add() instead of
    pwmchip_add_with_polarity()
  pwm: Drop function pwmchip_add_with_polarity()

 drivers/pwm/core.c            | 25 +++----------------------
 drivers/pwm/pwm-atmel-hlcdc.c |  2 +-
 drivers/pwm/pwm-bcm-kona.c    |  2 +-
 include/linux/pwm.h           |  2 --
 4 files changed, 5 insertions(+), 26 deletions(-)

-- 
2.29.2

