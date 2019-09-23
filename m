Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE81FBAF01
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2019 10:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406661AbfIWINy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Sep 2019 04:13:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38600 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405071AbfIWINy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Sep 2019 04:13:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id u28so9376841lfc.5
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2019 01:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YP0Dty02K/PU7snWf9QCmnq9+d/+lpZCzmP6b7jH6B4=;
        b=BJ5LbRkdAmmWPoS4xoIHkGfseBJtqsTjDT8/SzOvXN4s2EcGhdbg44m+jOXBELIcM7
         4ANJ7E6jTSF9ZV6PoV9s6M/UvcK5qxO/EEGJRfM6MxvXh4CH8RQ83T9QQeE2spGj3wZG
         z1XbDZZvAk5dflfZlTdavY3SuAp8xmzsLydtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YP0Dty02K/PU7snWf9QCmnq9+d/+lpZCzmP6b7jH6B4=;
        b=Iou4Y7/UimYEHiPKCkxGzObpvu7N/OtpTpHPcS8b0sJ8l9Ld3xf4GThbKI6NT48D4u
         54Uuq1PrMF55nLjhPLxNmLXVfs35B5ZFj9Rwxj86/hykVs9rklp5JBWeRXjGhkJlcSML
         G9dfw+i4cWj4d2OBdRh4/XvIRo2LrGybmKPcFuxLr6+Rg70JKHFjyTSaityiiQKayU4l
         wiDBEMiumk56lu9xvS9lZm4Ak7fx7JJZ6OakAT/AWGg/3WZLbt28tr4HfdU4ivxDybRM
         dnKW1PwhX8ZGViH37fUrF7firPJw5pB3Imj/kDYZNl1ozzHkwkXjHLYKTmsvLhV+TblF
         Mchw==
X-Gm-Message-State: APjAAAUEr85ulO4eb2b6XlRPaeGihK/+R2BwI2Z4GqY8sm7B72MZFfSX
        ohDUsaxDUuMF/D/W9mjnTGayEg==
X-Google-Smtp-Source: APXvYqz1aK8MYGtYecVVxc/h+5tNAbQ8QHxsPIQq+G8SCQClVwWdZ7aqolsB4dTq+uFnHjerMW4hNQ==
X-Received: by 2002:a05:6512:4dd:: with SMTP id w29mr15905123lfq.2.1569226431814;
        Mon, 23 Sep 2019 01:13:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c21sm2054946lff.61.2019.09.23.01.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:13:51 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/4] pwm: mxs: add support for setting polarity via DT
Date:   Mon, 23 Sep 2019 10:13:44 +0200
Message-Id: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
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

Rasmus Villemoes (4):
  pwm: mxs: implement ->apply
  pwm: mxs: remove legacy methods
  pwm: mxs: add support for inverse polarity
  dt-bindings: pwm: mxs-pwm: Increase #pwm-cells

 .../devicetree/bindings/pwm/mxs-pwm.txt       |  4 +-
 drivers/pwm/pwm-mxs.c                         | 73 ++++++++-----------
 2 files changed, 34 insertions(+), 43 deletions(-)

-- 
2.20.1

