Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C976741A17D
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 23:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhI0VtY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Sep 2021 17:49:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43276 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237202AbhI0VtX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 27 Sep 2021 17:49:23 -0400
Received: from user91-192-32-221.grape.cz ([91.192.32.221] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mUyTM-0005J1-DX; Mon, 27 Sep 2021 23:47:40 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>, lee.jones@linaro.org,
        thierry.reding@gmail.com
Cc:     xxm@rock-chips.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, devicetree@vger.kernel.org, cl@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
        pgwipeout@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: pwm: rockchip: add description for rk3568
Date:   Mon, 27 Sep 2021 23:47:38 +0200
Message-Id: <163277924886.2667343.9517363084260699018.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210726090355.1548483-1-heiko@sntech.de>
References: <20210726090355.1548483-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 26 Jul 2021 11:03:54 +0200, Heiko Stuebner wrote:
> add "rockchip,rk3568-pwm", "rockchip,rk3328-pwm" for pwm nodes on
> a rk3568 platform to pwm-rockchip.yaml.

Applied, thanks!

[2/2] arm64: dts: rockchip: add pwm nodes for rk3568
      commit: 98419a39d1dc276ac395c230ba2e6cf435a624b9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
