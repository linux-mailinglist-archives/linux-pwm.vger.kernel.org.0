Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1B2D293F
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 11:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgLHKwC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 05:52:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38656 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgLHKwC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 05:52:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id w13so9679376lfd.5
        for <linux-pwm@vger.kernel.org>; Tue, 08 Dec 2020 02:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GJIypj7aFv+EkGs5X79db2AgKKCjUhxQkXJzRHihlW4=;
        b=KXm8fix00uqPfGJ+tAdHns/wQJjcB+UiTso57/xB+V0rUVvbwxFD4B403mHmlf0HsS
         rJsJH7Q5/dA65vIJY12SLVorPYMMNn54ubi6JHSkysFxC/vpixgQcE+aKbvd4KWQXiSw
         Tnm+GPwSPACVyvi8A/G2wj0DalRlGIfBXelXsLcI3ghLjdoNEnp3Xt/psSJNKepWg1xa
         MIX1VhsemLHLGBE04Ex7E6P9XPJHDswFaYcxRQMfx/xfrNjP/C0wqeMSRsgk+/8eKBwB
         mAV/NcdqO+p8Ps09vPsBAydtMmoR7tHW+Ywbd02GKBg/xbpYDgkABy9xQ7B5J/Xdpo96
         AsUw==
X-Gm-Message-State: AOAM533k4Hwmi/jKMMO976EGVFF+TVgJ6aRkK3cuk726s7Qduf4ecM2I
        gc4c17W9mf7zwcAAkjYSDLQ=
X-Google-Smtp-Source: ABdhPJye8l8gwL4nXPcg3I4TNDJMJmiNV8b8jOOn38pTD8/MkgrkrpCw2W4bZFxmsVA5YkOvDRpVEg==
X-Received: by 2002:a19:2489:: with SMTP id k131mr3604491lfk.236.1607424680466;
        Tue, 08 Dec 2020 02:51:20 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n10sm1161481ljg.139.2020.12.08.02.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 02:51:19 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kmab6-00038e-VF; Tue, 08 Dec 2020 11:51:57 +0100
Date:   Tue, 8 Dec 2020 11:51:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v2] staging: greybus: Add TODO item about modernizing the
 pwm code
Message-ID: <X89azMazQfKZCKwm@localhost>
References: <20201208101607.42785-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201208101607.42785-1-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Dec 08, 2020 at 11:16:07AM +0100, Uwe Kleine-König wrote:
> drivers/staging/greybus/pwm.c uses the old style PWM callbacks, new drivers
> should stick to the atomic API instead.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
> On 12/8/20 10:39 AM, Johan Hovold wrote:
> > No sign off?
> > 
> > Please also add a staging prefix since this part of greybus still lives
> > there.
> 
> That after all these years I still fail occasionally to add a sign-off
> ... /me shakes his head about himself.

**it happens. :)

> Anyhow, here comes a v2, also with the requested prefix.

Thanks.

Acked-by: Johan Hovold <johan@kernel.org>

Johan
