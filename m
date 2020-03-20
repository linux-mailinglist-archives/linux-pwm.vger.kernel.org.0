Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA17B18D561
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2020 18:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCTRJ7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Mar 2020 13:09:59 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgCTRJ7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Mar 2020 13:09:59 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MwQKr-1jVudM1jCn-00sPyn; Fri, 20 Mar 2020 18:09:57 +0100
Received: by mail-qk1-f178.google.com with SMTP id h14so7629762qke.5;
        Fri, 20 Mar 2020 10:09:57 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3AjeCqF4eQedqqGLmc+BY9C1BRfVZznlpS/H8qbeC3Zle6nKq9
        xjNsm0S3VDZykFS1rqvrzGG38jJwKuXUceWVtFE=
X-Google-Smtp-Source: ADFU+vtjyO+ehLTD66pkWeXkdjTj4/yy0U6UhFzBOixds9km8+MN7n37hhenmQD129d14NVa+I+huaC/oF0GQuuVinA=
X-Received: by 2002:a37:a4d6:: with SMTP id n205mr9299331qke.352.1584724196159;
 Fri, 20 Mar 2020 10:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584667964.git.gurus@codeaurora.org> <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
In-Reply-To: <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Mar 2020 18:09:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
Message-ID: <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and function
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NT1QCBoJeAxayaviYjMCvNEQL3IYVL2LhtzFKOtdqS2IV0XjZa3
 wWW5chAgDpZ3YlZiAEunuXIMrORfU6DGtU3m6f3NpQn8z+7TRq+D5UQ2vxc0k8MvdT7smdY
 P6JgLiP+NviVJg4iv3gWtF9hMF5qM78kT4G8a2p6hCOBhbmDOAy/YOg86FgCCiHrTAIILiJ
 v3A65uoScg2fWVlqqgd5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OBUSs1wKTYM=:uNmjh1lUYwUMomH/yU/kca
 y5KrySbLrEVfWmoFzAPv8r6OYcJKLNbEpw8jsnSChMIVM6SlO9MomD4glOZjrlimSW1XdsbSy
 OdH+GzYXuW/cmSDeB2y7p8Rc8XZ9qHPXcGOa0HlNDIgZ9ZIWgS4mUTHRjwNaihi/c+yoAZFX2
 HlYxkuqdbv04Lcu+/xQwdFcJ8hiuLkR/zYB2tpfxS7MAmZrTMIpTc44v/GpeHOtf2bIxTnSsS
 GRy+YNuoj6fMVh8Jhy01mtV1ZkNasY/++aDx0jtpFXP8PM8xU1HchXu8WZ4I41qemS4HcxGfT
 0yXXGmlm/5rnHY8zgo46ADAPV4NgS+SJwu/5bCuF3JONkq5oXYLEPuEgWBJZxYs1fX1RnbdUI
 Lu3O/YIZboJ98fhSx6aRBYlzWaR4/xGgiOenIrAy3evjFJNrsF+jT/Kx6GuAZwR5mTYGnoAPv
 UG1gEXzdFQWfvlimucx+7TIRqMto3Bi2XhL7TACvifjHLtWCQ5DiGgwJ/hyLVXCYc6XrH5PBk
 kwRgVtYGB/xpn1CqktxKbWdzbZR4PrG8Q8wLRcpjXg71KIf3AZwMyJqz/w8tWVqgfI3maDZ6R
 YQ8J1jaWo7SKpwW7uDfWm6Rxj2x74gWhzudY+kkihrVoX9CKN3SXZRj4xemwrQcLk36pTwkj0
 O6PLhvmvessXcqMLM1kay+eRfxprkC+TpxrO4Vrq5NZ5XgcMJWX4XVXaP1YX642AjyxQSBUmh
 vh6Wie9lAV+r7XRSH1FXFuH+P/jkGrliM4KHf3Ca4TN+cqKePxXgwVRNrP5CXxl4HSRUxjdWF
 70YRjzKWkbaV78eiHWOgrRwd7s35djMxif/rpr7M7DtCK5fRiE=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:

> @@ -240,8 +240,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>
>         period_cycles /= prescale;
>         c = (unsigned long long)period_cycles * state->duty_cycle;
> -       do_div(c, state->period);
> -       duty_cycles = c;
> +       duty_cycles = div64_u64(c, state->period);
>

This change looks fine, but I wonder if the code directly above it

        c = clk_get_rate(imx->clk_per);
        c *= state->period;
        do_div(c, 1000000000);
        period_cycles = c;

might run into an overflow when both the clock rate and the period
are large numbers.

      Arnd
