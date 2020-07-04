Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E0214525
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Jul 2020 13:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgGDLX1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 4 Jul 2020 07:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGDLX1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 4 Jul 2020 07:23:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D4C061794;
        Sat,  4 Jul 2020 04:23:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so16235944pgc.5;
        Sat, 04 Jul 2020 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p1oWWVkh0jsAVWB9JrpnkR/n6AxGrkt00WC1nemoJio=;
        b=sjszTJJj7c0qTEa/EeZ6b8AWETs9E9g+N09S543MR1gVkk82OE4Nrg3y2fZLRpLZva
         zGLSDyL1ssL/wBoD1u7Uwtc4w2hjwu/62KL8jXeH/wv+P7uMFRZhODuR9wgmPj4TnASp
         O5mgeOnd7uh+bVxznpm8wmPFA2UX6uoSyXYcj0GFZKevWjDaXfzvZaIsjOAaCkt0eYIs
         /e8lpttYwzKPtT98eNClQ+fbsQvaKR6YG2cADKwbvXOVkFjKfyviKV+JxFK25yaAEWlw
         TzrOif3wsh0JlzlNJVTGGwWzHCwQuPhwka3VYmQKJyaRhXyBZPIi/YDUdEbGKGDfGnV2
         U3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p1oWWVkh0jsAVWB9JrpnkR/n6AxGrkt00WC1nemoJio=;
        b=CTg8Ky5jKXjrccZBajDXW0nOEVp6k8L0I8owbaTgD16x1RJ42e3bVbgiij2FjSZZYa
         VW38GxbjCLqwpsoG/MK09eylpZHC7nboE05I0bmdqxDzSCczUdmCJEouOTVinsTI1dwS
         /Ny3wmiVz5j4l1lQ9LENG+L/qhIgJS8OndhMhxGHNglZK75bDbyaWSdhi0lYEzhmB/PT
         EXkmSLjAxgrBn/qF+P4retTei/CqvE6SOYA00SWERUNugugQmRpiq0SKYm9PQMCGKw4m
         u32IEAWkuQsFuCajLxryuysIl9C7GLmp2jKnGrwmOzZJhW9V8zIAr7d9BRAdntmvYqY/
         hUOw==
X-Gm-Message-State: AOAM530cj/FxhnAlHbsYxtC4qnBjvTfgN0zCsfn0rBQzcRPn8Z24MCKO
        YtXSvTsHPh8T3foTpP0oBPz0te2BSs+LUvcrtOk=
X-Google-Smtp-Source: ABdhPJyqpUk3xdq8Qgmki5nQcYo/aa4m7E4b51HNaZw1RE6ViOy2Y3SRPwMP9KtHJD8svRJlQ519rLPfyGAYQySuL+4=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr26586009pgn.4.1593861805751;
 Sat, 04 Jul 2020 04:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200503105453.23658-1-miquel.raynal@bootlin.com> <20200703145313.vwjsh5crdqx2u76a@pengutronix.de>
In-Reply-To: <20200703145313.vwjsh5crdqx2u76a@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Jul 2020 14:23:09 +0300
Message-ID: <CAHp75Vdii+w4nNErG_z_YHwsTYWR9PeJsKk53szk4p-rop-Htw@mail.gmail.com>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 3, 2020 at 5:53 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Sun, May 03, 2020 at 12:54:53PM +0200, Miquel Raynal wrote:

...

> > +     ret =3D regmap_read(pca_chip->regmap, reg, &val);
> > +     mutex_unlock(&pca_chip->i2c_lock);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Cannot retrieve PWM intensity (%d)\n", ret)=
;
>
> Please use %pe for error codes.

%pe is mainly for error pointers, with plain integers it will look
awkward a bit.

> > +             return 0;
> > +     }

--=20
With Best Regards,
Andy Shevchenko
