Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD737B596
	for <lists+linux-pwm@lfdr.de>; Wed, 12 May 2021 07:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhELFsi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 01:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELFsi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 01:48:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B326CC061574
        for <linux-pwm@vger.kernel.org>; Tue, 11 May 2021 22:47:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g14so25604718edy.6
        for <linux-pwm@vger.kernel.org>; Tue, 11 May 2021 22:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=vbFsoh9ohEb7zIVWzV5ptiOiSycRks0c/6rvERhMVHc=;
        b=X7z5/Q1J6VgjxQXIPRS4M7F8EB971FbvpD6spXEJPRMIV094dHGOUwj2QtHG04F4xE
         VQ6rSu2guj5N278pG+aqYjl5C+hgxstxPuRUlVfHscWoxoGzPnD4I3r0xrvbz+t0H3Hf
         gTc8xaEKMFC0yymEVeRpCOt+CF9T2IVUnHPui8cBKJrCz99uamFGuFcrG3iXsjdMfBoh
         RmmWdw7/cMp0kRpWPgTaENwBoJPdTPrpophFfeUqRrbvnNgm0W/qeKdlNrw3+fndHOt1
         jyS9QIox54zKW0kGkqQMaJKtjZRFv4P/w5dBXdzpBEGkXQomozl7KMuo1RIHTddhcPVd
         ev1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=vbFsoh9ohEb7zIVWzV5ptiOiSycRks0c/6rvERhMVHc=;
        b=bbuqDrpBQ21te5ZunefvZGil9Yk7cpXF1F487jGvyeFS5cpy1yPigPP6JFqM0dRMsp
         yhLACh8/yFWBSJhQHleMMUI2QmnY/VYF2obQopw6ppTEQ+SS6P3ehIMnpV+GlNrvsh1p
         ZQfFzjf/7yI/eqFVFYZboT4qPmdDbc5/6odLwlFy8OXijcolMY+STRck+DcBO4G6guw1
         gvCKmA9nhz4YWUvhxSnBTBa82xGhn9tdY9wzriEiKb2S1NuN1oEuhMUO8o5inaVK/Byp
         fQnRCYRWhCfiNe15Fz+Yn6aFahcrG0M4bJ0wVvTDB5Nkdd8lzbZU/gFbbo0ydMQXQVTq
         IWlw==
X-Gm-Message-State: AOAM530PmMY+BY++Um4cw7Fx6odSQG+51PY4qVNmYn2a08kRd/hf3H+n
        TN7bqrD/EM4N3XW766phfzymzJJ89mmrUmYqtyU=
X-Google-Smtp-Source: ABdhPJx672mmykcbTexM9EAbZb31PEj0Rgd48inNYK/ucSswpGdvEzIdldedEHafGcqcqaChx4r5OQ==
X-Received: by 2002:a05:6402:2050:: with SMTP id bc16mr40819009edb.179.1620798448337;
        Tue, 11 May 2021 22:47:28 -0700 (PDT)
Received: from localhost (ip-89-102-194-33.net.upcbroadband.cz. [89.102.194.33])
        by smtp.gmail.com with ESMTPSA id r17sm16639423edt.33.2021.05.11.22.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 22:47:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Chen-Yu Tsai" <wens@csie.org>, <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-sunxi@googlegroups.com>,
        "Roman Beranek" <roman.beranek@prusa3d.com>
Subject: Re: [PATCH] pwm: sun4i: Avoid waiting until the next period
From:   "Roman Beranek" <roman.beranek@prusa3d.cz>
To:     "Emil Lenngren" <emil.lenngren@gmail.com>
Date:   Wed, 12 May 2021 07:31:10 +0200
Message-Id: <CBB0R32KLDNX.1JIF8XT3UECRZ@zen.local>
In-Reply-To: <CAO1O6seU7t==O=yCVBQK0iAkeEyO3dbRQ71obJh3Jm26xxWobw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed May 12, 2021 at 2:55 AM CEST, Emil Lenngren wrote:
> By closing the gate when the pwm should be disabled, I guess we could
> save some nanoampere or microampere (is this important?)

Or perhaps I could add suspend/resume ops and have the gate closed for
disabled channels after a fixed-duration delay of 2 cycles * 72k prsclr
(6 ms) until the system is resumed?

Cheers,
Roman
