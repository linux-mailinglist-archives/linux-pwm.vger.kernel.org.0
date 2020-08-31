Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBED625724E
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 05:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHaDYv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Aug 2020 23:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgHaDYr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 30 Aug 2020 23:24:47 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E072920E65;
        Mon, 31 Aug 2020 03:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598844286;
        bh=F8SGH7dboaPQz17xUfKd3KTHNfAbnW1y3V3zbE7JbIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gv/l+LgWt4CYKE0uf2j1yLMnDp4c01Jmy98F14D0dFwXTuUCBqRaklh1YL/8h9Krx
         4EZLCF45EDzHmlytvCraViLBHGfcJLoV6hXH8voWS2ph5uQZZ14zWPOaoh23gPXZ7M
         dXLytT9F8UB21s71Mmvto6H5U5+M38sXnBHG7Rnw=
Date:   Mon, 31 Aug 2020 11:24:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 18/19] arm64: dts: imx8mq-evk: Add hog suffix to
 wl-reg-on
Message-ID: <20200831032438.GH4488@dragon>
References: <20200825193536.7332-1-krzk@kernel.org>
 <20200825193536.7332-19-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825193536.7332-19-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Aug 25, 2020 at 09:35:35PM +0200, Krzysztof Kozlowski wrote:
> According to device tree specification, device node names should be
> somewhat generic and reflecting the function of the device so add the
> "hog" suffix to wl-reg-on GPIO hog.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
