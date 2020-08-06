Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4B23E070
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgHFSde (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 14:33:34 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:4877 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbgHFScK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 14:32:10 -0400
X-IronPort-AV: E=Sophos;i="5.75,441,1589209200"; 
   d="scan'208";a="54073234"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 07 Aug 2020 03:31:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9D57D40062A0;
        Fri,  7 Aug 2020 03:31:54 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/5] r8a7742: Enable support for CMT, PWM and TPU
Date:   Thu,  6 Aug 2020 19:31:47 +0100
Message-Id: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All,

This patch series adds support for PWM and TPU to r8a7742 SoC dtsi
and enables CMT0 node for r8a7742-iwg21d-q7 board.

Cheers,
Prabhakar

Lad Prabhakar (5):
  ARM: dts: r8a7742-iwg21d-q7: Enable cmt0
  dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742 support
  ARM: dts: r8a7742: Add PWM SoC support
  dt-bindings: pwm: renesas,tpu-pwm: Document r8a7742 support
  ARM: dts: r8a7742: Add TPU support

 .../bindings/pwm/renesas,pwm-rcar.yaml        |  1 +
 .../bindings/pwm/renesas,tpu-pwm.yaml         |  1 +
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |  4 +
 arch/arm/boot/dts/r8a7742.dtsi                | 81 +++++++++++++++++++
 4 files changed, 87 insertions(+)

-- 
2.17.1

