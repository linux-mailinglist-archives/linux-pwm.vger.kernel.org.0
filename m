Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5186922D874
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Jul 2020 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgGYPbf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 Jul 2020 11:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYPbf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Jul 2020 11:31:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80FCC08C5C0;
        Sat, 25 Jul 2020 08:31:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g7so4587255ejw.12;
        Sat, 25 Jul 2020 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FR6Dp1DwruwS2azPHTv2qb7tleyh4uVI6t5Ki9azlJY=;
        b=AFUoYUJzlD0ujrfjmTQivGD3aK3f626Pvakeu4Sg3IfEIDnJ3m1LhvT5ayAJsphM/R
         UMIWUNDCVbfgcqbAB9VZkQRWnx35an9XabgBXSNB271/oeqjYBZiBmDOEDjEunw0+sjD
         C7mL43cwcaNnI+KaxNACIuCCaR1WlYOtbzc3LRXoiF/yOUtgEYmtFDbwa+oDSfvJZVJE
         9j6hS5oTB6WTCTBkXs5zWCT9tvr4jjBEVeNDSU2dPr+oaf/4PA58BM99374omurbdj3+
         nD9Aj5L7YTtcruqhFgN9b+E7XDDfoM9QJ2V2MixEbHeE8J8qQSmQGN33/7sP91maudu6
         OI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FR6Dp1DwruwS2azPHTv2qb7tleyh4uVI6t5Ki9azlJY=;
        b=Rl2sxRSnEVVQEC/t4J3YhqqRF8IeGm4CGVG47dU98M0r71uiLJyULgXc5DM8oV/2+o
         5EO03Q54sbN89ek0Hll6o4X5WyVvNRX9f1f2Yy/Y+luI3lNzNfl2qEdSg0nMKF4Fx78G
         l5fkZyoP9eB3xgBtHBSiYxtGiPtnS8JeBtLnYGkx8CqDmDlqO3VxsP6cBt5Su/Ug2XkP
         3A3rJhkT4O5Lv76CqW2drZV5n43+ibluDG18XB9jU1CpGhBw83BeNWqXu5S8nJj1pF5C
         plxIXvPBCbb4kx5nD56+BuNg7ww3dfRUHOe7NHwgmnNHyeYJqDaooj1EUvTLcLLdhnrO
         TCug==
X-Gm-Message-State: AOAM533vJJ9dsTe0DTmXueU0TODFlRKwtYvNxpyxsIklSE5L2UbUChRX
        PQ5O3xDU0lXbIj1uANc5H1rD9gjy6oNSdIlaYek=
X-Google-Smtp-Source: ABdhPJwodSebe7Q/3rJdh2eDl+klzcVBlt0lFi0R8BZlsZYXjCOayE3PYJWUPAE+Fd7Kn3lUrHABclLwiMNPZ+3blY4=
X-Received: by 2002:a17:906:f106:: with SMTP id gv6mr11788715ejb.221.1595691093472;
 Sat, 25 Jul 2020 08:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-3-martin.botka1@gmail.com> <CADQ2G_G7N_iH523urk3wOieZ0bT7O88Vnnbq6r_h9A4GLXQ5Nw@mail.gmail.com>
 <20200725152442.GA11424@duo.ucw.cz>
In-Reply-To: <20200725152442.GA11424@duo.ucw.cz>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Sat, 25 Jul 2020 17:30:57 +0200
Message-ID: <CADQ2G_FmvAS_fzDzENxgx+G0JUiktgRvKL=LLCc1cYE=nATUDw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] pwm: core: Add option to config PWM duty/period
 with u64 data length
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> +#include <linux/math64.h>
> -               gain_q23 = (gain_q23 * dmic->boost_gain) / 100;
> +               gain_q23 = div_u64(gain_q23 * dmic->boost_gain, 100);

Ok so using a macro.

Thank you.
