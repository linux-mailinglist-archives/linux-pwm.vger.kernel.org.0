Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE1979A291
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Sep 2023 06:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjIKEtG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Sep 2023 00:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjIKEtF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Sep 2023 00:49:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A619C
        for <linux-pwm@vger.kernel.org>; Sun, 10 Sep 2023 21:49:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AC93C433CD;
        Mon, 11 Sep 2023 04:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694407740;
        bh=B+BA/wventHVJsSezWS2OunhdTGAZAZ+4bFsflnSOAY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Z3zrXwT/q/hreCYxPS2EE70ljquRd84Fah9X6JkVO3NxaC9eDkqnJ4VHWw85v5dmT
         Stotx/y+10r9bDYbshfInvSGWR8w7PxzWsKks/sIqhqc5ZnyVhbcF6AIQulFwrvMpj
         DlsYPOQ605oic6i5NjHH///uQZIeo95OJe7AsQtDoleQvzpeIQUiPTcplU8/M6qBpd
         D948Mv/Y1Y81wEQjMlHTjxT97AgBOwfgAjXS5VoAL/eqyJJC8pmmM1wcupo+BqB16h
         A7zeLFelWhnQNvY+B64ILh3nvysOgtbYDft4kq/HRFHPVAyQVvdHxynMtFHIBdDHPn
         B2BdLJUcHuAxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31C47E1F67F;
        Mon, 11 Sep 2023 04:49:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/10] pwm: Constistenly name pwm_chip variables "chip"
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169440774020.22573.10062500641878947449.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 04:49:00 +0000
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

This patch was applied to chrome-platform/linux.git (for-next)
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


