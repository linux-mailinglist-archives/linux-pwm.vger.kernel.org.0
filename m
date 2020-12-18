Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938462DEA4C
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Dec 2020 21:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbgLRUgK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Dec 2020 15:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbgLRUgJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Dec 2020 15:36:09 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4B9C0617B0
        for <linux-pwm@vger.kernel.org>; Fri, 18 Dec 2020 12:35:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o19so8723577lfo.1
        for <linux-pwm@vger.kernel.org>; Fri, 18 Dec 2020 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gG6mCf6v7fYse6hOM6yE0JGOuHH0YNhZes9w/QL8tHw=;
        b=R3yzZrDSS0+vsgCuyTFWk6wTgJpFZggaojIhJX0VVtDxhasYavTkCQlwRa17W1GYPP
         e9OjN5qMJVFNfgasUGbAsg3PkiGWvKPrNU+L7jzOl3Jc0twhpVEz+uiKveRA+lc1uk1+
         tyHneDCy3wmIUha5NS4t8V505z4KeIu42wQ8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gG6mCf6v7fYse6hOM6yE0JGOuHH0YNhZes9w/QL8tHw=;
        b=jkZFo+b1e7vu9z9PYtsHCyoXNHKxfzTJgqo0WbTQZscVR4zl0e7/7b2JUAFpwnz2ue
         dKt4wn9tzzaKlI6Oer+0ePlrZAbZjjgAXcvmdJv8NVs4tZmyDiICcex8YV+sOFaxQQgk
         FHYpThbgve7Is2zEaBlSsRIB6M6SV0R0qy8NOpR1aslfMXuq1/aIeK64QqMf6CDYuVzn
         RW6a6t1wxGgNg4+9gBW3adM5rYb7koR5Aem/sWcYlhjTT6yxJ2ziX88T7+Bs7HcdKkL8
         /ZFyB32BjYmZwlMxFybc+wz2QbyP8pRYSOBPfK6JL8EQUaWmKlqomY41NwlweDdt/xw9
         TI1A==
X-Gm-Message-State: AOAM5309hCgshAd30y9dfXYDiK/xHdKj8VgzK5MJT/a1MThNmKR85l0y
        279fh91mK/P7b39vyDxDsYpqnebYwtxEAA==
X-Google-Smtp-Source: ABdhPJy/mHLef9O433HYRRFK5lM6GIDiKhJ5P7nDLB+pXtnn9/xOssqrpOG/Jqu3yEDspvAtL1T8lQ==
X-Received: by 2002:a19:a405:: with SMTP id q5mr2246445lfc.503.1608323727220;
        Fri, 18 Dec 2020 12:35:27 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y124sm1034727lff.104.2020.12.18.12.35.25
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 12:35:25 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id x20so8586690lfe.12
        for <linux-pwm@vger.kernel.org>; Fri, 18 Dec 2020 12:35:25 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr1995208lfr.487.1608323724985;
 Fri, 18 Dec 2020 12:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20201218160401.2478999-1-thierry.reding@gmail.com>
In-Reply-To: <20201218160401.2478999-1-thierry.reding@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Dec 2020 12:35:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfVj3n5qftaLwk3ZiMiKooO-vzk_XHbcRKPCpBWbtq7w@mail.gmail.com>
Message-ID: <CAHk-=wgfVj3n5qftaLwk3ZiMiKooO-vzk_XHbcRKPCpBWbtq7w@mail.gmail.com>
Subject: Re: [GIT PULL] pwm: Changes for v5.11-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Dec 18, 2020 at 8:04 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> This is a fairly big release cycle from the PWM framework's point of
> view.

Why does all of this have commit dates from the last day?

It clearly cannot have been in linux-next in this form, at least.

I pulled and then unpulled. Don't send me stuff that hasn't been in
next without a _lot_ of explanations for why, most certainly not the
week before Christmas.

            Linus
