Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598C46F9E6C
	for <lists+linux-pwm@lfdr.de>; Mon,  8 May 2023 05:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjEHD4H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 7 May 2023 23:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjEHD4F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 7 May 2023 23:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540135FDE;
        Sun,  7 May 2023 20:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B376861E50;
        Mon,  8 May 2023 03:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 017E0C433A1;
        Mon,  8 May 2023 03:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683518162;
        bh=iqxRQMD53u2tbr+scb/mygfA71sAOYFgkZWapjTWLC8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nEjcgk3+n8PYkAocEwDvhmB9jmQVz13X6O5K2hyos1vxLgzNen0Ynbvp4PFTtwysi
         +BCR/a9mQn1f1BPAE4k0psgkYYi9BqOywL6GkMDTwiUY8GYSL9lYyA1BdBuKzU2hXH
         dIMT772sNaVuDE9zKYN9NvgT6DxfUYiSp40yp/AmEVnehU+lds/vfVirVunCKpAyLa
         6GHtWMLiKGxD2l0QV4Eeu747HdERt5Fw9YwxiuyioA/1nUw9YUMaq/ikApjI7ejKWe
         3t1Ha3yKoi59DNpgdlEAe7bez5m1nP6bIOk3zteJUF1LZ2Qo1c7mFFVQ9iCtduLuP8
         TS+0FH9YEdnOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3B00E26D29;
        Mon,  8 May 2023 03:56:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/30] pwm: Convert to platform remove callback returning void
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <168351816186.5651.2096317681881714301.git-patchwork-notify@kernel.org>
Date:   Mon, 08 May 2023 03:56:01 +0000
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@ci.codeaurora.org
Cc:     thierry.reding@gmail.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        rjui@broadcom.com, sbranden@broadcom.com, f.fainelli@gmail.com,
        bleung@chromium.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        vz@mleia.com, matthias.bgg@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        fabrice.gasnier@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        jonathanh@nvidia.com, sean.anderson@seco.com,
        michal.simek@xilinx.com, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, festevam@gmail.com,
        linux-imx@nxp.com, angelogioacchino.delregno@collabora.com,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, alim.akhtar@samsung.com,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Thierry Reding <thierry.reding@gmail.com>:

On Fri,  3 Mar 2023 19:54:15 +0100 you wrote:
> Hello,
> 
> this patch series adapts the platform drivers below drivers/pwm to use
> the .remove_new() callback. Compared to the traditional .remove()
> callback .remove_new() returns no value. This is a good thing because
> the driver core doesn't (and cannot) cope for errors during remove. The
> only effect of a non-zero return value in .remove() is that the driver
> core emits a warning. The device is removed anyhow and an early return
> from .remove() usually yields a resource leak.
> 
> [...]

Here is the summary with links:
  - [09/30] pwm: cros-ec: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/159a61a7b5b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


