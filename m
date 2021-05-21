Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5EC38C8E0
	for <lists+linux-pwm@lfdr.de>; Fri, 21 May 2021 16:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhEUODx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 May 2021 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbhEUODv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 May 2021 10:03:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98299C061574;
        Fri, 21 May 2021 07:02:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s20so11020689plr.13;
        Fri, 21 May 2021 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DWPn98eC44k+PyyPgCpWoFhVf53fNK+DheW9P08B0H0=;
        b=iUz/5i2acChphR26zt2ip+uqw31c9cj1M7DMK6S0VvYrEd6tpfGYgq8eRQbcX1C4XL
         Qv6C9UqOYoDj+ElbWvUhOjU56bbfCVphozbFiwFTWPoSOUecYWBcLNfRJtcD4zfjWS9C
         vkDKYqjD9slIiEw1irxgN1dZc4/OIaTNq7s3jJUoVcI9EvUmgaWN5DRayihIomNKXoUT
         NtN5919kgfuSugbjTA0SnJnTHE0Z6l4niwHSY8olJCWhPjc8FEkuZRCgwicgWivNUTji
         +I4AJ4JPRDv1HXh2hZ5BwW7nNwDbFgzsgkBXj9sdthRaU6LDfutlM9Efv3GX01YFK7hm
         FKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DWPn98eC44k+PyyPgCpWoFhVf53fNK+DheW9P08B0H0=;
        b=Jp0srJUoAcTbM4FnpVlOA/wM+YNB+6khwx3AoJxF+v6/n0s/H5cdad7QZQWWybjG6P
         USDDVVtukh5FyU+wR4SVla71XqW2Uu6btlGEBdY7vsrccjQgSvNO0OLgYm1ADwjBBSRD
         HyObMDzq6bAMZNJKbs99lwhNgSGZNnLjYay0w3cbU9ZoSW6oVTY1BfWzA8n9An/iXPvq
         5iF/n4SkrF3Wxxr6vQMPA8HLPD0hRk0dlEPAhnRcLUnrTN/zOvCStgwi4u9ka6YtEUwy
         iEv8+rBA7oNzB6RhhvPQp1txcDeMZ8cep8dbaLZMEZyZ5nXu3ZrBferHU5hbytuRXNe6
         oe0g==
X-Gm-Message-State: AOAM5320/VeGQeV9rCTFFEq+YJ1ORrVq2kPZXJP5bvtv7VKgRHVpNRqc
        GaKnNDExNgEoH2TpGGk9o1S5eJfsgLzr8+taDCMM8YD9C84=
X-Google-Smtp-Source: ABdhPJxP9kJ9+yXHBekW5UQ68mGCeDaRL1L/0XQzUQZe65vGaDWcaJufUgT5JT9lhiID/vnaGIoek8eqosjwHNvgksI=
X-Received: by 2002:a17:90a:af8b:: with SMTP id w11mr10967680pjq.228.1621605745017;
 Fri, 21 May 2021 07:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210521135516.64727-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210521135516.64727-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 May 2021 17:02:08 +0300
Message-ID: <CAHp75VcS5UBeJ9eq3dv_8EHwfjdBSBbC4kdmuKyrxCPj+gQ5hA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] platform/x86: Add PWM platform data for Merrifield
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 21, 2021 at 4:55 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> PWM is not functional since it requires pins to be muxed and configured
> properly. Add pinctrl mapping to platform initialization code. The pins will
> be configured properly whenever PWM driver is probed successfully.

Sorry guys for the noise, this has been mistakenly out here.
Nothing really for upstream.

-- 
With Best Regards,
Andy Shevchenko
