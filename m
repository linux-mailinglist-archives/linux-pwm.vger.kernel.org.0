Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E47D36FDC2
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Apr 2021 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhD3P2r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Apr 2021 11:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhD3P2r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Apr 2021 11:28:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47DEC06174A
        for <linux-pwm@vger.kernel.org>; Fri, 30 Apr 2021 08:27:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n2so17847360wrm.0
        for <linux-pwm@vger.kernel.org>; Fri, 30 Apr 2021 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=pMApo/Ws+UN1eYyEWGiCVA7HjUi3e6iQkzDy0eFDh34=;
        b=YBR4rv+8dFP75XyIMQ/wxcwAQwQq6QNeZNTA7qbHp5HXiG1hjqAVxEnwf2jvxmjPhj
         rmpwhMJ6DzaHJV5pPqjiiQ86GlJc+blMN9RxGf4mZYj9h/CSJHE8mVa6RVgErB5TLTjm
         4DNiuuf6t0PFqdNuam8dVLJiB/aDBxA4EnxpFhiijaiK3XgR1EPAbn43hZ2eFoOUvrv/
         j9hm5PUU+PsYTv7JvyvKLu9Kw2w3dpjLHvmijPS7BdVpRVOjoYUikRoAJcZk9gT+962F
         Vt9MgqJD0K5HsTUQJcDccnBlPsEi9x4dUTScMtYxSTHwJhgwgLLrXmxO/oOoGw6x2qFz
         DpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=pMApo/Ws+UN1eYyEWGiCVA7HjUi3e6iQkzDy0eFDh34=;
        b=TlY9WixkzfJ46gMO7eSdApz4Sr8BwqZg542yOOHabfxGdXl3rTYldMhsUPU0cJ3gv0
         N971pPw301FOfKouIHsEYaxDOn5cBvtNWvFnzW2tuVNe0X1DWIcV/L4+XxfbgG0y/zHC
         a87WImDjZB/1ueh+kMlM1bR+qozXvl3HnHYQGmdYZ+SxF3Jhz/JZ4+BhamxFCmodxbD1
         uiP//yl+utU9DC46l1n7YraNZIzoTzqGWcPAJkXv+TKTqxYPyVlECZ1R0bq40OuRnWmW
         laicFk5uQF5XcRhxZB1XvBIHeAx+vHoe+VNQZ+McjxzNeFv/yv+jUAtPmZULfjhHn044
         pdOg==
X-Gm-Message-State: AOAM533Ceb/jfSQA39MZqEcLRe8QCtOUE7xWrj1CwjfnpBL6vhdPYdSZ
        sll1CCRp586J+yPavmDXroUkNA==
X-Google-Smtp-Source: ABdhPJzxNJzJDEYUA6buYFcK0rLmg2zLAajIydPXtQj8HZE5OYh1uZ/kqvsPLjBuNZN4rI/i15UA6Q==
X-Received: by 2002:a5d:4308:: with SMTP id h8mr7439039wrq.371.1619796476474;
        Fri, 30 Apr 2021 08:27:56 -0700 (PDT)
Received: from localhost (ip-89-102-194-33.net.upcbroadband.cz. [89.102.194.33])
        by smtp.gmail.com with ESMTPSA id m14sm3379827wmi.39.2021.04.30.08.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 08:27:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Thierry Reding" <thierry.reding@gmail.com>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@siol.net>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-sunxi@googlegroups.com>,
        "Roman Beranek" <roman.beranek@prusa3d.com>
Subject: Re: [PATCH] pwm: sun4i: Round delay time up to a nearest jiffy
From:   "Roman Beranek" <roman.beranek@prusa3d.cz>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date:   Fri, 30 Apr 2021 17:10:03 +0200
Message-Id: <CB15JRQIWROB.2MRNYCPGI20C6@zen.local>
In-Reply-To: <20210430095101.rjkdukf67h2k4iea@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

On Fri Apr 30, 2021 at 11:51 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> If you agree that dropping both delay and clk_disable completely is the
> right thing, you address both problems and going forward with your patch
> isn't sensible.

I had my doubts whether simply clearing the PWMx_EN bit would be enough
to turn the PWM off but I stand corrected. It does work.

The added bonusu is that once without the invocations of {u,m}sleep and
clk_{enable_,disable_un}prepare, the sun4i_pwm_apply function finally
becomes safe for running in an atomic context.

I will therefore prepare a new patch and come back some time next week.

Have a great weekend,
Roman
