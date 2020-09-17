Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA74B26E923
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Sep 2020 00:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgIQWsh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Sep 2020 18:48:37 -0400
Received: from mo-csw-fb1116.securemx.jp ([210.130.202.175]:47774 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQWsh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Sep 2020 18:48:37 -0400
X-Greylist: delayed 982 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 18:48:35 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1116) id 08HMWEMf010880; Fri, 18 Sep 2020 07:32:14 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 08HMVpnK023317; Fri, 18 Sep 2020 07:31:51 +0900
X-Iguazu-Qid: 2wHHc0BbY4gbV4F4z6
X-Iguazu-QSIG: v=2; s=0; t=1600381910; q=2wHHc0BbY4gbV4F4z6; m=2BCTSRl35XTllhcwfqZFR2iuXuunMjuwNKJFya0sOm8=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1111) id 08HMVnXF022770;
        Fri, 18 Sep 2020 07:31:49 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 08HMVnN7020139;
        Fri, 18 Sep 2020 07:31:49 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 08HMVlPP003008;
        Fri, 18 Sep 2020 07:31:49 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 0/2] Add Toshiba Visconti SoC PWM support
Date:   Fri, 18 Sep 2020 07:31:38 +0900
X-TSB-HOP: ON
Message-Id: <20200917223140.227542-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

This is the PWM driver for Toshiba's ARM SoC, Visconti[0].
This has not yet been included in Linux kernel, but patches have been posted [1]
and some patches have been applied [2].

Since this is a SoC driver, this cannot work by itself, but I have confirmed that it
works with the patch series sent as [1] with DT setting.

Best regards,
  Nobuhiro

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html
[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2020-September/599678.html
[2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2020-September/600578.html

Nobuhiro Iwamatsu (2):
  dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
  pwm: visconti: Add Toshiba Visconti SoC PWM support

 .../bindings/pwm/toshiba,pwm-visconti.yaml    |  48 ++++++
 drivers/pwm/Kconfig                           |   9 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-visconti.c                    | 141 ++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
 create mode 100644 drivers/pwm/pwm-visconti.c

-- 
2.27.0

