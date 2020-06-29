Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57F20E5DF
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 00:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403941AbgF2Vm3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 17:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgF2Sh4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 14:37:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A9EC00F82E
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:47:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so15256821wmi.3
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rudM74e1Pgb+dgRXbno543NZk9dhJh2T8QURDAwNqxo=;
        b=MMrJypktX2dGwbWK2WJwHSZlgTCxBvMicf8S6HeV+IEHyBd/BsMsD7DMpdBDI83MMv
         QyiPxbAJaQSWycHKbp7oaNquqzwC+4IpMBeTWunKJygLXDTtCouHG6kwzAS2WB0rfUvL
         5sUUgJlP/7u5hxVJQ8kkalGly7nDzvinuu1S6Ow2rv0xN+jughtx7Ou23KzkI16t7Y9X
         ir8XBS6MkFgqtdbkxyPOsNQN/TqvwoD+BQGpXSohEbzVF7hCKT5WgnGh6cM9H9htgNKl
         UqFX7dMSyrL855EudgAl3ujqkL8MW+azJAKRg4/RN+dpJ51bk5lqXzd0ImdK4NFYM5cI
         F/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rudM74e1Pgb+dgRXbno543NZk9dhJh2T8QURDAwNqxo=;
        b=fE3jLSkW5oYlWRPsZXTjtHcHzirqxPNhjzgLwMk8tJt3B/mfrN5c/ViopfGsHz/PEp
         bv3L50vN1478FM3pZ9c+jh7RPT7OwycIptzKjI7zguZEleYbFoUc+BXfv00rpb+grl1v
         cwVdUS6cjLFZJE+tktwxBfkoGUBbVHLAwabt+bJlTflQ8F2vKB9FPbuqplHNBIDpjzPg
         4bgg+jO8gDAwLD/I7hODJ+0J8Stz3N8VIsXPgdcxo0Ns0xC+45VM1mEjKH46KLaMaghg
         ekYnc44V3fGK7lobuqK6rf8M8WzjllWgirLdMey7U5oxm3ACiPUA+sBRLTTmGKSJzFtX
         JOsA==
X-Gm-Message-State: AOAM531PtFTJMtz2aivYb7twqBSDDVUOzEfpwpT/i9wd3XNe+7achW/c
        bty4UF2iblwS/2WB6saVjnhKkg==
X-Google-Smtp-Source: ABdhPJymTdB7uYUnNxNAvBDg/jFPSHnhR3EKfJTDqrjBJtflMfvEKlNxtCKuRryFRR89Pu116D8EKw==
X-Received: by 2002:a1c:3142:: with SMTP id x63mr16024940wmx.62.1593434875113;
        Mon, 29 Jun 2020 05:47:55 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id e17sm12995924wrr.88.2020.06.29.05.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:47:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/4] Fix a bunch of W=1 warnings in PWM
Date:   Mon, 29 Jun 2020 13:47:48 +0100
Message-Id: <20200629124752.1018358-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Attempting to clean-up W=1 kernel builds, which are currently
overwhelmingly riddled with niggly little warnings.

Lee Jones (4):
  pwm: bcm-iproc: Remove impossible comparison when validating duty
    cycle
  pwm: bcm-kona: Remove impossible comparison when validating duty cycle
  pwm: mediatek: Provide missing kerneldoc description for 'soc' arg
  pwm: omap-dmtimer: Repair pwm_omap_dmtimer_chip's broken kerneldoc
    header

 drivers/pwm/pwm-bcm-iproc.c    | 3 +--
 drivers/pwm/pwm-bcm-kona.c     | 2 +-
 drivers/pwm/pwm-mediatek.c     | 1 +
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1

