Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E065DA3D14
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Aug 2019 19:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfH3Rjb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Aug 2019 13:39:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38825 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfH3Rjb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Aug 2019 13:39:31 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so15690747iog.5
        for <linux-pwm@vger.kernel.org>; Fri, 30 Aug 2019 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=47tlWRLNKtj5MR91kGpu5smjeLymr++ZvcjSqhRL9xQ=;
        b=IPKx/3JEZ5V7Zy0ANXfTidU7rnyx4RWn0FcNVp/C9l0DJIoJBM3ASstr5m+MHb5w8g
         cJu96elID8dyHtruySXwxNbM9T6+2glSq3lNsvDHUE2xmdpCAWsZgmyeHaxGEGSurZbX
         MH/GzcGg7yP0B79Zqi9hetJn/P2H8dj7eW5V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=47tlWRLNKtj5MR91kGpu5smjeLymr++ZvcjSqhRL9xQ=;
        b=c8AG163ke9DHtqLyUFWk71E87obOiTRUIVZ/BVnlIUttce16vAniZvgGxsFsFcp9bs
         sgNjx9YIlIuvioKHoQ4v2IWEKPCHHAdnP8IhCD1JkkaH8FuKxIo9tsGixLTcew+X297x
         nxkZ+ndiPYA59aj4/RgsGZFq3KMjQkBYV6sUk7IbUz2FwbpHV/pusBZV9SvpVXwAQc/y
         jKidS/lQywH5bP1pp27rIK8UAVB42g1fXZ10zdVJtdi5jc+rTzXoDL/HsMbd5d8FqBk9
         g4omUr5zIG/VYSA571I9nzFhI40gUrEJE260NCF0DXpDMZ8KuULIAZx1xHv1snvCf1tb
         kQNQ==
X-Gm-Message-State: APjAAAVS+fOSj28wLVrP0qZpJdqmGgTt+2mv49jDvtrXviTeSKyBl0N2
        inLRq5d5XPfx25S1gz6U9H5JIznBm6c=
X-Google-Smtp-Source: APXvYqyXm4BJGJSvPK1v5i+pN+9EnuWy+4Uu8tTFpTaLdiAdGS4wvewLqEGjqzkV0iOBzPA3JhfU/Q==
X-Received: by 2002:a02:ca0c:: with SMTP id i12mr1653483jak.82.1567186770523;
        Fri, 30 Aug 2019 10:39:30 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id v13sm7671025iol.60.2019.08.30.10.39.29
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 10:39:29 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id b10so15724599ioj.2
        for <linux-pwm@vger.kernel.org>; Fri, 30 Aug 2019 10:39:29 -0700 (PDT)
X-Received: by 2002:a02:a1c7:: with SMTP id o7mr18093414jah.26.1567186769165;
 Fri, 30 Aug 2019 10:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190824153707.13746-1-uwe@kleine-koenig.org> <20190824153707.13746-6-uwe@kleine-koenig.org>
In-Reply-To: <20190824153707.13746-6-uwe@kleine-koenig.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Aug 2019 10:39:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8kVU_zr69aKe-+GkAQh-tDwVf8tFogKve3s5O5ndF-g@mail.gmail.com>
Message-ID: <CAD=FV=X8kVU_zr69aKe-+GkAQh-tDwVf8tFogKve3s5O5ndF-g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] pwm: fsl-ftm: Don't update the state for the
 caller of pwm_apply_state()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Sat, Aug 24, 2019 at 8:37 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
>
> The pwm-fsl-ftm driver is one of only three PWM drivers which updates
> the state for the caller of pwm_apply_state(). This might have
> surprising results if the caller reuses the values expecting them to
> still represent the same state.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 4 ----
>  1 file changed, 4 deletions(-)

Presumably this patch could break something since the pwm-fsl-ftm
driver doesn't appear to implement the get_state() function.  ...or
did I miss it?

-Doug
