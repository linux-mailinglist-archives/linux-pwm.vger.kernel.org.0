Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BF97EBC46
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Nov 2023 04:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjKODla (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 22:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbjKODlP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 22:41:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C12F3;
        Tue, 14 Nov 2023 19:41:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5FFC433C9;
        Wed, 15 Nov 2023 03:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019671;
        bh=lGQ4M/0jEURw3jD4EeZpBamU602KWP679BaOBKopapo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mpu3AWbetoTERpZ32onJGeduv0ybCPWM0Aw/h939Hd7m68CzmGKgutZTLOSD9B74D
         8HsIXPonIiOkMvbYS0/oPC+RqJIHjXaEvD7avW+5jjOT63dYL0TWlssQnxNWSLkDT1
         l9oOyhUB49pj5AloO40EFdF0v8NRO+ol5TOdCNXXj2GL293uO8/8EZ2hxTO/nOWhaS
         555icCDajEPx3KPLUn1CLtkL3hiDxGG3DInAqLIp3FWHrWr0ZZSHOSu/1NexCGoUud
         zTghvI8hKNvTd1Elj+mzUduIk++qw0dKCSboOQeDr55Xbt0WTdPHP9XtvP/elL3PQw
         8YrV+wCKIV6kA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/4] pwm: Fix double shift bug
Date:   Tue, 14 Nov 2023 22:40:14 -0500
Message-ID: <20231115034024.1236659-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115034024.1236659-1-sashal@kernel.org>
References: <20231115034024.1236659-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.138
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit d27abbfd4888d79dd24baf50e774631046ac4732 ]

These enums are passed to set/test_bit().  The set/test_bit() functions
take a bit number instead of a shifted value.  Passing a shifted value
is a double shift bug like doing BIT(BIT(1)).  The double shift bug
doesn't cause a problem here because we are only checking 0 and 1 but
if the value was 5 or above then it can lead to a buffer overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pwm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c7bfa64aeb142..03c42e742dfe7 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -44,8 +44,8 @@ struct pwm_args {
 };
 
 enum {
-	PWMF_REQUESTED = 1 << 0,
-	PWMF_EXPORTED = 1 << 1,
+	PWMF_REQUESTED = 0,
+	PWMF_EXPORTED = 1,
 };
 
 /*
-- 
2.42.0

