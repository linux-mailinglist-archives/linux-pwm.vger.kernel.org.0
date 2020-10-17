Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A312912B7
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Oct 2020 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438564AbgJQPhf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Oct 2020 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438537AbgJQPhe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Oct 2020 11:37:34 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F08C061755;
        Sat, 17 Oct 2020 08:37:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id x1so5800892eds.1;
        Sat, 17 Oct 2020 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQkFgb2at5XX74ydv4VjHo8w1oRnKOQDiok7ZsAWiqM=;
        b=CuITXGOuOk7OZjR2rZbBaP/jwnrwUtUd51gdbR1+xgbMe8RGAXrzVNqLyTUK6P8F8V
         QrRj/PARpzlJHDT3BQqBVrti0p95/dNrDPs3+fWv3tgHkzpbSxc048iCxr1MOojC4CmH
         o0MD/udpSOvMTgFJFnlUis+Dt0nOO/8kNssIslwI40Z+viFXsFSXR/DcJyuDU+K8Yjn0
         prAE/Bp6htEkJhKi1SyQVeNDyvl74OiDb2lChecChoC1sBxT7k1ekfBeJ3mywB+xwCT1
         E8pWBNSQ0LpvGuly2FOyXmjShwv9OX3yiBTowpY5bng1W7upgCYYsiECs4oTJEnm+sha
         hOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQkFgb2at5XX74ydv4VjHo8w1oRnKOQDiok7ZsAWiqM=;
        b=mzPPW2vNivFo0SlJK7/MCYS8OMe1sDYA02Yim7f7Ps1Mkg6CqRXhrb4RiQcqv3VAJU
         kjwMAF5x9Oa8JOvah1TPvQP82w8x+qMbwPXEzYEwePUAwlj3jQ2HJJ89K8+s6tHhOjfE
         MSM+CXW+yWlQ+11FvdJR3Ti+QcYYB57BhDxuZKebv2PShalIvqhCyq10Pga2Y4zSc64X
         NzbXfZSaak0aDfg1/mGk9sr4gZ+vtWIJhUPZzWCnwXzsCtq3en5z5SIW2s52YPgqYYTj
         oEoo3We+T6xbgdOd40I/EujY+uRFWzk/h6QERgztmJNBzYQdLJqKTl3WIaiYagsg96x4
         esbw==
X-Gm-Message-State: AOAM532+hcgCCC/PHlVyXRZiq8ek4r1UfcKtUyZY91YqiwbtRsxDj/0P
        HO3YsEyh0htDmCYRtpO3iRffXErWkWmFnUfuDE0=
X-Google-Smtp-Source: ABdhPJyHIFy5iAirn/imRaafnNzuSVWLawglsHrGzHkF1B4dulJUWuaSiY/qz4gAnb5Xxt5R6Yv0eQm5Dz3AqMDtATE=
X-Received: by 2002:a50:fc09:: with SMTP id i9mr10162891edr.3.1602949052008;
 Sat, 17 Oct 2020 08:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201017052057.2698588-1-bjorn.andersson@linaro.org> <20201017052057.2698588-3-bjorn.andersson@linaro.org>
In-Reply-To: <20201017052057.2698588-3-bjorn.andersson@linaro.org>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Sat, 17 Oct 2020 17:37:20 +0200
Message-ID: <CADQ2G_Exk7+uXMcoyFu-VOcSf48Qjvg9KUCm0P6yXdQn8K_3wQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With the changes done to in V5 i have nothing to add.
