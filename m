Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52040BFE4
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Sep 2021 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhIOG5I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Sep 2021 02:57:08 -0400
Received: from www.zeus03.de ([194.117.254.33]:33972 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236408AbhIOG5I (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 15 Sep 2021 02:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=USnC/J5qgFpycWWgwpLWF3Sl3nW
        C+8deEKKtzUo3cSo=; b=gIrjacFKvHTtQoCQI3McpI+YrXZtqDR4B4RviQi3Sjq
        Eqhm7v3wn7vGh/Xoj8yauyYrrZNHJbpb6mm1zhHNfsh7S5HiJLf7LoffufjDafq1
        W1oA8/GzRe51bDoF9jNjTgDjxVAgOkA9+K45RNDaf/mWQGALfFiVTR/gKHCCK4lM
        =
Received: (qmail 696300 invoked from network); 15 Sep 2021 08:55:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Sep 2021 08:55:47 +0200
X-UD-Smtp-Session: l3s3148p1@otzgLwPMmosgAwDPXwzFAFG7/ghv85hq
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-pwm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pwm: renesas-tpu: minor improvements
Date:   Wed, 15 Sep 2021 08:55:39 +0200
Message-Id: <20210915065542.1897-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Here is a super-small series with improvements for the Renesas TPU
driver from our BSP. Please look at the patch descriptions for details.
Looking forward to comments or them simply being applied :)

Thanks and happy hacking,

   Wolfram


Duc Nguyen (2):
  pwm: renesas-tpu: better errno for impossible rates
  pwm: renesas-tpu: don't allow no duty if duty_ns is given

 drivers/pwm/pwm-renesas-tpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.30.2

