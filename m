Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C6B188999
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 16:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgCQP74 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 11:59:56 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:54488 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgCQP7z (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 11:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=euefWLuxU1COLDNswebG/zDd8n44iQG/oIUiow0l+k8=; b=Rd1sHmCw7URX7qFwECdA+CQdfs
        Qq2BrOmNMSVVqJQqoZNPM7HO8qoGH5WrmSylPSMBRBVb3SyN8k8eSviqUFEMp1e8KZ51mstYxJjpx
        KOizuubWsrzlUvgg1ARTz1n2ZxfnwcCE3W4VmF2J4jYiwSU7H7RmbVXfpwkcNUurkxQpLsdodkEke
        RrVlpvoPD+5nvA8yYwJuxu07V/5qt2jalgyBA/G2VhqMUTW0ARFcZc3feBY+pHPOFu4URZy3tuPqS
        deUEST4nlY5nh8Qwllch1OXaH0Y3McorydONMSBziwRFVXXrRbnh2c3nC+dvX/xQDN2htJneQYgoA
        MsfsJtOg==;
Received: from ip565b1bc7.direct-adsl.nl ([86.91.27.199]:60802 helo=localhost.localdomain)
        by web0081.zxcs.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jEEdB-001IGT-Mc; Tue, 17 Mar 2020 16:59:49 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [RFC PATCH 0/4] pwm: sun4i: Properly turn pwm off and fix stuck output state
Date:   Tue, 17 Mar 2020 16:59:02 +0100
Message-Id: <20200317155906.31288-1-dev@pascalroeleven.nl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: dev@pascalroeleven.nl
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi all,

For the last few days I've been debugging a lot to get pwm working again since
recent changes in 5.6-rc1 broke it for me.

Testing shows the pwm controller crashes (or the output gets stuck) when the
period register is written when the channel is disabled while the clock gate is
still on. Usually after multiple writes, but one write can also lead to
unpredictable behaviour. Patch 3 and 4 fix this.

Patch 2 contains a fix which wouldn't completely turn off the pwm if the
output is disabled. The clock gate needs to stay on for at least one more
period to ensure the output is properly disabled. This issue has been around
for a long time but has probably stayed unnoticed because if the duty_cycle is
also changed to 0, you can't tell the difference.

Patch 1 removes some leftovers which aren't needed anymore.

Obviously these patches work for my device, but I'd like to hear your opinion
if any of these changes make sense. After days, this one is a bit blurry for me.

Thanks to Uwe for some help with debugging.

Pascal.

Pascal Roeleven (4):
  pwm: sun4i: Remove redundant needs_delay
  pwm: sun4i: Disable pwm before turning off clock gate
  pwm: sun4i: Move delay to function
  pwm: sun4i: Delay after writing the period

 drivers/pwm/pwm-sun4i.c | 53 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

-- 
2.20.1

