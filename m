Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37963189141
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 23:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQWWZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 18:22:25 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCQWWZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 18:22:25 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MGQSj-1j4C7m1XeH-00GsXo; Tue, 17 Mar 2020 23:22:23 +0100
Received: by mail-qk1-f176.google.com with SMTP id e11so35446552qkg.9;
        Tue, 17 Mar 2020 15:22:22 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3Z+cE2UlhegvMC+4op4TlWtons67C2+xtwMg4aYQr0b250oJE1
        VBtYzKtmIFh8+c44kefTCn1XtjTvokgfh1YJZJA=
X-Google-Smtp-Source: ADFU+vuxipXRJd9I8d072RV0faI/2rGMZOyH3YUhR2vlAYRex9FyUKKPvFQbFe6jrqVgUczzNOMVCwrC8sbHYMYQGws=
X-Received: by 2002:a37:6285:: with SMTP id w127mr1193686qkb.138.1584483741962;
 Tue, 17 Mar 2020 15:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584473399.git.gurus@codeaurora.org> <587f9ccae68ad7e1ce97fa8da6037292af1a5095.1584473399.git.gurus@codeaurora.org>
In-Reply-To: <587f9ccae68ad7e1ce97fa8da6037292af1a5095.1584473399.git.gurus@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Mar 2020 23:22:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Hi_AoRC3g7qKth4e_Y1jZrbBDhWUb3YPZm10FWMu-ig@mail.gmail.com>
Message-ID: <CAK8P3a2Hi_AoRC3g7qKth4e_Y1jZrbBDhWUb3YPZm10FWMu-ig@mail.gmail.com>
Subject: Re: [PATCH v9 04/11] pwm: clps711x: Use 64-bit division macro
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z2eQotCVF8o3msDNOL1omdrkIssexNriZavBiBKYnLbXPOlYLjS
 yWsZ5Vg/PtxAIVZ0TZ1Acx5vB0D5fMushsdrIOPSH03HAgQlRZauJEJ+SqX1mC+KiigjAnC
 DIv6OTPqJgU6hMaqbfkmQCTaqQX7rbr5ZSLz1t7U9iN0F2iWr6p7OpSitoJYzuIpKZiP/hq
 nw/SvRh9cdM1Lj11CP1BA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yhdO/01Lugw=:oUbccFLRFu4gnR3zyBIUDW
 pCej3EO2GN4QSQRMjmFzJD7JrEyhqAYVqZH3pYm3rWaMJeTjer/GrZsIxZEREA9aONIG3G9fs
 r7ft+XXFBXKRtzIZ9VxKcmaMBjxjzihVTgQKzJFvBx2JQj/Fzn9iffD6vwix3sFvGY94EEXrA
 ZbB1s8XwebU5zRTNGM2nvOfEqNnO5R8ZEPID5pvveGyW3MT6N/H2QXPneeaCYVqQa20SwCnsJ
 BGlNTi0ErJvC6VL2UkYO6I5EQtsnZxfnxjXarwg0mSdTsyrpJMyBQ6qjylPpaJOcbw2I44pnr
 lVBMdZB1FK5PNqd9lSs0qoBsELIxsONEPkFmGa2x+dwmktptQAcJlbAueQHFi3sx9w3okMBcc
 Y4VjVA9DQNm+1AYoUcPULPBbpAX5RiLK1GNVRpbUZhAkQ9qnUZIL0pQvc3BWiZapsAX1kVJxh
 3Tm1qBzYmrrqF+g0jEu9MuUHL4T75gEoIQgmMvMD2xjiyb1b+5KHiRKtP3ikGgvxr4UUAKcRr
 iIyIV3deurH0jaSLjvcOGxPGoz92BhIGmGvTtA8hXCwybhNNLrzx/eGLhArSx2Ux/F5R+C80D
 hrn6YkT4flCjpGj/I2VtkNYmx1BrA3ygu41xXHjXxSRoUqKrH8//X4fTgKBP+OwqF3MIuHiSJ
 FlPy7ryuPWVnDUVBPKUa7rfLCtx/6ptJ2Ev5dTl5r/LQaMpwL+0r/eFH6sp7vsifK8QeTvqmB
 Z6j38FwrWjnSsKbdbCXL8Y7fPgTrD2MkQOJyLdDVOTET2iwjC6y8cXJtESvRLHon7SaJ9AX5N
 v29Xf9BymEYOUHL11zuKN6W99oi1d/sa9YY52rzNTcdV7feQjI=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 9:05 PM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by using DIV64_U64_ROUND_CLOSEST to
> handle a 64-bit divisor.
>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-clps711x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> index 924d39a..ba9500a 100644
> --- a/drivers/pwm/pwm-clps711x.c
> +++ b/drivers/pwm/pwm-clps711x.c
> @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
>  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
>  {
>         /* Duty cycle 0..15 max */
> -       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> +       return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
>  }

Is it actually going to exceed U32_MAX? If not, a type cast may be
more appropriate here than the expensive 64-bit division.

       Arnd
