Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8772964C9
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 20:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369542AbgJVSpz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 14:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368830AbgJVSpy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Oct 2020 14:45:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661EEC0613CE;
        Thu, 22 Oct 2020 11:45:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so1696170pfp.13;
        Thu, 22 Oct 2020 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJ+uKLoDbt4Kdg8ImByLjA8Njsk3WlOLgUgCbpkC9zk=;
        b=A8jUhEN65PHD6v/QKxHHZH30h3Bes875e+6+YJN1oRjC7MZxpv05pacosmi/+65EBk
         Dx8XXnOnRTnBVHVQ5JmYEycve17jrdZVst0f6IsgoRtTyydrVVoQEhhVNi4cbk+tod5A
         MNLeNR+TUQSkY5iFpk/xW8fcCvmfbFIEIsWzj8l/+MZ2GaZLFfk/oasxZ10SVZDdetqd
         m7cKjO1GDgNygAgXbqYg3qwViz8gUMo2l9iN/xTV7hcM7OzUJgHiVxn2xn1Ix11Xn3Mj
         w5xyxZzMqJdXhyvSL/CCT5pFyt+G/Ry3aTxphw+1BfRgwJ6o1PZGhL3mLbVF7NEE1HQo
         stlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJ+uKLoDbt4Kdg8ImByLjA8Njsk3WlOLgUgCbpkC9zk=;
        b=Lffidh1m26Tpvc0fK79Div1yEN/p+2gdVsvah6YqlDfyZhZRXsi+QpY1G+HVpOOppz
         H56NwCbB/viPVmrdC+9JqCmF4mTzVdpdMz1y0eS5PNMAASEkejo4dhvnM7EDePCxjRfQ
         Fx0moZo2qkGjTfSFuo25ZpPE2w8xzTBHLNEDmVqJhIlIRWzdJ7JO4OIqXxdDd8h4e0oL
         2cXwch18dfnTSWK+ZIDklGy5wc1slWQm1Mw4SKPA82RMQFiawtLtL51IzCzqbDAdqm4h
         SzW9FEN6fbyYSRIjq2xCZS9WoARgqGLKj1zbsZBO9HZRHL4O43E73SsHkWpjd8alueqQ
         oRMw==
X-Gm-Message-State: AOAM530yFVlBowcW0UkuuWa4lhLNX3dM35yizMP29Ui2FnMfAuN7HRy8
        Opi1yF75+HS780vfSL2EOJbcKHuaiiQ/HFVN39Q=
X-Google-Smtp-Source: ABdhPJwNbfbJKg7L/+F+lSBYE2PF207sJKCE67fjAwiCaIsXfyZycJr3U4/+t0LHsJes+amoJNW5cfEG1vmDYyxED/U=
X-Received: by 2002:a05:6a00:22c2:b029:156:543:7c1d with SMTP id
 f2-20020a056a0022c2b029015605437c1dmr3749000pfj.40.1603392352903; Thu, 22 Oct
 2020 11:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201022155858.20867-1-nsaenzjulienne@suse.de> <20201022155858.20867-2-nsaenzjulienne@suse.de>
In-Reply-To: <20201022155858.20867-2-nsaenzjulienne@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Oct 2020 21:46:41 +0300
Message-ID: <CAHp75Vej4UfsySRB6qXL7fFN7SjnTjy=p4Xkn1xBO0YOFy-kcQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] firmware: raspberrypi: Introduce rpi_firmware_put()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 22, 2020 at 9:06 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> When unbinding the firmware device we need to make sure it has no
> consumers left. Otherwise we'd leave them with a firmware handle
> pointing at freed memory.
>
> Keep a reference count of all consumers and make sure they all finished
> unbinding before we do.

Wait, if it's a device, why do we need all these?
get_device() / put_device() along with module_get() / module_put()
should be sufficient, no?

-- 
With Best Regards,
Andy Shevchenko
