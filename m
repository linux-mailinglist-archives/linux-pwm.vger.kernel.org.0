Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6EF44EE04
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Nov 2021 21:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhKLUpF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Nov 2021 15:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235637AbhKLUpF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Nov 2021 15:45:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4E9C3604DC;
        Fri, 12 Nov 2021 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636749734;
        bh=02kbx+NQby/DIKAXkAkQgEN2Ju1eHICzQSvRySoJ0W4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GoesSrmHV5JUfWaIZr5jkmbRACnAWZjQCm2M4AmqKB7t/bCivPm7OkoTEiO/hn+Dz
         rMBWw9re72IkSINBL4sGBKbILLEeS3w4TdfTVc2aXU7BL52vv0dpJyctUsznUfBHq5
         AhnbTSNr6H+HvA+/a7fcE2jCLc81Qh4JatDN8tz5i8cuCfPcEQvBNnAUL4cMaTx7Qj
         Orau+1BXeo/hzsGGSAGhaBcCnzPgXrevf2ZJlnPulHmPIE1d0m3lTV3X1ieFTVPStc
         GJ6q9j365E0D1pcRhC6IKua0armYUigPpTqsyaXc3JwQFTnWjSWTnhUuSKXoB+ezKW
         8Ta9rhXo1idZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4848B609F7;
        Fri, 12 Nov 2021 20:42:14 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211112103122.3664089-1-thierry.reding@gmail.com>
References: <20211112103122.3664089-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-pwm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211112103122.3664089-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.16-rc1
X-PR-Tracked-Commit-Id: e9d866d5a6296c701e5b46a94c0bbd6e2c0e357e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 030c28a021131c6944d35a4fa727781f9df3a05d
Message-Id: <163674973428.4802.17250676853948004535.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Nov 2021 20:42:14 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pull request you sent on Fri, 12 Nov 2021 11:31:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/030c28a021131c6944d35a4fa727781f9df3a05d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
