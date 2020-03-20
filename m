Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1246918D543
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2020 18:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCTRDJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Mar 2020 13:03:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:52025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgCTRDH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Mar 2020 13:03:07 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MAfQe-1j8iHa0k1o-00B0qA; Fri, 20 Mar 2020 18:03:06 +0100
Received: by mail-lf1-f44.google.com with SMTP id i1so4418254lfo.1;
        Fri, 20 Mar 2020 10:03:06 -0700 (PDT)
X-Gm-Message-State: ANhLgQ39zmuHYftErsjSRWWEYfv4e3Y18Djyduf8JnpdTbD6ABxfD164
        rIEGucIGWlDb7Ywp3SItWZzsVwLRDzubBGNIx5I=
X-Google-Smtp-Source: ADFU+vtGM1BAWj/ypTGImtaXGVhgdztgWM/eg3xxnSs7xp+2vbgGEFrzZEo8G63MzFh8mtaYi7v6nQ6u9eton4GUQoQ=
X-Received: by 2002:a05:6512:31d6:: with SMTP id j22mr5942299lfe.173.1584723785648;
 Fri, 20 Mar 2020 10:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584667964.git.gurus@codeaurora.org> <a1942f735fa4d3eb71546a3f07d9b5e78fd7919a.1584667964.git.gurus@codeaurora.org>
In-Reply-To: <a1942f735fa4d3eb71546a3f07d9b5e78fd7919a.1584667964.git.gurus@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Mar 2020 18:02:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2fdx55uNPqYxbVhUJZS2hBsCcr4u0i9dmoDkrdjVOMeA@mail.gmail.com>
Message-ID: <CAK8P3a2fdx55uNPqYxbVhUJZS2hBsCcr4u0i9dmoDkrdjVOMeA@mail.gmail.com>
Subject: Re: [PATCH v11 09/12] pwm: sun4i: Use 64-bit division function
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Nb6zGbGXVPUdXGZzWjYWmcJR/59MVZDu4HG9LMi7gpxV7FvhykF
 EIig5FCkaFNzfVBBDGlmta8ONjDB5N3X6eHZsXK1YPBzM16+tkapau27BqtXyxhC5bZgx73
 OxZntrLDjCzYHs0ps6NgwRWRyXQW7sTTkNEwhyMLAdC8CE7O0cEZxqvRadZnXOC2c1aJC10
 PadC2EOV2YdcPPR8Hz9Yg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E0uWrkMpb54=:nc5WrO/vT4gO4OFSvUZK36
 DP9MCrcPUvnQz+ckdsv6FRhFDCB5TnRwM3IBQsKeFQlWXaTQp6JbyFzzoZpPNiUoz4j/jp7xt
 PbBNxu5r8QbVzJFy+GERCtM5QRUpbcjsJyx9DDwfalv1CJAweapUAAzi+CkJLrxS9d1yV0eHU
 LmVTBHTa9SRjDuTZAyE/GyyTjI3QlCkgI2ncrUxtpmFw2wdMMZ0wtoGxTpsCRcuvvnpdVPOzV
 jIrWLt5XlAETXbasomunwH7O3bVqdfOs76DcBLZMVkhpS7HIf3dsUI2d9tTxhwUNFpYo04ODw
 vUuEepMSEsmw8FAHpGK9BYrvIRphRzX7+Ek4fK0UEONY2m5cED19w0jeBa/5vydW8U+kEcXl5
 56WnNAe/kHiiYsil8qubIfnOyrCYI9++mdJZ3dwNiVK+spafWaRR7xutGHIaf2LG9JonwBgHw
 yvDplf7Eu8QAfqJ+McEk11hIPgdcn+E2lfwkU9JdDJQ5sGYoJpD9vBWeaCbRDpbiygmSvyCsg
 P7mZqBIolIt5DF6jKZEgUA4XZuC6vZrK2rVtQ1WFWdjqkYHFOM2M9O90nRHFz2pbODSrJE9R/
 JKAikMbQYUnHamr+kTaly/6vYOcC/t2zRurmru+pIL8WvNVnRdKjN/sXheVmPP+09fSBMgCRI
 vuW4I2D5sH5uaiYfViKAC4A8ZXrihtGhyq5F4hy8MUC5tkV5fUqxTe0597E8LEyGr2OnifJdI
 PHKeIt2zBRJWLuNFU4Xthb/t4OLr1uD9kjnVu4Fn2f4rlgIV6azKa7bpiVIJrYU5Q7f6e9AZV
 fAxEC5VYXxEbGBrL1y6gaOo1+VLiAdeU5D0ItQLMLMWjNYSs+0=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>         sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
> -               usecs_to_jiffies(cstate.period / 1000 + 1);
> +               usecs_to_jiffies(div_u64(cstate.period, 1000) + 1);
>         sun4i_pwm->needs_delay[pwm->hwpwm] = true;
>

This one looks like it should use nsecs_to_jiffies(cstate.period) to avoid
having two 64-bit divisions.

       Arnd
