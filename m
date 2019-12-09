Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E293E117B6A
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Dec 2019 00:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfLIXZL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Dec 2019 18:25:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38686 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLIXZL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Dec 2019 18:25:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so18027572wrh.5;
        Mon, 09 Dec 2019 15:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2UnKFwMpc84ugnaUJy14wn/3dEflKg0s3Bahp4zLtUo=;
        b=Zd5s6RgD+wfVI3nxtONZ3Ipkko96qdozsMd8iVL5UhK7FUqOSao3l0KVLLtTIgZAaD
         nwLArRRH/RTkQHFwhirWcJLgtrgfcY+AnFaVALtEgtfLEAL8BS4H2PhxvrGroN2Qkojw
         1Ri2K5Y0EeRm3Pks51xa4UtW/LlaN54xJgpx227BTWrlz9lryOmDs2i0hQYLeVb4Pk2c
         R6kAyqSbHgZ92LHufwZKZg1YmH/Lkc5wJ4b+atqJaKmnOtbRlkkbLv/afZ2p0rCEYkV6
         ewX3yDO6cp31eZfhIBfI3N++YQw+3ye4oIFs2p9FotxK1U4APPM4jcKVNMsBpVJguVFj
         9u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2UnKFwMpc84ugnaUJy14wn/3dEflKg0s3Bahp4zLtUo=;
        b=Gy5wWobgZ8+UL3E32cd3zL4p8gPONDZJATzENEDUAUl30VB9rZfJHhc+VndWXPuo04
         ytQZPv46UjR+HE+cqs71ChrEpPSlKDH0s1CzBkDUqoPTP5SMlX6FJdUINAstLbwfPLF8
         Ja9H549EuUfoWWjKowJCJjaUlsXXNf9alF6CzINNqTI6tWdE59RX1bCOjAjPgECYbtxt
         1bMh7Xmt7NpnVmqC9HFRvF9WXCRpWbsTf6Rthb2IRVo+Hl0/fD+T6ba6TkzSz4PWAH+/
         BDnuYa2Ay8GD1muwR2rCU5hGdjdUgxQ7epYcZMZ64LZ67Obmpmo/v/tC/lQs3gnHHbtL
         jvIQ==
X-Gm-Message-State: APjAAAXPTZJCjyYkr7fB6GhRZGCc/PoFNROOKSPGQQ0HyXJOBjYfRsiJ
        SjFlknXc6pdJjUDaifhQCiLUxdFH
X-Google-Smtp-Source: APXvYqx4LacA0KBDaWsN4g+1NMZnd7gCeOWmfV53dINCk4vBMNBgyCrSUcwbe3Zby1ffpwLz5CB9Ew==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr4681436wru.181.1575933908744;
        Mon, 09 Dec 2019 15:25:08 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e8sm1129260wrt.7.2019.12.09.15.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 15:25:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM)
Subject: [PATCH] pwm: bcm2835: Allow building for ARCH_BRCMSTB
Date:   Mon,  9 Dec 2019 15:25:03 -0800
Message-Id: <20191209232503.7252-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

BCM7211 is supported using ARCH_BRCMSTB and uses this PWM controller
driver, make it possible to build it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index bd21655c37a6..0bb8a40c8d6c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -100,7 +100,7 @@ config PWM_BCM_KONA
 
 config PWM_BCM2835
 	tristate "BCM2835 PWM support"
-	depends on ARCH_BCM2835
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB
 	help
 	  PWM framework driver for BCM2835 controller (Raspberry Pi)
 
-- 
2.17.1

