Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4A73598C4
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 11:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhDIJIt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 05:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232878AbhDIJIq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 9 Apr 2021 05:08:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E67D610D0;
        Fri,  9 Apr 2021 09:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617959314;
        bh=P5AFIuwYBrowJYNt7JM2J+ymtXbj3UqqOtwOct8/uEw=;
        h=From:To:Cc:Subject:Date:From;
        b=DIo19fYO+HAVmsLHd25TJcFT8Y9ZIX+dv55jjDB/7xaii6taK3x4gVMJjzuvCuE6n
         XU+hfIxz2/rdL5OsUPV6BaS/l01e+Fm6pEIq+dfAIz/Bt7MyX7ZbaRjpVF9WOhchYm
         JASgKtDplWCTh1RIfV9u6S9egxgnzNy6500M4L+TeUaO0GCQbe3I8TXqjKoPaUaonT
         WhX4r1wiOndnMGbsbgjWJa9jTZ+hDnNUA9M6XOD09cQDHqhvbXKTJDWNdczYvOnmz1
         H6IlgBjERrWnlMUSuClWow13K20Y5FZva6D6SMrmoHnCIKWplEstfDNQpsqcamzHdr
         eNgwzoomn90dQ==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     arnd@arndb.de, Nicolas Saenz Julienne <nsaenz@kernel.org>,
        kernel test robot <lkp@intel.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: raspberrypi-poe: Fix mailbox message initialization
Date:   Fri,  9 Apr 2021 11:08:19 +0200
Message-Id: <20210409090819.24805-1-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

For testing purposes this driver might be built on big-endian
architectures. So make sure we take that into account when populating
structures that are to be passed to RPi4's mailbox.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 79caa362eab6 ("pwm: Add Raspberry Pi Firmware based PWM bus")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---

@arndb: This was just meged into the arm-soc tree some days ago. Should I
prepare a second PR once it's been reviewed?

 drivers/pwm/pwm-raspberrypi-poe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
index 043fc32e8be8..78423e66f4fc 100644
--- a/drivers/pwm/pwm-raspberrypi-poe.c
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -66,7 +66,7 @@ static int raspberrypi_pwm_get_property(struct rpi_firmware *firmware,
 					u32 reg, u32 *val)
 {
 	struct raspberrypi_pwm_prop msg = {
-		.reg = reg
+		.reg = cpu_to_le32(reg),
 	};
 	int ret;
 
-- 
2.30.2

