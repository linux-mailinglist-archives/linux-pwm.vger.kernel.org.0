Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF4CEFE07
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 14:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbfKENM6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 08:12:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38031 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388873AbfKENM5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 08:12:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so15901141wmk.3;
        Tue, 05 Nov 2019 05:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WY5PPYyjzIlUYWaKVbWNYoxpIbMZhVbt6dhhymdAGQs=;
        b=JSgUoECtGQgZQE15kpj0PnVdtZrhVVAx6CL/ehB8tTbNWqAAjZQtey2yhpBC8OFKaZ
         BN7k3RUbG0+9fVwYTbbj3DjS/SbWWuJY0jaTSj7NzwE5yzcIoQ+26JF9xOBAis6hyq/+
         4m/QQcZQFfbgilnVQILx6sj61ZfOQdV7fCcUmwBtA6L4uftfEhzOx5MyCvXOFmOt5pro
         TrrNRNzzSVP+rFr0zlZdqmRiFgqJSjSYyQKWgs0cim2GkJeb3JyjJ9yb1oikHQ9iyYes
         u9WapIV9c6AO7vOo+qLPG/GthhY/4r83kXPRr0c7CgfH4RkjET5vaYoTBsYs+h6WbL3S
         Fpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WY5PPYyjzIlUYWaKVbWNYoxpIbMZhVbt6dhhymdAGQs=;
        b=MUFwE4aJKgHtHSIaecgEZGz+2WcObkiULeEk1/hbIFF/eXQSK8I4T13k6iSx1TT/tV
         OJEsu/SP3sBDB3GrMQbYttmtMZFTEIh+vSQV3yDlXDrWdUKv9Wj+8VR8HrPF2qRvB8Jk
         PXuP1iX5RvS/AxAAXCSfvCyJqmEXj/DxicUBLeIkDnTbUH/33k29sOFl5+lwvW/QNcXU
         71zvOQiEP1tE6xAGeUneL5xbZaENPh9wqCmCCZlFjqx7TSQLdZwt3ma+SB8OsTVfARXZ
         qpRSnvu47m8fyc+Hcq2ZC/LJ4Zku8p/0GZExYI6hWRcL1TFGetbyFi7EXl6YfysZljas
         SvcQ==
X-Gm-Message-State: APjAAAVyQpmrGuEArteXMr4B9dbE4OWeUZcYuPQlQwOrI6HVs6V5CYyb
        DjLAWgOdVBbMAOg0k31/osTwYh64RyWbL1a2JlM=
X-Google-Smtp-Source: APXvYqz0FjNaPSBkkPJUaXt5lsctHnGENyGPSKY+qp5n9UrOj98xqWnHUC5P4uICW8dlH84YVkgQxXT618iSmay4Ygc=
X-Received: by 2002:a05:600c:228e:: with SMTP id 14mr3968298wmf.119.1572959575130;
 Tue, 05 Nov 2019 05:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-5-peron.clem@gmail.com>
 <20191104083835.m2pd4fvhn2ze6bjt@pengutronix.de> <CAJiuCccjgtMcJa-pZCB_DGN6L8m9bDTgQRoV6WUKPSjv8kn8vA@mail.gmail.com>
 <20191105072922.rku2of3cfphpfirq@pengutronix.de> <CAJiuCcdxvhra7L927UXMHHt3JZmWf8BCoWH4Jijyam2aEHfTPg@mail.gmail.com>
 <20191105131203.z4u35op7f6wm3pg2@pengutronix.de>
In-Reply-To: <20191105131203.z4u35op7f6wm3pg2@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 5 Nov 2019 14:12:43 +0100
Message-ID: <CAJiuCceLPDP6WUR0z4VLNqHaXXeWtHbfFPNDFaKuzdmzeecQ8Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] pwm: sun4i: Add support to output source clock directly
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 5 Nov 2019 at 14:12, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Cl=C3=A9ment,
>
> On Tue, Nov 05, 2019 at 01:58:31PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > This series just want to add a new device and a new bypass
> > functionality and I can't measure the output of PWM and testing it
> > properly.
> > Can this be done in another patch/series ?
>
> I'm fine if you implement the bypass stuff with this logic and keep the
> other stuff as is.

Thanks,
Cl=C3=A9ment

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
