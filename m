Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98A3A5DB6
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Jun 2021 09:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhFNHdN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Jun 2021 03:33:13 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:56169 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhFNHdM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Jun 2021 03:33:12 -0400
Received: by mail-wm1-f43.google.com with SMTP id g204so11481186wmf.5;
        Mon, 14 Jun 2021 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ETABA9jx0BN9sK74+u7FDNgO87mcXSRwrOssxg2Cmps=;
        b=ndHe4WYVyX4v6nhsQbu5ZTb0HoWPN+CcX2A9ftYfr+C5OJdHOt4L6qyp1FXgHRV3xG
         WSBLm0Nh/c+JgjN4aTxqHlue44WAcUhIMXp7PbQgPI0YAkyMFE2j++jBOm5TmZ3uYuw8
         jCYpCYHwHk67PaxD2T+Yh4bUpgP5+tMtrCc5R7cUC27GNEJM+Qh1vVMwtTcG0xJQA29N
         Q1TqqP0eYgg64bXQ3f3S30w8CUmQ05SieM/eQlQke1K7OxPtu9QLXbz9MwdCaBMMyjxG
         DcMjEsb4PSW0OqcOnDEIzL00d1uCS3V0h5oSqPlbQgMOtrquKlVAI1hs5KPj3ygQYaem
         ThrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ETABA9jx0BN9sK74+u7FDNgO87mcXSRwrOssxg2Cmps=;
        b=BzqcJyBR49qUmnijnOlAXU+rXAuxrTHLMELEpWWTvozzkKc01STOVlk6dGsoA5u4be
         FFvWslunprCSlbNxoCvxb+nx/DyVaoJjHFrSAa2fqCgQhF+MI2N6/bDO9Nu3Dj8sMYDO
         9Fk7bzsQsj/XRsoJ5jJz7fx4P/iWH+QuUFw2mA2jl/esltM8mO6eV+nY4cdstEpw1I0p
         IKK3BAxGoa9FnxrQalCleF5uS9VOA+YEHDtItGtKBYbAE1qgX11jEzeLAO8E2YcdfH2V
         mcrBvJ/pMmrTYKwspeIx/N2j2awmVQgyoeDKsEAK9Qq9LCuo2zCWloCHTlJyGhuu5lWL
         9RQg==
X-Gm-Message-State: AOAM5316r1am1nmsiBiHMtk7jLl3Ive5yr7tOrUKxh71NuIFnol+Vux5
        vaG4jERCfWABcsuZ5fU/0RikV/V0Bku0Aw==
X-Google-Smtp-Source: ABdhPJyYbSRKCCp6su+USg6Cf9HNE8y5Y5xQ4p5oD6WkqeX5BSosKGlLy/YbTbvCoFtLPeswcCZS5w==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr14888354wmh.151.1623655809582;
        Mon, 14 Jun 2021 00:30:09 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id l13sm15962340wrz.34.2021.06.14.00.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 00:30:09 -0700 (PDT)
Message-ID: <abf0b0cb8299f820be0d1ee32f445a956abf1202.camel@gmail.com>
Subject: Re: [PATCH 7/7] pwm: ep93xx: Prepare clock before using it
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Date:   Mon, 14 Jun 2021 09:30:08 +0200
In-Reply-To: <20210614072222.wgivnzbaekxxw7qu@pengutronix.de>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
         <20210613233041.128961-8-alexander.sverdlin@gmail.com>
         <20210614072222.wgivnzbaekxxw7qu@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe!

On Mon, 2021-06-14 at 09:22 +0200, Uwe Kleine-König wrote:
> > Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> > to Common Clock Framework.
> > 
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> 
> Maybe it would make sense to move the prepare into the probe function?!

If one thinks about real meaningful clk_prepare(), not like in EP93xx,
then clk_is_enabled_when_prepared() shall be considered and this might
change behaviour. That's why this "stupid" approach was chosen for this
conversion. Also, unfortunately, I don't have a test setup for PWM, this
made me shy towards this driver ;)

-- 
Alexander Sverdlin.


