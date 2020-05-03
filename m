Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7511C2EBD
	for <lists+linux-pwm@lfdr.de>; Sun,  3 May 2020 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgECTUh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 May 2020 15:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgECTUh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 May 2020 15:20:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BFC061A0E;
        Sun,  3 May 2020 12:20:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 145so4473156pfw.13;
        Sun, 03 May 2020 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdFNGTDLDdIBEa4zPq8Xb5v+CQ78ZHRP0MSZwCJG7Do=;
        b=X6cEz+J00Dq2b2asHfmODYZSaa/w43mmilEx5Ql7+Y7rRGQGJ0W/7uDnrdcEtJJyV0
         mmaATfO9H1UOTBcvK4/+Xoov9wHC+WGFFT2R7zpTO4RisLNFN1HUW9UtmSTmbgnf+BXS
         L0GBO/sm+gmefaMXeLQ5v6VP4/8SxFSrCzL2rquGIJSIegXpoHqwgPJAQhNLTJk0+jUc
         x0RvUF4BhbaEhrb4hnV28s4mkeFwnGgLE7EM9ImGOGAzvFN1TEWkSCT1xQIXNB27kseO
         VDSs4JxNoZqnkMie/Ih0wooxUUdb01RrTOWrvd+8anm1FOCiFN3xg7BPE+QKS9FKW2+o
         H8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdFNGTDLDdIBEa4zPq8Xb5v+CQ78ZHRP0MSZwCJG7Do=;
        b=IzU2fYDm7zSYUC00KLJ/jNZWSwMmu6MhiARQ6OkXwVhsnVrlKXG3bl4SkOa92c48gx
         k3bCdhRCBH58oRclVmi3D2lqK0AfS8N+U8qCnAYmrAPLCZj05bTunK9e02HJZjHeBUKK
         P1X6uqM3WEC+ntqdczn0Vp3YT30+Gtdcl4bjrLf1/2EI5GCe+Gx8Z4xMS3vdwYp1VkeL
         EbhHqt0F2CiJE+L6a2q6vlrMtt5GoDfhbrU16oIhpKDl9BnvYfpbgHXf+Wr3OJ74aG4l
         C0UonjTcrSTUdlBMIaXTt0y0FAaLdITj/SDlrZlsmwjR0jpU+jmEY5q5iNM5hZgdobzy
         xVvw==
X-Gm-Message-State: AGi0PuZclSjEYFEaSVoFOMdO/ZPCXGnlOS4PUWx7umuRdjmedWGr29RM
        9aaYb7RUx+DQ6vphTnoHQcOb7TGJf9HJUc/6FXc=
X-Google-Smtp-Source: APiQypJiGYeeGCHG1x0MvKwInlqyR0rKQgNUGscccAeZ21vwMf1rDvUTzMn6TDOcJsNlun19U2aKwuLUcK7j/ZiXkgA=
X-Received: by 2002:a62:f908:: with SMTP id o8mr14017471pfh.170.1588533636386;
 Sun, 03 May 2020 12:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
In-Reply-To: <20200503105453.23658-1-miquel.raynal@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 May 2020 22:20:23 +0300
Message-ID: <CAHp75Vcg9kdgr=AXxwmXO-rmL5z9nq=zJvCww8wG7i1B3BQNYg@mail.gmail.com>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 3, 2020 at 1:54 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.

Besides the messing with parameter types (int vs. bool) it should be
rebased on top of Bartosz's tree.

Also, it might be that we can instantiate a kind of device (MFD?) that
will share same regmap between two and have naturally different
drivers for GPIO and PWM.

Side note: I still think this should be a function of the pin when
driver will be converted to pin control. Now this change delays the
conversion and better approach. But as I said before, if GPIO
maintainers consider this good enough to go like this, I won't object.

Some background. It's known that some pin control devices may have PWM
function (limited, like blinking led or so, or full) and it would be
nice to have a pin mux option which enables PWM on a requested pin. Or
PWM tries to enable proper pin muxing (this sounds even better in
order of sharing same API from pin control, like "pin is available for
GPIO").

-- 
With Best Regards,
Andy Shevchenko
