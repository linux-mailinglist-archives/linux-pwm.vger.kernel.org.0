Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EECF2516C7
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 12:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgHYKpB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 06:45:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:61687 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729797AbgHYKpB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Aug 2020 06:45:01 -0400
X-IronPort-AV: E=Sophos;i="5.76,352,1592838000"; 
   d="scan'208";a="55260239"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Aug 2020 19:44:58 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 720BF4001B7F;
        Tue, 25 Aug 2020 19:44:56 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH 0/2] r8a774e1 add PWM support
Date:   Tue, 25 Aug 2020 11:44:53 +0100
Message-Id: <20200825104455.18000-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All,

This patch series adds PWM support to R8A774E1 (RZ/G2H) SoC.

Patches apply on top of [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/
    renesas-devel.git/log/?h=renesas-arm-dt-for-v5.10

Cheers,
Prabhakar

Marian-Cristian Rotariu (2):
  dt-bindings: pwm: renesas,pwm-rcar: Add r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add PWM device nodes

 .../bindings/pwm/renesas,pwm-rcar.yaml        |  1 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi     | 64 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

-- 
2.17.1

