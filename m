Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04803CDB34
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2019 07:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfJGFAc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Oct 2019 01:00:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36311 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGFAc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Oct 2019 01:00:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id h2so11174012edn.3
        for <linux-pwm@vger.kernel.org>; Sun, 06 Oct 2019 22:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTKd9BxTt/PAleEHYrjbGfQDxHC83timSY4p9uhdwxY=;
        b=jpp/wAaeud60o+Kl7w9WlxT8iTwbj6sHztRpaSL75wX9NPyzkBBrCkH/6sPyflDarl
         vxUtZbmPjoPH5/m3TQ9hmxXwpzzKdlsqzwtO/TY+jSVi80hfcp4dkC2b04oHL+fchDbx
         uvNFIxIWDgTqvMqC0DR5jLGEsLOipA46UEJmYEPciuuKdjvN9FLXhiQX/dog7ReUYs1n
         CY7RVtN/yQbS1jy8jkmKICkUWFe/ReaIV17hnqUAwSXytHuUayYDfMuJHl2YOvSxEBSI
         IGmv45HX59a3KyVfBunrXGeq7noibUuPEH0T76jZAwkpKRikGQgncqHxmouWDIRheR8M
         vy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTKd9BxTt/PAleEHYrjbGfQDxHC83timSY4p9uhdwxY=;
        b=mOJNH5S2zI9K2AndGDs2retsFtduC86mz7IX7e59BvYvMNcOamgwXsaTKfGJMBaqkh
         Fc5Xp/PCjsOmHFCFki0o5wken4Lk8y7ZyYe7k4UwRgPj1F07oyY4YLvmGhUgThkiipBD
         VqbFFEXtt7QHpF707Xc5EBQpmtkA3ZyxaHJVwts/JpxK+OHVsfhtHWczU7C7Qcx9/jHU
         /DgYFE0FkSxYm19RwuhIVqOjriaR3P1q+ik/oPPx2sd9FjMunPW1wetELsWAUR3+zpEg
         JtTwFx55dvGg6vwt2i7kftTaEUJctZydknz1I286GD+rpNU1yssGWFSTcw0iMFiWXYv9
         csIg==
X-Gm-Message-State: APjAAAXED0WbIm2MVu5MbCM44qgXjwJFeSzy8paxlQVPNmncefeVUHlI
        UyyC+Iiwm3vipc8yrHMXGweKBYtiDPpcapoDfxdFYce2
X-Google-Smtp-Source: APXvYqwCVgUVK4pofULcj6U6CcXacuCiAQAAUYp38BKbJHzMKdZXN0wRWYmmhSAPZ6sV0SFKGw/arB24iK2NwnfUvtU=
X-Received: by 2002:a17:906:57ce:: with SMTP id u14mr22483243ejr.184.1570424430064;
 Sun, 06 Oct 2019 22:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk> <20191004133207.6663-7-linux@rasmusvillemoes.dk>
In-Reply-To: <20191004133207.6663-7-linux@rasmusvillemoes.dk>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Sun, 6 Oct 2019 22:00:19 -0700
Message-ID: <CAOCOHw7TXj2zr7qoown0rM=W0dns4n1o+9gOHr_8=vebzH=bMw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] pwm: update comment on struct pwm_ops::apply
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 4, 2019 at 6:33 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Commit 71523d1812ac (pwm: Ensure pwm_apply_state() doesn't modify the
> state argument) updated the kernel-doc for pwm_apply_state(), but not
> for the ->apply callback in the pwm_ops struct.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  include/linux/pwm.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index b2c9c460947d..0ef808d925bb 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -243,10 +243,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
>   * @request: optional hook for requesting a PWM
>   * @free: optional hook for freeing a PWM
>   * @capture: capture and report PWM signal
> - * @apply: atomically apply a new PWM config. The state argument
> - *        should be adjusted with the real hardware config (if the
> - *        approximate the period or duty_cycle value, state should
> - *        reflect it)
> + * @apply: atomically apply a new PWM config
>   * @get_state: get the current PWM state. This function is only
>   *            called once per PWM device when the PWM chip is
>   *            registered.
> --
> 2.20.1
>
