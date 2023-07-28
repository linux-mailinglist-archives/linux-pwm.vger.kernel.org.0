Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52803766572
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjG1HgM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjG1HgH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:36:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9720435A2
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:36:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52227884855so2595630a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690529765; x=1691134565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VxKY6u5lFTg/57BHjnfzCRCe68ONUwyCwCpw46NNzY=;
        b=aonXMgVL0Nj0goAKvHXPy6hQ8HnuMWFhJuI63147hD14ibV5jUSwvkvUNFwde/ZaNG
         P9azSIaxCjVOXuIXAxwcGzdaU/vtHmAyHvTwn7Z2PkG6rfu3Btlkq5tz9zpTk/4FZOQQ
         b8hp6oBtYjAFgMcX0pfF+ynoUIzGRCBS0Abl40ErA8adLBvrAzCTvB6w90lePd8ut4fe
         gngKHSL1dURnCpJ+f38aBeABoK5/XQYTC8pZQa30QfiASWJw9KPod6prQvI+/u2SRcNC
         iDNsgX7wKJRltxMzcvBZDfLox48sUJQC/gqVCNAGkMoFt97fjB+OZwBi9AUCZ4TQShLR
         ZrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529765; x=1691134565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VxKY6u5lFTg/57BHjnfzCRCe68ONUwyCwCpw46NNzY=;
        b=JGSCEqLN3ohbpxU56ZZRQJ6hEiI+ajkkS0zPnSr0IIVxB3x9HIGMX3rql4X3ahQTzK
         niqfNyunUpT3+a1y3tfdCYIOYkyQtdkGcQBv13N+QENpk7gMiHlYr7SoXbaKJICmMqf7
         oLZnWt9s2GOx3cSXVic3JUW3w7jEgcZ4LKLI1gnEwrtHSTTdndO8dMkuBuQi0NrWBncZ
         eYge4F5L97fYeIiIy1Yisg+geF2XQC6eJYWy+jsaLFVOHqKlS/0IInArDCsER/ZeBGbM
         fJVRbpEf0YBetIj6yDcciZDaa9A8C1ek2RvOovner75ax8m1jmF2Xaf+TetcDqSOG5li
         wIpA==
X-Gm-Message-State: ABy/qLYOlpQg9rjZtH8fK1gT5LJOaaG3/pGYX1ThrxC2cLYHdpfDSh16
        ak2ZtkwDTW1GLFJnTWv4I6c=
X-Google-Smtp-Source: APBJJlGjXTQy7fDlif7j1HBb1Cl87wUmOAkJ+qxnK/T11iXMnTOwTrALAdBqP2UC0Qru/b8J94yeJA==
X-Received: by 2002:aa7:c251:0:b0:522:2711:873 with SMTP id y17-20020aa7c251000000b0052227110873mr1622180edo.1.1690529764790;
        Fri, 28 Jul 2023 00:36:04 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ca12-20020aa7cd6c000000b005222005e361sm1530203edb.45.2023.07.28.00.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:36:04 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/5] pwm: atmel-tcb: Some driver maintenance
Date:   Fri, 28 Jul 2023 09:36:02 +0200
Message-ID: <169052975103.3513148.5045149732339919882.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Wed, 19 Jul 2023 21:20:08 +0200, Uwe Kleine-König wrote:
> here come some improvements to the pwm-atmel-tcb driver.
> 
> There are still a few opportunities to improve the driver. For example
> .duty shouldn't be relevant for atmel_tcb_pwm_disable(). Also the driver
> could be converted from of_clk_get_by_name to devm_clk_get() (and then
> also devm_pwmchip_add()). Further more I think all members of
> atmel_tcb_pwm_device could be dropped as they are all only used in
> .apply() after they were assigned earlier in the same function; similar
> to how I removed the polarity member. Maybe someone with the hardware
> wants to chime in?
> 
> [...]

Applied, thanks!

[1/5] pwm: atmel-tcb: Harmonize resource allocation order
      commit: 0323e8fedd1ef25342cf7abf3a2024f5670362b8
[2/5] pwm: atmel-tcb: Fix resource freeing in error path and remove
      commit: c11622324c023415fb69196c5fc3782d2b8cced0
[3/5] pwm: atmel-tcb: Put per-channel data into driver data
      commit: 78dca23bd6706dd6a3cdb5c0052f48794b4d2bed
[4/5] pwm: atmel-tcb: Unroll atmel_tcb_pwm_set_polarity() into only caller
      commit: 9a6ac822a2153d583b0da95b8693e954b5f4203a
[5/5] pwm: atmel-tcb: Don't track polarity in driver data
      commit: 28a1dadc49e2902d0a7a2e8c699a15f93b1b6f40

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
