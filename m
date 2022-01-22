Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F69496A7C
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jan 2022 07:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiAVG6a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Jan 2022 01:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiAVG63 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Jan 2022 01:58:29 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FE6C06173B
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jan 2022 22:58:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso30768331wmj.0
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jan 2022 22:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0a69Bf7Fhja4VUL7PZg5y8GLumQUZqvM/tw385yH5Lc=;
        b=DH3U6P0GVxC+R94m4hagNz8CyDf3vcbJ5hAJJEoJ0F3i3dbF3f6kn78uDTkrgWf+6M
         wOZWs4SBjCR9olnXxJTeRBp0pblTsJZCPq69V5WEE3TznYE71hRkW4mcGBC6CLWAB4Nw
         fnrbEmOfg6cqliUDmTvfct3WpjbGUsqyPvnC7ker6wY4fXbNTF0JWkVOUgKBqywAyNlG
         z2jM2iAp/+DAFMgqVgI3jeS3ImZKdr9CD2hWGRbgfuDpsKMn2HTlYIBxsnGIS0V12uCc
         cnB6uLx4EoW0lRVIYUQlqEkwY6riLn9ZW36DzSzXqtUQzJy51zDBvO6VpZ9Oj2LHxyKs
         APCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0a69Bf7Fhja4VUL7PZg5y8GLumQUZqvM/tw385yH5Lc=;
        b=3Aqs/eFRDsJylE7f8EqmJ9GxLpmSMkPmUwkOC3HPoqULtPN0dAPMPRt7fHyc8oUiUe
         iF1KxSYl3IZJpVaLost08J6Y5wIkJaSNof68k9v9A46gYmQG4gcDcGBBjsP09Uo6L7+Z
         +c6n7etDP4kjS5ZdDus+8tV2cZqU9mKD80IKpBLWEqHA1C4uW83USYH1LzVJf10jitl8
         AwaL/GA1sAZqwAgq8uOYR+mx//wGq934ydfzIN3rD5S+BHdKewbW2R+ChSC4yMOk7gx7
         sBBIkJOjbEu3U+Kltsm7G+ymJ+HggY7Ln/qHMQZw7ezWax6dE5g9og0YcHmrbOn+9zzB
         za6Q==
X-Gm-Message-State: AOAM5312gW6lQZTTEZ4kPoyaOvvuUJinlEas6rZ9Pv1O6AxOaEkUZYne
        QxP2pMjKB14xj+TUhYhEt1ib/ErhYOk=
X-Google-Smtp-Source: ABdhPJwsYqegBJxekWrE3IdXUC+bKulGLqHvZDzpK0tlx5MJbdKk29gmiaSimRRGC/UXAIGTBU0YwQ==
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr3501725wmi.67.1642834707719;
        Fri, 21 Jan 2022 22:58:27 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:43:d620:bfbd:79f3:9552:6454])
        by smtp.googlemail.com with ESMTPSA id y2sm12258707wmj.13.2022.01.21.22.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 22:58:27 -0800 (PST)
From:   Lionel Vitte <lionel.vitte@gmail.com>
X-Google-Original-From: Lionel Vitte <lionel.vitte@free.fr>
To:     linux-pwm@vger.kernel.org
Cc:     thierry.reding@gmail.com, clemens.gruber@pqgruber.com,
        Lionel Vitte <lionel.vitte@free.fr>
Subject: [PATCH] pwm: pca9685: Set ALL_LED_OFF_L to POR value
Date:   Sat, 22 Jan 2022 07:58:19 +0100
Message-Id: <20220122065819.69150-1-lionel.vitte@free.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

During the driver probe, registers are not set to their POR value.

Signed-off-by: Lionel Vitte <lionel.vitte@free.fr>
---
 drivers/pwm/pwm-pca9685.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index c56001a790d0..c91fa7f9e33d 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -560,10 +560,10 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	pca9685_write_reg(pca, PCA9685_MODE1, reg);
 
 	/* Reset OFF/ON registers to POR default */
-	pca9685_write_reg(pca, PCA9685_ALL_LED_OFF_L, LED_FULL);
+	pca9685_write_reg(pca, PCA9685_ALL_LED_OFF_L, 0);
 	pca9685_write_reg(pca, PCA9685_ALL_LED_OFF_H, LED_FULL);
 	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_L, 0);
-	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_H, 0);
+	pca9685_write_reg(pca, PCA9685_ALL_LED_ON_H, LED_FULL);
 
 	pca->chip.ops = &pca9685_pwm_ops;
 	/* Add an extra channel for ALL_LED */
-- 
2.34.1

