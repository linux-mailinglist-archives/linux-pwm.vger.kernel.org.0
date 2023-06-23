Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E073BAB0
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jun 2023 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjFWOwE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Jun 2023 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjFWOv5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jun 2023 10:51:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6794E170E
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jun 2023 07:51:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so911867e87.2
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jun 2023 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531914; x=1690123914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUyn2on7g2gKchZ1a07mgt5yhl+cqGpXECdDvE6p/FI=;
        b=hc31moXGef362CCant2/PEepng6QGMt9NhQhIwim3ziG2hnToxuxn8eyCc8tm6Gx4l
         QBxAKAEhpF0S0lAO3cjTd+Gd9neOw1PUGEwogksaC9ub3N2hyrhjzTbTO5mM5MB+O86g
         vziYS+kPdY6iRlPK2vTj10ZArMMxGnvIIGGdm1y879SDfRx3UjrqRrLfZD0nElLopRDp
         tXCmvW/Q+v5bKHRXz99IMs1QCbB1uXOltpwnYVLBfCiI0DGj6LuUgqaQDl9u1FDK9FsV
         NVdQjDXwKOd4mPMLnqal/Vf+RyndsJvLkXYmew/VkhepgRhcUUfckU+rHlTgH6H5xpXS
         hhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531914; x=1690123914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUyn2on7g2gKchZ1a07mgt5yhl+cqGpXECdDvE6p/FI=;
        b=KX3NJMASR/IPYAN15JxGxQzBv3DvnbQEQ/Jk+0fxlbrjWIC1EIxJghQmwr9iCkv/bm
         hG2Polu0HS9abcYKYR5J28vL7+R7yzn+8IPLUiZ2+lT2kMv6z+q0xjwtx7aDsv3dEFl4
         TXZXA02bD4SAVD8d0B+nuh/ZAahOU74kBzAlYv1clfLxDohOugxWY0KTdb01W75OB1qW
         heyPwNb/KAV1HH/OIPIemaD+TfwPt/7RjyUnSOPpe2lD7BkAElfgfBpBUhkmgLs4YoYS
         lDyd7gwlWin33mK3o2SCFjyWzWXyl9KoAYKqgd7tDPyKCo2Ezz/hMpgIx0Xs3ppayTEH
         05SQ==
X-Gm-Message-State: AC+VfDyMLoB3la5WKEPCsksh0k1MpQHrAdNa18qZlY1Q65bGa0z8Cd23
        sO3gAskaJXuFaiW5Z3UCJ3obnG1TjHI=
X-Google-Smtp-Source: ACHHUZ67mc3LG2IFo//KskwVtu9WJRqlwgqCJ0EERUozMnCP/QgwG25jiNtxynU0Nj9m66qKEkVJQQ==
X-Received: by 2002:a05:6512:110a:b0:4f6:2b25:194e with SMTP id l10-20020a056512110a00b004f62b25194emr13260355lfg.58.1687531914038;
        Fri, 23 Jun 2023 07:51:54 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600012c800b0030ae4350212sm9740415wrx.66.2023.06.23.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:51:53 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     linux-pwm@vger.kernel.org, Marek Vasut <marex@denx.de>
Cc:     Brian Norris <briannorris@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] pwm: sysfs: Do not apply state to already disabled PWMs
Date:   Fri, 23 Jun 2023 16:51:37 +0200
Message-ID: <168753171966.1191890.1340898925923730605.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230512164736.53615-1-marex@denx.de>
References: <20230512164736.53615-1-marex@denx.de>
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


On Fri, 12 May 2023 18:47:36 +0200, Marek Vasut wrote:
> If the PWM is exported but not enabled, do not call pwm_class_apply_state().
> First of all, in this case, period may still be unconfigured and this would
> make pwm_class_apply_state() return -EINVAL, and then suspend would fail.
> Second, it makes little sense to apply state onto PWM that is not enabled
> before suspend.
> 
> Failing case:
> "
> $ echo 1 > /sys/class/pwm/pwmchip4/export
> $ echo mem > /sys/power/state
> ...
> pwm pwmchip4: PM: dpm_run_callback(): pwm_class_suspend+0x1/0xa8 returns -22
> pwm pwmchip4: PM: failed to suspend: error -22
> PM: Some devices failed to suspend, or early wake event detected
> "
> 
> [...]

Applied, thanks!

[1/1] pwm: sysfs: Do not apply state to already disabled PWMs
      commit: 38ba83598633373f47951384cfc389181c8d1bed

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
