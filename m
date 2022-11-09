Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93E6227FF
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Nov 2022 11:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKIKIT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Nov 2022 05:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiKIKIS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Nov 2022 05:08:18 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660E8F009
        for <linux-pwm@vger.kernel.org>; Wed,  9 Nov 2022 02:08:17 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id q9so45453652ejd.0
        for <linux-pwm@vger.kernel.org>; Wed, 09 Nov 2022 02:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U+M6w+R6FHYw23U9WYJNoWQ39Q7v0W77OetkXqSRij8=;
        b=QFR9DBBIlQOEM4cGA/+2bC5zT32JmpkmQGtfFPQb5d+KE2BGLOOlqvkeq/iqd6I+wA
         g+5Bc0zHBCjc1izMsCvtMUD+MFeIF0pwD56JuGlRo6A0QLus9g2hP/M+euIovcu6or1j
         RRz0ivnAYsbmfHDAKN3lpyZevihl1bh9wENq3j+Vmerwfw+58l0ZW/nCmftyVYTUXDBQ
         5snC6zZEcng4jV83Vx7Ldw9RzeNN+/lQS/8aZ02imDa3SjlUMWlbEW6j4ngpTZIgoEgO
         eCkc0UwTDCuhu9EZWR2C3d8Om5AgW6ssYlCFQE99crCezXpOCOGERq++9fPJtFR+fkLE
         JEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+M6w+R6FHYw23U9WYJNoWQ39Q7v0W77OetkXqSRij8=;
        b=L3Gn5gVbDDS8QOfbHG4vrN/v9cDhKJxX0kLMiKL4oT60SFG02pEJ/GyzOkn0I4BaeC
         gsqb6TqRs/I1iMv+yJEfkVhVFRObW2Mnnl4EiM0jZKctc4mvEgGQH5+alqSDel/aR2sr
         j+yQHXIBAXeZdOb0V6B12ODqBjMGaO82zO6lzImphiYsXypqa9svQsCHxBL28ZBR6RbX
         8BDhifm3HPR+w+4ijdfBhEjL9mMNynltapmxV3rJ1i5VZpXBXW8vI7f+g1JAnOdgL41v
         VqkFyFKWNjMMmc2/7N/nsP2DFkE6dCc2evRqhyrQWAtR064+lO1qvya89TfFczif8YTp
         2qDg==
X-Gm-Message-State: ACrzQf3pdiK8N+K0qT4VyfS/byDl9Ap4cYbiM++twnLI5vbwCdRgc1u8
        YnHwj8Iu7lZzwufnkkDL3spvsFWJnYR1oPm2Htf5wg==
X-Google-Smtp-Source: AMsMyM5OiIZs8z5Y3H9IpF29+eHXkZ6InmKjC4u8rtHyJawxyBp7+yMNOQJc7IM4fr+9THbBoA8jOBF94crtkBiCdLQ=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr24404336ejc.690.1667988495931; Wed, 09
 Nov 2022 02:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-7-andriy.shevchenko@linux.intel.com>
 <CACRpkdbVekP0kFpwexpb3NhqRSouNW7FhhRpSK0yRQTrJAGt4A@mail.gmail.com> <Y2t5ZXM0Oihz/LDK@smile.fi.intel.com>
In-Reply-To: <Y2t5ZXM0Oihz/LDK@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 11:08:04 +0100
Message-ID: <CACRpkda6uDOEXybduFbTe0yXzLMaQ8x0UORZAH-U0SOTWHkF-Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] pinctrl: intel: Enumerate PWM device when
 community has a capabilitty
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 9, 2022 at 10:56 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Nov 09, 2022 at 10:08:51AM +0100, Linus Walleij wrote:

> > I guess I can be convinced that this hack is the lesser evil :D
> >
> > What is it in the platform that makes this kind of hacks necessary?
>
> The PWM capability is discoverable by the looking for it in the pin
> control IP MMIO, it's not a separate device, but a sibling (child?)
> of the pin control, that's not a separate entity.

OK I get it.

> Moreover, not every pin control _community_ has that capability (capabilities
> are on the Community level and depends on ACPI representation of the
> communities themself - single device or device per community - the PWM may or
> may not be easily attached.

OK I think I understand it a bit, if ACPI thinks about the PWM
as "some feature of the community" then that is how it is, we have
this bad fit between device tree and Linux internals at times as well,
then spawning a device from another one is the way to go, we need
to consider the option that it is Linux that is weird at times, not the
HW description.

> What you are proposing is to invent at least two additional properties or so
> for the pin control device description and then to support old platforms,
> create a board file somewhere else, which will go through all pin control
> devices, checks the capabilities, then embeds the properties via properties
> (Either embedded into DSDT, if done in BIOS, or swnodes).
>
> Do I get you right?
>
> If so, in my opinion it's way more ugly and overkill that the current
> approach.

No I just wanted to understand things better. This small hack in the
pin controller is way better than a bigger and widespread hack
somewhere else.

> That said, I agree that this looks not nice, but that's all what
> Mika and me can come up with to make all this as little ugly and
> intrusive as possible.

I can live with it, rough consensus and running code.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
