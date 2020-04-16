Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476011ABA52
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 09:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439761AbgDPHvy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 03:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439430AbgDPHvu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 03:51:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE5CC061A0C
        for <linux-pwm@vger.kernel.org>; Thu, 16 Apr 2020 00:51:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k21so6794152ljh.2
        for <linux-pwm@vger.kernel.org>; Thu, 16 Apr 2020 00:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loMCxNASFvkfTDCyeUmtP2u+gte7x5OtiG/cQmRKcuQ=;
        b=xMUW3PGeSrw4ARkL9VDfzWDbSGxC6xcX4Ki7j9FBIb94zY/nyX3c8swn8+2K2eXQWf
         u5I0kwTaOMKF60tm8Ybb4RI83J/5chP+BKkJGzpCt4Njp+d5eKgO+RHGsvNhseRCUr0A
         kxzkYeOwrVdKr3ln53f3UvwS5CL7sp7ao9UeUyT58VwwdOmE7hQ8XnRCvvbD0t3FKapJ
         oJRfgQsGirpJkwaZ7IV8kGn4+8QNBvxXn8FYrLA5QKLO3da7dEJHYdfloWOUGYngvefF
         kPv4d618uycUv1TdFu4hKJ4ZeXV264Nmr2hjONIdx1CDO9GlIQy4qphT6PWNZXnRrTaf
         KZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loMCxNASFvkfTDCyeUmtP2u+gte7x5OtiG/cQmRKcuQ=;
        b=oF+OYMtcnhFpyBhtdTyW8J6p/jAXcG1p9Tnl+2aOeI30R0Z+NMQal8e4EX5yuXEJ2K
         72MTydHBjIFsD8hX3nL6CH68H5ZN8uZ2RV5bUYXpFq5LZj3LeP9YgHD7FQmQRjTi/1A+
         qFuzCu8EVN2a/aAIjQT6aAEZttUDe2tnkytQWkeLwmb3kMtYphRts9b7HR7dAjtmAqrl
         OnmUG0NlOHowTyyoCJuADR5cFhWLXDUhsxSvfydFBYIQUWdE75xzAaPTAQTSn8aVBkWN
         Iv/TWw5h20ZVFrgInU1lhEXE0Des7DPJ7CSDfNwwRnoieG0+kyc7LM6uGBHrpiK29ZGY
         euxg==
X-Gm-Message-State: AGi0PuZdCLlpc+EEXgqjnIGKLMWDbgNSodAbgjdlXDdheZVzQz27OAyQ
        LDoImQIZOPt2XuDp2WJFGr3QiRJsCZoRfK6zCLKgqg==
X-Google-Smtp-Source: APiQypJ3hmhHjH4xlCLoz3/xbW/q0EWD5I/m1MGIq4yanefRacOTieYBUa0MrvrxoWyMyTHM8e3D7N8MbRBPt6Mds40=
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr731003ljp.277.1587023508445;
 Thu, 16 Apr 2020 00:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200329104549.GX25745@shell.armlinux.org.uk>
In-Reply-To: <20200329104549.GX25745@shell.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 09:51:37 +0200
Message-ID: <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Mar 29, 2020 at 12:46 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:

> This series adds support for the fan PWM output on the Clearfog GT8K
> platform, and can potentially be extended to the Macchiatobin.

The gpio changes all look fine to me +/- fixes for review comments.

Could the MVEBU maintainers provide some feedback?
Curiously the file is only listed as a PWM driver in MAINTAINERS
so formally Thierry & Uwe review it (and Uwe did), but surely
the MVEBU platform maintainers should take a look too.

Yours,
Linus Walleij
