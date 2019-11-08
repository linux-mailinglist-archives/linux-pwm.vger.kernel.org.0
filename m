Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85ABFF52C1
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 18:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfKHRmZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 12:42:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39636 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfKHRmZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Nov 2019 12:42:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id a11so8006664wra.6;
        Fri, 08 Nov 2019 09:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLpxLiOoyJlR/gSpAnwkPXjar8cw71Hz2t/eOeAgaNg=;
        b=OtLbRvsVMsMOSQOVLGs4ke8ojgitE0iVhTAuaRcljAKVyPVYl6gsmir+PsExInJlxd
         w/WSaplhQfEaZMj1++wwaDMlvIt5/SYfeOf9/kgskkDgUxcdd6wh3qLJGAMv+YP9Qqkn
         BC/bosVjIFMmPsW7iiST1bQDiwUDltMN6OcyroCRAGmeWdhxT7yfpIiRDzX6nB2ffFJI
         CpNDfAbf2NvCWerkXysm2yBWE+L/x5X2renloc44a+EmlkQMMSY2pYsrD/zS56PXiue0
         6Q+yWyV0WkEeCKRNBR484DaudTWk7NCLhK73/TzzlWQ6srFWIVLhfIKK2FckACLt9VKk
         /qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLpxLiOoyJlR/gSpAnwkPXjar8cw71Hz2t/eOeAgaNg=;
        b=LFNaRbLXj9zjx5WFCRzz8jQDIlnM+ThUrHWGoFZezGbxe/DyGi9Vy6dsCuX8lOrssr
         iI1tcIPZh73Yp8MDi9/kQhPfNIIu5T0i1UXaJGOMaT0yErvOuYoStta8kmsETllABEEj
         i9ewxeKagx5mujTK2lT7y1DRn6m+cFuivKHl3GypdE2kzVXZViMW3tGSguYlj22ccYHh
         SHIZVpuGg3jnmHgwU/5uZUDCLRLYZCYhDYuF22HMMXSnzemdkq1MXj4xL0wwwb/y/lXN
         WmS9p9apYaAj89E71lyUFO7XgffuSTimBqQTBlnZu1Hl9Bsc9+0oeCIN0wjn8AA0CxUc
         aUmA==
X-Gm-Message-State: APjAAAW+n6NA5hKU7vb+KAiUClVzTTQBpRI85i4RhhEHexTb1nXyJSMW
        JbiueBZJHBOIJKazYVzIo9/gqioDGCI=
X-Google-Smtp-Source: APXvYqwj19uqZv95ef6LajG2/vuJSid1NG2XDKHTOp9c05U/dR633lHPrIQpZ1kmfiHvmctDqlu/hA==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr8925784wrn.377.1573234943057;
        Fri, 08 Nov 2019 09:42:23 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id w13sm6267368wrm.8.2019.11.08.09.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 09:42:21 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Fixes for v5.4-rc7
Date:   Fri,  8 Nov 2019 18:42:20 +0100
Message-Id: <20191108174220.3384630-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:

  Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc7

for you to fetch changes up to 24906a41eecb73d51974ade0847c21e429beec60:

  pwm: bcm-iproc: Prevent unloading the driver module while in use (2019-11-08 18:38:06 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Fixes for v5.4-rc7

Here's one more fix to keep a reference to the driver's module as long
as there are users of the PWM exposed by the driver.

----------------------------------------------------------------
Uwe Kleine-König (1):
      pwm: bcm-iproc: Prevent unloading the driver module while in use

 drivers/pwm/pwm-bcm-iproc.c | 1 +
 1 file changed, 1 insertion(+)
