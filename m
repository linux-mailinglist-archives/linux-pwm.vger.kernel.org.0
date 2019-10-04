Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13217CBBB5
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbfJDNc7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 09:32:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41219 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387917AbfJDNc7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Oct 2019 09:32:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id f5so6520359ljg.8
        for <linux-pwm@vger.kernel.org>; Fri, 04 Oct 2019 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6e6kNUFkOwggtKh2FtgQ72TKMBXQJNnsWv0kpOgx0sI=;
        b=XZkKHdG2crSiyzrMy2VYonGv0szQi+UnZmCse5Bf56kipSTq4oGJhOVzSkBSoZFHR1
         +ZF/LdhdrF5138bRvPtoMvzxccaUeOYRvhGHeLff0IJzgfXgOwBh7uHZdnco99ie3Xd7
         t0vZOi9c0XtZONz49s5W+o1BWQlyXdSavQ1zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6e6kNUFkOwggtKh2FtgQ72TKMBXQJNnsWv0kpOgx0sI=;
        b=jv5q8Tlx/MaZEM8fe+M5jdv3VkaMXfKaVyfxjV4ztHBDGRhJJYIDgW/Egn3jrtUNNO
         mT7vxXULYm0mvwq/eysEqyGV/l0492FVdL/zundatK6z7BOPUmhcE0q2kPYpWCISQu/V
         /sex3BNfz2hBWkYtmeZdoAwjanmybqWOvzcX1VkaCCvZZJ3rCQZGk68mhF9AOhdtxFKg
         iriz6FQWq5JS/LMKqQo5exZV9WCYnACqGUpRDxf7/G+o1w8qZDVrWM1LlchKCUkns+c6
         B/4TjCqTcBXOPR093RrV7Ghj9QaoSf1gAynGe0qAOKIRwJ3ipeBoKMpW+ep2Yv+mpkAk
         9yqA==
X-Gm-Message-State: APjAAAXFdmFzFfNVITitFu1/0DV7ZMnBA9Pvf90yegmxn8uuJpc5opD/
        vV9AS9nj0V7Cc+uFwfJff6AZAg==
X-Google-Smtp-Source: APXvYqxG/5L0LFLLyQDBwiDl6JJamRel6vq19pDlrjEK0hxD7neje+Af0NtighCjwoCkw70qCO0Dag==
X-Received: by 2002:a2e:9692:: with SMTP id q18mr9757018lji.73.1570195977546;
        Fri, 04 Oct 2019 06:32:57 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y26sm1534991ljj.90.2019.10.04.06.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 06:32:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/6] pwm: mxs: add support for setting polarity via DT
Date:   Fri,  4 Oct 2019 15:32:01 +0200
Message-Id: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series adds support for setting the polarity via DT to the
pwm-mxs driver.

The DT binding is updated, but I'm not touching the existing .dts or
.dtsi files - it seems that the same was done for bcm2835 in commits
46421d9d8e802e570dfa4d793a4938d2642ec7a7 and
8a88b2a2017d1e7e80db53080baff591fd454722, while
arch/arm/boot/dts/bcm283x.dtsi still has #pwm-cells = <2>.

v2:
- Rebase to v5.4-rc1
- Address comments from Uwe.
- Add Rob's ack to patch 4.
- New patches 5 and 6. The last one is independent of the others, but
  I stumbled on this when rebasing and found the signature had
  changed.

Rasmus Villemoes (6):
  pwm: mxs: implement ->apply
  pwm: mxs: remove legacy methods
  pwm: mxs: add support for inverse polarity
  dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
  pwm: mxs: avoid a division in mxs_pwm_apply()
  pwm: update comment on struct pwm_ops::apply

 .../devicetree/bindings/pwm/mxs-pwm.txt       |   4 +-
 drivers/pwm/pwm-mxs.c                         | 101 +++++++++---------
 include/linux/pwm.h                           |   5 +-
 3 files changed, 53 insertions(+), 57 deletions(-)

-- 
2.20.1

