Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23F53C1A22
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jul 2021 21:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhGHTwK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Jul 2021 15:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhGHTwH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 8 Jul 2021 15:52:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2593261434;
        Thu,  8 Jul 2021 19:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625773765;
        bh=gjYCCuq4A06gKeNh3PZpbCmFRZHNEr5WqtcjuVoovwg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H5mNer4N8I6a3KHtWi1Y8zG/92Cqhh0svl6iv/vncKur3cyJxhbGjyhHjNUICkCTz
         /+C4aQAIz8Dcg4VN1y5lMh+TJfwrer7uAyJKlIg0H7+6kt7ezsPj1pskfpwUVZLs8g
         fwopabOqY4Z5lAortHUbTCpyFdik/sVnES6hF4nhmRMgZBYNJkR9h+YL8eSSx1XO6/
         CPAGRywAdsDPhOkIzmHs0BA/ccqhzQRTmYBh42i4dqavLsdT2lniPKHSszqPNj1usk
         6CLXJJZ+6Y6pxao0C41Ou8GOQP2HkC0cynjRauXlRVAuSyYCfZsKNu83xa6Sb2duJG
         hrdlhtMTXeiKQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1ECFA609F6;
        Thu,  8 Jul 2021 19:49:25 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210708110415.1785007-1-thierry.reding@gmail.com>
References: <20210708110415.1785007-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210708110415.1785007-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.14-rc1
X-PR-Tracked-Commit-Id: bebedf2bb4a9e0cb4ffa72cbc960728051b338a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c1bfd746030a14435c9b60d08a81af61332089b
Message-Id: <162577376511.18035.16849873595115026933.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Jul 2021 19:49:25 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Thu,  8 Jul 2021 13:04:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c1bfd746030a14435c9b60d08a81af61332089b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
