Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235CA45D991
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Nov 2021 12:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhKYLy6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Nov 2021 06:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbhKYLw6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Nov 2021 06:52:58 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA8C0617A0;
        Thu, 25 Nov 2021 03:47:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id t26so15619659lfk.9;
        Thu, 25 Nov 2021 03:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xjNtZhslGdewYi4/DDCriqSgf5isSxRwQ8y3BIZKOyw=;
        b=aamzeuqJYayyPoYuDlfHehlm0t5RiB/4dmHiX1X4K5uKuzZO8qvIYW1ainbLyJemsN
         wJshgIxPZYw7X7zhoSYXT2mFNUzesVKLrt6f1tF2ND29eI5vLKH+8+sQaOO1hmOGiRci
         KSL5gT5jxmQVI48v6SaiQbPXCg93l5kjkmmdtkDRLJVTY3ANCuFLlMqSLurFMMgJcPM1
         wCfQmWSZCRAFAMHKhxEX+gfwzBDWn4fZ5Bo5mHLtKdgWgwdvIIlcvh9qoaNS7jodzX+F
         xwHaVqlzHLrsBv6TQ2U9GyYbgj3htKUTrY8MMZeJpFAkT3Expk6CXn+s5ygpG99KqIBr
         aPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xjNtZhslGdewYi4/DDCriqSgf5isSxRwQ8y3BIZKOyw=;
        b=pkClquiJTa5rC/jBzRkEKWgLX982EX4k8qr1+4gz/PvP/XfNKm+vYNouv/Mq1O39nC
         Ez8aTbjJC5G7raJ7h2Mjosy1ss93dIZ3iMYd8j03SuamznFoYO+2U3UDQr/6Co+zHXvv
         bMH29CQOBcNfjxF5SQOVr6ETmoXN7Y2BanWV0E/FKOVO8G1UM+HHh824Btkx1O8gvUsT
         cSOFbYySolN5ErqgoIPDnThqU3/lWc52NOumF266NEH/FBFwUao+eJpza9vW1896nSGZ
         bE6FGwh40GsTfrg6jOUc7Pv2T8Mr76ipPyEtKsOyhnfwVXV5AWKKhbAjG+8/AE658uFj
         m/Nw==
X-Gm-Message-State: AOAM531RRMj4RtLNd/IHjKIRk1IXbPWZYCvMkAJ3wZAFIXsxwAoN6Uga
        0DT4T0mSJ0r4v7KLqpfv1cOv72Fs9WykqtI3btlYLJm8bQ==
X-Google-Smtp-Source: ABdhPJxV0nTZKhLvw9mCwuGjnjREvyBOSbv/Q0U8XWchLzQKSAa9lZom2oNJxwxsaYUsUbVhljD5gKJNA7Z3z2cEX7I=
X-Received: by 2002:a19:5212:: with SMTP id m18mr24065469lfb.267.1637840841735;
 Thu, 25 Nov 2021 03:47:21 -0800 (PST)
MIME-Version: 1.0
From:   Johannes Pointner <h4nn35.work@gmail.com>
Date:   Thu, 25 Nov 2021 12:44:22 +0100
Message-ID: <CAHvQdo3ovYAENUC1eb=ujvcu6MHV+qW+d9V9L1+JX6eVbKb4Cg@mail.gmail.com>
Subject: pwm: pwm-omap-dmtimer: fails with Unable to find Timer pdev
To:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

I just tried to update an am3352 board to kernel 5.15 (before I used
5.10) but I'm not able to get omap-dmtimer-pwm to probe anymore. The
driver fails with the following errors:
[    1.238511] omap-dmtimer-pwm omap-pwm@timer5: Unable to find Timer pdev
[    1.238590] omap-dmtimer-pwm omap-pwm@timer6: Unable to find Timer pdev

Patching the driver like this
        timer_pdev = of_find_device_by_node(timer);
       if (!timer_pdev) {
               dev_err(&pdev->dev, "Unable to find Timer pdev\n");
-               ret = -ENODEV;
+               ret = -EPROBE_DEFER;
               goto err_find_timer_pdev;
       }
solves the problem but I'm not sure if this is the right way.

I tried to find out when this problem started and found out that the
last working version is 5.10.x. As of 5.11 it no longer works.

Thanks,
Hannes
