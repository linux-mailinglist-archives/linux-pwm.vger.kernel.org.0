Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270182FD4F1
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Jan 2021 17:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbhATQHH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Jan 2021 11:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391254AbhATQFe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 20 Jan 2021 11:05:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65BAE233F8;
        Wed, 20 Jan 2021 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611158693;
        bh=tCY0oELYRd4QvtVyOqXMepIBNI4ULR18UJOim1D3bsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sEmKfr9CxifTG2YE8U1qSq6PoLQjtahrX6K7FwtjlQ5VZoYVQcu73Tpfkkg0Hlaix
         Io7a5B7ukdvjEjPWfmi5Xs/UU4WqGtOP0PA3jD/+4lWe+7CQRQcaXLcck0XwgQJVHD
         Sm0CYOX8Avuqq/YRgq2wTKjv0hRak3Kq9dkEEYWpkhWbgf5QQDAJs6hFasnfx38CWI
         OKqlwcBXCxsns6HDVmT++FMKM9upO3kE/oT9brDMGLcW5qgTOePxz7ftuC9vX6taQo
         Nc0f3TFVcgh8HEVhSOZIotk0/sxKUckGGqdxgu17cB6NIKfqfboMnodt1S0rdtcLL5
         OC0p/zwiu8QbA==
Received: by mail-oi1-f176.google.com with SMTP id f132so25494184oib.12;
        Wed, 20 Jan 2021 08:04:53 -0800 (PST)
X-Gm-Message-State: AOAM532Wc5ioCkuwibp5mlULX6lfiglCxFlMWrk8935CCX/K+7yJDSuK
        j8+wmrFVXbZAGdmsQ0J8bgC5VtgWn3fekF+BV90=
X-Google-Smtp-Source: ABdhPJyLDeFbaDazP1z9y9ooclYTHcmXJDGv3fxWTYIMN6vJgmVL46kRjEEjTbvBK5FAEEjz0DdaTdejgQPy+pxBIdI=
X-Received: by 2002:aca:44d:: with SMTP id 74mr3345812oie.4.1611158692720;
 Wed, 20 Jan 2021 08:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20210120150944.1688327-1-arnd@kernel.org> <YAhRMaJhYJZat2SI@ulmo>
In-Reply-To: <YAhRMaJhYJZat2SI@ulmo>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 20 Jan 2021 17:04:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2JhcRnaDXK1V4=FgRJrGjqrj5-LzhCaC+jpLa1hDL+Pw@mail.gmail.com>
Message-ID: <CAK8P3a2JhcRnaDXK1V4=FgRJrGjqrj5-LzhCaC+jpLa1hDL+Pw@mail.gmail.com>
Subject: Re: [PATCH] pwm: remove zte zx driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 20, 2021 at 4:50 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Wed, Jan 20, 2021 at 04:09:22PM +0100, Arnd Bergmann wrote:

> > -config PWM_VT8500
> > -     tristate "vt8500 PWM support"
> > -     depends on ARCH_VT8500 || COMPILE_TEST
> > -     depends on HAS_IOMEM
> > -     help
> > -       Generic PWM framework driver for vt8500.
> > -
> > -       To compile this driver as a module, choose M here: the module
> > -       will be called pwm-vt8500.
> > -
>
> I assume that you dropped the PWM_VT8500 symbol by mistake? I can fix
> that up while applying, so no need to resend.

Indeed, thanks for catching my mistake and fixing it up!

       Arnd
