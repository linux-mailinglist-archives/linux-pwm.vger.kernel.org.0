Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8BE113D36
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2019 09:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfLEImI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Dec 2019 03:42:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46700 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfLEImI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Dec 2019 03:42:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so2358381wrl.13;
        Thu, 05 Dec 2019 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a82IPIzFvOWSz7olnZkzF0f2uFxsm3Ss8m2zNLETlDw=;
        b=B83tlR32xLtzxxgtJBg/au8fyTo2mopG0xjARcB2Sd6hxWygYttehAt6BbDaXGn0nX
         d7+BPEfv7X++lkZKWzoLKvEA8gAwj6B7G+gbhYaeqSSopnzhsZY4PIyCFvePm/9H8s4A
         kMpY0L4avBKvL2VuvQyPAQVg1+OK+2YHhfVIhfH8K/GyhDXphwsFZPjEZ83MGCK6OuE6
         LK+fBv+cN4+BbIt23qZqw2XBSUJIHPklTKaKOOsBm3O9D8nVrKeaxHExTZNL2YuiB7pp
         Ku3h5/IR0D1yR7+3IFDG/Zd96W/duLBXoa0lHX+SaT3bSso2pafdbmVyIU/nN/nab4Ti
         suPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a82IPIzFvOWSz7olnZkzF0f2uFxsm3Ss8m2zNLETlDw=;
        b=gm2rrlPRzd4QDF2xvds4DRsZI3LXd554hGiv5GmmPPkd0kMNX+hVUigwBdQh9Y0aYg
         or4yMNhSjH8ayachnBzt1MwQtE8ySrE5mGE4R5gxe05mIcUjBFPzW5Lx5fixZVAShSs/
         g0tTGNAguR1RGvZ7SjS/cRB58qnBMQ8NUNu4tgS7yDR3NIpNShA9fH4/qT+w4bzqonC4
         ifjrrouXI7t3qJz1RqBvxg4DELfGL3Ma+/KWbHR4dUzUgC4LNrXdJgllk1J4lz24sAhW
         7BJQtdt9G8rGxmXgckR5US+R/ZzCTZh9yicszi2a29XX84n9NGsY391HPTqRJarmWct0
         weXg==
X-Gm-Message-State: APjAAAVrP5EK8UvCF7O9GcUmiL1A6facSxIu4TVtATKSJa/j6wV77c1b
        jP14hycsBA4UfCv8B1+e+Q4=
X-Google-Smtp-Source: APXvYqzDX1hgz9cqElGyuR3b7xKncCWKJ834E6EEhbnMZoXvuFGMZysyEYp7H6eLhu0ngQoVeazgXg==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr8989992wro.216.1575535325950;
        Thu, 05 Dec 2019 00:42:05 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id w8sm10307744wmm.0.2019.12.05.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 00:42:04 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] pwm: Changes for v5.5-rc1
Date:   Thu,  5 Dec 2019 09:42:03 +0100
Message-Id: <20191205084203.1411690-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205061044.1006766-1-thierry.reding@gmail.com>
References: <20191205061044.1006766-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus,

The following changes since commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:

  Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.5-rc1

for you to fetch changes up to 9e1b4999a1693d67cc87a887057d8012c28fb12b:

  pwm: stm32: Pass breakinput instead of its values (2019-10-21 16:50:05 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.5-rc1

Various changes and minor fixes across a couple of drivers.

----------------------------------------------------------------
Colin Ian King (1):
      pwm: sun4i: Drop redundant assignment to variable pval

Fabrice Gasnier (3):
      dt-bindings: pwm-stm32: Document pinctrl sleep state
      pwm: stm32: Split breakinput apply routine to ease PM support
      pwm: stm32: Add power management support

Ondrej Jirman (1):
      pwm: sun4i: Fix incorrect calculation of duty_cycle/period

Rasmus Villemoes (1):
      pwm: Update comment on struct pwm_ops::apply

Thierry Reding (4):
      dt-bindings: pwm: mediatek: Remove gratuitous compatible string for MT7629
      pwm: stm32: Validate breakinput data from DT
      pwm: stm32: Remove clutter from ternary operator
      pwm: stm32: Pass breakinput instead of its values

 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   2 +-
 .../devicetree/bindings/pwm/pwm-stm32.txt          |   8 +-
 drivers/pwm/pwm-stm32.c                            | 112 +++++++++++++++------
 drivers/pwm/pwm-sun4i.c                            |   5 +-
 include/linux/mfd/stm32-timers.h                   |  12 +--
 include/linux/pwm.h                                |   5 +-
 6 files changed, 95 insertions(+), 49 deletions(-)
