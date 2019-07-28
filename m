Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9278233
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 01:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfG1XC1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 28 Jul 2019 19:02:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35430 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfG1XC1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 28 Jul 2019 19:02:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id p197so40673255lfa.2
        for <linux-pwm@vger.kernel.org>; Sun, 28 Jul 2019 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QvDMg/A2Rt5fxMboau0/0oy3s1qZzYfLl1+37OTI2s=;
        b=rOPuD9CEWBL/GqqiVJQfMsc1b77FhN/cFmrFSXMvy18LLdz2cpUFHiOEgM4Ui6HDvi
         t5i8t1jJIlnqjiu0+Y0BZDXmwudaKW5WWp5QPeEqe7CJ64wwP59256ecvHcgm6/aOGtf
         HQD31UlAJv+owg50Bk6UqwAbszE5fmwsUCAqhykwcaX4LXpGQkJeh90677sC0+Yvh1rw
         jJiLuQdIR0QgnWPzQjnXHdmawGf1OyaYRw/NjdtSHp7CA3Mdlyo3tBnG41zrOb5rgqV+
         TzHqxS/tAU1qrQLwPGiGLl/hkl4MaGpkf4cSqJjw9pQXwpbLu93YfDP3l5pCwVt6UL/K
         B9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QvDMg/A2Rt5fxMboau0/0oy3s1qZzYfLl1+37OTI2s=;
        b=ILUGrBwKaGpa7ErOvo+ee3mNDZH3+rFg43VsGIMrFI4AsrABHhOwIEtsz/dDsrR7aW
         VjT8xWdrsjn0Tz4b1UFVsBxWU/j3htD0dlkYT7pfjcVVjQi7pJngi7MS0+IJRyRvwYcN
         POLWj+Fa6Mw8V0lLg+1GPENzApWrdjZlpwjiNIDmDLwNDz0SKfXM5yZZle8i8j3qx4X1
         cAm8kBUfTulnGKTQ1loty2uFMw3gaWDGu/7lqirSeGIPMafAOamuqrc7TbHkLw3qaWSy
         dtaL1wJeHwurNboMTrYFhPniBpUbd+6zpGeNENPD5X9RUbGuVG/iVJXFBDWA0g6F6RUk
         4FeA==
X-Gm-Message-State: APjAAAWG9rP6dBLNoOI8vLPFUrtU33TestHzDq7ChcOeGxoa2Nw4T67r
        TAiVuomy2wJA4b42j2T+zKKPvI32UZDL2PLKNlNBmQ==
X-Google-Smtp-Source: APXvYqya5Tifa7claX2zxKxD5LFpUDCnOFeYo+T/QCqZpDuQ1qDiu99i+WGV5cNGo8hr2+lSDSPdmp+GoRHq3uI19PQ=
X-Received: by 2002:a19:7616:: with SMTP id c22mr51050132lff.115.1564354945858;
 Sun, 28 Jul 2019 16:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 01:02:14 +0200
Message-ID: <CACRpkdZqTaA04bja16xh338JiwoSqFpH_2rV95FaF7YhawQzMg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/7] pinctrl: sh-pfc: remove incomplete flag "cfg->type"
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 8, 2019 at 11:08 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:

> The old commit c58d9c1b26e3 ("sh-pfc: Implement generic pinconf
> support") broke the cfg->type flag to PINMUX_TYPE_FUNCTION because
> sh_pfc_pinconf_set() didn't call sh_pfc_reconfig_pin().
> Now if we fix the cfg->type condition, it gets worse because:
>  - Some drivers might be deferred so that .set_mux() will be called
>    multiple times.
>  - In such the case, the sh-pfc driver returns -EBUSY even if
>    the group is the same, and then that driver fails to probe.
>
> Since the pinctrl subsystem already has such conditions according
> to @set_mux and @gpio_request_enable, this patch just remove
> the incomplete flag from sh-pfc/pinctrl.c.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This looks like it should have a Fixes: tag as well.

Geert will decide what to do with this.

Can all the pinctrl patches be applied independently of the other
changes so Geert can apply and send me those patches in his pull
requests?

Yours,
Linus Walleij
