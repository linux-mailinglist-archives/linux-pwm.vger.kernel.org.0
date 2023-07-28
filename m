Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C03766594
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjG1HoX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjG1HoW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:44:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4F1B6
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:44:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5222bc91838so2421844a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690530260; x=1691135060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej7jACaNF/0vUYgAK86efdKzZ8v0cbf65iTBwlY3YJ8=;
        b=PO8CZFsMfuoDPNwfaIHNrJR1FsQummw4429pueoP6Jy3Xfwru7p07pdKlPeBtsLgQu
         tvqCk1DVGwvAijWefV4KpbHIJzmSs7u42Ua7E23fEFbflScg7LhHoIgDpjHgC/Ks9HVd
         gXyhABlEUyHIkv6Fr5boOogptVrclDAGj2WQT0RbzGQ0tgsrLGYBedfoRHidBoeevg1V
         7N+1WcMJbgxA9B1zTXlq+heNve3hprfqfauedjkWVoLaSpcpHtr2S4KpxnNrr/uW3r7v
         g+fUWxXUTI7ZeFzZ3BRW3XfpZwqxk+rIzgZsGxpTyD0lZSeo0NDTVzJmzPJK7OIaAHlH
         JVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530260; x=1691135060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ej7jACaNF/0vUYgAK86efdKzZ8v0cbf65iTBwlY3YJ8=;
        b=MdqjelhIdv7IIH/im6yPhlbLKrrCRSv9R5vYe/1FXcGkyOUXpIhKC/eVF0S9iszk/c
         p6C2035yQEBTVOGNClSq7QaWFeBBZKGRyYwdE4HTqicVBO6cSQUiSBgtCPBZJVYkd14o
         x6oWmYrsDVXsw18YbJbANY9pKQthGLtEU0/wfAA4XBUSEqFM4np612MWhGzBStohmjIJ
         d9NlNsGruFst/0JVu8gkGp22n5m1IN/nI72G9updcXXY3sP13PNdRcMWa38+9vlDIqRM
         FjC9Bje07l1NSWU0ldbdgKeW08v9+2dWhJMi7NRpGKO6C9/hrd98KK+mUqrOpx1CPBQY
         QeYA==
X-Gm-Message-State: ABy/qLZiWLEqG4xK9oyL4SIGtTtwOol8ebHhWupMcMLB0a4V4KPB7EAS
        nWDKxpFCzogsP+2pE+MYg58=
X-Google-Smtp-Source: APBJJlGeAVXmUlpplJD3DJpdoNjEDO77zC0X6M2wf/GGBqbIxr8MyC4IAfiVYgk8XHe+Su8CpjizvQ==
X-Received: by 2002:aa7:cd48:0:b0:522:4200:e20b with SMTP id v8-20020aa7cd48000000b005224200e20bmr1016426edw.36.1690530259782;
        Fri, 28 Jul 2023 00:44:19 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bf19-20020a0564021a5300b0051ded17b30bsm1491929edb.40.2023.07.28.00.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:44:19 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kenrel@pengutronix.de
Subject: Re: [PATCH] pwm: Fix order of freeing resources in pwmchip_remove()
Date:   Fri, 28 Jul 2023 09:44:13 +0200
Message-ID: <169053024121.3514419.8459300747105425734.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725081004.395798-1-u.kleine-koenig@pengutronix.de>
References: <20230725081004.395798-1-u.kleine-koenig@pengutronix.de>
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


On Tue, 25 Jul 2023 10:10:04 +0200, Uwe Kleine-König wrote:
> pwmchip_add() calls of_pwmchip_add() only after adding the chip to
> pwm_chips and releasing pwm_lock. So the proper order in
> pwmchip_remove() is to call of_pwmchip_remove() before taking the mutex
> and removing the chip from pwm_chips. This way pwmchip_remove() releases
> the resources in reverse order compared to pwmchip_add() requesting
> them.
> 
> [...]

Applied, thanks!

[1/1] pwm: Fix order of freeing resources in pwmchip_remove()
      commit: 86eed2a10304a9efe56c2b192b914b377cad260d

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
