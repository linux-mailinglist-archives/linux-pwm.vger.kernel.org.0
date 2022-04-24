Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DC50D20D
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Apr 2022 15:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiDXNeD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Apr 2022 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiDXNeC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 Apr 2022 09:34:02 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6F04505B
        for <linux-pwm@vger.kernel.org>; Sun, 24 Apr 2022 06:31:02 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id y2so3752277ybi.7
        for <linux-pwm@vger.kernel.org>; Sun, 24 Apr 2022 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UBhVovLDQ8BUGD5PCxc7A8mnlUEf+e10BiZ1ClrU/6A=;
        b=ayxcokoWgbaqqN6zIepV/Lob6iNhN6aAz/jo3J9LLVzRzb0W7XpJzlma85fpcYPVyM
         9Q4k4YZYV0k6Nf2Cag3uZpxebPa9pp7i7MUhw5ec8YSxCyNm7+uIjgjCSjqS9YR8xQBH
         nHFXdicEh432hL5pMIFAejeHKt+jM0Elu35GgIxFOAy6v36L1bHb1MqxZRPy+QpQJNxL
         RCI8i68+4qG2mVX14veiaTvVmRHGDInA01kTnCc76jn+snYiBgH9ptXqn4Ooq1YFExY5
         my4mEOarHLtuhIuebACUVuvxD5z/Mv0be0E6i1v6oK5O+/DXV5WiA43TpyYlE0I5ktvj
         bFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UBhVovLDQ8BUGD5PCxc7A8mnlUEf+e10BiZ1ClrU/6A=;
        b=NpNYMZ/7VEOWxXZe1rjMhh94h6J7kic7GEErPiZkkIJbBJTFtqgHmUWAznjnx9vFEl
         +HJn8nn5X/7qLlQ7b+VXuw2n4c6/IkB1NTba5F8GdqDJsiTtU7e6daSsgAfhxMRr2kJN
         2yF6z9cL3mDII68S0p0sDRMtMlt/Dlqtwzf4euCcq1f9nbi8DrgO1T7Sv0TOHGAUv5sV
         IPsAz3O8Pf01Z13fsOSjXR6yqTQfaxQj7ya72ga9UuWkuffDEbyqlO2ezNaODfj1Rpg6
         k2Ulm8NN+/stVPrMre6JF8cOHEUpHE7dN+CkIyJYphviZv2Mfimy85QNAqXzLJEO7/Ey
         dsBw==
X-Gm-Message-State: AOAM5335psYGvtBtaUD+GvbycgGP1BtiqeSGxQsqudFRkC7BG0k8Q/C6
        j2teMOg0aX8TNdl3Lgf/rCjxhFF48Wi7L8SO8ynDaw==
X-Google-Smtp-Source: ABdhPJzJf6w+AZ3j9VTg7w0PyOvxSCL0mkaYNzMZjZYevGB/rOBDFd/PXDeYB14B1y0U8+9CXS1WaUC+VHJY77lfpZE=
X-Received: by 2002:a25:4e82:0:b0:633:68d7:b864 with SMTP id
 c124-20020a254e82000000b0063368d7b864mr12644754ybb.514.1650807061564; Sun, 24
 Apr 2022 06:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
 <YmLcdmQrO4+0tEiJ@orome> <CACRpkdaqRe8HgPvm-YH9p=ZDetX6jcVHFRgvqk064KW=2-a-mQ@mail.gmail.com>
 <20220423161831.ob7cxj7do4423vrv@pengutronix.de>
In-Reply-To: <20220423161831.ob7cxj7do4423vrv@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Apr 2022 15:30:50 +0200
Message-ID: <CACRpkdZUSW8y8y0XhKocj8_pHMwKOTqesqpp2wxo+ogXnXOF+g@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: drop pwm base assignment
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Baruch Siach <baruch@tkos.co.il>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Apr 23, 2022 at 6:18 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Sat, Apr 23, 2022 at 12:18:20AM +0200, Linus Walleij wrote:
> > On Fri, Apr 22, 2022 at 6:48 PM Thierry Reding <thierry.reding@gmail.co=
m> wrote:
> >
> > > > -     /*
> > > > -      * There may already be some PWM allocated, so we can't force
> > > > -      * mvpwm->chip.base to a fixed point like mvchip->chip.base.
> > > > -      * So, we let pwmchip_add() do the numbering and take the nex=
t free
> > > > -      * region.
> > > > -      */
> > > > -     mvpwm->chip.base =3D -1;
> >
> > I don't see why this is removed. I understand why the comment is remove=
d
> > but all contemporary GPIO chips should use dynamic assignment of number=
s
> > i.e. base =3D -1.
>
> This is an assignment to struct pwm_chip::base, not struct gpio_chip::bas=
e.

Ah, how confusing.
If this is OK with Uwe:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
