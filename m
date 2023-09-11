Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CE579A276
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Sep 2023 06:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjIKEbt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Sep 2023 00:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjIKEbr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Sep 2023 00:31:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F21B8
        for <linux-pwm@vger.kernel.org>; Sun, 10 Sep 2023 21:31:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3979EC433CD;
        Mon, 11 Sep 2023 04:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694406700;
        bh=UepKFV/RYGBvPBdow3H0Kx6KiHwRlGChrZoa/xUHr6g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Lx9qX2N10++hfk0wbyInOwoEda8jSGtqfzDaHtPIys4N4GqOlzXvSj7ZhwEsFwyjP
         AimXb0YGhDW4drnaLrnbf8UMfhOekC4fGjyHacUpPHDyv0ZMzDpwmJ5A7RUESvaADn
         Mj2iLEs4vjYOUqwD3I8CcZnH/7J9O4E7P2du8TO3vLhgQbUtZwYzQd06/+2LSLbBQT
         KYImvYc3MFKWvSynXJO5OdsTPq+bUXjgH3yO5+o2Lf1M3fqRA4r/LBDqYuWkDrRQgY
         O7xANpP+sYrQvi3iinG7eOcBBQ0subiQgFVVUOpe9J+2pnElyGSQoWdZ10uk/3z9uU
         EPN5NdbrqvX1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23B43E1F67F;
        Mon, 11 Sep 2023 04:31:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/10] pwm: Constistenly name pwm_chip variables "chip"
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169440670014.22573.14581572371535756981.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 04:31:40 +0000
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@ci.codeaurora.org
Cc:     thierry.reding@gmail.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, bleung@chromium.org, heiko@sntech.de,
        palmer@dabbelt.com, paul.walmsley@sifive.com, michael@walle.cc,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, groeck@chromium.org,
        chrome-platform@lists.linux.dev,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Thierry Reding <thierry.reding@gmail.com>:

On Fri, 14 Jul 2023 22:56:13 +0200 you wrote:
> while working on an extension for the pwm framework, I noticed that some
> drivers and even the core only nearly consistently named all variables
> and struct members holding a pointer to a struct pwm_chip "chip":
> 
> $ git grep -Pho 'struct pwm_chip \**[a-z0-9_]+(*nla:[\(a-z0-9_])' v6.5-rc1 | sort | uniq -c | sort -n
>       1 struct pwm_chip *pwm
>       1 struct pwm_chip pwm
>       1 struct pwm_chip pwm_chip
>       2 struct pwm_chip *_chip
>       4 struct pwm_chip *c
>       8 struct pwm_chip *pc
>      57 struct pwm_chip chip
>     358 struct pwm_chip *chip
> 
> [...]

Here is the summary with links:
  - [05/10] pwm: cros-ec: Consistenly name pwm_chip variables "chip"
    https://git.kernel.org/chrome-platform/c/5996cdf132da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


