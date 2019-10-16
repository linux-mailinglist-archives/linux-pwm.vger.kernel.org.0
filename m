Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C9ED8EE6
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbfJPLGG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 07:06:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34600 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388775AbfJPLGG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:06:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so4415961wmc.1
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ud0etb9t9Ln1C6f6Oyeq4TMMUJX4VQnKxPs3TC5ZhBQ=;
        b=Bqc6p0eIVLUGyopTxqH1PHNSfEr3ahIyCunQiL7oLuH9uPaxmne5PRl1OYOFbrVDPF
         XEbIBugXxPBE6GEIlb0DcALU3xroqZU32qsjP63UdMnLCtPvVdi0NiRH5sQATrtAWO9Y
         kPgOJng8ScP50YrOFuI5fgiCoiE+Bms+Sv0TgPtYNqDTIpN5yPVsAq1/u10FH5k1xR/o
         weX79KXMATo7+iTfg9seSQGlHb6DOgwo9DXlP2RYdfGoKPEo0s6Som0aNK3JRnhWw4DR
         XE4bJTVS1oYfz5lncP9vJ6TFb2wCW/YPaPfjPD2WJ3fmwOM8sAAeVl9YvJ2F7FSNiDil
         enyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ud0etb9t9Ln1C6f6Oyeq4TMMUJX4VQnKxPs3TC5ZhBQ=;
        b=jkegh2Zk//7t+IZ8NelrkFeohDBUZyhlDwBhGW7w8UDInhUsEjb7dLCAuTyPF+YqD+
         sk+R3gjVpz1ZC+Q0zgovErLyNsHk100EVCcgp6VZj5QYWIt00nTtxNFfjHeOUpfFklR3
         2t9AytNgqVbALglavvHAuDnzBwkYCKR/JTHOQxECIdczpiefi1u3Hfv0eU3ELvwBo0Ar
         c9Qj8AU9v7Dtz1k0rYeR/8ZjYJy0k8BXK0tMAPlRQ20ukjyp4pdtL7a/KxfSSBOuET6L
         hB7JU+L3rOWVl0GHmCGgYizr9saM+OWKP4zk/2UB1AtTMK1iFqhnYkB1D90ghxzGtI2U
         Qdjw==
X-Gm-Message-State: APjAAAV+CapC/giS48LWDjVMqLPHDg8JW10k/kQbK39L7bgXzO1etY4J
        eIVHVf2INL0c4e2XPsQwdUw=
X-Google-Smtp-Source: APXvYqzOEapv4jzDAy7w7003PRpm20fF6dvRD04yfWJ7JiTl1ZJKXTKGPDCjM9JmPn3q/b5pVNeUaw==
X-Received: by 2002:a1c:804d:: with SMTP id b74mr2995414wmd.170.1571223964190;
        Wed, 16 Oct 2019 04:06:04 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id h125sm3075860wmf.31.2019.10.16.04.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 04:06:02 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 0/3] pwm: stm32: Minor cleanups
Date:   Wed, 16 Oct 2019 13:05:58 +0200
Message-Id: <20191016110601.1765415-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Looking at Fabrice's STM32 patches I noticed that we're now passing the
breakinput values (u32) into a function via int parameters. The easiest
way to fix this inconsistency is by just passing a pointer to the break
input structure. There's some preparatory work here that makes the code
slightly more readable, in my opinion. I ended up squashing two patches
into one in v2 because the second patch from v1 is already addressed in
patch 1 of v2. I've added a patch in v2 that validates device tree data
for breakinput as suggested by Uwe.

Lee, patch 1 of this small series touches the MFD header for the STM32
timers, but there's no good way to separate the patches, so if you could
provide an Acked-by on that patch so that I can take it through the PWM
tree along with the rest, that'd be great.

Thierry

Thierry Reding (3):
  pwm: stm32: Remove clutter from ternary operator
  pwm: stm32: Pass breakinput instead of its values
  pwm: stm32: Validate breakinput data from DT

 drivers/pwm/pwm-stm32.c          | 36 +++++++++++++++++---------------
 include/linux/mfd/stm32-timers.h | 12 ++++-------
 2 files changed, 23 insertions(+), 25 deletions(-)

-- 
2.23.0

