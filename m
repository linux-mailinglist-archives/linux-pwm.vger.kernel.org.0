Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE8E4580F7
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Nov 2021 00:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhKTXiJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Nov 2021 18:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhKTXiJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 20 Nov 2021 18:38:09 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11217C061574
        for <linux-pwm@vger.kernel.org>; Sat, 20 Nov 2021 15:35:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x6so47420992edr.5
        for <linux-pwm@vger.kernel.org>; Sat, 20 Nov 2021 15:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mHtQSj11k7VuMznmMKnh6/LXN6T5gxNJSVkExRwgo38=;
        b=oe+qY8jXhpFIPdIuJ46r8t+l4fXZVr0owy4RoE7UmfeBkCmHEoA/LR+ndZTf8j6deu
         ePM1fwDP/rNWpq4GX2SkJ31SHFRMClOgEoNxqpy9osa+d8dUuC1v2B1x4im7yl/5svVs
         q14TxWiGUGeOJLfi1VuPP/uBIvcBZj7c9BLXMHI7Nn3UB2O74kVrok3XHP5GC2uACQfW
         3e66yqObqna4A5nGnHQ7TiK+tfG9l5hiifz2WsaoWEAgsxORUTRCz6lCikJG/M8jrzpB
         oEAQJJ2BA3rWLhRns9yylVjCIwUNsmPmB380jqArZ2YhLNewqF7toAoj3vMBQ4qf0/W3
         s2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mHtQSj11k7VuMznmMKnh6/LXN6T5gxNJSVkExRwgo38=;
        b=ZCQyNW5mJQZQSeNYcYdx6y3x7Som+5CbVTS77/iqGXF9D+QxiO99p6XmWusdwGiwIS
         0xtJ1XpPIwqawJ0j7SINV8dkEgFYHOzV7Fllqj+MaX2kZPDHTRBhTrGzuHYsOYkWUBgC
         tYA4Tg8siVNqS+53y4PjIn5ZmM5dgrXMZnBslZBqSerTISijGLQfKKbVxkA1x6ur67IQ
         bHb8kfCCp15DfYizMx6gfPlCUhR9TmjHSB6Kc6t2wYRiJOjfFUZEkmeQS0tDQzRTMvSK
         Suu+Xwcqnjnj0dOImmusir4/Uh4ktENgoGWNGl6V5hr9IM7sX50oJ5phlWmb67Vi9HwU
         6/wg==
X-Gm-Message-State: AOAM532DUSQYFOgj7Y5wpqieZq2seURpZVptqLeB8xAxB4j4RONuxAsC
        r2+JA63SB1qkmwmnI0NYWJsTpywWoQRqUrpRh1o=
X-Google-Smtp-Source: ABdhPJwK9QpyBEvxzH8bMLZpZxGHDV7efAgsJ1o6DA+L2b42i+vMvbry3bEUxaeBSfdJk9prfR5Or5JegRPUH7AdiBs=
X-Received: by 2002:a50:da0a:: with SMTP id z10mr43945848edj.298.1637451303501;
 Sat, 20 Nov 2021 15:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20211108134628.120474-1-u.kleine-koenig@pengutronix.de> <20211108134628.120474-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211108134628.120474-2-u.kleine-koenig@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 21 Nov 2021 00:34:52 +0100
Message-ID: <CAFBinCBcS=MC_cZQVPBYzFGKmfjpkBKKDO7sa+Yeb8pUzB-O9g@mail.gmail.com>
Subject: Re: [PATCH 2/4] pwm: meson: Drop useless check for channel data being NULL
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 8, 2021 at 2:46 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> In meson_pwm_free() the function pwm_get_chip_data() always returns a
> non-NULL pointer because it's only called when the request callback
> succeeded and this callback calls pwm_set_chip_data() in this case.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
