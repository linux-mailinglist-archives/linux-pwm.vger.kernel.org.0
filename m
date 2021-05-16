Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748B938201A
	for <lists+linux-pwm@lfdr.de>; Sun, 16 May 2021 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhEPRBt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 May 2021 13:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEPRBs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 16 May 2021 13:01:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3120C061573
        for <linux-pwm@vger.kernel.org>; Sun, 16 May 2021 10:00:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z12so4278329ejw.0
        for <linux-pwm@vger.kernel.org>; Sun, 16 May 2021 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OacnSilRwRDmiHxH7ZyZ6MmTG6nUv/il1KgBvxYRXc8=;
        b=BtfhbgF0TY5Q5SPdAz7xga7SYJ0DMzDKYJYDfVeetBwEnYrHZ3FkK2rZ3YV0lHdVn1
         NpZH7Fv7P5nnGo0+wo2z5Ug25DiyigengSYjLh4P8ogSUIlmCi4G/TAyu+Vuq6d040Jm
         q+eU1FIKk1mlQ8OYao4qaUk/NMSoHOVnzZZVTSahdZw/sOuS6lJphJgYA4IcJq7NdRjO
         vcqzOiIH8bEF/vWd8SpYDuJSGC/G8DKaebcEv62NfjOiGAFwCRQLmCvHTiPgqRxUAzBA
         7Tn3r7EUc2BYrs4MqWElN6BJTNGutwdQIxbS+jDdeXaWVZLXM3xTbE2lAkUohhLmDT6d
         xaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OacnSilRwRDmiHxH7ZyZ6MmTG6nUv/il1KgBvxYRXc8=;
        b=Ni4fJwpea/U7rqxfhWpandPwQaCTHte843ipi9mQQhEx0RpjcpqQ0msEzKXREj5RBm
         FgyZHAACLFs9UzruGqbc+4NEp1P8Tq8pkhNzQW5JgKj8cJ719M+2GJSDldbfM5dhfoaj
         9x2qkzcG4xldwAr5ZU2355pNpC+x9NLHI9Znzgz8xO83rtVGxuF7pXEG/fpA6lEtAlIJ
         KwXM4vwTc0lApZwWHIcEXVqYxIqO1ypvYX+OOU0DmrZLorxswi1fNMaSvN48iqppnqgm
         dBIaeyFz1tGmwNP+Yatz8t5kkzkefN2k4dgNl6pEpsR8NBriKgWH8x5EAgnuGTKpVXsf
         z/8g==
X-Gm-Message-State: AOAM5306QenU1FQR9a+iozK8JGeIXj08T1CA2RZUWtFWs+PoZclRQY+w
        xAV5i4299vNCjoo2jtNleHCQsMiH/x10djSCbtI=
X-Google-Smtp-Source: ABdhPJz0lFd8wY1CmZVADqXS4+E9OuaAfRQVnBqcZUFGvxtc0RHRhwjYR2FhBcVzL1RyVSPFzMImLMy5I3hdOMMMTjk=
X-Received: by 2002:a17:906:f256:: with SMTP id gy22mr21412629ejb.537.1621184431551;
 Sun, 16 May 2021 10:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <CABgxDoJbnFb+=oSMNrhbBGbFCRZWBQ54Dkyy02YnYm5bveD4gA@mail.gmail.com>
 <20210510190924.990912-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210510190924.990912-1-u.kleine-koenig@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 16 May 2021 19:00:20 +0200
Message-ID: <CAFBinCAY21Y-zQGC-Un=e82VK9bGuFc+cDAxjSkJjm8E5sEQcw@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: meson: Simplify using devm_pwmchip_add
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, May 10, 2021 at 9:09 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
>  drivers/pwm/pwm-meson.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
I'd say your patch achieves it's goal by re-using more code instead of
duplicating it across drivers
Thanks for working on this!


Best regards,
Martin
