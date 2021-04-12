Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9A35C3D1
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 12:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbhDLKY0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 06:24:26 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:16073 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbhDLKYQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 06:24:16 -0400
X-Greylist: delayed 1741 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 06:24:16 EDT
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 13C9ibKd096476
        for <linux-pwm@vger.kernel.org>; Mon, 12 Apr 2021 17:44:37 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 13C9iS0m096463;
        Mon, 12 Apr 2021 17:44:28 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 17:54:50 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <p.zabel@pengutronix.de>,
        <billy_tasi@aspeedtech.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/4] Support pwm driver for aspeed ast26xx
Date:   Mon, 12 Apr 2021 17:54:53 +0800
Message-ID: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 13C9iS0m096463
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The legacy driver of aspeed pwm is binding with tach controller and it
doesn't follow the pwm framworks usage. In addition, the pwm register
usage of the 6th generation of ast26xx has drastic change. So these
patch serials add the new aspeed pwm driver to fix up the problem above.

Billy Tsai (4):
  dt-bindings: Add bindings for aspeed pwm-tach.
  dt-bindings: Add bindings for aspeed pwm
  pwm: Add Aspeed ast2600 PWM support
  pwm: Add support for aspeed pwm controller

 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  52 ++++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  47 +++
 drivers/pwm/Kconfig                           |   6 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-aspeed-g6.c                   | 291 ++++++++++++++++++
 5 files changed, 397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
 create mode 100644 drivers/pwm/pwm-aspeed-g6.c

-- 
2.25.1

