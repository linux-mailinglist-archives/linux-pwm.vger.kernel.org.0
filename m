Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9697E956B
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Nov 2023 04:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjKMDX7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Nov 2023 22:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjKMDX7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Nov 2023 22:23:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E064171A;
        Sun, 12 Nov 2023 19:23:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46C41C433B7;
        Mon, 13 Nov 2023 03:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699845835;
        bh=sTORHFHs64nriYPghaE5on9s96E8KHDcO2AObOHSmYs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bR1Jq+W7c7tQOEqWMzeeY8RXV+14qqgrDGSEnoFOBf3JAOnMTf6CT7qCg10U0nR0P
         zQzr1cxfpGj+A1f3T5pDsHW2cIgf0D/bSgWVEWXkH5ohWPzIH/9/iepkE9PjSyz9gC
         jmrDMsciwX/JQ++Cd1yKWAiMyva+22B8Y4Nyr6Al8AZDNmkcmBMrZwHy8agT7BH3V4
         GxqmlHUYQz2BxWBYea9u+wF8bm5G/JXACqmX1paJ8AaaB7kKKHFIIUai0XBiz+m0Nc
         JTNijb89KFoGOaIW3f/8C167H5XzHY21wha3qfX4tQgh+vXZdYdYLzaXrSGv25CNfh
         31jNlqn+wLybg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26A71C04DD9;
        Mon, 13 Nov 2023 03:23:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/11] pwm: Some random cleanups
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169984583515.27851.15324455433917462968.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Nov 2023 03:23:55 +0000
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@ci.codeaurora.org
Cc:     thierry.reding@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        florian.fainelli@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-mediatek@lists.infradead.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux-samsung-soc@vger.kernel.org, bleung@chromium.org,
        groeck@chromium.org, chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Thierry Reding <thierry.reding@gmail.com>:

On Fri, 29 Sep 2023 18:19:07 +0200 you wrote:
> Hello,
> 
> this is a set of patches I based my efforts for closing a race condition
> in the pwm core on. I thought I already sent them out, but it seems I
> didn't. So here they come!
> 
> Best regards
> Uwe
> 
> [...]

Here is the summary with links:
  - [11/11] pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_err_probe()
    https://git.kernel.org/chrome-platform/c/896c450960f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


